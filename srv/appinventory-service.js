const cds = require('@sap/cds');
const utils = require('./src/utils');

const defaultProductSuiteID = 'afe4a31f-4083-496e-b925-9de5e53f6c51';

let dummyFilters = []; // example [{filter:'regionsFilter_ID',values:[1,2]}]
const triggerFilterNames = [
  'regionsFilter_ID',
  'requiredSapBtpServicesFilter_ID',
  'requiredSystemsFilter_ID',
  'usedFrameworksFilter_ID',
];
const valRegex = /"val":(\d+)/g; // assuming the keys are always numbers

module.exports = (srv) => {
  // srv.before('READ', 'Apps', async (req) => {
  //   // *** Add 'mandatory' fields to be returned
  //   if (req.query?.SELECT?.columns) {
  //     if (
  //       !JSON.stringify(req.query.SELECT.columns).includes('isProductSuite')
  //     ) {
  //       req.query.SELECT.columns.push({ ref: ['isProductSuite'] });
  //     }
  //     if (
  //       !JSON.stringify(req.query.SELECT.columns).includes(
  //         'productSuiteParentApp_ID',
  //       )
  //     ) {
  //       req.query.SELECT.columns.push({ ref: ['productSuiteParentApp_ID'] });
  //     }
  //   }
  //   // *** End of 'mandatory' fields to be returned

  //     console.log('ORIGINAL FILTER!', JSON.stringify(req.query.SELECT.where));
  //   //   // dummyFilters = [{ filter: 'regionsFilter_ID', values: [1, 2] }]; // try to build as this...

  //   //   const filterQueryArr = req.query.SELECT.where;
  //   //   if (!filterQueryArr) {
  //   //     return;
  //   //   }

  //   //   // ***Rewrite filters to remove dummies.***

  //   //   function searchFilterName(partialFilterText) {
  //   //     for (let i = 0; i < triggerFilterNames.length; i++) {
  //   //       if (partialFilterText.includes(triggerFilterNames[i])) {
  //   //         return true;
  //   //       }
  //   //     }
  //   //     return false;
  //   //   }

  //   //   let newFilterQueryArr = [];
  //   //   for (let i = 0; i < filterQueryArr.length; i++) {
  //   //     if (typeof filterQueryArr[i] === 'object') {
  //   //       let partialFilterString = JSON.stringify(filterQueryArr[i]);
  //   //       let isxpr = partialFilterString.includes(`{"xpr":[{"ref":["`);
  //   //       let isDummyFilter = searchFilterName(partialFilterString);
  //   //       let isVal = partialFilterString.includes(`{"val":`);
  //   //       let isFunc = partialFilterString.includes(`[{"func":"`);

  //   //       if ((!isDummyFilter && isxpr) || isFunc) {
  //   //         //keep it
  //   //         newFilterQueryArr.push(filterQueryArr[i]);
  //   //         newFilterQueryArr.push('and');
  //   //       }
  //   //       if (!isDummyFilter && !isxpr && !isVal) {
  //   //         //keep it
  //   //         newFilterQueryArr.push(filterQueryArr[i]);
  //   //         newFilterQueryArr.push(filterQueryArr[i + 1]);
  //   //         newFilterQueryArr.push(filterQueryArr[i + 2]);
  //   //         newFilterQueryArr.push('and');
  //   //       }
  //   //     }
  //   //   }

  //   //   if (newFilterQueryArr.length > 0) {
  //   //     // remove last 'and'
  //   //     newFilterQueryArr = newFilterQueryArr.slice(
  //   //       0,
  //   //       newFilterQueryArr.length - 1,
  //   //     );
  //   //   }
  //   //   console.log("NEW FILTER!!!", JSON.stringify(newFilterQueryArr));
  //   //   req.query.SELECT.where = newFilterQueryArr;
  // });

  // srv.before('READ', 'Apps', async (req) => {
  //   console.log("HERE BEFORE");
  //   console.log(circularJSON.stringify(req.query.SELECT));
  //   console.log('URL', req._.req.url);
  //   // req.query.SELECT = JSON.parse(`{"from":{"ref":[{"id":"AppinventoryService.Apps","where":[{"ref":["ID"]},"=",{"val":"afe4a31f-4083-496e-b925-9de5e53f6c51"}]}]},"columns":[{"ref":["ID"]},{"ref":["appName"]},{"ref":["stage"],"expand":[{"ref":["ID"]},{"ref":["value"]}]},{"ref":["appType"],"expand":[{"ref":["ID"]},{"ref":["value"]}]}],"orderBy":[{"ref":["ID"],"sort":"asc"}]}`);
  //   // req.query.SELECT = JSON.parse(`{"from":{"ref":["AppinventoryService.Apps"]},"orderBy":[{"ref":["ID"],"sort":"asc"}]}`);
  // });

  // srv.before('READ', 'Apps/productSuiteChildrenApps', async (req) => {
  //   console.log('Apps/productSuiteChildrenApps HERE!');
  // });

  srv.on('READ', 'Apps', async (req, next) => {
    // Let the CDS engine to resolve the filters (without the dummies)

  //   console.log("HERE ON!");
    // let whereClause = circularJSON.stringify(req.query.SELECT.columns);
    // console.log("ON!!", whereClause);
  //   // if (whereClause.includes('productSuiteChildrenApps')){
  //   //   return [];
  //   // }
  //   // console.log(circularJSON.stringify(req.query.SELECT));
  //   // console.log(JSON.stringify(req.query));

    let result = await cds.run(req.query);
  //   console.log('result', result);

  //   if (!result.length) {
  //     // here we also cover the entity query (result = {...})
  //     return result;
  //   }

  //   // remove default Product Suite
  //   result = result.filter(app => app.ID !== defaultProductSuiteID);
  //   if (result.length === 0) {
  //     return [];
  //   }

  //   //  ****Apply the "dummy filters".****

  //   //  -ACCESS DB to get filtered info (intermediate tables)
  //   let appRegions = [];
  //   if (dummyFilters.length > 0) {
  //     // ...other intermediate tables...
  //     for (let i = 0; i < dummyFilters.length; i++) {
  //       switch (dummyFilters[i].filter) {
  //         case 'regionsFilter_ID':
  //           if (result.length > 0) {
  //             // get the valid app ids that matches the filter
  //             appRegions = await SELECT.from('AppinventoryService.App_Regions')
  //               .columns('region_ID', 'app_ID')
  //               .where({ region_ID: dummyFilters[i].values });
  //             if (appRegions.length === 0) {
  //               result = []; // if filter is set and nothing to filter => nothing to return
  //             }
  //           }
  //           break;
  //         // get the rest of the filters...
  //         case 'requiredSystemsFilter_ID':
  //           break;
  //         default:
  //           break;
  //       }
  //     }
  //   }

  //   if (result.length === 0) {
  //     return [];
  //   }

  //   // -Apply filters based on the intermediate tables subsets
  //   for (let i = 0; i < dummyFilters.length; i++) {
  //     switch (dummyFilters[i].filter) {
  //       case 'regionsFilter_ID':
  //         if (result.length > 0) {
  //           result = result.filter((app) =>
  //             appRegions.find((region) => region.app_ID === app.ID),
  //           );
  //         }
  //         break;
  //       default:
  //         break;
  //     }
  //   }

  //   // After applying all the manual filters, re execute the engine with the selected IDs.
  //   req.query.SELECT.where = buildFilterForIDs(result.map((app) => app.ID));
  //   result = await cds.run(req.query);
    console.log("HERE!");
    // result = await utils.fillAppsComplexValues(result, req.query);
    return result;
  });

  // srv.after('READ', 'Apps', () => {
  //   dummyFilters = [];
  // });

  // srv.after('READ', 'Apps', each => {
  //   if (!each.productSuiteParentApp_ID) {
  //     each.productSuiteParentApp_ID = defaultProductSuiteID;
  //   }
  // })
};
