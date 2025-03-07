trigger sendingMailAfterInsert on Contact (after insert) {

    List<Messaging.SingleEmailMessage> emailList = New List<Messaging.SingleEmailMessage>();
    EmailTemplate etemplate = [Select Id,Subject,Description,HtmlValue,DeveloperName,Body from EmailTemplate where name='Email Template to send After Contact is Inserted'];
    
    For (Contact conObj:Trigger.new)
    {
        if (conObj.Email!=null)
        {
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setTargetObjectId(conObj.Id);
            mail.setSenderDisplayName('System Administrator');
            mail.setUseSignature(false);
            mail.setBccSender(false);
            mail.setSaveAsActivity(false);
            mail.setTemplateID(etemplate.Id);
            mail.toAddresses = new String[]{conObj.Email};
            emailList.add(mail);
            
        }
    }
    
    If (emailList.size()>0)
    {
    Messaging.SendEmailResult[] results = Messaging.sendEmail(emailList);
    If (results[0].success)
    {
        System.Debug('The email was sent successfully.');
    }
    
    else
    {
        System.Debug('The EMail to failed to send: '+ results[0].errors[0].message);
    }
    
    }
}