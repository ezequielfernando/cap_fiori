using AppinventoryService as service from '../../srv/appinventory-service';

//Annotation for Progress Bar
annotate service.Apps with @(
    UI.DataPoint #Progress: {
        $Type        : 'UI.DataPointType',
        Value        : inventoryCompletion,
        TargetValue  : 100,
        Visualization: #Progress,
        MinimumValue : 0,
        MaximumValue : 100,
        ValueFormat  : {NumberOfFractionalDigits: 0}
    },
    UI.LineItem           : [
        {
            $Type                : 'UI.DataField',
            Value                : appName,
            ![@UI.Importance]    : #High,
            ![@HTML5.CssDefaults]: {width: '12.5%'}
        },
        {
            $Type                : 'UI.DataField',
            Label                : '{i18n>Stage}',
            Value                : stage.value,
            ![@UI.Importance]    : #High,
            ![@HTML5.CssDefaults]: {width: '12.5%'}
        },
        {
            $Type                : 'UI.DataField',
            Label                : '{i18n>AppType}',
            Value                : appType.value,
            ![@HTML5.CssDefaults]: {width: '12.5%'}
        },
        {
            $Type                : 'UI.DataField',
            Label                : 'IT Service',
            Value                : itService,
            ![@HTML5.CssDefaults]: {width: '12.5%'}
        },
        {
            $Type                : 'UI.DataField',
            Label                : 'Service Now Reference No.',
            Value                : serviceNowReferenceNumberFilter,
            ![@HTML5.CssDefaults]: {width: '12.5%'}
        },
        {
            $Type                : 'UI.DataField',
            Label                : 'Platform Admin',
            Value                : platformAdmin,
            ![@HTML5.CssDefaults]: {width: '12.5%'}
        },
        {
            $Type                : 'UI.DataField',
            Label                : 'Release Type',
            Value                : releaseType.value,
            ![@HTML5.CssDefaults]: {width: '12.5%'}
        },
        {
            $Type : 'UI.DataFieldForAnnotation',
            Label : 'Inventory Completion',
            Target: ![@UI.DataPoint#Progress]
        },
    ],
    UI.SelectionFields    : [
        appType_ID,
        pillar_ID,
        stage_ID,
        regionsFilter_ID,
    ]
);

annotate service.Apps with @(
    UI.FieldGroup #GeneratedGroup1: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Label: 'appID',
                Value: appID,
            },
            {
                $Type: 'UI.DataField',
                Label: 'app Name',
                Value: appName,
            },
            {
                $Type: 'UI.DataField',
                Label: 'appNameGer',
                Value: gerName,
            },
            {
                $Type: 'UI.DataField',
                Label: 'techAppName',
                Value: technicalAppName,
            },
            {
                $Type: 'UI.DataField',
                Label: 'appType_ID',
                Value: appType_ID,
            },
            {
                $Type: 'UI.DataField',
                Label: 'domain_ID',
                Value: domain_ID,
            },
            {
                $Type: 'UI.DataField',
                Label: 'pillar_ID',
                Value: pillar_ID,
            },
            {
                $Type: 'UI.DataField',
                Label: 'stage_ID',
                Value: stage_ID,
            },
            {
                $Type: 'UI.DataField',
                Label: 'itService',
                Value: itService,
            },
            {
                $Type: 'UI.DataField',
                Label: 'productOwner',
                Value: productOwner,
            },
            {
                $Type: 'UI.DataField',
                Label: 'itServiceAssignmentGroup',
                Value: itServiceAssignmentGroup,
            },
        ],
    },
    UI.Facets                     : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>ContainedApps}',
            ID : 'i18nContainedApps',
            Target : 'productSuiteChildrenApps/@UI.LineItem#i18nContainedApps',
        }
    ]
);

annotate service.Apps with @(UI.FieldGroup #ContainedApps: {
    $Type: 'UI.FieldGroupType',
    Data : [],
});

annotate service.Apps with @(UI.HeaderInfo: {
    Title         : {
        $Type: 'UI.DataField',
        Value: appName,
    },
    TypeName      : '',
    TypeNamePlural: 'SBC Entries',
});

annotate service.Apps with @(
    UI.HeaderFacets                  : [{
        $Type : 'UI.ReferenceFacet',
        ID    : 'Generalinformation',
        Target: '@UI.FieldGroup#Generalinformation',
    },
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'itService',
            Target : '@UI.FieldGroup#itService',
        },
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'uxScore',
            Target : '@UI.FieldGroup#uxScore',
        }, ],
    UI.FieldGroup #Generalinformation: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: pillar_ID,
            },
            {
                $Type : 'UI.DataField',
                Value : productOwner,
            },
        ],
    }
);

annotate service.Apps with @(
    UI.LineItem #ContainedApps : [
        {
            $Type : 'UI.DataField',
            Value : appName,
        },{
            $Type : 'UI.DataField',
            Value : appType.value,
        },{
            $Type : 'UI.DataField',
            Value : stage.value,
        },]
);
annotate service.ChildrenApps with @(
    UI.LineItem #i18nContainedApps : [
        {
            $Type : 'UI.DataField',
            Value : appName,
            Label : 'App Name',
        },
        {
            $Type : 'UI.DataField',
            Value : appType.value,
            Label : 'App Type',
        },{
            $Type : 'UI.DataField',
            Value : stage.value,
            Label : 'Stage',
        },]
);
annotate service.ChildrenApps with @(
    UI.HeaderInfo : {
        Title : {
            $Type : 'UI.DataField',
            Value : appName,
        },
        TypeName : '',
        TypeNamePlural : '',
    }
);
annotate service.ChildrenApps with @(
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Versions',
            ID : 'Versions',
            Target : 'versions/@UI.LineItem#Versions',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Technical Details',
            ID : 'TechnicalDetails',
            Target : '@UI.FieldGroup#TechnicalDetails',
        },
    ]
);
annotate service.App_Versions with @(
    UI.LineItem #Versions : [
    ]
);
annotate service.ChildrenApps with @(
    UI.FieldGroup #TechnicalDetails : {
        $Type : 'UI.FieldGroupType',
        Data : [
        ],
    }
);
annotate service.ChildrenApps with @(
    UI.HeaderFacets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'generalInformation',
            Target : '@UI.FieldGroup#generalInformation',
        },
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'itService',
            Target : '@UI.FieldGroup#itService',
        },
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'uxScore',
            Target : '@UI.FieldGroup#uxScore',
        },],
    UI.FieldGroup #App : {
        $Type : 'UI.FieldGroupType',
        Data : [],
    }
);
annotate service.Apps with @(
    UI.FieldGroup #itService : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : itService,
                Label : 'itService',
            },
            {
                $Type : 'UI.DataField',
                Value : itServiceOwner,
            },],
    }
);
annotate service.Apps with @(
    UI.FieldGroup #uxScore : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : uxScore,
            },],
    }
);
annotate service.ChildrenApps with @(
    UI.FieldGroup #generalInformation : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : currOperatingVersion,
                Label : 'currOperatingVersion',
            },{
                $Type : 'UI.DataField',
                Value : upcomingVersion,
                Label : 'upcomingVersion',
            },{
                $Type : 'UI.DataField',
                Value : stageOfUpcomingVersion,
                Label : 'stageOfUpcomingVersion',
            },{
                $Type : 'UI.DataField',
                Value : pillar_ID,
                Label : 'pillar_ID',
            },],
    }
);
annotate service.ChildrenApps with @(
    UI.FieldGroup #itService : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : productSuiteName,
                Label : 'productSuiteName',
            },{
                $Type : 'UI.DataField',
                Value : productOwner,
                Label : 'productOwner',
            },{
                $Type : 'UI.DataField',
                Value : itService,
                Label : 'itService',
            },{
                $Type : 'UI.DataField',
                Value : itServiceOwner,
                Label : 'itServiceOwner',
            },],
    }
);
annotate service.ChildrenApps with @(
    UI.FieldGroup #uxScore : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : uxScore,
                Label : 'uxScore',
            },],
    }
);
