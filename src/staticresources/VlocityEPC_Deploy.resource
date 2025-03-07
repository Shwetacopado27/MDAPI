{
    "recordTypeMap": {},
    "RecordSetBundles": [
      {
        "Records": [
          {
            "attributes": {
              "type": "copado__Function__c",
              "url": "/services/data/v56.0/sobjects/copado__Function__c/a0k7Q000000mDuiQAE"
            },
            "copado__API_Name__c": "VlocityEPC_Deploy",
            "copado__Image_Name__c": "tljkhq4ap5d0wlddpdixby16ki34oc-vlocity-epc-wizard:v1.0",
            "copado__Options__c": "[]",
            "copado__Parameters__c": "[{\"required\":false,\"name\":\"git_json\",\"defaultValue\":\"\"},{\"required\":false,\"name\":\"git_depth\",\"defaultValue\":\"\"},{\"required\":false,\"name\":\"dest_sessionId\",\"defaultValue\":\"\"},{\"required\":false,\"name\":\"dest_endpoint\",\"defaultValue\":\"\"},{\"required\":false,\"name\":\"source_branch\",\"defaultValue\":\"\"},{\"required\":false,\"name\":\"vlocity_verbose\",\"defaultValue\":\"\"},{\"required\":false,\"name\":\"vlocity_latest\",\"defaultValue\":\"\"},{\"required\":false,\"name\":\"deploy_yaml\",\"defaultValue\":\"\"}]",
            "copado__Script__c": "#!/bin/bash\nset -euo pipefail\ntrap upload_logs EXIT\n\n# declare/log function parameters and set the default value if any\nparameter() {\n    local v; eval v=\"\\${$1:=}\"; [ -z \"$v\" ] && { printf -v \"$1\" \"%s\" \"${3:-}\"; eval v=\"\\${$1:=}\"; }; echo \"[parameter] $1=$v\"\n}\n# execute a command and print the time it took to run it. Useful for troubleshooting performance issues\nfunction profiler() { export TIMEFORMAT=\"[profiler] %R seconds: $1\"$'\\n'; time $@; }\n\n# start of the upload_logs_periodically functionality\nfunction upload_logs() {\n    if test -s /tmp/watchdog_logs.txt; then\n        tail -c131000 /tmp/watchdog_logs.txt > /tmp/watchdog_logs.last.$$\n        echo '{}' | jq --rawfile text /tmp/watchdog_logs.last.$$ '{copado__Result_Data__c: $text}' > /tmp/watchdog_logs.request.$$\n        curl --silent --fail-with-body -XPATCH -H \"Content-type: application/json\" --data-binary \"@/tmp/watchdog_logs.request.$$\" -H \"Authorization: Bearer $CF_SF_SESSIONID\" \"$CF_SF_ENDPOINT/services/data/v50.0/sobjects/copado__Result__c/$CF_RESULTID\" -o /tmp/dummy.txt \\\n            || echo \"(logs.err $?)\"\n    fi\n}\n# every 10 / 60 seconds upload the last Xkb of logs in the Result__c object\nfunction upload_logs_periodically {\n    sleep=60\n    if (( SECONDS < 300 )); then sleep=10; fi\n    while true; do\n        sleep \"$sleep\"\n        upload_logs\n    done\n}\nupload_logs_periodically & # start watchdog process\n\n\n### MAIN FUNCTION\n\n#function_image tljkhq4ap5d0wlddpdixby16ki34oc-vlocity-epc-wizard:v1.0\nparameter git_json\nparameter git_depth --optional 100\nparameter dest_sessionId\nparameter dest_endpoint\nparameter source_branch\nparameter vlocity_verbose --optional true\nparameter vlocity_latest --optional false\nparameter deploy_yaml\necho\n\n# if VLOCITY_LATEST=true, upgrade to the latest vlocity build tool\nif [ \"$vlocity_latest\" == \"true\" ]; then\n\tcopado -p \"Upgrading to the latest vlocity build tool\"\n    cd ~\n    profiler npm install vlocity --local |& tee -a /tmp/watchdog_logs.txt\n    cd /app\n    # now trick the shell into loading this version and not the global one\n    alias vlocity=/home/func/node_modules/.bin/vlocity\nfi\n\n# clean up parameters\nexport dest_endpoint=\"https://$(echo $dest_endpoint | cut -d'/' -f3)\"\n\n# set up the Deploy.yaml file\nif test -z \"${deploy_yaml:-}\"; then\n\tdeploy_yaml='\nprojectPath: vlocity\nautoRetryErrors: true\nautoUpdateSettings: true\ngitCheck: true\nqueries:\n'\nelse\n\tcopado -p \"Applying custom Deploy.yaml\"\nfi\necho\necho \"### deploy_yaml:\"\necho \"$deploy_yaml\" | tee /tmp/Deploy.yaml\necho\n\ncopado -p \"cloning branch $source_branch\"\nprofiler copado-git-get --depth \"$git_depth\" \"$source_branch\" |& tee -a /tmp/watchdog_logs.txt\necho | tee -a /tmp/watchdog_logs.txt\n\nSECONDS=0 # this will force the watchdog process to reset the polling time.\ncopado -p \"Executing vlocity build tool\"\nvlocityExitCode=0\nvlocity -job /tmp/Deploy.yaml packDeploy -sf.instanceUrl \"$dest_endpoint\" -sf.sessionId \"$dest_sessionId\" --verbose \"$vlocity_verbose\" --simpleLogging \\\n    |& tee -a /tmp/watchdog_logs.txt || vlocityExitCode=$?\necho $'\\n'\"vlocity exit code: $vlocityExitCode\" | tee -a /tmp/watchdog_logs.txt\n\ncopado -p \"Attaching vlocity log files, if any\"\n[ -f \"VlocityBuildErrors.log\"  ] && copado -u VlocityBuildErrors.log\n[ -f \"VlocityBuildLog.yaml\"  ] && copado -u VlocityBuildLog.yaml\n\necho \"... done\"\nexit $vlocityExitCode",
            "copado__Type__c": "Custom",
            "copado__Version__c": "1",
            "Id": "a0k7Q000000mDuiQAE",
            "LastReferencedDate": "2023-02-01T16:03:48.000+0000",
            "LastViewedDate": "2023-02-01T16:03:48.000+0000",
            "Name": "VlocityEPC_Deploy"
          }
        ],
        "ObjectType": "copado__Function__c"
      },
      {
        "Records": [
          {
            "attributes": {
              "type": "copado__JobTemplate__c",
              "url": "/services/data/v56.0/sobjects/copado__JobTemplate__c/a0t7Q000000maISQAY"
            },
            "copado__ApiName__c": "VlocityEPC_Deploy_1",
            "copado__Type__c": "Custom",
            "copado__Version__c": 1,
            "Id": "a0t7Q000000maISQAY",
            "LastReferencedDate": "2023-02-03T08:59:34.000+0000",
            "LastViewedDate": "2023-02-03T08:59:34.000+0000",
            "Name": "VlocityEPC_Deploy"
          }
        ],
        "ObjectType": "copado__JobTemplate__c"
      },
      {
        "Records": [
          {
            "attributes": {
              "type": "copado__JobStep__c",
              "url": "/services/data/v56.0/sobjects/copado__JobStep__c/a0s7Q000000u4YvQAI"
            },
            "copado__ApiName__c": "VlocityEPC_Deploy_1_VlocityEPC_Deploy_1",
            "copado__ConfigJson__c": "{\"functionName\":\"VlocityEPC_Deploy\",\"parameters\":[{\"name\":\"git_json\",\"value\":\"{$Context.Repository.Credential}\",\"required\":false},{\"name\":\"git_depth\",\"value\":\"{$Pipeline.Property.GIT_DEPTH}\",\"required\":false},{\"name\":\"dest_sessionId\",\"value\":\"{$Destination.Credential.SessionId}\",\"required\":false},{\"name\":\"dest_endpoint\",\"value\":\"{$Destination.Credential.Endpoint}\",\"required\":false},{\"name\":\"source_branch\",\"value\":\"{$Context.JobExecution__r.DataJson.Source_Branch__c}\",\"required\":false},{\"name\":\"vlocity_verbose\",\"value\":\"{$Pipeline.Property.VLOCITY_VERBOSE}\",\"required\":false},{\"name\":\"vlocity_latest\",\"value\":\"{$Pipeline.Property.VLOCITY_LATEST}\",\"required\":false},{\"name\":\"deploy_yaml\",\"value\":\"{$Pipeline.Property.DEPLOY_YAML}\",\"required\":false}]}",
            "copado__CustomType__c": "Function",
            "copado__JobTemplate__c": "a0t7Q000000maISQAY",
            "copado__Order__c": 1,
            "copado__Type__c": "Function",
            "Id": "a0s7Q000000u4YvQAI",
            "Name": "VlocityEPC_Deploy"
          }
        ],
        "ObjectType": "copado__JobStep__c"
      }
    ],
    "blobsByUID": {}
  }
  