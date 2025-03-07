trigger OpportunityValidationTrigger on Opportunity (before update) {
    
    for (Opportunity opp : trigger.new)
    {
        //Close Date Validation
        
         if (opp.CloseDate < Date.Today())
         {
             opp.addError ('Opportunity cannot have a Close Date in the past.');
         }
        
        //Stage Transition Lock
        
        If (opp.StageName =='Closed Won' && Trigger.oldMap.get(opp.Id).StageName == 'Prospecting')
        {
            opp.addError ('Opportunity cannot transition directly from Prospecting to Closed Won.');
        }
        
        //Minimum Amount for “Closed Won
        
        if (opp.StageName == 'Closed Won' && opp.Amount >=10000)
        {
            opp.addError ('Opportunity in Closed Won stage must have an Amount greater than or equal to amount 10,000.');
        }
        
    }

}