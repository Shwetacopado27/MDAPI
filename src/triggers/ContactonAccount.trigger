trigger ContactonAccount on Account (After insert, after update) {

    
    List<Contact> lstcon = new List<Contact>();
    for (Account acc: Trigger.new)
    {
        If (acc.AnnualRevenue!=null)
        {
        Contact con = new Contact();
        con.FirstName = 'Test';
        con.AccountId = acc.Id;
        con.LastName = 'ss';
        lstcon.add(con);
    }
    }
    
    Insert lstcon;
}