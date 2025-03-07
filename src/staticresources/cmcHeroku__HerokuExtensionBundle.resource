{
  "recordTypeMap": {},
  "RecordSetBundles": [
    {
      "Records": [
        {
          "attributes": {
            "type": "copado__JobTemplate__c",
            "url": "/services/data/v53.0/sobjects/copado__JobTemplate__c/a0u1X000001xbpCQAQ"
          },
          "copado__ApiName__c": "Heroku_Promote_1",
          "copado__Type__c": "Custom",
          "copado__Version__c": 1,
          "CreatedDate": "2022-02-08T11:46:02.000+0000",
          "Id": "a0u1X000001xbpCQAQ",
          "IsDeleted": false,
          "LastModifiedDate": "2022-02-08T11:46:02.000+0000",
          "LastReferencedDate": "2022-02-08T11:46:02.000+0000",
          "LastViewedDate": "2022-02-08T11:46:02.000+0000",
          "Name": "Heroku_Promote",
          "SystemModstamp": "2022-02-08T11:46:02.000+0000"
        },
        {
          "attributes": {
            "type": "copado__JobTemplate__c",
            "url": "/services/data/v53.0/sobjects/copado__JobTemplate__c/a0u1X000001xbpDQAQ"
          },
          "copado__ApiName__c": "Heroku_Deploy_1",
          "copado__Type__c": "Custom",
          "copado__Version__c": 1,
          "CreatedDate": "2022-02-08T11:46:02.000+0000",
          "Id": "a0u1X000001xbpDQAQ",
          "IsDeleted": false,
          "LastModifiedDate": "2022-02-08T11:46:02.000+0000",
          "LastReferencedDate": "2022-02-08T11:46:02.000+0000",
          "LastViewedDate": "2022-02-08T11:46:02.000+0000",
          "Name": "Heroku_Deploy",
          "SystemModstamp": "2022-02-08T11:46:02.000+0000"
        }
      ],
      "ObjectType": "copado__JobTemplate__c"
    },
    {
      "Records": [
        {
          "attributes": {
            "type": "copado__JobStep__c",
            "url": "/services/data/v53.0/sobjects/copado__JobStep__c/a0t1X000002asF3QAI"
          },
          "copado__ApiName__c": "Heroku_Promote_Promote",
          "copado__ConfigJson__c": "{\"functionName\":\"Heroku_Promote\",\"parameters\":[{\"name\":\"git_json\",\"value\":\"{$Context.Repository.Credential}\"},{\"name\":\"user_stories\",\"value\":\"{$Context.JobExecution__r.DataJson.userStoryBranches}\"},{\"name\":\"promotion\",\"value\":\"{$Context.JobExecution__r.DataJson.promotionBranchName}\"},{\"name\":\"target_branch\",\"value\":\"{$Context.JobExecution__r.DataJson.destinationBranchName}\"},{\"name\":\"tag\",\"value\":\"{$Job.ExecutionParent.Release__r.Version__c}\"},{\"name\":\"merge_strategy\",\"value\":\"theirs\"}]}",
          "copado__CustomType__c": "Function",
          "copado__JobTemplate__c": "a0u1X000001xbpCQAQ",
          "copado__Order__c": 1,
          "copado__Type__c": "Function",
          "CreatedDate": "2022-02-08T11:46:02.000+0000",
          "Id": "a0t1X000002asF3QAI",
          "IsDeleted": false,
          "LastModifiedDate": "2022-02-08T11:46:02.000+0000",
          "Name": "Promote",
          "SystemModstamp": "2022-02-08T11:46:02.000+0000"
        },
        {
          "attributes": {
            "type": "copado__JobStep__c",
            "url": "/services/data/v53.0/sobjects/copado__JobStep__c/a0t1X000002asF4QAI"
          },
          "copado__ApiName__c": "Heroku_Deploy_Heroku_Deploy",
          "copado__ConfigJson__c": "{\"functionName\":\"Heroku_Deploy\",\"parameters\":[{\"name\":\"git_json\",\"value\":\"{$Context.Repository.Credential}\"},{\"name\":\"promotion\",\"value\":\"{$Context.JobExecution__r.DataJson.promotionBranchName}\"},{\"name\":\"app_name\",\"value\":\"{$Destination.Property.heroku_app_name}\"},{\"name\":\"heroku_api_key\",\"value\":\"{$Pipeline.Property.heroku_api_key}\"},{\"name\":\"target_branch\",\"value\":\"{$Context.JobExecution__r.DataJson.destinationBranchName}\"}]}",
          "copado__CustomType__c": "Function",
          "copado__JobTemplate__c": "a0u1X000001xbpDQAQ",
          "copado__Order__c": 1,
          "copado__Type__c": "Function",
          "CreatedDate": "2022-02-08T11:46:02.000+0000",
          "Id": "a0t1X000002asF4QAI",
          "IsDeleted": false,
          "LastModifiedDate": "2022-02-08T11:46:02.000+0000",
          "Name": "Heroku_Deploy",
          "SystemModstamp": "2022-02-08T11:46:02.000+0000"
        }
      ],
      "ObjectType": "copado__JobStep__c"
    },
    {
      "Records": [
        {
          "attributes": {
            "type": "copado__Function__c",
            "url": "/services/data/v53.0/sobjects/copado__Function__c/a0l1X0000039P7MQAU"
          },
          "copado__API_Name__c": "Heroku_Promote",
          "copado__Image_Name__c": "copado-multicloud-dpl:v1",
          "copado__Options__c": "[ ]",
          "copado__Parameters__c": "[ {\n  \"required\" : true,\n  \"name\" : \"git_json\",\n  \"defaultValue\" : \"{$Context.Repository.Credential}\"\n}, {\n  \"required\" : true,\n  \"name\" : \"user_stories\",\n  \"defaultValue\" : \"{$Context.JobExecution__r.DataJson.userStoryBranches}\"\n}, {\n  \"required\" : true,\n  \"name\" : \"promotion\",\n  \"defaultValue\" : \"{$Context.JobExecution__r.DataJson.promotionBranchName}\"\n}, {\n  \"required\" : true,\n  \"name\" : \"target_branch\",\n  \"defaultValue\" : \"{$Context.JobExecution__r.DataJson.destinationBranchName}\"\n}, {\n  \"required\" : false,\n  \"name\" : \"tag\",\n  \"defaultValue\" : \"{$Job.ExecutionParent.Release__r.Version__c}\"\n}, {\n  \"required\" : true,\n  \"name\" : \"merge_strategy\",\n  \"defaultValue\" : \"theirs\"\n} ]",
          "copado__Script__c": "git_depth=${git_depth:-100}  # set a default git depth of 100 commits\nmerge_strategy=${merge_strategy-theirs} # set default merge strategy to ours (only if unset)\nif [ -n \"$merge_strategy\" ]; then merge_strategy_option=(-X \"$merge_strategy\"); else merge_strategy_option=(); fi\n\necho \"promotion branch: $promotion\"\necho \"merge strategy: $merge_strategy\"\necho \"user stories: $user_stories\"\necho \"git_depth: $git_depth\"\n\ncopado --progress \"fetching $target_branch\"\ncopado-git-get --depth \"$git_depth\" \"$target_branch\"\ncopado-git-get --depth \"$git_depth\" --create \"$promotion\"\nbranches=$(echo \"$user_stories\" | jq -c -r '.[]')\nfor user_story in ${branches[@]}; do\n    echo \"merging $user_story\"\n    copado-git-get --depth \"$git_depth\" \"$user_story\"\n    git checkout \"$promotion\"\n    git merge \"${merge_strategy_option[@]}\" -m \"auto resolved $user_story win over $promotion\" \"$user_story\"\ndone\n\ncopado --progress \"pushing $promotion $tag\"\n\nif [ -n \"$tag\" ]; then\n    git tag \"$tag\"\n    git push --atomic origin \"$promotion\" \"$tag\"\nelse\n    echo \"not tag specified\"\n    git push origin \"$promotion\"\nfi",
          "copado__Timeout__c": 5,
          "copado__Type__c": "Custom",
          "copado__Worker_Size__c": "S",
          "CreatedDate": "2022-02-08T11:46:02.000+0000",
          "Id": "a0l1X0000039P7MQAU",
          "IsDeleted": false,
          "LastModifiedDate": "2022-02-08T11:47:28.000+0000",
          "LastReferencedDate": "2022-02-08T11:47:43.000+0000",
          "LastViewedDate": "2022-02-08T11:47:43.000+0000",
          "Name": "Heroku Promote",
          "SystemModstamp": "2022-02-08T11:47:28.000+0000"
        },
        {
          "attributes": {
            "type": "copado__Function__c",
            "url": "/services/data/v53.0/sobjects/copado__Function__c/a0l1X0000039P7NQAU"
          },
          "copado__API_Name__c": "Heroku_Deploy",
          "copado__Description__c": "Deploy to heroku",
          "copado__Image_Name__c": "copado-multicloud-dpl:v1",
          "copado__Options__c": "[ ]",
          "copado__Parameters__c": "[ {\n  \"required\" : true,\n  \"name\" : \"git_json\",\n  \"defaultValue\" : \"{$Context.Repository.Credential}\"\n}, {\n  \"required\" : true,\n  \"name\" : \"promotion\",\n  \"defaultValue\" : \"{$Context.JobExecution__r.DataJson.promotionBranchName}\"\n}, {\n  \"required\" : true,\n  \"name\" : \"app_name\",\n  \"defaultValue\" : \"{$Destination.Property.heroku_app_name}\"\n}, {\n  \"required\" : true,\n  \"name\" : \"heroku_api_key\",\n  \"defaultValue\" : \"{$Pipeline.Property.heroku_api_key}\"\n}, {\n  \"required\" : true,\n  \"name\" : \"target_branch\",\n  \"defaultValue\" : \"{$Context.JobExecution__r.DataJson.destinationBranchName}\"\n} ]",
          "copado__Script__c": "copado --progress \"fetching $promotion\"\ncopado-git-get \"$promotion\"\ncopado --progress \"deploying $app_name\"\ndpl --provider=heroku --api_key=\"$heroku_api_key\" --app=\"$app_name\"\ncopado-git-get --depth 100 \"$target_branch\"\ngit merge \"$promotion\"\ngit push origin \"$target_branch\"",
          "copado__Timeout__c": 15,
          "copado__Type__c": "Custom",
          "copado__Worker_Size__c": "S",
          "CreatedDate": "2022-02-08T11:46:02.000+0000",
          "Id": "a0l1X0000039P7NQAU",
          "IsDeleted": false,
          "LastModifiedDate": "2022-02-08T11:48:35.000+0000",
          "LastReferencedDate": "2022-02-08T11:48:35.000+0000",
          "LastViewedDate": "2022-02-08T11:48:35.000+0000",
          "Name": "Heroku Deploy",
          "SystemModstamp": "2022-02-08T11:48:35.000+0000"
        }
      ],
      "ObjectType": "copado__Function__c"
    }
  ],
  "blobsByUID": {}
}