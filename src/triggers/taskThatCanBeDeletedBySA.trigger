trigger taskThatCanBeDeletedBySA on Task (before delete) {

    Id Pid = UserInfo.getProfileId();
    
    Profile pname = [Select name from Profile where id=:Pid];
    
    for (Task taskobj : Trigger.old)
    {
        if (pname.name !='System Administrator')
            taskobj.addError('No Access for Deletion');
    }
}