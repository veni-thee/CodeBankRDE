/**
 * @description: Trailhead: Apex Integration Services > Apex Web Services
 * @author: Veni Gonzales
 * @department: N/A
 * Test Class: CaseManagerTest
 */

//  Create an Apex REST class that is accessible at /Accounts/<Account_ID>/contacts. The service will return the account's ID and name plus the ID and name of all contacts associated with the account. Write unit tests that achieve 100% code coverage for the class and run your Apex tests.

// Class must have a method called getAccount
// Method must be annotated with @HttpGet and return an Account object
// Method must return the ID and Name for the requested record and all associated contacts with their ID and Name
// Create unit tests
// Unit tests must be in a separate Apex class called AccountManagerTest
// Unit tests must cover all lines of code included in the AccountManager class, resulting in 100% code coverage
// Run your test class at least once (via Run All tests the Developer Console) before attempting to verify this challenge


@RestResource(urlMapping='/Cases/*')
global with sharing class CaseManager {
    
	@HttpGet
    global static Case getCaseById() {
        RestRequest request = RestContext.request;
        // grab the caseId from the end of the URL
        String caseId = request.requestURI.substring(
        	request.requestURI.lastIndexOf('/')+1);
        Case result = [SELECT CaseNumber, Subject, Status, Origin, Priority
                      FROM Case
                      WHERE Id =: caseId];
        return result;
    }
    @HttpPost
    global static Id createCase(String subject, String status,
    	String origin, String priority) {
		Case thisCase = new Case(
        	Subject = subject,
        	Status = status,
        	Origin = origin,
        	Priority = priority);
      	insert thisCase;
        return thisCase.Id;
	}
    @HttpDelete
    global static void deleteCase() {
        RestRequest request = RestContext.request;
        String caseId = request.requestURI.substring(
        	request.requestURI.lastIndexOf('/')+1);
        Case thisCase = [SELECT Id FROM Case WHERE Id = :caseId];
        delete thisCase;
    }
    @HttpPut
    global static Id upsertCase(String subject, String status,
    	String origin, String priority, String id) {
   		Case thisCase = new Case(
        	Id = id,
        	Subject = subject,
        	Status = status,
        	Origin = origin,
        	Priority = priority);                                    
            // Match case by Id, if present.
            // Otherwise create a new case.
            upsert thisCase;
        	// Return the case Id
        	return thisCase.Id;
    	}
    @HttpPatch
    global static Id updateCaseFields() {
        RestRequest request = RestContext.request;
        String caseId = request.requestURI.substring(
        	request.requestURI.lastIndexOf('/')+1);
        Case thisCase = [SELECT Id FROM Case WHERE Id = :caseId];
        // Deserialize the JSON string into name-value pairs
        Map<String, Object> params = (Map<String, Object>)JSON.deserializeUntyped(request.requestbody.toString());
        // Iterate through each parameter field and value
        for (String fieldName : params.keySet()) {
            //Set the field and value on the Case sObject
            thisCase.put(fieldName, params.get(fieldName));
        }
        update thisCase;
        return thisCase.Id;
    }
}