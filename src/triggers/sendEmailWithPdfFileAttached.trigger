trigger sendEmailWithPdfFileAttached on Lead (before insert) {
    
    List <Messaging.SingleEmailMessage> emaillist = new List<Messaging.SingleEmailMessage>();
    
    EmailTemplate emailtemplate = [Select id, Subject, Description, HtmlValue, DeveloperName, Body from EmailTemplate where name = 'Pdf Attached Email for Lead'];
    
    for (Lead lobj : trigger.new)
    {
        if (lobj.Email !=null)  
        {
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setTargetObjectId(lobj.Id);
            mail.setSenderDisplayName('System Administrator');
            mail.setUseSignature(false);
            mail.setBccSender(false);
            mail.setSaveAsActivity(false);
            mail.setTemplateID(emailTemplate.Id);
            mail.ToAddresses = new String[]{lObj.Email};
            emaillist.add(mail);                                             
        }
    }

  if (emaillist.size()>0)
  {
Messaging.SendEmailResult[] results = Messaging.sendEmail(emaillist);
   if (results[0].success)
                                      
                                      {
                                          System.Debug('The email was sent successfully.');
                                      }
                                      
    else
                                      {
                                          System.debug('The email failed to send: '+ results[0].errors[0].message);
                                      }
                                      

 }
}