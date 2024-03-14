/* eslint-disable */
const cds = require('@sap/cds');

const triggerFilterNames = [
  'regionsFilter_ID',
  'requiredSapBtpServicesFilter_ID',
  'requiredSystemsFilter_ID',
  'usedFrameworksFilter_ID',
];

function buildFilterForIDs(ids) {
  const xpr = [];
  ids.map((id) => {
    if (xpr.length === 0) {
      xpr.push({ ref: ['ID'] }, '=', { val: id });
    } else {
      xpr.push('or');
      xpr.push({ ref: ['ID'] }, '=', { val: id });
    }
  });
  return [{ xpr: xpr }];
}

async function fillAppsComplexValues(result, query) {
  const { App_Regions } = cds.entities;

  const columnsDescriptor = JSON.stringify(query?.SELECT?.columns);

  if (!columnsDescriptor) {
    return result;
  }

  const appIDs = result.map((app) => app.ID);

  if (columnsDescriptor.includes(`{"ref":["regionsDisplay"]`)) {
    // Retrieve DB data
    const appRegions = await SELECT.from(App_Regions)
      .columns((appRegion) => {
        appRegion.app_ID,
          appRegion.region_ID,
          appRegion.region((region) => {
            region.value;
          });
      })
      .where({ app_ID: appIDs });

    // complete result field concatenating the values (ID) with comma.
    if (appRegions.length > 0) {
      result.map((app) => {
        app.regionsDisplay = appRegions
          .filter((region) => region.app_ID === app.ID)
          .map((region) => {
            return region.region.value + '(' + region.region_ID + ')';
          })
          .join(', ');
      });
    }
  }
  return result;
}

// Function to merge arrays and output one like [{filter:'regionsFilter_ID',values:[1,2]}, ...]
const mergeFilters = (valuesArr, refsVar) => {
  const result = {};

  if (!refsVar || !valuesArr || refsVar.length === 0 || valuesArr.length === 0) {
    return {};
  }

  for (let i = 0; i < valuesArr.length; i++) {
    const filter = refsVar[i];
    const value = parseInt(valuesArr[i], 10);

    if (!result[filter]) {
      result[filter] = { filter, values: [] };
    }

    if (!result[filter].values.includes(value)) {
      result[filter].values.push(value);
    }
  }

  return Object.values(result);
};

function searchFilterName(partialFilterText) {
  for (let i = 0; i < triggerFilterNames.length; i++) {
    if (partialFilterText.includes(triggerFilterNames[i])) {
      return true;
    }
  }
  return false;
}

module.exports = {
  buildFilterForIDs,
  fillAppsComplexValues,
  mergeFilters,
  searchFilterName,
};
