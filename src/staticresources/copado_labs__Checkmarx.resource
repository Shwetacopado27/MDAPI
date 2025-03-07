{
    "recordTypeMap": {},
    "RecordSetBundles": [
      {
        "Records": [
          {
            "attributes": {
              "type": "copado__Function__c",
              "url": "/services/data/v56.0/sobjects/copado__Function__c/a0k7Q000000mktTQAQ"
            },
            "copado__ApexClass__c": "copado_labs.EvaluateScanResult",
            "copado__API_Name__c": "Run_Checkmarx_QIF_1",
            "copado__Callback_Type__c": "ApexClass",
            "copado__Image_Name__c": "cbsrlaowbenauz7nj0qcriifrxseww-checkmarx-docker:v1.0",
            "copado__Options__c": "[ ]",
            "copado__Parameters__c": "[ {\n  \"name\" : \"CX_TENANT\",\n  \"defaultValue\" : \"\"\n}, {\n  \"name\" : \"CX_BASE_IAM_URI\",\n  \"defaultValue\" : \"\"\n}, {\n  \"name\" : \"CX_BASE_URI\",\n  \"defaultValue\" : \"\"\n}, {\n  \"name\" : \"CX_APIKEY\",\n  \"defaultValue\" : \"\"\n}, {\n  \"name\" : \"CX_PROJECT\",\n  \"defaultValue\" : \"\"\n}, {\n  \"name\" : \"branchesAndFileIdJson\",\n  \"defaultValue\" : \"\"\n}, {\n  \"name\" : \"git_json\",\n  \"defaultValue\" : \"{$Context.Repository.Credential}\"\n}, {\n  \"name\" : \"git_depth\",\n  \"defaultValue\" : \"{$Pipeline.Property.GIT_DEPTH}\"\n}, {\n  \"name\" : \"consolidatedResultId\",\n  \"defaultValue\" : \"{$Context.JobExecution__r.DataJson.resultId}\"\n}, {\n  \"name\" : \"testResultIds\",\n  \"defaultValue\" : \"{$Context.JobExecution__r.DataJson.resultIds}\"\n}, {\n  \"name\" : \"CXSAST_PROJECT\",\n  \"defaultValue\" : \"\"\n}, {\n  \"name\" : \"CXSAST_SERVER\",\n  \"defaultValue\" : \"\"\n}, {\n  \"name\" : \"CXSAST_USERNAME\",\n  \"defaultValue\" : \"\"\n}, {\n  \"name\" : \"CXSAST_PASSWORD\",\n  \"defaultValue\" : \"\"\n}, {\n  \"name\" : \"CXSASTHIGH\",\n  \"defaultValue\" : \"\"\n}, {\n  \"name\" : \"CXSASTMEDIUM\",\n  \"defaultValue\" : \"\"\n}, {\n  \"name\" : \"CXSASTLOW\",\n  \"defaultValue\" : \"\"\n} ]",
            "copado__Script__c": "#!/bin/bash\nset -euo pipefail\ncd /app\n\n# declare/log function parameters and set the default value if any\nparameter() {\n    local v; eval v=\"\\${$1:=}\"; [ -z \"$v\" ] && { printf -v \"$1\" \"%s\" \"${3:-}\"; eval v=\"\\${$1:=}\"; }; echo \"[parameter] $1=$v\"\n}\n# execute a command and print the time it took to run it. Useful for troubleshooting performance issues\nfunction profiler() { export TIMEFORMAT=\"[profiler] %R seconds: $1\"$'\\n'; time $@; }\n\n\nparameter git_json\nparameter git_depth --optional 100\nparameter branchesAndFileIdJson\nparameter consolidatedResultId\nparameter testResultIds\nparameter CX_PROJECT\nparameter CX_TENANT\nparameter CX_BASE_IAM_URI\nparameter CX_BASE_URI\nparameter CX_APIKEY\nparameter CXSAST_PROJECT\nparameter CXSAST_SERVER\nparameter CXSAST_USERNAME\nparameter CXSAST_PASSWORD\nparameter CXSASTHIGH --optional 99999\nparameter CXSASTMEDIUM --optional 99999\nparameter CXSASTLOW --optional 99999\necho\n\n########## Get Source and Destination Branch names and Checkout Repository #############\ncopado -p \"Reading parameters...\"\noriginBranch=$(jq -r '.originBranch' <<< $branchesAndFileIdJson)\ndestinationBranch=$(jq -r '.destinationBranch' <<< $branchesAndFileIdJson)\n\ncopado -p \"cloning repo...\"\ncopado-git-get --depth \"$git_depth\" \"$destinationBranch\"\ncopado-git-get --depth \"$git_depth\" \"$originBranch\"\n\n########### Create delta packages for new, modified or deleted metadata  ############\ncopado -p \"Generating Diff between the Source and Destination branches...\"\nmkdir changed-sources\nsfdx sgd:source:delta --to \"HEAD\" --from \"origin/$destinationBranch\" --output changed-sources/ --generate-delta --source .\necho \"### Here's the files that have been changes in this US\"\ncat changed-sources/package/package.xml \necho\n\n################ Run SFDX Scanner only on Changed Metadata  ###############\n\nexitCode=0\n\nif test -n \"$CX_PROJECT\"; then\n    copado -p \"running Checkmarx Scan...\"\n    cx scan create --sast-incremental --output-name \"cx_output_report\" --report-format \"sarif\" \\\n        --output-path \".\" -s \"/app/changed-sources/\" --branch \"$originBranch\" --scan-types \"sast,sca\" \\\n        --project-name \"$CX_PROJECT\" --file-filter \"*.cls,!*__*.cls,*.page,*.js,*.html,*.trigger,!*__*.trigger,*.component,!*__*.component\" \\\n        || exitCode=$?\nfi\n\nif test -n \"$CXSAST_PROJECT\"; then\n    copado -p \"running CxSAST Scan...\"\n\n    /opt/cxconsole/runCxConsole.sh scan \\\n        -v \\\n        -Log /dev/stdout \\\n        -ForceScan \\\n        -ProjectName \"$CXSAST_PROJECT\" \\\n        -CxServer \"$CXSAST_SERVER\" \\\n        -cxUser \"$CXSAST_USERNAME\" \\\n        -cxPassword \"$CXSAST_PASSWORD\" \\\n        -LocationType folder \\\n        -LocationPath \"/app/changed-sources/\" \\\n        -includeExcludePattern '**/*.cls,**/*.trigger,**/*.js,**/*.page,**/*.html,**/*.component' \\\n        -SASTHigh \"$CXSASTHIGH\" \\\n        -SASTMedium \"$CXSASTMEDIUM\" \\\n        -SASTLow \"$CXSASTLOW\" \\\n        -reportPDF /app/cx_output_report.pdf \\\n        |& tee -a /tmp/output.txt \\\n        || exitCode=$?\n\n    # check the output. If runCxConsole says 'No files to zip', the command failed, but it was not an error\n    # there were no changes, or there were no CODE changes, do not fail because nothing was scanned\n    if grep -F 'No files to zip' /tmp/output.txt; then\n        exitCode=0;\n    fi\n\nfi\n\n# check if there was a report generated and notify the end user\nif test -n cx_output_report.*; then\n    copado -p \"No Analysis Output was generated\" -r \"No Analysis Output was generated, because there is no code to scan or because of an error in the scanning\"\nelse\n    copado -p \"Uploading Analysis Output\"\nfi\n\n# parse the json array testResultIds (it can be empty), and add consolidatedResultId (it can be empty as well)\ntestResultsIds=\"$(echo \"$testResultIds\"| jq '.[] ' -r)\"\ntestResultsIds=${testResultsIds:-$consolidatedResultId}\necho \"### exitCode=$exitCode testResultsIds=$testResultsIds;\"\n\n# if there are no parentids of testresultid or consolidatedResultId, upload to the Result object\nif test -z \"$testResultsIds\"; then\n    test -f cx_output_report.sarif && copado -u cx_output_report.sarif --name \"pmd-output.sarif.json\"\n    test -f /app/cx_output_report.pdf && copado -u /app/cx_output_report.pdf\nfi\nfor id in $testResultsIds; do\n    test -f cx_output_report.sarif && copado -u cx_output_report.sarif --name \"pmd-output.sarif.json\" --parentid \"$id\"\n    test -f /app/cx_output_report.pdf && copado -u /app/cx_output_report.pdf --parentid \"$id\"\ndone\n\nif [ $exitCode = 10 ]; then\n    copado -p \"Failed on threshold SAST HIGH, over $CXSASTHIGH\" -e \"Failed on threshold SAST HIGH, over $CXSASTHIGH\"\nelif [ $exitCode = 11 ]; then\n    copado -p \"Failed on threshold SAST Medium, over $CXSASTMEDIUM\" -e \"Failed on threshold SAST Medium, over $CXSASTMEDIUM\"\nelif [ $exitCode = 12 ]; then\n    copado -p \"Failed on threshold SAST LOW, over $CXSASTLOW\" -e \"Failed on threshold SAST LOW, over $CXSASTLOW\"\nelif [ $exitCode != 0 ]; then\n    copado -p \"Errors\" -e \"Errors were detected in the scan\"\nfi\nexit $exitCode",
            "copado__Type__c": "Custom",
            "copado__Version__c": "1",
            "Id": "a0k7Q000000mktTQAQ",
            "LastReferencedDate": "2023-02-02T08:57:21.000+0000",
            "LastViewedDate": "2023-02-02T08:57:21.000+0000",
            "Name": "Run Checkmarx QIF"
          }
        ],
        "ObjectType": "copado__Function__c"
      },
      {
        "Records": [
          {
            "attributes": {
              "type": "copado__JobTemplate__c",
              "url": "/services/data/v56.0/sobjects/copado__JobTemplate__c/a0t7Q000000n8xIQAQ"
            },
            "copado__ApiName__c": "Run_Checkmarx_QIF_1",
            "copado__Type__c": "Custom",
            "copado__Version__c": 1,
            "Id": "a0t7Q000000n8xIQAQ",
            "LastReferencedDate": "2023-02-03T09:35:59.000+0000",
            "LastViewedDate": "2023-02-03T09:35:59.000+0000",
            "Name": "Run CheckMarx QIF"
          }
        ],
        "ObjectType": "copado__JobTemplate__c"
      },
      {
        "Records": [
          {
            "attributes": {
              "type": "copado__JobStep__c",
              "url": "/services/data/v56.0/sobjects/copado__JobStep__c/a0s7Q000000u4P9QAI"
            },
            "copado__ApiName__c": "Run_Checkmarx_QIF_1_Set Repository For Scan_0.0",
            "copado__ConfigJson__c": "{\"flowName\":\"copado_labs.SetRepositoryForScan\",\"parameters\":[{\"name\":\"testIds\",\"value\":\"{$Context.JobExecution__r.DataJson.testIds}\"},{\"name\":\"jobStepToUpdate\",\"value\":\"{$Job.Step.Execute Scan.Id}\"}]}",
            "copado__CustomType__c": "Salesforce Flow",
            "copado__JobTemplate__c": "a0t7Q000000n8xIQAQ",
            "copado__Order__c": 0,
            "copado__Type__c": "Flow",
            "Id": "a0s7Q000000u4P9QAI",
            "Name": "Set Repository For Scan"
          },
          {
            "attributes": {
              "type": "copado__JobStep__c",
              "url": "/services/data/v56.0/sobjects/copado__JobStep__c/a0s7Q000000u4PAQAY"
            },
            "copado__ApiName__c": "Run_Checkmarx_QIF_1_Get Parent Execution Context_1.0",
            "copado__ConfigJson__c": "{\"flowName\":\"copado_labs.Carry_Orchastrator_Job_Execution_Context\",\"parameters\":[{\"name\":\"jobExecutionId\",\"value\":\"{$Job.FirstStep.copado__JobExecution__c}\"},{\"name\":\"testIds\",\"value\":\"{$Context.JobExecution__r.DataJson.testIds}\"},{\"name\":\"consolidatedResultId\",\"value\":\"{$Context.JobExecution__r.DataJson.resultId}\"}]}",
            "copado__CustomType__c": "Salesforce Flow",
            "copado__JobTemplate__c": "a0t7Q000000n8xIQAQ",
            "copado__Order__c": 1,
            "copado__Type__c": "Flow",
            "Id": "a0s7Q000000u4PAQAY",
            "Name": "Get Parent Execution Context"
          },
          {
            "attributes": {
              "type": "copado__JobStep__c",
              "url": "/services/data/v56.0/sobjects/copado__JobStep__c/a0s7Q000000u4PCQAY"
            },
            "copado__ApiName__c": "Run_Checkmarx_QIF_1_Execute Scan_3.0",
            "copado__ConfigJson__c": "{\"functionName\":\"Run_Checkmarx_QIF_1\",\"parameters\":[{\"name\":\"CX_TENANT\",\"value\":\"{$Pipeline.Property.CX_TENANT}\"},{\"name\":\"CX_BASE_IAM_URI\",\"value\":\"{$Pipeline.Property.CX_BASE_IAM_URI}\"},{\"name\":\"CX_BASE_URI\",\"value\":\"{$Pipeline.Property.CX_BASE_URI}\"},{\"name\":\"CX_APIKEY\",\"value\":\"{$Pipeline.Property.CX_APIKEY}\"},{\"name\":\"CX_PROJECT\",\"value\":\"{$Pipeline.Property.CX_PROJECT}\"},{\"name\":\"branchesAndFileIdJson\",\"value\":\"{$Context.Apex.copadoQuality.RetrieveBranchesAndFileIdForPmdScan}\"},{\"name\":\"git_json\",\"value\":\"{$Context.Repository.Credential}\"},{\"name\":\"git_depth\",\"value\":\"{$Pipeline.Property.GIT_DEPTH}\"},{\"name\":\"consolidatedResultId\",\"value\":\"{$Context.JobExecution__r.DataJson.resultId}\"},{\"name\":\"testResultIds\",\"value\":\"{$Context.JobExecution__r.DataJson.resultIds}\"},{\"name\":\"CXSAST_PROJECT\",\"value\":\"{$Pipeline.Property.CXSAST_PROJECT}\"},{\"name\":\"CXSAST_SERVER\",\"value\":\"{$Pipeline.Property.CXSAST_SERVER}\"},{\"name\":\"CXSAST_USERNAME\",\"value\":\"{$Pipeline.Property.CXSAST_USERNAME}\"},{\"name\":\"CXSAST_PASSWORD\",\"value\":\"{$Pipeline.Property.CXSAST_PASSWORD}\"},{\"name\":\"CXSASTHIGH\",\"value\":\"{$Pipeline.Property.CXSASTHIGH}\"},{\"name\":\"CXSASTMEDIUM\",\"value\":\"{$Pipeline.Property.CXSASTMEDIUM}\"},{\"name\":\"CXSASTLOW\",\"value\":\"{$Pipeline.Property.CXSASTLOW}\"}]}",
            "copado__CustomType__c": "Function",
            "copado__JobTemplate__c": "a0t7Q000000n8xIQAQ",
            "copado__Order__c": 3,
            "copado__Type__c": "Function",
            "Id": "a0s7Q000000u4PCQAY",
            "Name": "Execute Scan"
          }
        ],
        "ObjectType": "copado__JobStep__c"
      },
      {
        "Records": [
          {
            "attributes": {
              "type": "copado__ExtensionConfiguration__c",
              "url": "/services/data/v56.0/sobjects/copado__ExtensionConfiguration__c/a1u7Q000001NnynQAC"
            },
            "copado__AcceptanceCriteria__c": "{}",
            "copado__Active__c": true,
            "copado__ExtensionApplication__c": "Test",
            "copado__ExtensionTool__c": "Checkmarx",
            "copado__Status__c": "Inactive",
            "copado__TestType__c": "Checkmarx",
            "Id": "a1u7Q000001NnynQAC",
            "LastReferencedDate": "2023-01-13T11:15:21.000+0000",
            "LastViewedDate": "2023-01-13T11:15:21.000+0000",
            "Name": "Checkmarx"
          }
        ],
        "ObjectType": "copado__ExtensionConfiguration__c"
      }
    ],
    "blobsByUID": {}
  }