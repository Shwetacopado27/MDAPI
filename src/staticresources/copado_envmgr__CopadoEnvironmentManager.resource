{
  "recordTypeMap": {},
  "RecordSetBundles": [
    {
      "Records": [
        {
          "attributes": {
            "type": "copado__JobTemplate__c",
            "url": "/services/data/v59.0/sobjects/copado__JobTemplate__c/a0t7Q00000CbKBQQA3"
          },
          "Id": "a0t7Q00000CbKBQQA3",
          "Name": "Environment Manager Delete Org",
          "copado__ApiName__c": "copadoenvmgr_delete_org_1",
          "copado__Description__c": "<p>Delete an org immediately, instead of waiting ofr its expiration date</p>",
          "copado__Type__c": "Custom",
          "copado__Version__c": 1
        },
        {
          "attributes": {
            "type": "copado__JobTemplate__c",
            "url": "/services/data/v59.0/sobjects/copado__JobTemplate__c/a0t7Q00000CbKEHQA3"
          },
          "Id": "a0t7Q00000CbKEHQA3",
          "Name": "Environment Manager Delete User",
          "copado__ApiName__c": "copadoenvmgr_delete_user_1",
          "copado__Description__c": "<p>this is a demo template with a single &quot;manual&quot; step type.</p>",
          "copado__Type__c": "Custom",
          "copado__Version__c": 1
        },
        {
          "attributes": {
            "type": "copado__JobTemplate__c",
            "url": "/services/data/v59.0/sobjects/copado__JobTemplate__c/a0t7Q00000CbKaDQAV"
          },
          "Id": "a0t7Q00000CbKaDQAV",
          "Name": "Environment Manager Create Org",
          "copado__ApiName__c": "copadoenvmgr_create_org_1",
          "copado__Description__c": "<p>List of steps to create a sandbox or scratch org</p>",
          "copado__Type__c": "Custom",
          "copado__Version__c": 1,
          "copado__VolumeOptions__c": "[{\"name\":\"volumeSize\",\"value\":\"10\"},{\"name\":\"volumeTTL\",\"value\":\"120\"},{\"name\":\"preserveVolumeAfterExecution\",\"value\":\"false\"},{\"name\":\"volumeEnabled\",\"value\":\"true\"}]"
        },
        {
          "attributes": {
            "type": "copado__JobTemplate__c",
            "url": "/services/data/v59.0/sobjects/copado__JobTemplate__c/a0t7Q00000CbKaIQAV"
          },
          "Id": "a0t7Q00000CbKaIQAV",
          "Name": "Environment Manager Create User",
          "copado__ApiName__c": "copadoenvmgr_create_user_1",
          "copado__Description__c": "<p>List of steps to create Salesforce User in an Org</p>",
          "copado__Type__c": "Custom",
          "copado__Version__c": 1,
          "copado__VolumeOptions__c": "[{\"name\":\"volumeSize\",\"value\":\"10\"},{\"name\":\"volumeTTL\",\"value\":\"120\"},{\"name\":\"preserveVolumeAfterExecution\",\"value\":\"false\"},{\"name\":\"volumeEnabled\",\"value\":\"true\"}]"
        },
        {
          "attributes": {
            "type": "copado__JobTemplate__c",
            "url": "/services/data/v59.0/sobjects/copado__JobTemplate__c/a0t7Q00000CbKcJQAV"
          },
          "Id": "a0t7Q00000CbKcJQAV",
          "Name": "Environment Manager Demo Setup",
          "copado__ApiName__c": "copadoenvmgr_demo_setup_1",
          "copado__Description__c": "<p></p>",
          "copado__Type__c": "Custom",
          "copado__Version__c": 1
        }
      ],
      "ObjectType": "copado__JobTemplate__c"
    },
    {
      "Records": [
        {
          "attributes": {
            "type": "copado__JobStep__c",
            "url": "/services/data/v59.0/sobjects/copado__JobStep__c/a0s7Q000000WbmIQAS"
          },
          "Id": "a0s7Q000000WbmIQAS",
          "Name": "Delete Org",
          "copado__ApiName__c": "copadoenvmgr_delete_org_1_Delete Org_0",
          "copado__ConfigJson__c": "{\"functionName\":\"copadoenvmgr_delete_org\",\"parameters\":[{\"name\":\"name\",\"value\":\"{$Job.ExecutionParent.Name}\"},{\"name\":\"orgType\",\"value\":\"{$Job.ExecutionParent.copado_envmgr__EnvironmentDefinition__r.copado_envmgr__OrgType__c}\"},{\"name\":\"definitionStatus\",\"value\":\"{$Job.ExecutionParent.copado_envmgr__Status__c}\"},{\"name\":\"newOrgId\",\"value\":\"{$Destination.Id}\"},{\"name\":\"parentEnvSessionId\",\"value\":\"{$Source.Credential.SessionId}\"},{\"name\":\"parentEnvEndpoint\",\"value\":\"{$Source.Credential.Endpoint}\"},{\"name\":\"sfdxUrl\",\"value\":\"{$Destination.Property.SfdxUrl}\"},{\"name\":\"mockSfdxUrl\",\"value\":\"{$Source.Property.MOCKSFDXURL}\"}]}",
          "copado__CustomType__c": "Function",
          "copado__JobTemplate__c": "a0t7Q00000CbKBQQA3",
          "copado__Order__c": 0,
          "copado__Parent_Owner_Id__c": "0057Q000000MfOQ",
          "copado__Type__c": "Function"
        },
        {
          "attributes": {
            "type": "copado__JobStep__c",
            "url": "/services/data/v59.0/sobjects/copado__JobStep__c/a0s7Q000000WblyQAC"
          },
          "Id": "a0s7Q000000WblyQAC",
          "Name": "Delete Org",
          "copado__ApiName__c": "copadoenvmgr_delete_user_1_Delete Org_0",
          "copado__ConfigJson__c": "{\"functionName\":\"copadoenvmgr_delete_user\",\"parameters\":[{\"name\":\"username\",\"value\":\"{$Job.ExecutionParent.Name}\"},{\"name\":\"sfdxUrl\",\"value\":\"{$Destination.Property.SfdxUrl}\"},{\"name\":\"mockSfdxUrl\",\"value\":\"{$Source.Property.MOCKSFDXURL}\"}]}",
          "copado__CustomType__c": "Function",
          "copado__JobTemplate__c": "a0t7Q00000CbKEHQA3",
          "copado__Order__c": 0,
          "copado__Parent_Owner_Id__c": "0057Q000000MfOQ",
          "copado__Type__c": "Function"
        },
        {
          "attributes": {
            "type": "copado__JobStep__c",
            "url": "/services/data/v59.0/sobjects/copado__JobStep__c/a0s7Q000000WbmDQAS"
          },
          "Id": "a0s7Q000000WbmDQAS",
          "Name": "Create Org",
          "copado__ApiName__c": "copadoenvmgr_create_org_1_Create Org_0",
          "copado__ConfigJson__c": "{\"functionName\":\"copadoenvmgr_create_org\",\"parameters\":[{\"name\":\"name\",\"value\":\"{$Job.ExecutionParent.Name}\"},{\"name\":\"orgType\",\"value\":\"{$Job.ExecutionParent.copado_envmgr__OrgType__c}\"},{\"name\":\"definitionStatus\",\"value\":\"{$Job.ExecutionParent.copado_envmgr__Status__c}\"},{\"name\":\"expirationDays\",\"value\":\"{$Job.ExecutionParent.copado_envmgr__ExpirationDays__c}\"},{\"name\":\"defintionId\",\"value\":\"{$Job.ExecutionParent.Id}\"},{\"name\":\"definitionJson\",\"value\":\"{$Job.ExecutionParent.copado_envmgr__DefinitionJson__c}\"},{\"name\":\"environmentDefinitionId\",\"value\":\"{$Job.ExecutionParent.Id}\"},{\"name\":\"jobExecutionId\",\"value\":\"{$Context.JobExecution__r.Id}\"},{\"name\":\"skipCreateOrg\",\"value\":\"{$Context.JobExecution__r.DataJson.skipCreateOrg}\"},{\"name\":\"apexAfterOrgCreation\",\"value\":\"{$Job.ExecutionParent.copado_envmgr__ApexAfterOrgCreation__c}\"},{\"name\":\"mockSfdxUrl\",\"value\":\"{$Source.Property.MOCKSFDXURL}\"},{\"name\":\"ENVIRONMENT_MANAGER_AUTH\",\"value\":\"{$Source.Property.ENVIRONMENT_MANAGER_AUTH}\"},{\"name\":\"environmentOrgId\",\"value\":\"{$Context.JobExecution__r.DataJson.environmentOrgId}\"},{\"name\":\"newOrgId\",\"value\":\"{$Context.JobExecution__r.DataJson.newOrgId}\"}]}",
          "copado__CustomType__c": "Function",
          "copado__JobTemplate__c": "a0t7Q00000CbKaDQAV",
          "copado__Order__c": 0,
          "copado__Parent_Owner_Id__c": "0057Q000000MfOQ",
          "copado__Type__c": "Function"
        },
        {
          "attributes": {
            "type": "copado__JobStep__c",
            "url": "/services/data/v59.0/sobjects/copado__JobStep__c/a0s7Q000000WbmEQAS"
          },
          "Id": "a0s7Q000000WbmEQAS",
          "Name": "Deploy Metadata",
          "copado__ApiName__c": "copadoenvmgr_create_org_1_Deploy Metadata_1",
          "copado__ConfigJson__c": "{\"functionName\":\"copadoenvmgr_deploy_metadata\",\"parameters\":[{\"name\":\"name\",\"value\":\"{$Job.ExecutionParent.Name}\"},{\"name\":\"platform\",\"value\":\"SFDX\"},{\"name\":\"orgType\",\"value\":\"{$Job.ExecutionParent.copado_envmgr__OrgType__c}\"},{\"name\":\"orgCreatedDate\",\"value\":\"{$Destination.CreatedDate}\"},{\"name\":\"definitionStatus\",\"value\":\"{$Job.ExecutionParent.copado_envmgr__Status__c}\"},{\"name\":\"expirationDays\",\"value\":\"{$Job.ExecutionParent.copado_envmgr__ExpirationDays__c}\"},{\"name\":\"parentEnvSessionId\",\"value\":\"{$Source.Credential.SessionId}\"},{\"name\":\"parentEnvEndpoint\",\"value\":\"{$Source.Credential.Endpoint}\"},{\"name\":\"newEnvId\",\"value\":\"{$Destination.Id}\"},{\"name\":\"sfdxUrl\",\"value\":\"{$Destination.Property.SfdxUrl}\"},{\"name\":\"git_json\",\"value\":\"{$Context.Repository.Credential}\"},{\"name\":\"skipDeployMetadata\",\"value\":\"{$Context.JobExecution__r.DataJson.skipDeployMetadata}\"},{\"name\":\"fromBranch\",\"value\":\"{$Context.JobExecution__r.DataJson.fromBranch}\"},{\"name\":\"createBranch\",\"value\":\"{$Context.JobExecution__r.DataJson.createBranch}\"},{\"name\":\"isPreexistingOrg\",\"value\":\"{$Context.JobExecution__r.DataJson.isPreexistingOrg}\"},{\"name\":\"apexAfterMetadataDeployment\",\"value\":\"{$Job.ExecutionParent.copado_envmgr__ApexAfterMetadataDeployment__c}\"},{\"name\":\"apexAfterPackageInstallation\",\"value\":\"{$Job.ExecutionParent.copado_envmgr__ApexAfterPackageInstallation__c}\"},{\"name\":\"packageInstallationJson\",\"value\":\"{$Job.ExecutionParent.copado_envmgr__PackageInstallationJson__c}\"}]}",
          "copado__CustomType__c": "Function",
          "copado__JobTemplate__c": "a0t7Q00000CbKaDQAV",
          "copado__Order__c": 1,
          "copado__Parent_Owner_Id__c": "0057Q000000MfOQ",
          "copado__Type__c": "Function"
        },
        {
          "attributes": {
            "type": "copado__JobStep__c",
            "url": "/services/data/v59.0/sobjects/copado__JobStep__c/a0s7Q000000WbmFQAS"
          },
          "Id": "a0s7Q000000WbmFQAS",
          "Name": "Update Pipeline",
          "copado__ApiName__c": "copadoenvmgr_create_org_1_Update Pipeline_2",
          "copado__ConfigJson__c": "{\"functionName\":\"copadoenvmgr_update_pipeline\",\"parameters\":[{\"name\":\"name\",\"value\":\"{$Job.ExecutionParent.Name}\"},{\"name\":\"platform\",\"value\":\"SFDX\"},{\"name\":\"orgType\",\"value\":\"{$Job.ExecutionParent.copado_envmgr__OrgType__c}\"},{\"name\":\"expirationDays\",\"value\":\"{$Job.ExecutionParent.copado_envmgr__ExpirationDays__c}\"},{\"name\":\"parentEnvSessionId\",\"value\":\"{$Source.Credential.SessionId}\"},{\"name\":\"parentEnvEndpoint\",\"value\":\"{$Source.Credential.Endpoint}\"},{\"name\":\"pipelineId\",\"value\":\"{$Pipeline.Id}\"},{\"name\":\"newEnvId\",\"value\":\"{$Destination.Id}\"},{\"name\":\"sfdxUrl\",\"value\":\"{$Destination.Property.SfdxUrl}\"},{\"name\":\"git_json\",\"value\":\"{$Context.Repository.Credential}\"},{\"name\":\"skipUpdatePipeline\",\"value\":\"{$Context.JobExecution__r.DataJson.skipUpdatePipeline}\"},{\"name\":\"pipelineDestinationEnvId\",\"value\":\"{$Context.JobExecution__r.DataJson.pipelineDestinationEnvId}\"},{\"name\":\"fromBranch\",\"value\":\"{$Context.JobExecution__r.DataJson.fromBranch}\"},{\"name\":\"createBranch\",\"value\":\"{$Context.JobExecution__r.DataJson.createBranch}\"}]}",
          "copado__CustomType__c": "Function",
          "copado__JobTemplate__c": "a0t7Q00000CbKaDQAV",
          "copado__Order__c": 2,
          "copado__Parent_Owner_Id__c": "0057Q000000MfOQ",
          "copado__Type__c": "Function"
        },
        {
          "attributes": {
            "type": "copado__JobStep__c",
            "url": "/services/data/v59.0/sobjects/copado__JobStep__c/a0s7Q000000Wbm3QAC"
          },
          "Id": "a0s7Q000000Wbm3QAC",
          "Name": "Create User",
          "copado__ApiName__c": "copadoenvmgr_create_user_1_Create User_0",
          "copado__ConfigJson__c": "{\"functionName\":\"copadoenvmgr_create_user\",\"parameters\":[{\"name\":\"name\",\"value\":\"{$Job.ExecutionParent.Name}\"},{\"name\":\"expirationDays\",\"value\":\"{$Job.ExecutionParent.copado_envmgr__ExpirationDays__c}\"},{\"name\":\"username\",\"value\":\"{$Context.JobExecution__r.DataJson.username}\"},{\"name\":\"email\",\"value\":\"{$Context.JobExecution__r.DataJson.email}\"},{\"name\":\"randomString\",\"value\":\"{$Context.JobExecution__r.DataJson.randomString}\"},{\"name\":\"parentEnvSessionId\",\"value\":\"{$Source.Credential.SessionId}\"},{\"name\":\"parentEnvEndpoint\",\"value\":\"{$Source.Credential.Endpoint}\"},{\"name\":\"newEnvId\",\"value\":\"{$Destination.Id}\"},{\"name\":\"sfdxUrl\",\"value\":\"{$Destination.Property.SfdxUrl}\"},{\"name\":\"apexCode\",\"value\":\"{$Job.ExecutionParent.copado_envmgr__ApexCode__c}\"}]}",
          "copado__CustomType__c": "Function",
          "copado__JobTemplate__c": "a0t7Q00000CbKaIQAV",
          "copado__Order__c": 0,
          "copado__Parent_Owner_Id__c": "0057Q000000MfOQ",
          "copado__Type__c": "Function"
        },
        {
          "attributes": {
            "type": "copado__JobStep__c",
            "url": "/services/data/v59.0/sobjects/copado__JobStep__c/a0s7Q000000Wbm8QAC"
          },
          "Id": "a0s7Q000000Wbm8QAC",
          "Name": "Demo Setup",
          "copado__ApiName__c": "copadoenvmgr_demo_setup_1_Demo Setup_0",
          "copado__ConfigJson__c": "{\"functionName\":\"copadoenvmgr_demo_setup\",\"parameters\":[{\"name\":\"parentEnvId\",\"value\":\"{$Context.JobExecution__r.copado__Source__c}\"},{\"name\":\"projectId\",\"value\":\"{$Context.JobExecution__r.copado__ParentId__c}\"},{\"name\":\"orgType\",\"value\":\"{$Context.JobExecution__r.DataJson.orgType}\"},{\"name\":\"userEmail\",\"value\":\"{$User.Email}\"}]}",
          "copado__CustomType__c": "Function",
          "copado__JobTemplate__c": "a0t7Q00000CbKcJQAV",
          "copado__Order__c": 0,
          "copado__Parent_Owner_Id__c": "0057Q000000MfOQ",
          "copado__Type__c": "Function"
        }
      ],
      "ObjectType": "copado__JobStep__c"
    },
    {
      "Records": [
        {
          "attributes": {
            "type": "copado__Function__c",
            "url": "/services/data/v59.0/sobjects/copado__Function__c/a0k7Q000000SjaKQAS"
          },
          "Id": "a0k7Q000000SjaKQAS",
          "Name": "copadoenvmgr_create_org",
          "copado__API_Name__c": "copadoenvmgr_create_org",
          "copado__Image_Name__c": "fvcqzrjk8wbg8rxm1pgtxme5w3khpx-copado-environment-manager:v1",
          "copado__Options__c": "[]",
          "copado__Parameters__c": "[{\"name\":\"name\",\"defaultValue\":\"{$Job.ExecutionParent.Name}\",\"required\":true},{\"name\":\"orgType\",\"defaultValue\":\"{$Job.ExecutionParent.copado_envmgr__OrgType__c}\",\"required\":true},{\"name\":\"definitionStatus\",\"defaultValue\":\"{$Job.ExecutionParent.copado_envmgr__Status__c}\",\"required\":true},{\"name\":\"expirationDays\",\"defaultValue\":\"{$Job.ExecutionParent.copado_envmgr__ExpirationDays__c}\",\"required\":true},{\"name\":\"defintionId\",\"defaultValue\":\"{$Job.ExecutionParent.Id}\",\"required\":true},{\"name\":\"definitionJson\",\"defaultValue\":\"{$Job.ExecutionParent.copado_envmgr__DefinitionJson__c}\",\"required\":true},{\"name\":\"environmentDefinitionId\",\"defaultValue\":\"{$Job.ExecutionParent.Id}\",\"required\":true},{\"name\":\"jobExecutionId\",\"defaultValue\":\"{$Context.JobExecution__r.Id}\",\"required\":true},{\"name\":\"skipCreateOrg\",\"defaultValue\":\"{$Context.JobExecution__r.DataJson.skipCreateOrg}\",\"required\":false},{\"name\":\"apexAfterOrgCreation\",\"defaultValue\":\"{$Job.ExecutionParent.copado_envmgr__ApexAfterOrgCreation__c}\",\"required\":false},{\"name\":\"mockSfdxUrl\",\"defaultValue\":\"{$Source.Property.MOCKSFDXURL}\",\"required\":false},{\"name\":\"ENVIRONMENT_MANAGER_AUTH\",\"defaultValue\":\"{$Source.Property.ENVIRONMENT_MANAGER_AUTH}\",\"required\":true},{\"name\":\"environmentOrgId\",\"defaultValue\":\"{$Context.JobExecution__r.DataJson.environmentOrgId}\",\"required\":false},{\"name\":\"newOrgId\",\"defaultValue\":\"{$Context.JobExecution__r.DataJson.newOrgId}\",\"required\":false}]",
          "copado__Script__c": "#!/bin/bash\n\nset -euo pipefail # force exit-on-error\ntrap 'echo \"##### finished with exit code: $? line: $LINENO\"' EXIT ERR\nlog() { echo; echo \"[log] \" \"$*\"; }\nlog_param() { local p=$1; echo \"$p=${!p:-}\"; export \"${p?}\"; }\nlog_speed() { echo $'\\n'\"[start] $*...\" 1>&2; TIMEFORMAT=$'[timing]\\t%2R\\t'\"$*\"; time $@; }\n# try to disable slow and error-prone external connections to SF... it does not help with the update warnings though\nexport SF_DISABLE_TELEMETRY=true SF_DISABLE_AUTOUPDATE=true SF_USE_PROGRESS_BAR=false SF_JSON_TO_STDOUT=true SF_DISABLE_DNS_CHECK=true\nexport WAIT_TIME=480 # 8 hours\n\n\ncat <<'__EOT__' > /tmp/replacer.py\nimport sys, os, re, random\ncontent = sys.stdin.read()\ncontent = re.sub(r'(?i)\\{!RANDOM\\}', str(random.randint(10000, 99999)), content)\nprint(content)\n__EOT__\n\n\n# Function start\nlog_param name # {$Job.ExecutionParent.Name}\nlog_param orgType # {$Job.ExecutionParent.copado_envmgr__OrgType__c}\nlog_param definitionStatus # {$Job.ExecutionParent.copado_envmgr__Status__c}\nlog_param expirationDays # {$Job.ExecutionParent.copado_envmgr__ExpirationDays__c}\nlog_param defintionId # {$Job.ExecutionParent.Id}\nlog_param definitionJson # {$Job.ExecutionParent.copado_envmgr__DefinitionJson__c}\nlog_param environmentDefinitionId # {$Job.ExecutionParent.Id}\nlog_param jobExecutionId # {$Context.JobExecution__r.Id}\nlog_param skipCreateOrg # optional {$Context.JobExecution__r.DataJson.skipCreateOrg}\nlog_param apexAfterOrgCreation # optional {$Job.ExecutionParent.copado_envmgr__ApexAfterOrgCreation__c}\nlog_param mockSfdxUrl > /dev/null # optional {$Source.Property.MOCKSFDXURL}\nlog_param ENVIRONMENT_MANAGER_AUTH > /dev/null # {$Source.Property.ENVIRONMENT_MANAGER_AUTH}\n\n# the next two are set for pooled, pre-existing orgs\nlog_param environmentOrgId # optional {$Context.JobExecution__r.DataJson.environmentOrgId}\nlog_param newOrgId # optional {$Context.JobExecution__r.DataJson.newOrgId}\n\nsleep 5s # small delay to ensure correct logging of errors\n\nlog \"Authenticate the Parent Org / DevHub Org\"\n#note: we need to cleanup the endpoints. They are not the base url\nexport CF_SF_ENDPOINT=\"https://$(echo $CF_SF_ENDPOINT | sed -e 's/[^/]*\\/\\/\\([^@]*@\\)\\?\\([^:/]*\\).*/\\2/')\"\necho \"$ENVIRONMENT_MANAGER_AUTH\" > /tmp/SfdxUrl.json\nsf org login sfdx-url --alias parentOrg --sfdx-url-file /tmp/SfdxUrl.json\n\n# validate that there is \nparentOrgSfdxAuthUrl=\"$(sf org display --target-org parentOrg --verbose --json | jq -r '.result.sfdxAuthUrl')\"\nif [[ \"$parentOrgSfdxAuthUrl\" == \"null\" ]]; then\n    echo \"Error. the CLI did not had the required information\"; exit 2\nfi\n\nlog \"Preparing definition...\"\necho \"$definitionJson\" | python /tmp/replacer.py > /tmp/org-def.json\ncopado -p \"Creating Org type=$orgType\"\n\nif [[ \"$skipCreateOrg\" == true ]]; then\n    copado -p 'Skipping org creation'\n    echo \"{}\" > /tmp/org-create-result.json\nelif [[ \"$definitionStatus\" == \"Developing\" ]]; then\n    if [[ -z \"${mockSfdxUrl:-}\" ]]; then\n        copado -p 'Error: The Status of this definiton is \"Developing\" but there is no value in the System Property MOCKSFDXURL'\n        exit 1\n    fi\n    copado -p \"Dev mode: using existing MockSfdxUrl property in parent Environment\"\n    echo \"$mockSfdxUrl\" > /tmp/mockSfdxUrl.json\n    # note: we try twice, to have another change on network errors\n    sf org login sfdx-url --alias sandbox --sfdx-url-file /tmp/mockSfdxUrl.json || \\\n        sf org login sfdx-url --alias sandbox --sfdx-url-file /tmp/mockSfdxUrl.json\n    sf org display --target-org sandbox --json > /tmp/org-create-result.json\nelif [[ \"$orgType\" == \"Sandbox\"  ]]; then\n    log_speed sf org create sandbox --alias sandbox --target-org parentOrg -f /tmp/org-def.json \\\n        --no-prompt --wait \"$WAIT_TIME\" --no-track-source --json > /tmp/org-create-result.json \\\n        || { echo \"there was an error $?\"; cat /tmp/org-create-result.json; exit 9; }\nelif [[ \"$orgType\" == \"Scratch Org\"  ]]; then\n    log_speed sf org create scratch  --alias sandbox --target-dev-hub parentOrg -f /tmp/org-def.json \\\n        --wait \"$WAIT_TIME\" --duration-days \"$expirationDays\" --json > /tmp/org-create-result.json \\\n        || { echo \"there was an error $?\"; cat /tmp/org-create-result.json; exit 9; }\nelse\n    log \"error... orgType not recognized: $orgType\"\n    exit 98\nfi\n\ntouch /tmp/SfdxUrl.json # leave at least an empty file\nif [[ \"$skipCreateOrg\" != true ]]; then\n    echo\n    copado -p \"Save the new org\"\n    sf org display --target-org sandbox --verbose --json > /tmp/SfdxUrl.json\n    newOrgId=\"$(jq -r '.result.id' /tmp/SfdxUrl.json)\"\nfi\n\nlog \"Saving the results\"\n# call the Salesforce service to immediately save the newly created org information and modify the running job execution\ncurl -Ss --fail-with-body -H \"Authorization: Bearer $CF_SF_SESSIONID\" \\\n    -d \"action=saveOrg\" -d \"jobExecutionId=$jobExecutionId\" -d \"newOrgId=$newOrgId\" \\\n    -d \"environmentDefinitionId=$environmentDefinitionId\" -d \"environmentOrgId=$environmentOrgId\" \\\n    --data-urlencode sfdxUrl@/tmp/SfdxUrl.json \\\n    \"$CF_SF_ENDPOINT/services/apexrest/copado_envmgr/environmentsave\" -o /tmp/result.txt || { test -f /tmp/result.txt && cat /tmp/result.txt; exit 9; }\nlog \"Saved\"\n\nif [[ \"$skipCreateOrg\" != true && -n \"${apexAfterOrgCreation:-}\" ]]; then\n    log \"Execute apex code\"\n    echo \"$apexAfterOrgCreation\" > /tmp/apex.apex\n    sf apex run --file /tmp/apex.apex --target-org sandbox\n    log \"Execute apex code completed\"\nfi",
          "copado__Timeout__c": 480,
          "copado__Type__c": "Custom",
          "copado__Version__c": "1",
          "copado__Worker_Size__c": "S"
        },
        {
          "attributes": {
            "type": "copado__Function__c",
            "url": "/services/data/v59.0/sobjects/copado__Function__c/a0k7Q000000SjaZQAS"
          },
          "Id": "a0k7Q000000SjaZQAS",
          "Name": "copadoenvmgr_create_user",
          "copado__API_Name__c": "copadoenvmgr_create_user",
          "copado__Image_Name__c": "fvcqzrjk8wbg8rxm1pgtxme5w3khpx-copado-environment-manager:v1",
          "copado__Options__c": "[]",
          "copado__Parameters__c": "[{\"name\":\"name\",\"defaultValue\":\"{$Job.ExecutionParent.Name}\",\"required\":true},{\"name\":\"expirationDays\",\"defaultValue\":\"{$Job.ExecutionParent.copado_envmgr__ExpirationDays__c}\",\"required\":true},{\"name\":\"username\",\"defaultValue\":\"{$Context.JobExecution__r.DataJson.username}\",\"required\":true},{\"name\":\"email\",\"defaultValue\":\"{$Context.JobExecution__r.DataJson.email}\",\"required\":true},{\"name\":\"randomString\",\"defaultValue\":\"{$Context.JobExecution__r.DataJson.randomString}\",\"required\":true},{\"name\":\"parentEnvSessionId\",\"defaultValue\":\"{$Source.Credential.SessionId}\",\"required\":true},{\"name\":\"parentEnvEndpoint\",\"defaultValue\":\"{$Source.Credential.Endpoint}\",\"required\":true},{\"name\":\"newEnvId\",\"defaultValue\":\"{$Destination.Id}\",\"required\":true},{\"name\":\"sfdxUrl\",\"defaultValue\":\"{$Destination.Property.SfdxUrl}\",\"required\":true},{\"name\":\"apexCode\",\"defaultValue\":\"{$Job.ExecutionParent.copado_envmgr__ApexCode__c}\",\"required\":true}]",
          "copado__Script__c": "#!/bin/bash\n\nset -euo pipefail # force exit-on-error\ntrap 'echo \"##### finished with exit code: $? line: $LINENO\"' EXIT ERR\nlog() { echo; echo \"[log] \" \"$*\"; }\nlog_param() { local p=$1; echo \"$p=${!p:-}\"; export \"${p?}\"; }\nlog_speed() { echo $'\\n'\"[start] $*...\" 1>&2; TIMEFORMAT=$'[timing]\\t%2R\\t'\"$*\"; time $@; }\n# try to disable slow and error-prone external connections to SF... it does not help with the update warnings though\nexport SF_DISABLE_TELEMETRY=true SF_DISABLE_AUTOUPDATE=true SF_USE_PROGRESS_BAR=false SF_JSON_TO_STDOUT=true SF_DISABLE_DNS_CHECK=true\n\n\ncat <<'__EOT__' > /tmp/replacer.py\nimport sys, os, re\ncontent = sys.stdin.read()\ncontent = re.sub(r'(?i)\\{!USERNAME\\}', os.getenv('username') or '', content)\ncontent = re.sub(r'(?i)\\{!EMAIL\\}', os.getenv('email') or '', content)\ncontent = re.sub(r'(?i)\\{!RANDOM\\}', os.getenv('randomString') or '', content)\nprint(content)\n__EOT__\n\n\n# Function start\nlog_param name # {$Job.ExecutionParent.Name}\nlog_param expirationDays # {$Job.ExecutionParent.copado_envmgr__ExpirationDays__c}\nlog_param username # {$Context.JobExecution__r.DataJson.username}\nlog_param email # {$Context.JobExecution__r.DataJson.email}\nlog_param randomString # {$Context.JobExecution__r.DataJson.randomString}\nlog_param parentEnvSessionId # {$Source.Credential.SessionId}\nlog_param parentEnvEndpoint # {$Source.Credential.Endpoint}\nlog_param newEnvId # {$Destination.Id}\nlog_param sfdxUrl > /dev/null # {$Destination.Property.SfdxUrl}\nlog_param apexCode # {$Job.ExecutionParent.copado_envmgr__ApexCode__c}\n\n\nlog \"Authenticate the Sandbox / Scratch Org\"\necho \"$sfdxUrl\" > /tmp/SfdxUrl.json\nsf org login sfdx-url --alias sandbox --sfdx-url-file /tmp/SfdxUrl.json\n\nlog \"Execute apex code:\"\necho \"$apexCode\" | python /tmp/replacer.py > /tmp/create_user.apex\nsf apex run --file /tmp/create_user.apex --target-org sandbox\nsf apex get log --number 1 --target-org sandbox\nlog \"Execute apex code: completed successfully\"",
          "copado__Timeout__c": 60,
          "copado__Type__c": "Custom",
          "copado__Version__c": "1",
          "copado__Worker_Size__c": "S"
        },
        {
          "attributes": {
            "type": "copado__Function__c",
            "url": "/services/data/v59.0/sobjects/copado__Function__c/a0k7Q000001H4vZQAS"
          },
          "Id": "a0k7Q000001H4vZQAS",
          "Name": "copadoenvmgr_delete_org",
          "copado__API_Name__c": "copadoenvmgr_delete_org",
          "copado__Image_Name__c": "fvcqzrjk8wbg8rxm1pgtxme5w3khpx-copado-environment-manager:v1",
          "copado__Options__c": "[]",
          "copado__Parameters__c": "[{\"name\":\"name\",\"defaultValue\":\"{$Job.ExecutionParent.Name}\",\"required\":true},{\"name\":\"orgType\",\"defaultValue\":\"{$Job.ExecutionParent.copado_envmgr__EnvironmentDefinition__r.copado_envmgr__OrgType__c}\",\"required\":true},{\"name\":\"definitionStatus\",\"defaultValue\":\"{$Job.ExecutionParent.copado_envmgr__Status__c}\",\"required\":true},{\"name\":\"newOrgId\",\"defaultValue\":\"{$Destination.Id}\",\"required\":true},{\"name\":\"parentEnvSessionId\",\"defaultValue\":\"{$Source.Credential.SessionId}\",\"required\":true},{\"name\":\"parentEnvEndpoint\",\"defaultValue\":\"{$Source.Credential.Endpoint}\",\"required\":true},{\"name\":\"sfdxUrl\",\"defaultValue\":\"{$Destination.Property.SfdxUrl}\",\"required\":true},{\"name\":\"mockSfdxUrl\",\"defaultValue\":\"{$Source.Property.MOCKSFDXURL}\",\"required\":false}]",
          "copado__Script__c": "#!/bin/bash\n\nset -euo pipefail # force exit-on-error\ntrap 'echo \"##### finished with exit code: $? line: $LINENO\"' EXIT ERR\nlog() { echo; echo \"[log] \" \"$*\"; }\nlog_param() { local p=$1; echo \"$p=${!p:-}\"; export \"${p?}\"; }\nlog_speed() { echo $'\\n'\"[start] $*...\" 1>&2; TIMEFORMAT=$'[timing]\\t%2R\\t'\"$*\"; time $@; }\n# try to disable slow and error-prone external connections to SF... it does not help with the update warnings though\nexport SF_DISABLE_TELEMETRY=true SF_DISABLE_AUTOUPDATE=true SF_USE_PROGRESS_BAR=false SF_JSON_TO_STDOUT=true SF_DISABLE_DNS_CHECK=true\n\n\n# Function start\nlog_param name # {$Job.ExecutionParent.Name}\nlog_param orgType # {$Job.ExecutionParent.copado_envmgr__EnvironmentDefinition__r.copado_envmgr__OrgType__c}\nlog_param definitionStatus # {$Job.ExecutionParent.copado_envmgr__Status__c}\nlog_param newOrgId # {$Destination.Id}\nlog_param parentEnvSessionId # {$Source.Credential.SessionId}\nlog_param parentEnvEndpoint # {$Source.Credential.Endpoint}\nlog_param sfdxUrl > /dev/null # {$Destination.Property.SfdxUrl}\nlog_param mockSfdxUrl > /dev/null # optional {$Source.Property.MOCKSFDXURL}\n\n\nlog \"Authenticate the Sandbox / Scratch Org\"\necho \"$sfdxUrl\" > /tmp/SfdxUrl.json\nsf org login sfdx-url --alias sandbox --sfdx-url-file /tmp/SfdxUrl.json\n\nif [[ \"$definitionStatus\" == \"Developing\" ]]; then\n    copado -p \"Dev mode: no deletion will happen\"\nelif [[ \"$orgType\" == \"Sandbox\"  ]]; then\n    sf org delete sandbox --target-org sandbox --no-prompt\nelif [[ \"$orgType\" == \"Scratch Org\"  ]]; then\n    log \"Authenticate the Parent Org\"\n    export parentEnvEndpoint=\"https://$(echo $parentEnvEndpoint | sed -e 's/[^/]*\\/\\/\\([^@]*@\\)\\?\\([^:/]*\\).*/\\2/')\"\n    SFDX_ACCESS_TOKEN=\"$parentEnvSessionId\" sf org login access-token --alias parentOrg --instance-url \"$parentEnvEndpoint\" --no-prompt --set-default-dev-hub\n    sf org delete scratch --target-org sandbox --no-prompt\nelse\n    log \"error... orgType not recognized: $orgType\"\n    exit 1\nfi",
          "copado__Timeout__c": 480,
          "copado__Type__c": "Custom",
          "copado__Version__c": "1",
          "copado__Worker_Size__c": "S"
        },
        {
          "attributes": {
            "type": "copado__Function__c",
            "url": "/services/data/v59.0/sobjects/copado__Function__c/a0k7Q000001H5C9QAK"
          },
          "Id": "a0k7Q000001H5C9QAK",
          "Name": "copadoenvmgr_delete_user",
          "copado__API_Name__c": "copadoenvmgr_delete_user",
          "copado__Image_Name__c": "fvcqzrjk8wbg8rxm1pgtxme5w3khpx-copado-environment-manager:v1",
          "copado__Options__c": "[]",
          "copado__Parameters__c": "[{\"name\":\"username\",\"defaultValue\":\"{$Job.ExecutionParent.Name}\",\"required\":true},{\"name\":\"sfdxUrl\",\"defaultValue\":\"{$Destination.Property.SfdxUrl}\",\"required\":true},{\"name\":\"mockSfdxUrl\",\"defaultValue\":\"{$Source.Property.MOCKSFDXURL}\",\"required\":false}]",
          "copado__Script__c": "#!/bin/bash\n\nset -euo pipefail # force exit-on-error\ntrap 'echo \"##### finished with exit code: $? line: $LINENO\"' EXIT ERR\nlog() { echo; echo \"[log] \" \"$*\"; }\nlog_param() { local p=$1; echo \"$p=${!p:-}\"; export \"${p?}\"; }\nlog_speed() { echo $'\\n'\"[start] $*...\" 1>&2; TIMEFORMAT=$'[timing]\\t%2R\\t'\"$*\"; time $@; }\n# try to disable slow and error-prone external connections to SF... it does not help with the update warnings though\nexport SF_DISABLE_TELEMETRY=true SF_DISABLE_AUTOUPDATE=true SF_USE_PROGRESS_BAR=false SF_JSON_TO_STDOUT=true SF_DISABLE_DNS_CHECK=true\n\n\n# Function start\nlog_param username # {$Job.ExecutionParent.Name}\nlog_param sfdxUrl > /dev/null # {$Destination.Property.SfdxUrl}\nlog_param mockSfdxUrl > /dev/null # optional {$Source.Property.MOCKSFDXURL}\n\n\nlog \"Authenticate the Sandbox / Scratch Org\"\necho \"$sfdxUrl\" > /tmp/SfdxUrl.json\nsf org login sfdx-url --alias sandbox --sfdx-url-file /tmp/SfdxUrl.json\n\ncat << __EOT__ > /tmp/apex.apex\nString username = '$username';\n\nUser[] u = [SELECT Id, IsActive FROM User where Username = :username];\nif(u.isEmpty()) {\n    System.debug('User '+username+' not found');\n}else{\n    u[0].IsActive = false;\n    update as user u[0];\n}\n__EOT__\n\nlog \"Execute apex code:\"\nsf apex run --file /tmp/apex.apex --target-org sandbox",
          "copado__Timeout__c": 60,
          "copado__Type__c": "Custom",
          "copado__Version__c": "1",
          "copado__Worker_Size__c": "S"
        },
        {
          "attributes": {
            "type": "copado__Function__c",
            "url": "/services/data/v59.0/sobjects/copado__Function__c/a0k7Q000001HMmSQAW"
          },
          "Id": "a0k7Q000001HMmSQAW",
          "Name": "copadoenvmgr_deploy_metadata",
          "copado__API_Name__c": "copadoenvmgr_deploy_metadata",
          "copado__Image_Name__c": "fvcqzrjk8wbg8rxm1pgtxme5w3khpx-copado-environment-manager:v1",
          "copado__Options__c": "[]",
          "copado__Parameters__c": "[{\"name\":\"name\",\"defaultValue\":\"{$Job.ExecutionParent.Name}\",\"required\":true},{\"name\":\"platform\",\"defaultValue\":\"SFDX\",\"required\":true},{\"name\":\"orgType\",\"defaultValue\":\"{$Job.ExecutionParent.copado_envmgr__OrgType__c}\",\"required\":true},{\"name\":\"orgCreatedDate\",\"defaultValue\":\"{$Destination.CreatedDate}\",\"required\":true},{\"name\":\"definitionStatus\",\"defaultValue\":\"{$Job.ExecutionParent.copado_envmgr__Status__c}\",\"required\":true},{\"name\":\"expirationDays\",\"defaultValue\":\"{$Job.ExecutionParent.copado_envmgr__ExpirationDays__c}\",\"required\":true},{\"name\":\"parentEnvSessionId\",\"defaultValue\":\"{$Source.Credential.SessionId}\",\"required\":true},{\"name\":\"parentEnvEndpoint\",\"defaultValue\":\"{$Source.Credential.Endpoint}\",\"required\":true},{\"name\":\"newEnvId\",\"defaultValue\":\"{$Destination.Id}\",\"required\":true},{\"name\":\"sfdxUrl\",\"defaultValue\":\"{$Destination.Property.SfdxUrl}\",\"required\":true},{\"name\":\"git_json\",\"defaultValue\":\"{$Context.Repository.Credential}\",\"required\":true},{\"name\":\"skipDeployMetadata\",\"defaultValue\":\"{$Context.JobExecution__r.DataJson.skipDeployMetadata}\",\"required\":false},{\"name\":\"fromBranch\",\"defaultValue\":\"{$Context.JobExecution__r.DataJson.fromBranch}\",\"required\":false},{\"name\":\"createBranch\",\"defaultValue\":\"{$Context.JobExecution__r.DataJson.createBranch}\",\"required\":false},{\"name\":\"isPreexistingOrg\",\"defaultValue\":\"{$Context.JobExecution__r.DataJson.isPreexistingOrg}\",\"required\":false},{\"name\":\"apexAfterMetadataDeployment\",\"defaultValue\":\"{$Job.ExecutionParent.copado_envmgr__ApexAfterMetadataDeployment__c}\",\"required\":false},{\"name\":\"apexAfterPackageInstallation\",\"defaultValue\":\"{$Job.ExecutionParent.copado_envmgr__ApexAfterPackageInstallation__c}\",\"required\":false},{\"name\":\"packageInstallationJson\",\"defaultValue\":\"{$Job.ExecutionParent.copado_envmgr__PackageInstallationJson__c}\",\"required\":false}]",
          "copado__Script__c": "#!/bin/bash\n\nset -euo pipefail # force exit-on-error\ntrap 'echo \"##### finished with exit code: $? line: $LINENO\"' EXIT ERR\nlog() { echo; echo \"[log] \" \"$*\"; }\nlog_param() { local p=$1; echo \"$p=${!p:-}\"; export \"${p?}\"; }\nlog_speed() { echo $'\\n'\"[start] $*...\" 1>&2; TIMEFORMAT=$'[timing]\\t%2R\\t'\"$*\"; time $@; }\n# try to disable slow and error-prone external connections to SF... it does not help with the update warnings though\nexport SF_DISABLE_TELEMETRY=true SF_DISABLE_AUTOUPDATE=true SF_USE_PROGRESS_BAR=false SF_JSON_TO_STDOUT=true SF_DISABLE_DNS_CHECK=true\nexport WAIT_TIME=480 # 8 hours\n\ncat <<'__EOT__' > /tmp/package_installer_script.py\nimport sys, os, json, shlex\npackageMap = json.loads(os.environ.get('packageInstallationJson') or '{}')\nfor id, others in packageMap.items():\n    installationKeyParam = f'-k {shlex.quote(others[\"installation-key\"])}' if 'installation-key' in others else ''\n    print(f\"copado -p \\\"Installing {shlex.quote(others.get('name'))}\\\"; sf package install --no-prompt --target-org sandbox --security-type AllUsers --publish-wait 480 --wait 480 --package '{shlex.quote(id)}' {installationKeyParam} --json || test -n \\\"${{CF_COPADO_TESTING_MODE:-}}\\\"\")\n__EOT__\n\n\n# Function start\nlog_param name # {$Job.ExecutionParent.Name}\nlog_param platform # SFDX\nlog_param orgType # {$Job.ExecutionParent.copado_envmgr__OrgType__c}\nlog_param orgCreatedDate # {$Destination.CreatedDate}\nlog_param definitionStatus # {$Job.ExecutionParent.copado_envmgr__Status__c}\nlog_param expirationDays # {$Job.ExecutionParent.copado_envmgr__ExpirationDays__c}\nlog_param parentEnvSessionId # {$Source.Credential.SessionId}\nlog_param parentEnvEndpoint # {$Source.Credential.Endpoint}\nlog_param newEnvId # {$Destination.Id}\nlog_param sfdxUrl > /dev/null # {$Destination.Property.SfdxUrl}\nlog_param git_json # {$Context.Repository.Credential}\nlog_param skipDeployMetadata # optional {$Context.JobExecution__r.DataJson.skipDeployMetadata}\nlog_param fromBranch # optional {$Context.JobExecution__r.DataJson.fromBranch}\nlog_param createBranch # optional {$Context.JobExecution__r.DataJson.createBranch}\nlog_param isPreexistingOrg # optional {$Context.JobExecution__r.DataJson.isPreexistingOrg}\nlog_param apexAfterMetadataDeployment # optional {$Job.ExecutionParent.copado_envmgr__ApexAfterMetadataDeployment__c}\nlog_param apexAfterPackageInstallation # optional {$Job.ExecutionParent.copado_envmgr__ApexAfterPackageInstallation__c}\nlog_param packageInstallationJson # optional {$Job.ExecutionParent.copado_envmgr__PackageInstallationJson__c}\n\n\nlog \"Authenticate the Sandbox / Scratch Org\"\necho \"$sfdxUrl\" > /tmp/SfdxUrl.json\n# note: we try twice, to reduce the chance of network errors\nsf org login sfdx-url --alias sandbox --sfdx-url-file /tmp/SfdxUrl.json || \\\n    sf org login sfdx-url --alias sandbox --sfdx-url-file /tmp/SfdxUrl.json\n\npython /tmp/package_installer_script.py > /tmp/package_installer_script.sh\ncat /tmp/package_installer_script.sh\n. /tmp/package_installer_script.sh\n\nif [[ -n \"${apexAfterPackageInstallation:-}\" ]]; then\n    log \"Execute apex code\"\n    echo \"$apexAfterPackageInstallation\" > /tmp/apex.apex\n    sf apex run --file /tmp/apex.apex --target-org sandbox\n    log \"Execute apex code completed\"\nfi\n\nif [[ \"$skipDeployMetadata\" == true ]]; then copado -p 'Skipping deployment'; exit 0; fi\n\nlog \"git operations...\"\ncopado -p \"Fetch the git repository\"\nrm -fr /app/repository || true # execute outstanding reuses the volume and that leads to errors\nmkdir -p /app/repository\ncd /app/repository\n\ncopado-git-get --depth=100 \"$fromBranch\"\n\nif [[ -n \"$createBranch\" ]]; then\n    copado-git-get -c \"$createBranch\"\n    git push origin \"$createBranch\"\nfi\n\n# for sandboxes, filter the metadata to deploy. Scratch orgs deploy the whole thing, unless they were pre-created\n\nif [[ \"$orgType\" == \"Sandbox\" || \"$isPreexistingOrg\" == \"true\" ]]; then\n    commitId=\"$(git rev-list --after=\"$orgCreatedDate\" HEAD | tail -n1)\"\n    git log --pretty='%H %cd %s'\n    log \"Calculating changes since $orgCreatedDate ( commitId=$commitId )\"\n    if [[ -n \"$commitId\" ]]; then\n        log_speed sfdx sgd:source:delta --to \"HEAD\" --from \"$commitId\" --output /tmp/\n        log \"List of metadata to be deployed\"\n        cat /tmp/package/package.xml; echo\n        if [ \"$( wc -l /tmp/package/package.xml| cut -d' ' -f1)\" -gt 3 ]; then\n            if [[ \"$definitionStatus\" == \"Developing\" ]]; then\n                copado -p \"Dev mode. Not deploying\"\n            else\n                copado -p \"Deploying metadata\"\n                # Source tracking is enabled by default on scratch and sandbox orgs\n                sf project deploy start -x /tmp/package/package.xml --target-org sandbox --test-level NoTestRun --concise --json --ignore-conflicts --wait \"$WAIT_TIME\" \\\n                    | sed -n \"1,1000p\"\n                copado -p \"Deployment completed\"\n            fi\n        else\n            copado -p \"Nothing to deploy\"\n        fi\n    else\n        copado -p \"Nothing to deploy\"\n    fi\nelif [[ \"$orgType\" == \"Scratch Org\"  ]]; then\n    copado -p \"Deploying all metadata\"\n    sf project deploy start --target-org sandbox --test-level NoTestRun --concise --json --ignore-conflicts --wait \"$WAIT_TIME\" \\\n        | sed -n \"1,1000p\"\n    copado -p \"Deployment completed\"\nelse\n    log \"error... orgType not recognized: $orgType\"\n    exit 1\nfi\n\nif [[ -n \"${apexAfterMetadataDeployment:-}\" ]]; then\n    log \"Execute apex code\"\n    echo \"$apexAfterMetadataDeployment\" > /tmp/apex.apex\n    sf apex run --file /tmp/apex.apex --target-org sandbox\n    log \"Execute apex code completed\"\nfi",
          "copado__Timeout__c": 480,
          "copado__Type__c": "Custom",
          "copado__Version__c": "1",
          "copado__Worker_Size__c": "S"
        },
        {
          "attributes": {
            "type": "copado__Function__c",
            "url": "/services/data/v59.0/sobjects/copado__Function__c/a0k7Q000000SjaPQAS"
          },
          "Id": "a0k7Q000000SjaPQAS",
          "Name": "copadoenvmgr_update_pipeline",
          "copado__API_Name__c": "copadoenvmgr_update_pipeline",
          "copado__Image_Name__c": "fvcqzrjk8wbg8rxm1pgtxme5w3khpx-copado-environment-manager:v1",
          "copado__Options__c": "[]",
          "copado__Parameters__c": "[{\"name\":\"name\",\"defaultValue\":\"{$Job.ExecutionParent.Name}\",\"required\":true},{\"name\":\"platform\",\"defaultValue\":\"SFDX\",\"required\":true},{\"name\":\"orgType\",\"defaultValue\":\"{$Job.ExecutionParent.copado_envmgr__OrgType__c}\",\"required\":true},{\"name\":\"expirationDays\",\"defaultValue\":\"{$Job.ExecutionParent.copado_envmgr__ExpirationDays__c}\",\"required\":true},{\"name\":\"parentEnvSessionId\",\"defaultValue\":\"{$Source.Credential.SessionId}\",\"required\":true},{\"name\":\"parentEnvEndpoint\",\"defaultValue\":\"{$Source.Credential.Endpoint}\",\"required\":true},{\"name\":\"pipelineId\",\"defaultValue\":\"{$Pipeline.Id}\",\"required\":true},{\"name\":\"newEnvId\",\"defaultValue\":\"{$Destination.Id}\",\"required\":true},{\"name\":\"sfdxUrl\",\"defaultValue\":\"{$Destination.Property.SfdxUrl}\",\"required\":true},{\"name\":\"git_json\",\"defaultValue\":\"{$Context.Repository.Credential}\",\"required\":true},{\"name\":\"skipUpdatePipeline\",\"defaultValue\":\"{$Context.JobExecution__r.DataJson.skipUpdatePipeline}\",\"required\":false},{\"name\":\"pipelineDestinationEnvId\",\"defaultValue\":\"{$Context.JobExecution__r.DataJson.pipelineDestinationEnvId}\",\"required\":false},{\"name\":\"fromBranch\",\"defaultValue\":\"{$Context.JobExecution__r.DataJson.fromBranch}\",\"required\":false},{\"name\":\"createBranch\",\"defaultValue\":\"{$Context.JobExecution__r.DataJson.createBranch}\",\"required\":false}]",
          "copado__Script__c": "#!/bin/bash\n\nset -euo pipefail # force exit-on-error\ntrap 'echo \"##### finished with exit code: $? line: $LINENO\"' EXIT ERR\nlog() { echo; echo \"[log] \" \"$*\"; }\nlog_param() { local p=$1; echo \"$p=${!p:-}\"; export \"${p?}\"; }\nlog_speed() { echo $'\\n'\"[start] $*...\" 1>&2; TIMEFORMAT=$'[timing]\\t%2R\\t'\"$*\"; time $@; }\n# try to disable slow and error-prone external connections to SF... it does not help with the update warnings though\nexport SF_DISABLE_TELEMETRY=true SF_DISABLE_AUTOUPDATE=true SF_USE_PROGRESS_BAR=false SF_JSON_TO_STDOUT=true SF_DISABLE_DNS_CHECK=true\n\n\n# Function start\nlog_param name # {$Job.ExecutionParent.Name}\nlog_param platform # SFDX\nlog_param orgType # {$Job.ExecutionParent.copado_envmgr__OrgType__c}\nlog_param expirationDays # {$Job.ExecutionParent.copado_envmgr__ExpirationDays__c}\nlog_param parentEnvSessionId # {$Source.Credential.SessionId}\nlog_param parentEnvEndpoint # {$Source.Credential.Endpoint}\nlog_param pipelineId # {$Pipeline.Id}\nlog_param newEnvId # {$Destination.Id}\nlog_param sfdxUrl > /dev/null # {$Destination.Property.SfdxUrl}\nlog_param git_json # {$Context.Repository.Credential}\nlog_param skipUpdatePipeline # optional {$Context.JobExecution__r.DataJson.skipUpdatePipeline}\nlog_param pipelineDestinationEnvId # optional {$Context.JobExecution__r.DataJson.pipelineDestinationEnvId}\nlog_param fromBranch # optional {$Context.JobExecution__r.DataJson.fromBranch}\nlog_param createBranch # optional {$Context.JobExecution__r.DataJson.createBranch}\n\n\nif [[ \"$skipUpdatePipeline\" == true ]]; then copado -p 'Skipping execution'; exit 0; fi\n\nlog \"git operations...\"\ncopado -p \"Fetch the git repository\"\nmkdir -p /app/repository\ncd /app/repository\ncopado-git-get --depth=1 \"$fromBranch\"\n\nif [[ -n \"$createBranch\" ]]; then\n    # we fetch-or-create the branch\n    copado-git-get -c \"$createBranch\"\n    git push origin \"$createBranch\"\nfi\n\n\nlog \"Authenticate the Copado Org\"\nexport CF_SF_ENDPOINT=\"https://$(echo $CF_SF_ENDPOINT | sed -e 's/[^/]*\\/\\/\\([^@]*@\\)\\?\\([^:/]*\\).*/\\2/')\"\nSFDX_ACCESS_TOKEN=\"$CF_SF_SESSIONID\" sf org login access-token --alias copadoOrg --instance-url \"$CF_SF_ENDPOINT\" --no-prompt\n\n# NOTE: doing this in Apex is good because it is configurable (E.g. stages)\n# but it requires the USER requesting this to have edit permissions in the pipeline\n# Copado User has those permissions, and in APO a Copado user has that access as well, so I'm assuming it is normal?\ncat << __EOT__ > /tmp/apex.apex\nString pipelineId = '$pipelineId';\nString fromBranch = '$fromBranch';\nString createBranch = '$createBranch';\nString newEnvId = '$newEnvId';\nString pipelineDestinationEnvId = '$pipelineDestinationEnvId';\n\n// \"upsert\" the Pipeline Connection\ncopado__Deployment_Flow_Step__c dfs = new copado__Deployment_Flow_Step__c(\n    copado__Deployment_Flow__c = pipelineId,\n    copado__Destination_Environment__c = pipelineDestinationEnvId,\n    copado__Destination_Branch__c = fromBranch,\n    copado__Branch__c = createBranch,\n    copado__Source_Environment__c = newEnvId\n);\n\nboolean notFound = [SELECT Id FROM copado__Deployment_Flow_Step__c \n    WHERE copado__Deployment_Flow__c = :dfs.copado__Deployment_Flow__c\n    AND copado__Destination_Environment__c = :dfs.copado__Destination_Environment__c\n    AND copado__Source_Environment__c = :dfs.copado__Source_Environment__c\n    WITH USER_MODE LIMIT 1].isEmpty();\n\nif(notFound) {\n    insert as user dfs;\n}else{\n    System.debug('Pipeline Connection already exists. Skipping.');\n}\n\n__EOT__\n\nlog \"Execute apex code\"\nsf apex run --file /tmp/apex.apex --target-org copadoOrg | grep -vF 'ENTERING_MANAGED_PKG|copado'\nlog \"Execute apex code completed\"",
          "copado__Timeout__c": 5,
          "copado__Type__c": "Custom",
          "copado__Version__c": "1",
          "copado__Worker_Size__c": "S"
        },
        {
          "attributes": {
            "type": "copado__Function__c",
            "url": "/services/data/v59.0/sobjects/copado__Function__c/a0k7Q000001H5tlQAC"
          },
          "Id": "a0k7Q000001H5tlQAC",
          "Name": "copadoenvmgr_demo_setup",
          "copado__API_Name__c": "copadoenvmgr_demo_setup",
          "copado__Image_Name__c": "fvcqzrjk8wbg8rxm1pgtxme5w3khpx-copado-environment-manager:v1",
          "copado__Options__c": "[]",
          "copado__Parameters__c": "[{\"name\":\"parentEnvId\",\"defaultValue\":\"{$Context.JobExecution__r.copado__Source__c}\",\"required\":true},{\"name\":\"projectId\",\"defaultValue\":\"{$Context.JobExecution__r.copado__ParentId__c}\",\"required\":true},{\"name\":\"orgType\",\"defaultValue\":\"{$Context.JobExecution__r.DataJson.orgType}\",\"required\":true},{\"name\":\"userEmail\",\"defaultValue\":\"{$User.Email}\",\"required\":true}]",
          "copado__Script__c": "#!/bin/bash\n\nset -euo pipefail # force exit-on-error\ntrap 'echo \"##### finished with exit code: $? line: $LINENO\"' EXIT ERR\nlog() { echo; echo \"[log] \" \"$*\"; }\nlog_param() { local p=$1; echo \"$p=${!p:-}\"; export \"${p?}\"; }\nlog_speed() { echo $'\\n'\"[start] $*...\" 1>&2; TIMEFORMAT=$'[timing]\\t%2R\\t'\"$*\"; time $@; }\n# try to disable slow and error-prone external connections to SF... it does not help with the update warnings though\nexport SF_DISABLE_TELEMETRY=true SF_DISABLE_AUTOUPDATE=true SF_USE_PROGRESS_BAR=false SF_JSON_TO_STDOUT=true SF_DISABLE_DNS_CHECK=true\n\n\ncat <<'__EOT__' > /tmp/run.py\n#!/usr/bin/env python3\nimport sys, os, json\nfrom urllib.parse import quote_plus\nimport urllib.request, urllib.error\n\nSF_API_VERSION = os.getenv('{SF_API_VERSION}') or 'v58.0'\n\ndef api(url, method='GET', data=None, dataJson=None, contentType=\"application/json; charset=UTF-8\", rawResponse=False, sessionid=None, endpoint=None):\n    data = (data!=None and bytes(data.encode(\"utf-8\")) or (dataJson!=None and json.dumps(dataJson).encode('utf-8'))) or None\n    try:\n        req = urllib.request.Request(url=endpoint+url, data=data, method=method, headers={\"Authorization\": f\"Bearer {sessionid}\", \"Content-Type\": contentType})\n        with urllib.request.urlopen(req, timeout=150) as resp:\n            return (resp, resp.read()) if rawResponse else json.loads(resp.read() or 'null') \n    except urllib.error.HTTPError as e:\n        raise Exception(f'api_error: {e} response body={e.read()}\\n... url={endpoint+url} request body={data}') from None\n    except Exception as e:\n        raise Exception(f'api_error: {e}\\n... url={endpoint+url} request body={data}') from None\n\nendpoint, sessionid, orgType, sfdxUrl = os.getenv('CF_SF_ENDPOINT'), os.getenv('CF_SF_SESSIONID'), os.getenv('orgType'), sys.argv[1]\n# get the template ids\nsoql = f\"\"\"SELECT Id, copado__ApiName__c FROM copado__JobTemplate__c \n    WHERE copado__ApiName__c IN ('copadoenvmgr_delete_org_1','copadoenvmgr_delete_user_1','copadoenvmgr_create_org_1','copadoenvmgr_create_user_1')\"\"\"\nresp = api(f'/services/data/{SF_API_VERSION}/query/?q='+quote_plus(soql), sessionid=sessionid, endpoint=endpoint)\ntemplateMap = {r['copado__ApiName__c']: r['Id'] for r in resp['records']}\n\ndefinitionJson = \"{\\r\\n     \\\"sandboxName\\\": \\\"demo{!RANDOM}\\\",\\r\\n     \\\"licenseType\\\": \\\"Developer\\\",\\r\\n     \\\"autoActivate\\\": true\\r\\n}\"\nif orgType == 'Scratch Org':\n    definitionJson = '{\\r\\n  \"orgName\": \"COPADO company\",\\r\\n  \"edition\": \"Developer\",\\r\\n  \"language\": \"en_US\",\\r\\n  \"features\": [\"EnableSetPasswordInApi\"],\\r\\n  \"settings\": {\\r\\n    \"lightningExperienceSettings\": {\\r\\n      \"enableS1DesktopEnabled\": true\\r\\n    },\\r\\n    \"mobileSettings\": {\\r\\n      \"enableS1EncryptedStoragePref2\": false\\r\\n    }\\r\\n  }\\r\\n}\\r\\n'\n\n# create the EnvironmentDefinition object\nrec = {\n    \"Name\": f\"Demo {orgType} creation\",\n    \"copado_envmgr__DefinitionJson__c\": definitionJson,\n    \"copado_envmgr__OrgType__c\": orgType,\n    \"copado_envmgr__ExpirationDays__c\": 2,\n    \"copado_envmgr__PipelineDestinationEnvId__c\": os.getenv('pipelineDestinationEnvId'),\n    \"copado_envmgr__DefaultBranch__c\": os.getenv('sourceBranch'),\n    \"copado_envmgr__Description__c\": \"\",\n    \"copado_envmgr__DesiredAvailableOrgs__c\": 1,\n    \"copado_envmgr__Status__c\": \"Testing\",\n    \"copado_envmgr__JobTemplate__c\": templateMap['copadoenvmgr_create_org_1'],\n    \"copado_envmgr__DeleteJobTemplate__c\": templateMap['copadoenvmgr_delete_org_1'],\n    \"copado_envmgr__ParentEnvironment__c\" : os.getenv('parentEnvId'),\n    \"copado_envmgr__Project__c\" : os.getenv('projectId'),\n    }\n\nres = api(f\"/services/data/{SF_API_VERSION}/sobjects/copado_envmgr__EnvironmentDefinition__c\", \n    method='POST', dataJson=rec, sessionid=sessionid, endpoint=endpoint)\n\nenvironmentDefinitionId = res['id']\n\n# create the EnvironmentPersona object\nrec = {\n    \"Name\": \"QA (Standard User)\",\n    \"copado_envmgr__EnvironmentDefinition__c\": environmentDefinitionId,\n    \"copado_envmgr__ExpirationDays__c\": 2,\n    \"copado_envmgr__ApexCode__c\": \"User user = new User();\\n// Select a standard platform user profile. NOTE: selecting the Profile by Name is sensitive to the language of the org\\nProfile p = [SELECT Id FROM Profile WHERE Name = 'Standard Platform User' ORDER BY CreatedDate ASC LIMIT 1];\\nuser.ProfileId = p.Id;\\nuser.LastName = '{!USERNAME}';\\nuser.Email = '{!EMAIL}';\\nuser.Username = '{!USERNAME}';\\nuser.Alias = 'nr';\\nuser.TimeZoneSidKey = 'America/Los_Angeles';\\nuser.EmailEncodingKey = 'UTF-8';\\nuser.LanguageLocaleKey = 'en_US';\\nuser.LocaleSidKey = 'en_US';\\ninsert user;\\nSystem.resetPassword(user.Id, true);\\n\",\n    \"copado_envmgr__Username__c\": os.getenv('userEmail')+\".user{!RANDOM}\",\n    \"copado_envmgr__Description__c\": \"\",\n    \"copado_envmgr__JobTemplate__c\": templateMap['copadoenvmgr_create_user_1'],\n    \"copado_envmgr__DeleteJobTemplate__c\": templateMap['copadoenvmgr_delete_user_1'],\n    }\nres = api(f\"/services/data/{SF_API_VERSION}/sobjects/copado_envmgr__EnvironmentPersona__c\", \n    method='POST', dataJson=rec, sessionid=sessionid, endpoint=endpoint)\n\n# create the EnvironmentPersona object\nrec = {\n    \"Name\": \"Dev (System Administrator)\",\n    \"copado_envmgr__EnvironmentDefinition__c\": environmentDefinitionId,\n    \"copado_envmgr__ExpirationDays__c\": 2,\n    \"copado_envmgr__ApexCode__c\": \"User user = new User();\\n// Select a sysadmin profile. NOTE: selecting the Profile by Name is sensitive to the language of the org\\nProfile p = [SELECT Id FROM Profile WHERE UserType = 'Standard' AND PermissionsAuthorApex = true ORDER BY CreatedDate ASC LIMIT 1];\\nuser.ProfileId = p.Id;\\nuser.LastName = '{!USERNAME}';\\nuser.Email = '{!EMAIL}';\\nuser.Username = '{!USERNAME}';\\nuser.Alias = 'nr';\\nuser.TimeZoneSidKey = 'America/Los_Angeles';\\nuser.EmailEncodingKey = 'UTF-8';\\nuser.LanguageLocaleKey = 'en_US';\\nuser.LocaleSidKey = 'en_US';\\ninsert user;\\nSystem.resetPassword(user.Id, true);\\n\",\n    \"copado_envmgr__Username__c\": os.getenv('userEmail')+\".admin{!RANDOM}\",\n    \"copado_envmgr__Description__c\": \"\",\n    \"copado_envmgr__JobTemplate__c\": templateMap['copadoenvmgr_create_user_1'],\n    \"copado_envmgr__DeleteJobTemplate__c\": templateMap['copadoenvmgr_delete_user_1'],\n    }\nres = api(f\"/services/data/{SF_API_VERSION}/sobjects/copado_envmgr__EnvironmentPersona__c\", \n    method='POST', dataJson=rec, sessionid=sessionid, endpoint=endpoint)\n\nif sfdxUrl:\n    # create the system property with the mock authentication in the \"parent Org\"\n    rec = {\n        \"Name\" : f\"MOCKSFDXURL\", \n        \"copado__API_Name__c\" : f\"MOCKSFDXURL\", \n        \"copado__Environment__c\" : os.getenv('parentEnvId'),\n        \"copado__Is_Sensitive__c\" : True,\n        \"copado__Value__c\": sfdxUrl }\n    api(f\"/services/data/{SF_API_VERSION}/sobjects/copado__System_Property__c\", \n        method='POST', dataJson=rec, sessionid=sessionid, endpoint=endpoint)\n\n__EOT__\n\n# Function start\nlog_param parentEnvId # {$Context.JobExecution__r.copado__Source__c}\nlog_param projectId # {$Context.JobExecution__r.copado__ParentId__c}\nlog_param orgType # {$Context.JobExecution__r.DataJson.orgType}\nlog_param userEmail # {$User.Email}\n\n\n#NOTE: a temporary issue with Copado Functions prevents seeing logs too short, this will pad the logs\nprintf '                                                                               \\n%.0s' {1..20}\n\n#NOTE: we need to cleanup the endpoints. They are not the base url\nexport CF_SF_ENDPOINT=\"https://$(echo $CF_SF_ENDPOINT | sed -e 's/[^/]*\\/\\/\\([^@]*@\\)\\?\\([^:/]*\\).*/\\2/')\"\n\nlog \"creating objects\"\npython /tmp/run.py \"\"\nlog \"creating objects: done\"",
          "copado__Timeout__c": 60,
          "copado__Type__c": "Custom",
          "copado__Version__c": "1",
          "copado__Worker_Size__c": "S"
        }
      ],
      "ObjectType": "copado__Function__c"
    }
  ],
  "blobsByUID": {}
}