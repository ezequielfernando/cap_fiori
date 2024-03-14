require ('@sap/cds');

console.log('Starting CAP Application on', new Date());
const packageJson = require('../package.json');
console.log("App version: ", packageJson.version);

cds.on('bootstrap', app => {
  app.get('/health', (_, res) => {
    res.status(200).send('OK');
  });
});

module.exports = cds.server;