/**
 * @description: Test Class for RecordTypeSelector
 * @author: Veni Gonzales
 * @department: N/A
 */
@isTest
public class RecordTypeSelector_Test {
    
	@isTest
    static void testRecordTypeSelector() {
        Id testId = RecordTypeSelector.getRecordTypeByDevNameAndObject('TestDevName', 'TestObject');
        Assert.areEqual(true, testId == null);
    }
}