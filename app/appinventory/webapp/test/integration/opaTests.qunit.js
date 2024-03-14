sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'appinventory/appinventory/test/integration/FirstJourney',
		'appinventory/appinventory/test/integration/pages/AppsList',
		'appinventory/appinventory/test/integration/pages/AppsObjectPage'
    ],
    function(JourneyRunner, opaJourney, AppsList, AppsObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('appinventory/appinventory') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheAppsList: AppsList,
					onTheAppsObjectPage: AppsObjectPage
                }
            },
            opaJourney.run
        );
    }
);