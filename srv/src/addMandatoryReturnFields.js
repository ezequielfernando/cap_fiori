function addMandatoryReturnFields(req) {
  if (req.query?.SELECT?.columns) {
    if (!JSON.stringify(req.query.SELECT.columns).includes('isProductSuite')) {
      req.query.SELECT.columns.push({ ref: ['isProductSuite'] });
    }
    if (
      !JSON.stringify(req.query.SELECT.columns).includes(
        'productSuiteParentApp_ID',
      )
    ) {
      req.query.SELECT.columns.push({ ref: ['productSuiteParentApp_ID'] });
    }
  }
}

module.exports = addMandatoryReturnFields;