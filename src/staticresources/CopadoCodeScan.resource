{
    "recordTypeMap": {},
    "RecordSetBundles": [
      {
        "Records": [
          {
            "attributes": {
              "type": "copado__ExtensionConfiguration__c",
              "url": "/services/data/v60.0/sobjects/copado__ExtensionConfiguration__c/a0iWV0000004NR3YAM"
            },
            "copado__AcceptanceCriteria__c": "{}",
            "copado__Active__c": true,
            "copado__ExtensionApplication__c": "Test",
            "copado__ExtensionTool__c": "CodeScan",
            "copado__Status__c": "Inactive",
            "copado__TestType__c": "CodeScan",
            "Id": "a0iWV0000004NR3YAM",
            "LastReferencedDate": "2024-02-12T09:21:59.000+0000",
            "LastViewedDate": "2024-02-12T09:21:59.000+0000",
            "Name": "Code Scan"
          }
        ],
        "ObjectType": "copado__ExtensionConfiguration__c"
      },
      {
        "Records": [
          {
            "attributes": {
            "type": "copado__Function__c",
            "url": "/services/data/v62.0/sobjects/copado__Function__c/a0lJ70000011dR5IAI"
          },
          "copado__API_Name__c": "Run_Code_Scan_1",
          "copado__Image_Name__c": "xieeoka6kixfqik4tc07hnxxigf50h-sfdx-codescan-plugin:v1.0",
          "copado__Options__c": "[ ]",
          "copado__Parameters__c": "[ {\n  \"name\" : \"SERVER\",\n  \"defaultValue\" : \"\"\n}, {\n  \"name\" : \"PROJECT_ID\",\n  \"defaultValue\" : \"\"\n}, {\n  \"name\" : \"TOKEN\",\n  \"defaultValue\" : \"\"\n}, {\n  \"name\" : \"BRANCH\",\n  \"defaultValue\" : \"\"\n}, {\n  \"name\" : \"ORGANIZATION\",\n  \"defaultValue\" : \"\"\n}, {\n  \"name\" : \"git_json\",\n  \"defaultValue\" : \"{$Context.Repository.Credential}\"\n}, {\n  \"name\" : \"USER_STORY\",\n  \"defaultValue\" : \"\"\n} ]",
          "copado__Script__c": "# Author: Shweta Chadha\n# Date: 3rd Oct, 2024\n\n\necho \"param TOKEN = $TOKEN\"\necho \"param SERVER = $SERVER\"\necho \"param PROJECT_ID = $PROJECT_ID\"\necho \"param ORGANIZATION = $ORGANIZATION\"\necho \"param BRANCH = $BRANCH\"\n\n# If the branch is not set, fallback to feature/<USER_STORY>\nif test -z \"${BRANCH:-}\"; then\n    BRANCH=\"feature/$USER_STORY\"\nfi\necho \"param BRANCH = $BRANCH\"\n\n# Step 1: Clone the repo and fetch both the feature and master branches\ncopado -p \"Cloning repo...\"\ncopado-git-get $BRANCH\n# Fetch the master branch to ensure it is available locally\ngit fetch origin master\n\n# Fetch the feature branch to ensure it is up to date\ngit fetch origin $BRANCH\n\n# Checkout the feature branch\ngit checkout $BRANCH\n\n# Compare the feature branch with the remote master branch\nCHANGED_FILES=$(git diff --name-only origin/master...$BRANCH | grep '\\.cls$\\|\\.trigger$\\|\\.page$\\|\\.component$\\|\\.cmp$\\|\\.js$' || true)\n\n# Step 3: Run the code scan only on the delta files if changes are detected\nif [ -n \"$CHANGED_FILES\" ]; then\n    echo \"Changed files detected:\"\n    echo \"$CHANGED_FILES\"  # Output the original file paths\n\n    # Step 3: Create a temporary directory\n    TEMP_DIR=$(mktemp -d)\n    echo \"Temporary directory created at: $TEMP_DIR\"\n\n    # Step 4: Copy changed files to the temporary directory while preserving directory structure\n    while IFS= read -r FILE; do  # Read each line from CHANGED_FILES\n        if [ -f \"$FILE\" ]; then  # Check if the file exists\n            # Get the directory of the changed file\n            DIR_NAME=$(dirname \"$FILE\")\n            # Create the necessary directory structure in the temp dir\n            mkdir -p \"$TEMP_DIR/$DIR_NAME\"\n            # Copy the file to the corresponding directory in the temp dir\n            cp \"$FILE\" \"$TEMP_DIR/$FILE\"  # Copy using the original file path\n        else\n            echo \"Warning: File $FILE does not exist.\"\n        fi\n    done <<< \"$CHANGED_FILES\"  # Pass the changed files list to the while loop\n\n    # Verify that the files have been copied with their directory structure\n    echo \"Files copied to the temporary directory:\"\n    find \"$TEMP_DIR\" -type f  # List files in the temporary directory\n    \n    # List files in the temporary directory using ls\n    echo \"Contents of the temporary directory:\"\n    ls -R $TEMP_DIR  # Recursive list of files and directories\n\n    # Change to the temporary directory\n    cd $TEMP_DIR || exit 1  # Exit if changing directory fails\n    \n  exitCode=0  # Set the flag exitCode variable to 0\n  \n  #Run the Code Scan Command\n  #This command first execute the scan in code scan and then output the result into result.json also print in the log, \n  #If the execution of command is not successfull then the exitCode will be set to 1 else it will be 0\n  sfdx codescan:run --token=$TOKEN --server=$SERVER --projectkey=$PROJECT_ID --organization=$ORGANIZATION \\\n        -Dsonar.sources=. \\\n    -Dsonar.comparison.branch=$BRANCH -Dsonar.comparison.base=master --json 2>&1 | tee /tmp/result.json \\\n        || exitCode=$?\n\n    # Validate via SonarQube API if the result was uploaded because sometime even the exitCode is 1 the scan is successfull but failed in quality gate.\n    status=$(curl -u \"$TOKEN:\" \"$SERVER/api/ce/task?id=$(cat /tmp/result.json | jq -r '.task.id')\" | jq -r '.task.status')\n        \n    if [ \"$status\" == \"SUCCESS\" ]; then\n        echo \"SonarQube scan was uploaded successfully for branch $BRANCH.\"\n              # Check the quality gate status using SonarQube API\n        qualityGateStatus=$(curl -u \"$TOKEN:\" \"$SERVER/api/qualitygates/project_status?projectKey=$PROJECT_ID&branch=$BRANCH\" | jq -r '.projectStatus.status')\n\n        if [ \"$qualityGateStatus\" == \"OK\" ]; then\n                echo \"Quality gate passed.\"\n        else\n            echo \"Quality gate failed. Code scan failed due to quality gate failure.\"\n            exitCode=1\n        fi\n    else\n        echo \"SonarQube scan upload failed for branch $BRANCH.\"\n    fi\n    # Step 4: Check the result and upload it to SonarQube\n    if [ $exitCode -eq 0 ]; then\n        echo \"Code scan completed successfully.\"\n    else\n        echo \"Code scan failed with exit code $exitCode.\"\n        exit $exitCode\n        copado -u /tmp/result.json\n    fi\nelse\n    echo \"No changed files detected between $BRANCH and master.\"\n  \nfi",
          "copado__Timeout__c": 300,
          "copado__Type__c": "Custom",
          "copado__Version__c": "1",
          "copado__Worker_Size__c": "S",
          "Id": "a0lJ70000011dR5IAI",
          "LastReferencedDate": "2024-10-09T08:39:40.000+0000",
          "LastViewedDate": "2024-10-09T08:39:40.000+0000",
          "Name": "Run CodeScan"
        },
        {
          "attributes": {
            "type": "copado__Function__c",
            "url": "/services/data/v62.0/sobjects/copado__Function__c/a0lJ70000011dR6IAI"
          },
          "copado__ApexClass__c": "EvaluateCodeScanResult",
          "copado__API_Name__c": "Run_CodeScan_QIF",
          "copado__Description__c": "For the Quality Gate Engine only",
          "copado__Image_Name__c": "xieeoka6kixfqik4tc07hnxxigf50h-sfdx-codescan-plugin:v1.0",
          "copado__Options__c": "[ ]",
          "copado__Parameters__c": "[ {\n  \"name\" : \"SERVER\",\n  \"defaultValue\" : \"\"\n}, {\n  \"name\" : \"PROJECT_ID\",\n  \"defaultValue\" : \"\"\n}, {\n  \"name\" : \"TOKEN\",\n  \"defaultValue\" : \"\"\n}, {\n  \"name\" : \"ORGANIZATION\",\n  \"defaultValue\" : \"\"\n}, {\n  \"name\" : \"git_json\",\n  \"defaultValue\" : \"{$Context.Repository.Credential}\"\n}, {\n  \"name\" : \"branchesAndFileIdJson\",\n  \"defaultValue\" : \"{$Job.PrevStep.ResultDataJson__c}\"\n}, {\n  \"name\" : \"USER_STORY\",\n  \"defaultValue\" : \"\"\n}, {\n  \"name\" : \"BRANCH\",\n  \"defaultValue\" : \"\"\n} ]",
          "copado__Script__c": "# Author: Shweta Chadha\n# Date: 3rd Oct, 2024\n\n\necho \"param TOKEN = $TOKEN\"\necho \"param SERVER = $SERVER\"\necho \"param PROJECT_ID = $PROJECT_ID\"\necho \"param ORGANIZATION = $ORGANIZATION\"\necho \"param BRANCH = $BRANCH\"\n\n# Check if the USER_STORY contains \"CodeScan - \" and extract the actual user story if it does\nif [[ $USER_STORY == \"CodeScan - \"* ]]; then\n    # Extract the portion after \"CodeScan - \" (the actual user story)\n    USER_STORY=${USER_STORY#\"CodeScan - \"}\n    echo \"Updated USER_STORY = $USER_STORY\"\nfi\n\n# If the branch is not set, fallback to feature/<USER_STORY>\nif test -z \"${BRANCH:-}\"; then\n    BRANCH=\"feature/$USER_STORY\"\nfi\necho \"param BRANCH = $BRANCH\"\n\n\n# Step 1: Clone the repo and fetch both the feature and master branches\ncopado -p \"Cloning repo...\"\ncopado-git-get $BRANCH\n# Fetch the master branch to ensure it is available locally\ngit fetch origin master\n\n# Fetch the feature branch to ensure it is up to date\ngit fetch origin $BRANCH\n\n# Checkout the feature branch\ngit checkout $BRANCH\n\n# Compare the feature branch with the remote master branch\nCHANGED_FILES=$(git diff --name-only origin/master...$BRANCH | grep '\\.cls$\\|\\.trigger$\\|\\.page$\\|\\.component$\\|\\.cmp$\\|\\js$' || true)\n\n# Step 3: Run the code scan only on the delta files if changes are detected\nif [ -n \"$CHANGED_FILES\" ]; then\n    echo \"Changed files detected:\"\n    echo \"$CHANGED_FILES\"  # Output the original file paths\n\n    # Step 3: Create a temporary directory\n    TEMP_DIR=$(mktemp -d)\n    echo \"Temporary directory created at: $TEMP_DIR\"\n\n    # Step 4: Copy changed files to the temporary directory while preserving directory structure\n    while IFS= read -r FILE; do  # Read each line from CHANGED_FILES\n        if [ -f \"$FILE\" ]; then  # Check if the file exists\n            # Get the directory of the changed file\n            DIR_NAME=$(dirname \"$FILE\")\n            # Create the necessary directory structure in the temp dir\n            mkdir -p \"$TEMP_DIR/$DIR_NAME\"\n            # Copy the file to the corresponding directory in the temp dir\n            cp \"$FILE\" \"$TEMP_DIR/$FILE\"  # Copy using the original file path\n        else\n            echo \"Warning: File $FILE does not exist.\"\n        fi\n    done <<< \"$CHANGED_FILES\"  # Pass the changed files list to the while loop\n\n    # Verify that the files have been copied with their directory structure\n    echo \"Files copied to the temporary directory:\"\n    find \"$TEMP_DIR\" -type f  # List files in the temporary directory\n    \n    # List files in the temporary directory using ls\n    echo \"Contents of the temporary directory:\"\n    ls -R $TEMP_DIR  # Recursive list of files and directories\n\n    # Change to the temporary directory\n    cd $TEMP_DIR || exit 1  # Exit if changing directory fails\n    \n  exitCode=0  # Set the flag exitCode variable to 0\n  \n  #Run the Code Scan Command\n  #This command first execute the scan in code scan and then output the result into result.json also print in the log, \n  #If the execution of command is not successfull then the exitCode will be set to 1 else it will be 0\n  sfdx codescan:run --token=$TOKEN --server=$SERVER --projectkey=$PROJECT_ID --organization=$ORGANIZATION \\\n        -Dsonar.sources=. \\\n    -Dsonar.comparison.branch=$BRANCH -Dsonar.comparison.base=master --json 2>&1 | tee /tmp/result.json \\\n        || exitCode=$?\n\n    # Validate via SonarQube API if the result was uploaded because sometime even the exitCode is 1 the scan is successfull but failed in quality gate.\n    status=$(curl -u \"$TOKEN:\" \"$SERVER/api/ce/task?id=$(cat /tmp/result.json | jq -r '.task.id')\" | jq -r '.task.status')\n        \n    if [ \"$status\" == \"SUCCESS\" ]; then\n        echo \"SonarQube scan was uploaded successfully for branch $BRANCH.\"\n              # Check the quality gate status using SonarQube API\n        qualityGateStatus=$(curl -u \"$TOKEN:\" \"$SERVER/api/qualitygates/project_status?projectKey=$PROJECT_ID&branch=$BRANCH\" | jq -r '.projectStatus.status')\n\n        if [ \"$qualityGateStatus\" == \"OK\" ]; then\n                echo \"Quality gate passed.\"\n        else\n            echo \"Quality gate failed. Code scan failed due to quality gate failure.\"\n            exitCode=1\n        fi\n    else\n        echo \"SonarQube scan upload failed for branch $BRANCH.\"\n    fi\n    # Step 4: Check the result and upload it to SonarQube\n    if [ $exitCode -eq 0 ]; then\n        echo \"Code scan completed successfully.\"\n    else\n        echo \"Code scan failed with exit code $exitCode.\"\n        exit $exitCode\n        copado -u /tmp/result.json\n    fi\nelse\n    echo \"No changed files detected between $BRANCH and master.\"\n  \nfi",
          "copado__Timeout__c": 300,
          "copado__Type__c": "Custom",
          "copado__Version__c": "1",
          "copado__Worker_Size__c": "S",
          "Id": "a0lJ70000011dR6IAI",
          "LastReferencedDate": "2024-10-09T08:39:49.000+0000",
          "LastViewedDate": "2024-10-09T08:39:49.000+0000",
          "Name": "Run CodeScan QIF"
        }
        ],
        "ObjectType": "copado__Function__c"
      },
      {
        "Records": [
          {
            "attributes": {
              "type": "copado__JobTemplate__c",
              "url": "/services/data/v60.0/sobjects/copado__JobTemplate__c/a0xWV0000000C2nYAE"
            },
            "copado__ApiName__c": "Run_CodeScan_User_Story",
            "copado__Type__c": "Custom",
            "copado__Version__c": 1,
            "Id": "a0xWV0000000C2nYAE",
            "LastReferencedDate": "2024-02-12T08:28:24.000+0000",
            "LastViewedDate": "2024-02-12T08:28:24.000+0000",
            "Name": "Run CodeScan from User Story"
          },
          {
            "attributes": {
              "type": "copado__JobTemplate__c",
              "url": "/services/data/v60.0/sobjects/copado__JobTemplate__c/a0xWV0000000C2oYAE"
            },
            "copado__ApiName__c": "Run_CodeScan_QIF_1",
            "copado__Type__c": "Custom",
            "copado__Version__c": 1,
            "Id": "a0xWV0000000C2oYAE",
            "LastReferencedDate": "2024-02-12T09:29:07.000+0000",
            "LastViewedDate": "2024-02-12T09:29:07.000+0000",
            "Name": "Run CodeScan QIF"
          }
        ],
        "ObjectType": "copado__JobTemplate__c"
      },
      {
        "Records": [
          {
            "attributes": {
              "type": "copado__JobStep__c",
              "url": "/services/data/v60.0/sobjects/copado__JobStep__c/a0wWV0000000JvVYAU"
            },
            "copado__ApiName__c": "CodeScan_Run CodeScan_1",
            "copado__ConfigJson__c": "{\"functionName\":\"Run_Code_Scan_1\",\"parameters\":[{\"name\":\"SERVER\",\"value\":\"{$Pipeline.Property.CS_SERVER}\"},{\"name\":\"PROJECT_ID\",\"value\":\"{$Pipeline.Property.CS_PROJECT_ID}\"},{\"name\":\"TOKEN\",\"value\":\"{$Pipeline.Property.CS_TOKEN}\"},{\"name\":\"BRANCH\",\"value\":\"\"},{\"name\":\"ORGANIZATION\",\"value\":\"{$Pipeline.Property.CS_ORGANIZATION}\"},{\"name\":\"git_json\",\"value\":\"{$Context.Repository.Credential}\"},{\"name\":\"USER_STORY\",\"value\":\"{$Job.ExecutionParent.Name}\"}]}",
            "copado__CustomType__c": "Function",
            "copado__IsSkipped__c": false,
            "copado__JobTemplate__c": "a0xWV0000000C2nYAE",
            "copado__Order__c": 3,
            "copado__Type__c": "Function",
            "Id": "a0wWV0000000JvVYAU",
            "Name": "Run CodeScan"
          },
          {
            "attributes": {
              "type": "copado__JobStep__c",
              "url": "/services/data/v60.0/sobjects/copado__JobStep__c/a0wWV0000000JvWYAU"
            },
            "copado__ApiName__c": "Run CodeScan_1_Execute PMD_3",
            "copado__ConfigJson__c": "{\"functionName\":\"Run_CodeScan_QIF\",\"parameters\":[{\"name\":\"SERVER\",\"value\":\"{$Pipeline.Property.CS_SERVER}\"},{\"name\":\"PROJECT_ID\",\"value\":\"{$Pipeline.Property.CS_PROJECT_ID}\"},{\"name\":\"TOKEN\",\"value\":\"{$Pipeline.Property.CS_TOKEN}\"},{\"name\":\"ORGANIZATION\",\"value\":\"{$Pipeline.Property.CS_ORGANIZATION}\"},{\"name\":\"git_json\",\"value\":\"{$Context.Repository.Credential}\"},{\"name\":\"branchesAndFileIdJson\",\"value\":\"{$Context.Apex.copadoQuality.RetrieveBranchesAndFileIdForPmdScan}\"},{\"name\":\"USER_STORY\",\"value\":\"{$Job.ExecutionParent.Name}\"},{\"name\":\"BRANCH\",\"value\":\"\"}]}",            "copado__CustomType__c": "Function",
            "copado__IsSkipped__c": false,
            "copado__JobTemplate__c": "a0xWV0000000C2oYAE",
            "copado__Order__c": 4,
            "copado__Type__c": "Function",
            "Id": "a0wWV0000000JvWYAU",
            "Name": "Execute CodeScan"
          },
          {
            "attributes": {
              "type": "copado__JobStep__c",
              "url": "/services/data/v60.0/sobjects/copado__JobStep__c/a0wWV0000000JvYYAU"
            },
            "copado__ApiName__c": "Run CodeScan_1_Set Repository For Scan_1",
            "copado__ConfigJson__c": "{\"flowName\":\"SetRepositoryForScan\",\"parameters\":[{\"name\":\"testIds\",\"value\":\"{$Context.JobExecution__r.DataJson.testIds}\"},{\"name\":\"jobStepToUpdate\",\"value\":\"{$Job.Step.Execute CodeScan.Id}\"}]}",
            "copado__CustomType__c": "Salesforce Flow",
            "copado__IsSkipped__c": false,
            "copado__JobTemplate__c": "a0xWV0000000C2oYAE",
            "copado__Order__c": 1,
            "copado__Type__c": "Flow",
            "Id": "a0wWV0000000JvYYAU",
            "Name": "Set Repository For Scan"
          },
          {
            "attributes": {
              "type": "copado__JobStep__c",
              "url": "/services/data/v60.0/sobjects/copado__JobStep__c/a0wWV0000000JvZYAU"
            },
            "copado__ApiName__c": "Run_CodeScan_QIF_1_Get Parent Execution Context_5",
            "copado__ConfigJson__c": "{\"flowName\":\"Carry_Orchastrator_Job_Execution_Context\",\"parameters\":[{\"name\":\"jobExecutionId\",\"value\":\"{$Job.FirstStep.copado__JobExecution__c}\"},{\"name\":\"testIds\",\"value\":\"{$Context.JobExecution__r.DataJson.testIds}\"},{\"name\":\"consolidatedResultId\",\"value\":\"{$Context.JobExecution__r.DataJson.resultId}\"}]}",
            "copado__CustomType__c": "Salesforce Flow",
            "copado__IsSkipped__c": false,
            "copado__JobTemplate__c": "a0xWV0000000C2oYAE",
            "copado__Order__c": 2,
            "copado__Type__c": "Flow",
            "Id": "a0wWV0000000JvZYAU",
            "Name": "Get Parent Execution Context"
          }
        ],
        "ObjectType": "copado__JobStep__c"
      }
    ],
    "blobsByUID": {}
}
