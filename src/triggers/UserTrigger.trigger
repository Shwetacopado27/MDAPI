trigger UserTrigger on User (after insert) {
    if(Trigger.isAfter) {
        if(Trigger.isInsert) {
            UserTriggerHandler.addAdminToPublicGroup(Trigger.new);
        }
    }
}