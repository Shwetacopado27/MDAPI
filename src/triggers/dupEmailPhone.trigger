trigger dupEmailPhone on Contact (before insert, before update) {
    
    Map<String, Contact> emailMap = New Map<String, Contact>();
    Map<String, Contact> phoneMap = New Map<String, Contact>();
    
    for ( Contact con : Trigger.new)
    {
        If (Trigger.IsInsert)
            
        {
            emailmap.put(con.Email, con);
            phonemap.put(con.Phone, con);
            
        }
        
    If (Trigger.IsUpdate)
        
    {
        if (trigger.oldmap.get(con.Id).Email != null)
        {
            emailmap.put(con.Email, con);
            phonemap.put(con.Phone, con);
    }
    }
    }
    
    String errorMessage ='';
    List<Contact> existcon = [Select Id, Email, Phone from Contact where Email IN:emailmap.keyset() OR Phone IN:emailmap.keyset()];
    
    if (existcon.size()>0)
    {
        For (Contact c: existcon)
        {
            if (c.Email !=null)
            {
                if (emailmap.get(c.Email)!=null)
                {
                    errorMessage = 'EMail';
                }
            }
            
            if (c.Phone!=null)
              {
                  if (phonemap.get(c.Phone)!=null)
                  {
                    errorMessage =  errorMessage + (errorMessage != '' ? 'and Phone ' : 'Phone ');
                  }
       
              }
            if(errorMessage!=''){
          trigger.new[0].addError('Your Contact '+errorMessage +' already exists in system.');
}
        }
        
        
    }


}