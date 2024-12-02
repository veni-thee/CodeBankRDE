/**
 * @description: Selector class for User Object
 * @author: Veni Gonzales
 * @department: NA
 * @testClass: UserSelector_Test
 */
public with sharing class UserSelector extends fflib_SObjectSelector {
    
    public Schema.SObjectType getSObjectType() {
        return User.SObjectType;
    }
    
    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<SObjectField> {
            User.Id,
            User.Name,
            User.Email,
            User.IsActive
        };
    }
    
    public List<User> selectById(Set<Id> idSet) {
        return (List<User>) selectSObjectsById(idSet);
    }
     
    public List<User> getUserByEmail(Set<String> email){
        /** Setting newQueryFactory(false) means it will not query the selected fields
         based on the getSObjectFieldList **/
        fflib_QueryFactory query = newQueryFactory()
        .setCondition('Email IN :email AND IsActive = true')
        .setLimit( 1 );
        return (List<User>) Database.query( query.toSOQL() );
    }
}