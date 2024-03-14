const cds = require('@sap/cds');

const {
  App_Regions,
  App_RequiredSystems,
  App_RequiredSapBtpServices,
  App_UsedFrameworks,
  // App_ServiceNowReferenceNumbers,
  // App_Versions,
} = cds.entities;

async function applyComplexFilters(result, complexFilters) {
  let appRegions = [];
  let appReqBtpServices = [];
  let appReqSystems = [];
  let appUsedFrameworks = [];
  // MM: I need to think a little bit more about how to implement this two
  // let appSNRef = [];
  // let appVersions = [];
  // -ACCESS DB to get filtered info (intermediate tables)
  // and apply the subresult filtering to the return
  if (complexFilters.length > 0) {
    for (let i = 0; i < complexFilters.length; i++) {
      switch (complexFilters[i].filter) {
        case 'regionsFilter_ID':
          if (result.length > 0) {
            appRegions = await SELECT.from(App_Regions)
              .columns('region_ID', 'app_ID')
              .where({ region_ID: { in: complexFilters[i].values } });
            if (appRegions.length === 0) {
              return [];
            }
            // MM: On each case, if matched, we will filter the result (after removing dummy filters from the query)
            result = result.filter((app) =>
              appRegions.find((region) => region.app_ID === app.ID),
            );
          }
          break;
        case 'requiredSapBtpServicesFilter_ID':
          if (result.length > 0) {
            appReqBtpServices = await SELECT.from(App_RequiredSapBtpServices)
              .columns('requiredSapBtpService_ID', 'app_ID')
              .where({
                requiredSapBtpService_ID: { in: complexFilters[i].values },
              });
            if (appReqBtpServices.length === 0) {
              return [];
            }
            result = result.filter((app) =>
              appReqBtpServices.find(
                (btpService) => btpService.app_ID === app.ID,
              ),
            );
          }
          break;
        case 'requiredSystemsFilter_ID':
          if (result.length > 0) {
            appReqSystems = await SELECT.from(App_RequiredSystems)
              .columns('requiredSystem_ID', 'app_ID')
              .where({ requiredSystem_ID: { in: complexFilters[i].values } });
            if (appReqSystems.length === 0) {
              return [];
            }
            result = result.filter((app) =>
              appReqSystems.find((reqSystem) => reqSystem.app_ID === app.ID),
            );
          }
          break;
        case 'usedFrameworksFilter_ID':
          if (result.length > 0) {
            appUsedFrameworks = await SELECT.from(App_UsedFrameworks)
              .columns('usedFramework_ID', 'app_ID')
              .where({ usedFramework_ID: { in: complexFilters[i].values } });
            if (appUsedFrameworks.length === 0) {
              return [];
            }
            result = result.filter((app) =>
              appUsedFrameworks.find(
                (usedFramework) => usedFramework.app_ID === app.ID,
              ),
            );
          }
          break;
        default:
          break;
      }
    }
  }
  return result;
}

module.exports = applyComplexFilters;