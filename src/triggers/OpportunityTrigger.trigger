trigger OpportunityTrigger on Opportunity (after insert, after update) {

   
    List<Opportunity> closedopp = new List<Opportunity>();
    
    Set<Id> accountIds = new Set<Id>();
    For (Opportunity opp : trigger.new)
        
        if (opp.stagename == 'ClosedWon')
    {
         closedopp.add (opp);
    }
    
    For (Opportunity opport : closedopp)
    {
        accountIds.add(opport.AccountId);
    }
    
    List<Account> accounttoupdate = [Select Id, (select Amount, StageName from Opportunities where stagename = 'ClosedWon') from Account where Id IN :accountIds];
    
    for (Account acc : accounttoupdate)
    {
        Decimal totalamount = 0;
        
        for (Opportunity o : acc.opportunities)
        {
            if (o.Stagename == 'Closedwon')
            {
                totalamount += o.Amount;
            }
        }
            acc.TotalOpportunityAmount__c = totalamount;        


    }
    
    update accounttoupdate;
}