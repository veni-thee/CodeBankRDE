/**
 * @description: Test Class for UserSelector
 * @author: Veni Gonzales
 * @department: N/A
 */
@isTest
public class UserSelector_Test {

    @isTest
    static void testUserSelector() {
        // Instantiate UserSelector
        UserSelector usrSel = new UserSelector();
        
        // Generate a random User Id and test selectById with an empty result
        Id usrId = fflib_IDGenerator.generate(User.SObjectType);
        Assert.areEqual(0, usrSel.selectById(new Set<Id> {usrId}).size());
        
        // Test getUserByEmail method to assert that it returns an empty result
        Assert.areEqual(0, usrSel.getUserByEmail(new Set<String> {'test@email.com'}).size());
    }
}