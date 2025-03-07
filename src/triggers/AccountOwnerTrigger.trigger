trigger AccountOwnerTrigger on Account (after update) {
    
    if (trigger.IsUpdate && trigger.IsAfter)
    {
       List <Id> accountIds = new List<Id>();
        
        for ( Account acc : Trigger.new)
            
        {
            if (acc.OwnerId != Trigger.oldMap.get(acc.id).OwnerId)
          {
            accountIds.add(acc.Id);
            
          }
    }
    
    if (accountIds.size() != 0)
    {
        List<Contact> contacts = [Select Id, OwnerId, AccountId from Contact where AccountId IN :accountIds];
        
        for (Contact con : contacts)
        {
            con.OwnerId = Trigger.Newmap.get (con.AccountId).OwnerId;
        }
        
        update contacts;
    }
    
}
}