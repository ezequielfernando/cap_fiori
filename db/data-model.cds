namespace db;

using {
    cuid,
    managed
} from '@sap/cds/common';

// Types
@assert.range
type Progress : String enum {
    Planned;
    InProgress = 'In-Progress';
    Completed
}

// Aspects
aspect KeyValue {
    key ID : Integer;
    value  : String;
}

// Entities
@Capabilities: {FilterRestrictions: {FilterExpressionRestrictions: [
    {
        Property          : 'technicalGoLive',
        AllowedExpressions: 'SingleRange'
    },
    {
        Property          : 'businessGoLive',
        AllowedExpressions: 'SingleRange'
    },
    {
        Property          : 'serviceNowReferenceNumberFilter',
        AllowedExpressions: 'SingleValue'
    },
    {
        Property          : 'serviceNowReferenceNumberFilter',
        AllowedExpressions: 'SingleValue'
    },
    {
        Property          : 'versionsFilter',
        AllowedExpressions: 'SingleValue'
    }
]}}

entity Apps : managed, cuid {
    appName                          : String not null;
    stage                            : Association to Stage not null;
    releaseType                      : Association to ReleaseType;
    pillar                           : Association to Pillar not null;
    itService                        : String;
    platformAdmin                    : String; //ES: this should be a text (for now) => MM: DONE! ES: delete the csv and the entity => MM: Done
    serviceNowReferenceNumbers       : Association to many App_ServiceNowReferenceNumbers
                                           on serviceNowReferenceNumbers.app_ID = $self.ID; //ES: missing hyperlink. Ask Marco if possible to work with this, or random html content in a field? => MM: DONE! Q to Aldi:Maybe only possible single value, not multiple.
    //MM: Added 1..n relation fix. User will input manually the SN ref number and associate it with the corresponding App. Marco will use it to make the smart hyperlink.
    serviceNowReferenceNumberFilter  : String;
    serviceNowReferenceNumberDisplay : String;
    appID                            : String not null;
    appOwner                         : String;
    btpNavigationRoles               : String; //Separated by ',', free text.
    deploymentTrack                  : String;
    deploymentType                   : Association to DeploymentType not null;
    domain                           : Association to Domains not null;
    fioriAppType                     : Association to FioriAppType;
    gitRepo                          : String;
    implementationPartner            : String not null;
    inventoryCompletion              : Integer @Measures.Unit: '%';
    inventoryCompletionFilter        : Association to InventoryCompletion;
    inventoryCompletion_criticality  : Integer;
    itServiceAssignmentGroup         : String;
    productOwner                     : String;
    regions                          : Association to many App_Regions
                                           on regions.app_ID = $self.ID;
    regionsFilter                    : Association to Regions;
    regionsDisplay                   : String;
    requiredDevFrameworks            : String;
    requiredSapBtpServices           : Association to many App_RequiredSapBtpServices
                                           on requiredSapBtpServices.app_ID = $self.ID;
    requiredSapBtpServicesFilter     : Association to RequiredSapBtpServices;
    requiredSapBtpServicesDisplay    : String;
    requiredSystems                  : Association to many App_RequiredSystems
                                           on requiredSystems.app_ID = $self.ID;
    requiredSystemsFilter            : Association to RequiredSystems;
    requiredSystemsDisplay           : String;
    otherRequiredSystem              : String;
    sapLaunchpadIntegrationReq       : Boolean;
    sapWorkZoneIntegrationReq        : Boolean;
    shortDescr                       : String not null;
    statusAuditConceptRequirements   : Progress;
    statusCodeQualityCheck           : Progress;
    statusDpa                        : Progress;
    statusMonitoringConcept          : Progress;
    statusSecurityConceptAssessment  : Progress;
    statusSecurityPenTest            : Progress;
    tShirtSize                       : Association to TShirtSize;
    technicalAppName                 : String not null;
    templateRoles                    : String; //Separated by ',', free text.
    year                             : Integer;
    usedFrameworks                   : Association to many App_UsedFrameworks
                                           on usedFrameworks.app_ID = $self.ID;
    usedFrameworksFilter             : Association to UsedFrameworks;
    usedFrameworksDisplay            : String;
    appType                          : Association to AppTypes;
    productSuiteName                 : String;
    itServiceOwner                   : String;
    generalInfo                      : String;
    versions                         : Association to many App_Versions
                                           on versions.app_ID = $self.ID;
    versionsFilter                   : String;
    versionsDisplay                  : String;
    currOperatingVersion             : String;
    upcomingVersion                  : String;
    stageOfUpcomingVersion           : String;
    gerName                          : String not null;
    otherRequiredSystems             : String;
    proxyProductOwner                : String;
    isProductSuite                   : Boolean;
    productSuiteChildrenApps         : Association to many ChildrenApps
                                           on productSuiteChildrenApps.productSuiteParentApp_ID = $self.ID;
    productSuiteParentApp_ID         : UUID;
    uxScore                          : Decimal(1, 1);
    productOwnerEmail                : String;
    businessGoLive                   : Date;
    technicalGoLive                  : Date;
/*
ES:
Q to Aldi: In creation/edition: what are mandatory fields?
Related to previous: not null will be determined afterwards but we can keep for testnig
*/
}

entity ChildrenApps as projection on Apps;

entity App_BGL : cuid {
    app_ID : UUID;
    region : Association to Regions;
    goLive : Date;
}

entity App_TGL : cuid {
    app_ID : UUID;
    region : Association to Regions;
    goLive : Date;
}

entity App_Versions : cuid {
    app_ID  : UUID;
    version : String;
    tShirtsize : Association to TShirtSize;
    demand : String;
    leanIXID : String;
    releaseSync : String;
    businessGoLive : Date;    // MM: We suppose with marco that BGL and TGL are associations independent for each version
    technicalGoLive : Date;
    devPD : String;     // MM: Dont know really what this one means
    stage : Association to Stage;
    releaseDate : Date;
    doht : String;
    // releaseType : Association to ReleaseType // MM: Maybe this is independent on each version and its not inherited?
    appDemo : String; // MM: this one is a link
}

entity App_ServiceNowReferenceNumbers : cuid {
    app_ID                    : UUID;
    serviceNowReferenceNumber : String;
}

entity App_UsedFrameworks : cuid {
    app_ID        : UUID;
    usedFramework : Association to UsedFrameworks;
}

entity App_Regions : managed, cuid {
    region : Association to Regions;
    app_ID : UUID;
}

entity App_RequiredSapBtpServices : cuid {
    app_ID                : UUID;
    requiredSapBtpService : Association to RequiredSapBtpServices;
}

entity App_RequiredSystems : cuid {
    app_ID         : UUID;
    requiredSystem : Association to RequiredSystems;
}

// Value Help Entities
entity Stage : KeyValue {}
entity Pillar : KeyValue {}
entity Domains : KeyValue {}
entity AppTypes : KeyValue {}
entity Regions : KeyValue {}
entity FioriAppType : KeyValue {}
entity DeploymentType : KeyValue {}
entity TShirtSize : KeyValue {}
entity RequiredSystems : KeyValue {}
entity RequiredSapBtpServices : KeyValue {}
entity ReleaseType : KeyValue {}
entity UsedFrameworks : KeyValue {}
entity InventoryCompletion : KeyValue {}
