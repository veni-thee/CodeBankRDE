/**
 * @description: Test Class for ConstantsGlobal
 * @author: Veni Gonzales
 * @department: N/A
 */
@isTest
public class ConstantsGlobal_Test {
    
    public final static Id ACCOUNT_RECORDTYPEID_PRIVATE = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Private').getRecordTypeId();
    
    @isTest
    static void testConstantsGlobal() {
        System.assertEquals(ACCOUNT_RECORDTYPEID_PRIVATE, ConstantsGlobal.ACCOUNT_RECORDTYPEID_PRIVATE);
    }
}