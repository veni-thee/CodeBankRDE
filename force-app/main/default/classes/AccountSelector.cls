/**
 * @description: Selector class for Account Object
 * @author: Veni Gonzales
 * @department: NA
 * @testClass: AccountSelector_Test
 */
public with sharing class AccountSelector extends fflib_SObjectSelector {
    
    public Schema.SObjectType getSObjectType() {
        return Account.SObjectType;
    }
    
    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<SObjectField> {
            Account.Id,
            Account.Name,
            Account.Acct_Ref__c,
            Account.RecordTypeId
        };
    }
    
    public List<Account> selectById(Set<Id> idSet) {
        return (List<Account>) selectSObjectsById(idSet);
    }
     
    public List<Account> getAccByAccRefNum(Set<String> acctRef){
        /** Setting newQueryFactory(false) means it will not query the selected fields
         based on the getSObjectFieldList **/
        fflib_QueryFactory query = newQueryFactory()
        .setCondition('Acct_Ref__c IN :acctRef')
        .setLimit( 1 );
        return (List<Account>) Database.query( query.toSOQL() );
    }
}