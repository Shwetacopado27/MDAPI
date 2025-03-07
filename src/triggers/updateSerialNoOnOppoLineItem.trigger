trigger updateSerialNoOnOppoLineItem on OpportunityLineItem (before insert) {

    set <id> oppId = new set<id>();
    
    for (OpportunityLineItem oppprod:Trigger.new)
    {
        
        oppId.add(oppprod.OpportunityId);
    }
    
    List<OpportunityLineItem> oppProdListToUpdate = new List<OpportunityLineItem>();
    //Map of Opportunity Id and SeralNo of OpportunityLineItem
    Map<Id,String> oppIdSerialNoMap = new Map<Id,String>();
    
    List<OpportunityLineItem> oppProdList=[Select Id,Serial_No__c,OpportunityId from OpportunityLineItem where OpportunityId=:oppId];    
    if (oppProdList.size()>0)
    {
        For (OpportunityLineItem oppoPrd:oppProdList)
        {
            
            if (oppoprd.Serial_No__c!=null)
            {
      //Getting the last number of the SerialNo field
               String lastword =  oppoprd.Serial_No__c.right(1);
                
     //converting String into Integer so that I can increment the lastnumber which is already there in SerialNo field
     
                Integer num = Integer.valueOf(lastword);
                num++;
                
     //appending the incremented number

                oppoprd.Serial_No__c = oppoprd.Serial_No__c+','+(num);
                oppProdListTOUpdate.add(oppoPrd);
    
     //adding it to Map so that i can make changes for the OpportunityLineItem which is newly getting inserted
     
                oppIdSerialNoMap.put(oppoPrd.OpportunityId,oppoPrd.Serial_No__c);
            }
            
            else 
            {
                
     //if the SerialField is null then it means there is no OpportunityLineItem present so by default we are passing 1
     
               oppoPrd.Serial_No__c='1';
               oppProdListTOUpdate.add(oppoPrd);
           
            }                  
        }
    }
    
       if (oppProdListTOUpdate.size()>0)
       {
           update oppProdListTOUpdate;
       }
    
    For (OpportunityLineItem oppprod:Trigger.new)
    {
        If (oppIdSerialNoMap.containsKey(oppprod.OpportunityId))
        {
            oppprod.Serial_No__c = oppIdSerialNoMap.get(oppProd.OpportunityId);
        }
        else
        {
            oppProd.Serial_No__c='1';
        }
    }

    
}