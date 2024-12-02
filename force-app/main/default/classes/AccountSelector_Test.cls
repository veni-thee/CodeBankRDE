/**
 * @description: Test Class for AccountSelector
 * @author: Veni Gonzales
 * @department: N/A
 */
@isTest
public with sharing class AccountSelector_Test {
    
    @isTest
    static void testAccountSelector() {
        // Instantiate UserSelector
        AccountSelector accSel = new AccountSelector();
        
        // Generate a random User Id and test selectById with an empty result
        Id accId = fflib_IDGenerator.generate(Account.SObjectType);
        Assert.areEqual(0, accSel.selectById(new Set<Id> {accId}).size());
        
        // Test getAccByAccRefNum method to assert that it returns an empty result
        Assert.areEqual(0, accSel.getAccByAccRefNum(new Set<String> {'XXX-456'}).size());
    }
}