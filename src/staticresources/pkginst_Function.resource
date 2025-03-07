{
  "recordTypeMap": {},
  "RecordSetBundles": [
    {
      "Records": [
        {
          "attributes": {
            "type": "copado__Function__c",
            "url": "/services/data/v56.0/sobjects/copado__Function__c/a0n09000005RC5OAAW"
          },
          "copado__API_Name__c": "install_2G_package",
          "copado__Image_Name__c": "copado-multicloud-dx:v3",
          "copado__Options__c": "[ ]",
          "copado__Parameters__c": "[ {\n  \"required\" : true,\n  \"name\" : \"sessionID\",\n  \"defaultValue\" : \"{$Context.Credential.SessionId}\"\n}, {\n  \"required\" : false,\n  \"name\" : \"packageID\",\n  \"defaultValue\" : \"\"\n}, {\n  \"required\" : true,\n  \"name\" : \"endpointID\",\n  \"defaultValue\" : \"{$Context.Credential.Endpoint}\"\n}, {\n  \"required\" : false,\n  \"name\" : \"uninstall\",\n  \"defaultValue\" : \"\"\n} ]",
          "copado__Script__c": "copado --progress \"Creating SFDX Folder\"\nsfdx force:project:create -n InstallationProject\ncd InstallationProject\n\n#Get base Salesforce URL using SoapEndpoint\n#Needs to be in https://companyname.lightning.force.com format\nInstanceUrl=$(echo \"$endpointID\" | cut -d'/' -f3)\nInstanceUrl=\"https://\"$InstanceUrl\n\nsfdx force:config:set instanceUrl=\"$InstanceUrl\" --global\nif [ $uninstall == true ]\nthen\n   copado --progress \"Uninstalling\"\n   sfdx force:package:uninstall --package $packageID -u $sessionID -w 1000\nelse\n   copado --progress \"Installing\"\n   sfdx force:package:install --package $packageID -u $sessionID -w 1000\nfi",
          "copado__Timeout__c": 60,
          "copado__Type__c": "Custom",
          "copado__Version__c": "1",
          "Id": "a0n09000005RC5OAAW",
          "LastReferencedDate": "2022-11-21T11:42:59.000+0000",
          "LastViewedDate": "2022-11-21T11:42:59.000+0000",
          "Name": "Install 2G Package"
        }
      ],
      "ObjectType": "copado__Function__c"
    }
  ],
  "blobsByUID": {}
}