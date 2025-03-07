//test class for Contactonaccount trigger
@isTest

public class ContactonAccount_Test {
    
@istest
    //test method to test the creation of contact on the insertion of Account

    Static void TestAddmethod()
    {
        //Create test account record
        
        Account acc = new Account(name='test Account',AnnualRevenue =1234);
        insert acc;
       List<Contact> cc = [Select id from contact where accountid = :acc.Id];
           System.assertequals(1,cc.size());
        
        Account acc1 = new Account(name='test account1');
        insert acc1;
        List<Contact> cc1 = [Select id from contact where accountid = :acc1.id];
            System.assertEquals(0, cc1.size());
    }
     

}