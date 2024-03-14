const cds = require('@sap/cds');
const {
  buildFilterForIDs,
  fillAppsComplexValues,
  mergeFilters,
  searchFilterName,
} = require('./src/utils');
const addMandatoryReturnFields = require('./src/addMandatoryReturnFields');
const applyComplexFilters = require('./src/applyComplexFilters');

let complexFilters = []; // example [{filter:'regionsFilter_ID',values:[1,2]}]
const triggerFilterNames = [
  'regionsFilter_ID',
  'requiredSapBtpServicesFilter_ID',
  'requiredSystemsFilter_ID',
  'usedFrameworksFilter_ID',
];

const defaultProductSuiteID = 'afe4a31f-4083-496e-b925-9de5e53f6c51';

const valRegex = /"val":(\d+)/g;
const refRegex = /"ref":\s*\["[a-zA-Z_]+_ID"\]/g;

const {
  Apps,
  App_Regions,
  App_RequiredSystems,
  App_RequiredSapBtpServices,
  App_UsedFrameworks,
  // App_ServiceNowReferenceNumbers,
  // App_Versions,
} = cds.entities;

module.exports = (srv) => {
  srv.before('READ', 'Apps', async (req) => {
    // Add 'mandatory' fields to be returned on every request for processing on FE.
    addMandatoryReturnFields(req);

    // Store Complex filters
    console.log('(req.query?.SELECT?.where)', req.query?.SELECT?.where);
    if (req.query?.SELECT?.where) {
      console.log('HERE!!!!');
      const filterQueryArr = req.query.SELECT.where;
      console.log('filterQueryArr', JSON.stringify(filterQueryArr));
      if (!filterQueryArr) return;

      const filterQueryArrToString = JSON.stringify(filterQueryArr);
      const filterValues = filterQueryArrToString
        .match(valRegex)
        ?.map((string) => string.split(':')[1]);
      const filterRefs = filterQueryArrToString
        .match(refRegex)
        ?.map((string) => string.split(':')[1].split('"')[1]);

      if (filterValues && filterRefs) {
        const preDummyFilters = mergeFilters(filterValues, filterRefs);
        complexFilters = preDummyFilters.filter((obj) =>
          triggerFilterNames.includes(obj.filter),
        );
        console.log(complexFilters);
      }

      // Rewrite query filters to remove complex ones.
      let newFilterQueryArr = [];
      for (let i = 0; i < filterQueryArr.length; i++) {
        if (typeof filterQueryArr[i] === 'object') {
          let partialFilterString = JSON.stringify(filterQueryArr[i]);
          let isxpr = partialFilterString.includes(`{"xpr":[{"ref":["`);
          let isComplexFilter = searchFilterName(partialFilterString);
          let isVal = partialFilterString.includes(`{"val":`);
          let isFunc = partialFilterString.includes(`[{"func":"`);

          if ((!isComplexFilter && isxpr) || isFunc) {
            // keep it
            newFilterQueryArr.push(filterQueryArr[i]);
            newFilterQueryArr.push('and');
          }
          if (!isComplexFilter && !isxpr && !isVal) {
            // keep it -- if it's val there are 3 lines building the filter
            newFilterQueryArr.push(filterQueryArr[i]);
            newFilterQueryArr.push(filterQueryArr[i + 1]);
            newFilterQueryArr.push(filterQueryArr[i + 2]);
            newFilterQueryArr.push('and');
          }
        }
      }

      if (newFilterQueryArr.length > 0) {
        // remove last 'and'
        newFilterQueryArr = newFilterQueryArr.slice(
          0,
          newFilterQueryArr.length - 1,
        );
      }
      console.log('NEW FILTER!!!', JSON.stringify(newFilterQueryArr));
      // replace whole filter expression
      req.query.SELECT.where = newFilterQueryArr;
    } else {
      console.log('NOTHING TO DO HERE');
    }
  });

  srv.on('READ', 'Apps', async (req) => {
    // Let the CDS engine to resolve the filters (without the dummies)
    let result = await cds.run(req.query);
    if (!result.length) {
      // here we also cover the entity query (result = {...})
      return result;
    }

    //  ****Apply the "complex filters".****
    result = await applyComplexFilters(result, complexFilters);

    if (result.length === 0) {
      return [];
    }

    // After applying all the manual filters, re execute the engine just with the selected IDs.
    req.query.SELECT.where = buildFilterForIDs(
      result.map((app) => {
        if (app.ID !== defaultProductSuiteID) return app.ID;
      }),
    );
    result = await cds.run(req.query);

    // Fill fields of complex filters
    result = await fillAppsComplexValues(result, req.query);

    return result;
  });

  srv.after('READ', 'Apps', (each) => {
    complexFilters = []; // Empty the array to prevent stacking
    if (!each.productSuiteParentApp_ID) {
      each.productSuiteParentApp_ID = defaultProductSuiteID;
    }
  });
};
