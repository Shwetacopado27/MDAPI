@isTest
private class UserTriggerTest {
    // Verify that when user having System Administrator profile is created, the user is also added to the public group Admin.
    @isTest
    static void testUserInsertion_valid() {
        Group adminGroup = [SELECT Id FROM Group WHERE DeveloperName = 'Admins' AND Type = 'Regular' LIMIT 1];
        // GroupMembers before insertion
        List<GroupMember> membersBefore = [SELECT Id From GroupMember Where GroupId = :adminGroup.Id];
        
        Profile adminProfile = [SELECT Id FROM Profile WHERE Name = 'System Administrator' LIMIT 1];
        User usr = TestUserUtil.createUser('Test', 'User', 'tusr', 'test.user444@apexstepbystep.com', adminProfile);
        
        Test.startTest();
        insert usr;
        Test.stopTest();
        
        // Assert that members after insertion should be exactly 1 greater than before
        List<GroupMember> membersAfter = [SELECT Id, UserOrGroupId From GroupMember Where GroupId = :adminGroup.Id];
        System.assertEquals(membersBefore.size() + 1, membersAfter.size(), 'User is not added to group Admins.');
        
        Set<Id> userIdsSet = new Set<Id>();
        for(GroupMember member : membersAfter) {
            userIdsSet.add(member.UserOrGroupId);
        }
        System.assertEquals(true, userIdsSet.contains(usr.Id), 'GroupMember is not created for the inserted user.');
    }
    
    // Verify that when user having other than the System Administrator profile is created, the user should not be added to the public group Admin.
    @isTest
    static void testUserInsertion_invalid() {
        Group adminGroup = [SELECT Id FROM Group WHERE DeveloperName = 'Admins' AND Type = 'Regular' LIMIT 1];
        // GroupMembers before insertion
        List<GroupMember> membersBefore = [SELECT Id From GroupMember Where GroupId = :adminGroup.Id];
        
        Profile adminProfile = [SELECT Id FROM Profile WHERE Name = 'Standard User' LIMIT 1];
        User usr = TestUserUtil.createUser('Test', 'User', 'tusr', 'test.user444@apexstepbystep.com', adminProfile);
        
        Test.startTest();
        insert usr;
        Test.stopTest();
        
        // Assert that members after insertion should be same as before
        List<GroupMember> membersAfter = [SELECT Id, UserOrGroupId From GroupMember Where GroupId = :adminGroup.Id];
        System.assertEquals(membersBefore.size(), membersAfter.size(), 'Group Members count is not same.');
        
        Set<Id> userIdsSet = new Set<Id>();
        for(GroupMember member : membersAfter) {
            userIdsSet.add(member.UserOrGroupId);
        }
        System.assertEquals(false, userIdsSet.contains(usr.Id), 'GroupMember is created for the inserted user.');
    }
}