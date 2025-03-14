trigger ContactTrigger on Contact (after insert, after update, after delete) 
{
    if(Trigger.isAfter) {
        // Code runs when any contact is inserted.
        if(Trigger.isInsert) {
            // Map of Account Ids as the Keys and count of contacts which need to be updated later as the value.
            Map<Id, Integer> accMapWithContsCount = new Map<Id, Integer>();
            
            // Check if the inserted contact has some value in the account for each contact,
            // if yes then add the Integer 1 in the map
            for(Contact con : Trigger.new) {
                // it would check if the key 'AccountId' already exists in the map, if no then simply set the integer value 1 for the account.
                // else update the value to 1.
                if(!accMapWithContsCount.containsKey(con.AccountId)) {
                    accMapWithContsCount.put(con.AccountId, 1);
                }
                else {
                    accMapWithContsCount.put(con.AccountId, accMapWithContsCount.get(con.AccountId) + 1);
                }
            }
            
            // Get all the accounts with the keySet of map and update field 'Total_Contacts_Count__c' with the values from the map.
            List<Account> accountsToBeUpdated = [Select Id, Total_Contacts_Count__c From Account Where Id IN :accMapWithContsCount.keySet()];
            for(Account acc : accountsToBeUpdated) {
                acc.Total_Contacts_Count__c = acc.Total_Contacts_Count__c + accMapWithContsCount.get(acc.Id);
            }
            update accountsToBeUpdated;
        }
        
        // Code runs when any contact is updated.
        if(Trigger.isUpdate) {
            Map<Id, Integer> accMapWithContsCount = new Map<Id, Integer>();
            for(Contact con : Trigger.new) {
                // Condition which checks that the code should run only if there is a change in Account field of contact.
                if(con.AccountId != Trigger.oldMap.get(con.Id).AccountId) {
                    
                    // Check when previously there was nothing in the account field but then some account was populated during updation.
                    if(Trigger.oldMap.get(con.Id).AccountId == null) {
                        if(!accMapWithContsCount.containsKey(con.AccountId)) {
                            accMapWithContsCount.put(con.AccountId, 1);
                        }
                        else {
                            accMapWithContsCount.put(con.AccountId, accMapWithContsCount.get(con.AccountId) + 1);
                        }
                    }
                    
                    // Check when previously there was some value in the Account field but during updation the account was removed
                    // and new value is null
                    else if(Trigger.oldMap.get(con.Id).AccountId != null && con.AccountId == null) {
                        if(!accMapWithContsCount.containsKey(Trigger.oldMap.get(con.Id).AccountId)) {
                            // since there is no value after updation in the field Account of Contact
                            // so new Total Contacts Count on Account would be less
                            accMapWithContsCount.put(Trigger.oldMap.get(con.Id).AccountId, -1);
                        }
                        else {
                            accMapWithContsCount.put(Trigger.oldMap.get(con.Id).AccountId, accMapWithContsCount.get(Trigger.oldMap.get(con.Id).AccountId) - 1);
                        }
                    }
                    
                    // Check when account associated to contact before and after updation was different.
                    else {
                        // For new account which was populated to the contact
                        if(!accMapWithContsCount.containsKey(con.AccountId)) {
                            accMapWithContsCount.put(con.AccountId, 1);
                        }
                        else {
                            accMapWithContsCount.put(con.AccountId, accMapWithContsCount.get(con.AccountId) + 1);
                        }
                        
                        // For old account which was updated with the new one
                        Id oldId = Trigger.oldMap.get(con.Id).AccountId;
                        if(!accMapWithContsCount.containsKey(oldId)) {
                            accMapWithContsCount.put(oldId, -1);
                        }
                        else {                            
                            accMapWithContsCount.put(oldId, accMapWithContsCount.get(oldId) - 1);
                        }
                    }
                }
            }
            
            // Get all the accounts with the keySet of map and update field 'Total_Contacts_Count__c' with the values from the map.
            List<Account> accountsToBeUpdated = [Select Id, Total_Contacts_Count__c From Account Where Id IN :accMapWithContsCount.keySet()];
            for(Account acc : accountsToBeUpdated) {
                acc.Total_Contacts_Count__c = acc.Total_Contacts_Count__c + accMapWithContsCount.get(acc.Id);
            }
            update accountsToBeUpdated;
        }
            
    // Code runs when any contact is deleted.
    
            If (Trigger.Isdelete)
            {
                Map <Id, Integer> accMapWithContsCount = new Map<Id,Integer>();
                
                For ( Contact con: trigger.old)
                {
                    If (!accMapWithContsCount.ContainsKey(con.AccountId))
                    {
                        accMapWithContsCount.put(con.AccountId, -1 );
                    }
                     else {
                    accMapWithContsCount.put(con.AccountId, accMapWithContsCount.get(con.AccountId) - 1);
                }
                
                }
               
                     // Get all the accounts with the keySet of map and update field 'Total_Contacts_Count__c' with the values from the map.
                    
            List<Account> accountsToBeUpdated = [Select Id, Total_Contacts_Count__c From Account Where Id IN :accMapWithContsCount.keySet()];
           
                for(Account acc : accountsToBeUpdated) {
                acc.Total_Contacts_Count__c = acc.Total_Contacts_Count__c + accMapWithContsCount.get(acc.Id);
            }
                
            update accountsToBeUpdated;
                
                
           }
            }
    }