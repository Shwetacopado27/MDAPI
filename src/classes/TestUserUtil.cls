@isTest
public class TestUserUtil {
    public static User createUser(String fName, String lName, String alias, String username, Profile profile) {
        User usr = new User(LastName = lName,
                            FirstName = fName,
                            Alias = alias,
                            Email = fName + '.' + lName + '@apexstepbystep.com',
                            Username = username,
                            ProfileId = profile.id,
                            TimeZoneSidKey = 'GMT',
                            LanguageLocaleKey = 'en_US',
                            EmailEncodingKey = 'UTF-8',
                            LocaleSidKey = 'en_US'
                           );
        return usr;
    }
}