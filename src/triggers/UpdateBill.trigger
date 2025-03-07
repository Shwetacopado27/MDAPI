trigger UpdateBill on Account (After Update) {
    
    If ( trigger.IsAfter && trigger.IsUpdate)
     
    {
        Set<Id> accountIds = new Set<Id>();
        
        for (Account acc : Trigger.new)
        {
// Compare the new BillingCity to the old BillingCity for the same account
            if (acc.BillingCity != Trigger.oldMap.get(acc.Id).BillingCity)
            {
                accountIds.add (acc.Id);
            }

        }
    
    
    List<Contact> listofcontacts = [Select id, MailingCity, AccountId from Contact where AccountId IN :accountIds];
    
            // Iterate through each Contact and udpate the MailingCity to its Account's BillingCity
     
    For (Contact con : listofcontacts)
    {
        con.MailingCity = Trigger.newMap.get(con.AccountId).BillingCity;
    }
// Update contacts if there is any record in the list

    if(!listofcontacts.IsEmpty())
    {
        update listofcontacts;
    }

}
}