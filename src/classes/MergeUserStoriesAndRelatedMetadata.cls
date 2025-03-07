public class MergeUserStoriesAndRelatedMetadata {
    
    public static String mergeUserStories(Set<Id> userStoriesIdSet){
        
        String bundleUserStoryTitle = 'Bundle User Story - '+ System.now();
        Id userStoryRecordTypeId = Schema.SObjectType.copado__User_Story__c.getRecordTypeInfosByName().get('User Story').getRecordTypeId();
        copado__User_Story__c bundledUserStory = new copado__User_Story__c();
        // return if the userStoriesIdSet is empty
        if(userStoriesIdSet.isEmpty()){
            return 'Please enter the user story project Ids';
        }
        
        // Retrieve the Project and Org Credential from one of the userstory part of userStoriesIdSet
        List<copado__User_Story__c> userStoryDetailList = [SELECT
                                                           copado__Project__c , copado__Org_Credential__c
                                                           FROM
                                                           copado__User_Story__c
                                                           WHERE
                                                           Id IN :userStoriesIdSet LIMIT 1];
        // Create new Bundle User Story
        if(!userStoryDetailList.isEmpty()){
            bundledUserStory = new copado__User_Story__c(copado__User_Story_Title__c = bundleUserStoryTitle,
                                                         RecordTypeId  = userStoryRecordTypeId,
                                                         copado__Project__c = userStoryDetailList[0].copado__Project__c,
                                                         copado__Org_Credential__c = userStoryDetailList[0].copado__Org_Credential__c);
            try{
                DataBase.insert(bundledUserStory, true);
                bundledUserStory = [SELECT Id, Name from copado__User_Story__c WHERE ID = :bundledUserStory.Id];
            } catch (Exception  exp){
                return 'Exception occured while creating bundled User Story Record: '+exp.getMessage();
            }
        }
        
        // Query User Stories related Metadata Records and deepclone and then insert.
        List<copado__User_Story_Metadata__c> userStoriesMetadataRecordForInsert = new List<copado__User_Story_Metadata__c>();
        for(copado__User_Story_Metadata__c usMetadataObj: [SELECT Id,copado__Action__c , copado__Category__c , copado__ModuleDirectory__c , copado__Metadata_API_Name__c , 
                                                           copado__JsonInformation__c  , copado__Status__c ,copado__Last_Commit_Date__c , copado__Status_Icon__c , copado__Type__c , Name 
                                                           FROM 
                                                           copado__User_Story_Metadata__c
                                                           WHERE 
                                                           copado__User_Story__c  IN :userStoriesIdSet]){
                                                               copado__User_Story_Metadata__c clonedUSMetadata =    usMetadataObj.clone(false,true,false,false); //clone(Boolean preserveId, Boolean isDeepClone, Boolean preserveReadonlyTimestamps, Boolean preserveAutonumber)
                                                               clonedUSMetadata.copado__User_Story__c = bundledUserStory.Id;
                                                               String buildUniqueIdString = bundledUserStory.Id;
                                                                   buildUniqueIdString += usMetadataObj.copado__ModuleDirectory__c != null ? ';'+ usMetadataObj.copado__ModuleDirectory__c: '';
                                                               buildUniqueIdString += usMetadataObj.copado__Type__c != null ? ';'+ usMetadataObj.copado__Type__c : '';
                                                               buildUniqueIdString += usMetadataObj.copado__Metadata_API_Name__c != null ? ';'+ usMetadataObj.copado__Metadata_API_Name__c : '';
                                                               system.debug('buildUniqueIdString'+buildUniqueIdString);
                                                               clonedUSMetadata.copado__Unique_ID__c  = buildUniqueIdString;
                                                               clonedUSMetadata.Name = bundledUserStory.Name +' '+ usMetadataObj.copado__Metadata_API_Name__c;
                                                               system.debug('copado__Unique_ID__c**'+clonedUSMetadata.copado__Unique_ID__c);
                                                               userStoriesMetadataRecordForInsert.add(clonedUSMetadata);
                                                           }
        if(!userStoriesMetadataRecordForInsert.isEmpty()){
            try{
                DataBase.insert(userStoriesMetadataRecordForInsert,true);
            } catch (Exception  exp){
                return 'Exception occured while creating User Story Metadata records: '+exp.getMessage();
            }
        }
        System.debug('Merged/Bundled User Story is created successfully, Uesr Story Id '+bundledUserStory.Id);
        return 'Merged/Bundled User Story is created successfully';
    }
    
}