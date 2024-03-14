/* eslint-disable max-len */
/* eslint-disable no-undef */
sap.ui.define(['sap/ui/core/mvc/ControllerExtension'], (ControllerExtension) => ControllerExtension.extend('appinventory.appinventory.ext.controller.NavigationController', {
  // this section allows to extend lifecycle hooks or hooks provided by Fiori elements
  override: {
    /**
             * Called when a controller is instantiated and its View controls (if available) are already created.
             * Can be used to modify the View before it is displayed, to bind event handlers and do other one-time initialization.
             * @memberOf appinventory.appinventory.ext.controller.NavigationController
             */
    onInit() {
      // you can access the Fiori elements extensionAPI via this.base.getExtensionAPI
      // eslint-disable-next-line no-unused-vars
      const oModel = this.base.getExtensionAPI().getModel();
    },
    routing: {
      onBeforeNavigation(oContextInfo) {
        console.log(oContextInfo.bindingContext.oBinding.oCache.aElements[oContextInfo.bindingContext.iIndex]);
        const oIndex = oContextInfo.bindingContext.iIndex;
        const oLineContextData = oContextInfo.bindingContext.oBinding.oCache.aElements[oIndex];
        const oRouting = this.base.getExtensionAPI().routing;
        const { isProductSuite, ID, productSuiteParentApp_ID } = oLineContextData;
        // if there's not productSuite then navigate directly to ChildrenAppsObjectPage
        if (!isProductSuite) {
          oRouting.navigateToRoute('Apps_productSuiteChildrenAppsObjectPage', {
            key: `${productSuiteParentApp_ID}`,
            key2: `${ID}`,
          });
        } else {
          // return false to trigger the default internal navigation
          return false;
        }
        // return true is necessary to prevent further default navigation
        return true;
      },
    },
  },
}));
