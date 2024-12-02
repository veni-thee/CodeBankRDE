/**
 * @description: Selector Class for RecordType Object
 * @author: Veni Gonzales
 * @department: N/A
 * @testClass: RecordTypeSelector_Test
 */
public class RecordTypeSelector {
    
    public static Id getRecordTypeByDevNameAndObject(String recordTypeDeveloperName, String objectType) {
        List<RecordType> recordTypeList = [SELECT Id, DeveloperName, SobjectType, IsActive
                                           FROM RecordType 
                                           WHERE DeveloperName =: recordTypeDeveloperName
                                           AND SobjectType =: objectType
                                           AND IsActive = true];
        if (!recordTypeList.isEmpty()) {
            return recordTypeList[0].Id;
        } else {
            return null;
        }
    }
    
}