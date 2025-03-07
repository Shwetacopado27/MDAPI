public class Demo4 {

  public void mainreferencemethod()
  {
          
    Account a = new Account();
      a.name = 'test account';
      a.website = 'www.apexclass6.com';
    system.debug('before referencebyvalue:' + a);
    
    referencebyvalue(a);
    
    system.debug('after referencebyvalue:' + a);
   }
    
    public void referencebyvalue(Account a)
    {
       a.website = 'www.salesforce.com';
    }
}