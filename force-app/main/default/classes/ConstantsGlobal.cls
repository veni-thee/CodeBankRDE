/**
 * @description: Class to store all the constants.
 * @author: Veni Gonzales
 * @department: N/A
 * @testClass: ConstantsGlobal_Test
 */
public class ConstantsGlobal {

    //Constants for Opportunity Object
    public final static Id ACCOUNT_RECORDTYPEID_PRIVATE {
        get {
            return RecordTypeSelector.getRecordTypeByDevNameAndObject('Private', 'Account');
        }
    }
}