/**
 * @description: Test Class for AccountEmailHandler
 * @author: Veni Gonzales
 * @department: N/A
 */
@isTest
public class AccountEmailHandler_Test {

    private static fflib_ApexMocks mocks = new fflib_ApexMocks();

    @isTest
    static void testHandleInboundEmail_Success() {
        // Step 1: Set up test data
        
        // Create a User
        Id runningUsrId = UserInfo.getUserId();
        User runningUsr = [SELECT Id, Email FROM User WHERE Id = :runningUsrId LIMIT 1];

        // Create an Account
        Account testAccount = new Account();
        testAccount.Name = 'Test Account Name';
        testAccount.Acct_Ref__c = 'REF-XXX';
        insert testAccount;

        // Step 2: Create inbound email data
        Messaging.InboundEmail email = new Messaging.InboundEmail();
        email.subject = 'Reference [REF-XXX]';
        email.fromAddress = runningUsr.Email;
        email.ccAddresses = new List<String>{ runningUsr.Email };
        email.plainTextBody = 'This is a test email.';
        email.toAddresses = new List<String>{ 'inboundrde@2-2g2hh7wrfrl165xi8bpif7h8buaffhum2vqw9rux7qybt2vd9c.ns-7ifxb2a2.ind56.apex.salesforce.com' };

        Messaging.InboundEnvelope envelope = new Messaging.InboundEnvelope();
        envelope.fromAddress = runningUsr.Email;

        // Step 3: Execute the handler
        AccountEmailHandler handler = new AccountEmailHandler();
        Messaging.InboundEmailResult result = handler.handleInboundEmail(email, envelope);

        // Step 4: Assertions
        System.assert(result.success, 'The email should be processed successfully.');

        // Verify that the email message was created and is related to the account
        List<EmailMessage> emailMessages = [SELECT Id, Subject, RelatedToId FROM EmailMessage WHERE Subject = :email.subject];
        System.assertEquals(1, emailMessages.size(), 'There should be one EmailMessage created.');
        System.assertEquals(testAccount.Id, emailMessages[0].RelatedToId, 'The EmailMessage should be related to the correct Account.');
    }

    @isTest
    static void testHandleInboundEmail_PrivateAccountNotification() {
        // Step 1: Set up test data
        // Create a User
        // Create a User
        Id runningUsrId = UserInfo.getUserId();
        User runningUsr = [SELECT Id, Email FROM User WHERE Id = :runningUsrId LIMIT 1];

        // Create a Private Account
        Account privateAccount = new Account();
        privateAccount.Name = 'Test Private Account Name';
        privateAccount.Acct_Ref__c = 'REF-ZZZ';
        privateAccount.RecordTypeId = ConstantsGlobal.ACCOUNT_RECORDTYPEID_PRIVATE;
        insert privateAccount;

        // Step 2: Create inbound email data
        Messaging.InboundEmail email = new Messaging.InboundEmail();
        email.subject = 'Reference [REF-ZZZ]';
        email.fromAddress = runningUsr.Email;
        email.plainTextBody = 'This is a test email.';

        Messaging.InboundEnvelope envelope = new Messaging.InboundEnvelope();
        envelope.fromAddress = runningUsr.Email;

        // Step 3: Execute the handler
        AccountEmailHandler handler = new AccountEmailHandler();
        Messaging.InboundEmailResult result = handler.handleInboundEmail(email, envelope);

        // Step 4: Assertions
        System.assert(result.success, 'The email should be processed successfully.');

        // Verify no EmailMessage was created
        List<EmailMessage> emailMessages = [SELECT Id FROM EmailMessage WHERE Subject = :email.subject];
        System.assertEquals(0, emailMessages.size(), 'No EmailMessage should be created for a Private Account.');
    }
}
