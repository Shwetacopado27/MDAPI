trigger AccountTrigger on Account (after insert) {
    

    if (trigger.isAfter && trigger.IsInsert)
    {
    
        List<Contact> contacts = new List<Contact>();

		for (Account a: trigger.new)

{
   		 Contact c = new Contact(Lastname = a.name+ 'con', AccountId = a.Id );
    	 contacts.add(c);
}    
       insert contacts;
        
    }
}