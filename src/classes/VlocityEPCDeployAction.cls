global with sharing class VlocityEPCDeployAction implements copado.JobExecutionCallback {
    // Job template that will execute this Deployment
    private final static String TEMPLATE_NAME = 'VlocityEPC_Deploy_1';

    global VlocityEPCDeployAction() {
    }
    // TODO: there is a limit of ~5 maximum destinations, due to Job Template Execution Limits. Validate it
    // NOTE: not batch safe, but with the low limit mentioned, not actually necessary
    @InvocableMethod(label='Execute a Deployment from a Vlocity EPC configuration' category='Copado VlocityEPC')
    global static void executeAction(Request[] requests) {
        copado.CreateExecution.Request[] jobs = new copado.CreateExecution.Request[]{};

        Map<Id, Request> requestsByConfigurationId = new Map<Id, Request>();
        for(Request r : requests) {
            requestsByConfigurationId.put(r.configuration.Id, r);
        }
        VlocityEPCDeployDestination__c[] dests = [SELECT Id, Environment__c, Configuration__c, Configuration__r.Source_Branch__c, Configuration__r.Pipeline__c 
            FROM VlocityEPCDeployDestination__c 
            WHERE Configuration__c in :requestsByConfigurationId.keySet() WITH SECURITY_ENFORCED ORDER BY Configuration__c, Environment__c];

        for(VlocityEPCDeployDestination__c dest : dests) {
            Request request = requestsByConfigurationId.get(dest.Configuration__c);
            if(request.selectedDestinations!=null && !request.selectedDestinations.contains(dest.Id)) {
                continue; // ignore not selected destinations
            }
            copado.CreateExecution.Request job = new copado.CreateExecution.Request();
            job.runAfterInstantiation = true;
            job.parentId = dest.Id;
            job.pipelineId = dest.Configuration__r.Pipeline__c;
            job.destinationId = dest.Environment__c;
            job.templateName = TEMPLATE_NAME;
            job.dataJson = JSON.serialize(dest.Configuration__r);
            job.callback = VlocityEPCDeployAction.class.getName();
            jobs.add(job);
        }

        VlocityEPCDeployment__c[] deployments = new VlocityEPCDeployment__c[]{};

        copado__JobExecution__c[] jobsExecutions = copado.CreateExecution.execute(jobs);

        integer idx=0;
        for(copado__JobExecution__c job : jobsExecutions) {
            dests[idx].Last_Job_Execution__c = job.Id;
            deployments.add(new VlocityEPCDeployment__c(
                Template__c = dests[idx].Configuration__c,
                Environment__c = dests[idx].Environment__c,
                Source_Branch__c = dests[idx].Configuration__r.Source_Branch__c,
                Job_Execution__c = job.Id
            ));
            idx++;
        }

        update Security.stripInaccessible(AccessType.UPDATABLE, dests).getRecords();
        insert Security.stripInaccessible(AccessType.CREATABLE, deployments).getRecords();
    }

    // callback to update the Result lookup in the VlocityEPCDeployment__c object
    global void execute(copado__JobExecution__c job, String status) {
        // get the newest result associated with this job execution
        copado__Result__c[] results = [SELECT Id
            FROM copado__Result__c 
            WHERE copado__JobStep__r.copado__JobExecution__c = :job.Id 
            WITH SECURITY_ENFORCED ORDER BY CreatedDate DESC LIMIT 1];
        if(results.isEmpty()) {
            return;
        }

        VlocityEPCDeployment__c[] deployments = [SELECT Id, Result__c
            FROM VlocityEPCDeployment__c 
            WHERE Job_Execution__c = :job.Id AND Result__c != :results[0].Id
            WITH SECURITY_ENFORCED ORDER BY CreatedDate DESC LIMIT 1];
        if(deployments.isEmpty()) {
            return;
        }
        deployments[0].Result__c = results[0].Id;
        // NOTE: this could be improved, detecting if any field was removed (they are all necessary)
	    update Security.stripInaccessible(AccessType.UPDATABLE, deployments).getRecords();
    }

    global with sharing class Request {
        @InvocableVariable
        global VlocityEPCConfiguration__c configuration;
        @InvocableVariable
        global String selectedDestinations;
    }
}