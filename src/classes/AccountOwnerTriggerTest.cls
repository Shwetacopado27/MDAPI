@IsTest

private class AccountOwnerTriggerTest {
    
//Create test data in 'testsetup'    
@testSetup 

    static void testdata()
    {
//Create instance of a standard user
            
            Profile standardProfile = [Select Id, Name from profile where Name = 'Standard User'];
            
            User standardUser = new User (Alias = 'standt', Email='standarduser@testclasses.com', 
            EmailEncodingKey='UTF-8', LastName='TestUser', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = standardProfile.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standarduser@testclasses.com');
            
// Create Account and Contact using run as the above user.
            System.runas(standardUser)
            {
                Account acc = new Account(Name = 'TestAccount');
                Insert acc;
                Contact con = new Contact(LastName = 'TestContact', AccountId=acc.Id);
                Insert con;
            }
            
    }
        
// Positive Test cases
// 1. Update Account's Owner
// 2. Verify Contact Owner should get updated. 
@isTest
       
        static void accountTrigger_afterUpdateTest_positive()
    {
//Get the account and contact
        Account acc = [select Id, OwnerId from Account where Name = 'TestAccount' Limit 1];
        
        Contact con = [select Id, OwnerId from Contact where Name = 'TestContact' Limit 1];
    
    
// Assert owners of account and contact are not same as the current owner

    System.assertNotEquals(System.UserInfo.getUserId(), acc.OwnerId, 'Owner should not be same');
    System.assertNotEquals(System.UserInfo.getUserId(), con.OwnerId, 'Owner should not be same'); 
    
//Update the acount owner 
     Test.startTest();
    
        acc.OwnerId = System.UserInfo.getUserId();
        update acc;
    
     Test.stopTest();

// Verify the contact should be updated to the current owner.
	Contact updatedcon = [Select Id, Name, OwnerId from Contact where name = 'TestContact' LIMIT 1];
    system.assertEquals(System.UserInfo.getUserId(), updatedcon.OwnerId, 'Contact Owner should get updated');

    //Negative Test cases
    //Update any other field other than Account Owner
    //Verify Account owner field not get updated
    }  
    @istest
    static void accountTrigger_afterUpdateTest_negative()
    {
                Account acc = [select Id, OwnerId from Account where Name = 'TestAccount' Limit 1];
                Contact con = [select Id, OwnerId from Contact where Name = 'TestContact' Limit 1];
        
        //change the contact's owner
       Test.startTest();
     
        con.OwnerId = System.UserInfo.getUserId();
        update con;
        
       Test.stopTest();
   //Verify Contact and Account owner should not be the same
   
        system.assertNotEquals(con.OwnerId, acc.OwnerId, 'Account and Contact owner should not be same');
        
   // Now update the Account but keep the Owner same. Contact Owner should not get updated to Account Owner
   // and both should remain different.

     Test.startTest();
     acc.Type = 'Industry';
     update acc;
     Test.stopTest();   
       
        
  // Verify that account and contact Owners should not be same.
  Contact  updatecon = [select Id, OwnerId from Contact where Name = 'TestContact' Limit 1];
        
  system.assertNotEquals(con.OwnerId, acc.OwnerId, 'Account and Contact owner should not be same');
        
    }
    
}