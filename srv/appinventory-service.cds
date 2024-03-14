using db from '../db/data-model';
@impl: 'srv/appinventory-service-exp.js'

service AppinventoryService {

    entity Apps                           as projection on db.Apps;

    @readonly
    entity Regions                        as projection on db.Regions;

    @readonly
    entity App_Regions                    as projection on db.App_Regions;

    @readonly
    entity Pillars                        as projection on db.Pillar;

    @readonly
    entity Domains                        as projection on db.Domains;

    @readonly
    entity AppTypes                       as projection on db.AppTypes;

    @readonly
    entity Stage                          as projection on db.Stage;

    @readonly
    entity FioriAppType                   as projection on db.FioriAppType;

    @readonly
    entity DeploymentType                 as projection on db.DeploymentType;

    @readonly
    entity TShirtSize                     as projection on db.TShirtSize;

    @readonly
    entity RequiredSystems                as projection on db.RequiredSystems;

    @readonly
    entity RequiredSapBtpServices         as projection on db.RequiredSapBtpServices;

    @readonly
    entity ReleaseType                    as projection on db.ReleaseType;

    @readonly
    entity UsedFrameworks                 as projection on db.UsedFrameworks;

    @readonly
    entity App_UsedFrameworks             as projection on db.App_UsedFrameworks;

    @readonly
    entity App_RequiredSapBtpServices     as projection on db.App_RequiredSapBtpServices;

    @readonly
    entity App_RequiredSystems            as projection on db.App_RequiredSystems;

    @readonly
    entity App_ServiceNowReferenceNumbers as projection on db.App_ServiceNowReferenceNumbers;

    @readonly
    entity App_Versions                   as projection on db.App_Versions;

    @readonly
    entity InventoryCompletion            as projection on db.InventoryCompletion;

    @readonly
    entity ChildrenApps                   as projection on db.ChildrenApps;
}

//Completely hidden to FE
annotate AppinventoryService.Apps with {
    regions                    @UI.Hidden;
    requiredSapBtpServices     @UI.Hidden;
    serviceNowReferenceNumbers @UI.Hidden;
    requiredSystems            @UI.Hidden;
    otherRequiredSystem        @UI.Hidden;
    usedFrameworks             @UI.Hidden;
    createdAt                  @UI.Hidden;
    createdBy                  @UI.Hidden;
    modifiedAt                 @UI.Hidden;
    modifiedBy                 @UI.Hidden;
};

// Hidden from filtering
annotate AppinventoryService.Apps with {
    serviceNowReferenceNumberDisplay @UI.HiddenFilter;
    regionsDisplay                   @UI.HiddenFilter;
    requiredSapBtpServicesDisplay    @UI.HiddenFilter;
    requiredSystemsDisplay           @UI.HiddenFilter;
    usedFrameworksDisplay            @UI.HiddenFilter;
    technicalGoLiveDisplay           @UI.HiddenFilter;
    businessGoLiveDisplay            @UI.HiddenFilter;
};
