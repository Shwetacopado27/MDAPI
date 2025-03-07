@IsTest

public class OpportunityValidationTriggerTest {
    
@isTest static void testCloseDateValidation()
{
    
    Opportunity opp = New Opportunity(Name = 'test Opp', CloseDate = System.Today().adddays(-1), StageName = 'Prospecting', Amount = 12000);
    Insert opp;
    
    Test.startTest();
    
    try
    {
        opp.StageName = 'Qualification';
        update opp;
    }
    
   catch (Exception e)  
   {
       System.assert(e.getmessage().contains('Opportunity canot have the close date in the past'));
   }
    
    Test.stopTest();
}
    
@isTest static void testStageTransitionLock()
{
        Opportunity opp = New Opportunity(Name = 'test Opp1', CloseDate = System.Today().adddays(7), StageName = 'Prospecting', Amount = 8000);
        Insert opp;
    
    Test.startTest();
    try 
    {
        opp.stageName = 'ClosedWon';
        opp.Amount = 15000;
        update opp;
    }
    
   catch (Exception e)
   {
       System.assert(e.getmessage().contains('Opportunity cannot transition directly from Prospecting to Closed Won'));
   }
      Test.stopTest();
}    
    
    @isTest static void testMinimumAmountForClosedWon() {

            Opportunity opp = New Opportunity(Name = 'test Opp2', CloseDate = System.Today().adddays(7), StageName = 'Prospecting', Amount = 5000);
            Insert opp;
    
    Test.startTest();
    try 
    {
        opp.Amount = 8000;
        update opp;
    }

     catch (Exception e)
     {
         System.assert(e.getmessage().contains('Opportunity in Closed Won stage must have an Amount greater than or equal to amount 10,000'));

     }
          Test.stopTest();                                            
}

}