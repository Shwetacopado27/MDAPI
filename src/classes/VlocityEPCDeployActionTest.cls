@isTest
public with sharing class VlocityEPCDeployActionTest {

    @TestSetup
    private static void createData() {
        setup();
    }

    @isTest
    private static void testDeployAction() {

        // now execute a configuration
        System.runAs(getRunAsUser()) {
            VlocityEPCConfiguration__c config = prepareTestData();
            
            VlocityEPCDeployAction.Request request = new VlocityEPCDeployAction.Request();
            request.configuration = config;
            VlocityEPCDeployAction.Request[] requests = new VlocityEPCDeployAction.Request[]{request };
            VlocityEPCDeployAction.executeAction(requests);

            VlocityEPCDeployDestination__c dest = [SELECT Last_Job_Execution__c FROM VlocityEPCDeployDestination__c WHERE Configuration__c= :config.Id];
            System.assertNotEquals(null, dest.Last_Job_Execution__c, 'job execution not set');

            // test the empty constructor (constructor requred for Flows)
            VlocityEPCDeployAction action = new VlocityEPCDeployAction();
        }
    }



    private static VlocityEPCConfiguration__c prepareTestData() {
        copado__Git_Repository__c repository = new copado__Git_Repository__c(Name = 'copado-unit-test');
        insert repository;
        copado__Deployment_Flow__c pipeline = new copado__Deployment_Flow__c(Name = 'copado-unit-test', 
                                                  copado__Platform__c = 'Other', 
                                                  copado__Git_Repository__c = repository.Id);
        insert pipeline;
        
        copado__Environment__c env = new copado__Environment__c(
            Name = 'copado-unit-test'
        );
        insert env;

        VlocityEPCConfiguration__c config = new VlocityEPCConfiguration__c(
            Name = 'copado-unit-test',
            Pipeline__c = pipeline.Id,
            Source_Branch__c = 'main'
        );
        insert config;

        VlocityEPCDeployDestination__c dst = new VlocityEPCDeployDestination__c(
            Configuration__c = config.Id,
            Environment__c = env.Id
        );
        insert dst;

        copado__JobTemplate__c template = new copado__JobTemplate__c(Name='VlocityEPC_Deploy', copado__Version__c=1);
        insert template;

        return config;
    }

	// TestUtilities.cls copied and adapted from copadodx-extension-package    

    public static void setup() {
        User runAsUser = createUser();
        assignPermissionSet(runAsUser.Id);
        System.runAs(runAsUser) {
            assignLicense(runAsUser.Id);
        }
    }

    public static User createUser() {
        User runAsUser = new User(
            LastName = 'UserLastName',
            Username = 'username@myemail.com',
            Email = 'username@myemail.com',
            Alias = 'MyAlias',
            TimeZoneSidKey = 'America/Los_Angeles',
            LocaleSidKey = 'en_US',
            EmailEncodingKey = 'UTF-8',
            ProfileId = [SELECT Id, Name FROM Profile WHERE UserType = 'Standard' AND PermissionsPrivacyDataAccess = false AND PermissionsSubmitMacrosAllowed = true AND PermissionsMassInlineEdit = true LIMIT 1].Id,
            LanguageLocaleKey = 'en_US'
        );
        insert runAsUser;
        return runAsUser;
    }

    public static User getRunAsUser() {
        List<User> runAsUsers = [SELECT Id FROM User WHERE Username = 'username@myemail.com'];
        return runAsUsers[0];
    }

    public static void assignLicense(Id userId) {
        copado.GlobalAPI copadoGlobalAPI = new copado.GlobalAPI();
        copado.GlobalAPI.UserLicense userLicense = new copado.GlobalAPI.UserLicense();
        userLicense.isCCMEnabled = true;
        userLicense.isCopadoEnabled = true;
        userLicense.userId = userId;
        copadoGlobalAPI.upsertCopadoLicense(userLicense);
    }

    public static void assignPermissionSet(Id userId) {
        List<PermissionSetAssignment> assignments = new List<PermissionSetAssignment>();
        Set<String> permissions = new Set<String>{'Copado_User', 'Copado_Functions', 'Copado_Job_Engine', 'Vlocity_EPC_Deploy'};
        for (PermissionSet permission : [SELECT Id, Name FROM PermissionSet WHERE Name IN :permissions]) {
            assignments.add(new PermissionSetAssignment(AssigneeId = userId, PermissionSetId = permission.Id));
        }
        insert assignments;
    }
}