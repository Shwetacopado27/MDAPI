trigger duplicateLead on Lead (after insert) {
    
    if(checkrecursive.runonce())
    {
        List<Lead> leadlst = new List<Lead>();
        leadlst = Trigger.new.deepclone();
        insert leadlst;
    }

}