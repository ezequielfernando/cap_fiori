using from './appinventory/annotations';

//Common Labels for entity
annotate AppinventoryService.Apps with {
    appName                         @Common.Label: 'App Name';
    stage                           @Common.Label: 'SBC DevOps Stage';
    releaseType                     @Common.Label: 'Release Type';
    pillar                          @Common.Label: 'Pillar';
    itService                       @Common.Label: 'IT-Services';
    platformAdmin                   @Common.Label: 'Platform Admin';
    serviceNowReferenceNumbers      @Common.Label: 'Service Now Reference No.';
    serviceNowReferenceNumberFilter @Common.Label: 'Service Now Reference No. Filter';
    appID                           @Common.Label: 'App ID';
    appOwner                        @Common.Label: 'App Owner (Pillar)';
    btpNavigationRoles              @Common.Label: 'BTP Navigation Role(s)';
    deploymentTrack                 @Common.Label: 'Deployment Track';
    deploymentType                  @Common.Label: 'Deployment Type';
    domain                          @Common.Label: 'Domain';
    fioriAppType                    @Common.Label: 'Fiori App Type';
    gitRepo                         @Common.Label: 'GIT Respository URL';
    implementationPartner           @Common.Label: 'Implementation Partner';
    inventoryCompletion             @Common.Label: 'Inventory Completion';
    inventoryCompletion_criticality @Common.Label: 'Inventory Completion Criticality';
    itServiceAssignmentGroup        @Common.Label: 'IT Service Assignment Group';
    productOwner                    @Common.Label: 'Product Owner (Business)';
    regions                         @Common.Label: 'Relevant Regions';
    regionsFilter                   @Common.Label: 'Relevant Regions Filter';
    regionsDisplay                  @Common.Label: 'Relevant Regions Display';
    requiredDevFrameworks           @Common.Label: 'Required Dev Frameworks';
    requiredSapBtpServices          @Common.Label: 'Required SAP BTP Services';
    requiredSapBtpServicesFilter    @Common.Label: 'Required SAP BTP Services Filter';
    requiredSapBtpServicesDisplay   @Common.Label: 'Required SAP BTP Services Display';
    requiredSystems                 @Common.Label: 'Required Systems';
    requiredSystemsFilter           @Common.Label: 'Required Systems Filter';
    requiredSystemsDisplay          @Common.Label: 'Required Systems Display';
    otherRequiredSystem             @Common.Label: 'Required System (other)';
    sapLaunchpadIntegrationReq      @Common.Label: 'SAP Launchpad integration required';
    sapWorkZoneIntegrationReq       @Common.Label: 'SAP Work Zone integration required';
    shortDescr                      @Common.Label: 'Short Description';
    statusAuditConceptRequirements  @Common.Label: 'Status Audit Concept / Requirements';
    statusCodeQualityCheck          @Common.Label: 'Status Code Quality Check';
    statusDpa                       @Common.Label: 'Status DPA';
    statusMonitoringConcept         @Common.Label: 'Status Monitoring Concept';
    statusSecurityConceptAssessment @Common.Label: 'Status Security Concept Assessment';
    statusSecurityPenTest           @Common.Label: 'Status Security Pen Test';
    tShirtSize                      @Common.Label: 'T-Shirt Size';
    technicalAppName                @Common.Label: 'Technical App Name';
    templateRoles                   @Common.Label: 'Template Role(s)';
    year                            @Common.Label: 'Year';
    usedFrameworks                  @Common.Label: 'Used Frameworks';
    usedFrameworksFilter            @Common.Label: 'Used Frameworks Filter';
    usedFrameworksDisplay           @Common.Label: 'Used Frameworks Display';
    appType                         @Common.Label: 'App Type';
    entryID                         @Common.Label: 'Entry ID';
    productSuiteName                @Common.Label: 'Product Suite Name';
    itServiceOwner                  @Common.Label: 'IT Service Owner';
    generalInfo                     @Common.Label: 'General Information';
    currOperatingVersion            @Common.Label: 'Current Operating Version';
    upcomingVersion                 @Common.Label: 'Upcoming Version';
    stageOfUpcomingVersion          @Common.Label: 'Stage of Upcoming Version';
    gerName                         @Common.Label: 'German Name';
    otherRequiredSystems            @Common.Label: 'Other Required Systems';
    proxyProductOwner               @Common.Label: 'Product Owner';
    foundFields                     @Common.Label: 'Found Fields';
    fieldsForCompletion             @Common.Label: 'Fields for Completion';
    isProductSuite                  @Common.Label: 'Is Product Suite';
    productSuiteChildrenApps        @Common.Label: 'Product Suite Children Apps';
    productSuiteParentApp           @Common.Label: 'Product Suite Parent App';
    uxScore                         @Common.Label: 'UX Score';
    productOwnerEmail               @Common.Label: 'Product Owner Email';
};


//Declaration of filters
annotate AppinventoryService.Apps with {

    stage
    @Common.ValueListWithFixedValues: true
    @Common.ValueList               : {
        $Type         : 'Common.ValueListType',
        CollectionPath: 'Stage',
        Parameters    : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: stage_ID,
                ValueListProperty: 'ID',
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'value',
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'colour',
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'icon',
            },
        ],
    };

    releaseType
    @Common.ValueListWithFixedValues: true
    @Common.ValueList               : {
        $Type         : 'Common.ValueListType',
        CollectionPath: 'ReleaseType',
        Parameters    : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: releaseType_ID,
                ValueListProperty: 'ID',
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'value',
            },
        ],
    };

    regionsFilter
    @Common.ValueListWithFixedValues: true
    @Common.ValueList               : {
        $Type         : 'Common.ValueListType',
        CollectionPath: 'Regions',
        Parameters    : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: regionsFilter_ID,
                ValueListProperty: 'ID',
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'value',
            }
        ],
    };

    pillar
    @Common.ValueListWithFixedValues: true
    @Common.ValueList               : {
        $Type         : 'Common.ValueListType',
        CollectionPath: 'Pillars',
        Parameters    : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: pillar_ID,
                ValueListProperty: 'ID',
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'value',
            },
        ],
    };

    appType
    @Common.ValueListWithFixedValues: true
    @Common.ValueList               : {
        $Type         : 'Common.ValueListType',
        CollectionPath: 'AppTypes',
        Parameters    : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: appType_ID,
                ValueListProperty: 'ID',
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'value',
            },
        ],
    };

    deploymentType
    @Common.ValueList               : {
        $Type         : 'Common.ValueListType',
        CollectionPath: 'DeploymentType',
        Parameters    : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: deploymentType_ID,
                ValueListProperty: 'ID',
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'value',
            },
        ],
    };

    tShirtSize
    @Common.ValueList               : {
        $Type         : 'Common.ValueListType',
        CollectionPath: 'TShirtSize',
        Parameters    : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: tShirtSize_ID,
                ValueListProperty: 'ID',
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'value',
            },
        ],
    };

    platformAdmin
    @Common.ValueListWithFixedValues: true
    @Common.ValueList               : {
        $Type         : 'Common.ValueListType',
        CollectionPath: 'Apps',
        Parameters    : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: platformAdmin,
                ValueListProperty: 'platformAdmin',
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'ID',
            },
        ],
    };

    fioriAppType
    @Common.ValueListWithFixedValues: true
    @Common.ValueList               : {
        $Type         : 'Common.ValueListType',
        CollectionPath: 'FioriAppType',
        Parameters    : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: fioriAppType_ID,
                ValueListProperty: 'ID',
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'value',
            },
        ],
    };

    requiredSapBtpServicesFilter
    @Common.ValueListWithFixedValues: true
    @Common.ValueList               : {
        $Type         : 'Common.ValueListType',
        CollectionPath: 'RequiredSapBtpServices',
        Parameters    : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: requiredSapBtpServicesFilter_ID,
                ValueListProperty: 'ID',
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'value',
            }
        ],
    };

    requiredSystemsFilter
    @Common.ValueListWithFixedValues: true
    @Common.ValueList               : {
        $Type         : 'Common.ValueListType',
        CollectionPath: 'RequiredSystems',
        Parameters    : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: requiredSystemsFilter_ID,
                ValueListProperty: 'ID',
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'value',
            }
        ],
    };

    usedFrameworksFilter
    @Common.ValueListWithFixedValues: true
    @Common.ValueList               : {
        $Type         : 'Common.ValueListType',
        CollectionPath: 'UsedFrameworks',
        Parameters    : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: usedFrameworksFilter_ID,
                ValueListProperty: 'ID',
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'value',
            }
        ],
    };
};
