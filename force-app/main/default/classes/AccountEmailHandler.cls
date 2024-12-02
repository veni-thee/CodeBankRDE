/**
 * @description: Handled Inbound Emails from RDE
 * @author: Veni Gonzales
 * @department: NA
 * @testClass: AccountEmailHandler_Test
 */
global class AccountEmailHandler implements Messaging.InboundEmailHandler {

    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {

        // Initialize the result
        Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();

        try {
            String emailSubject = email.subject;
            String emailFromAddress = email.fromAddress;

            UserSelector usrSelector = new UserSelector();
            List<User> usrList = usrSelector.getUserByEmail(new Set<String> {emailFromAddress});
            Id validUsrId;

            // Example: Insert a record in Salesforce (e.g., Account)
            if (!usrList.isEmpty()) {
                validUsrId = usrList[0].Id;
                System.debug('INBOUND TEST ONLY');

                String refNum = null;

                // Check if the email subject contains square brackets and extract the value inside
                if (emailSubject != null && emailSubject.contains('[') && emailSubject.contains(']')) {
                    Pattern pattern = Pattern.compile('\\[(.*?)\\]');
                    Matcher matcher = pattern.matcher(emailSubject);
                    if (matcher.find()) {
                        refNum = matcher.group(1); // Extract the text inside the brackets
                        System.debug('Value inside brackets: ' + refNum);
                    } else {
                        System.debug('No text found inside square brackets.');
                    }
                }

                Id privateRTId = ConstantsGlobal.ACCOUNT_RECORDTYPEID_PRIVATE;
                List<EmailMessage> emailMsgListToCreate = new List<EmailMessage>();
                fflib_SObjectUnitOfWork uowEmail = new fflib_SObjectUnitOfWork(new List<Schema.SObjectType>{ EmailMessage.SObjectType });
                AccountSelector accSelector = new AccountSelector();
                List<Account> accList = accSelector.getAccByAccRefNum(new Set<String> {refNum});
                if (!accList.isEmpty()) {
                    for (Account acc : accList) {
                        if (acc.RecordTypeId != privateRTId) {
                            EmailMessage emailMsg = new EmailMessage();
                            if (email.ccAddresses != null) {
                                emailMsg.CcAddress = String.join(email.ccAddresses, ', ');
                            }
                            emailMsg.FromAddress = email.fromAddress;
                            emailMsg.MessageIdentifier = email.messageId;
                            emailMsg.FromName = email.fromName;
                            emailMsg.HtmlBody = email.htmlBody;
                            emailMsg.Subject = emailSubject;
                            emailMsg.RelatedToId = acc.Id; // Related Account ID
                            if (email.toAddresses != null) {
                                emailMsg.ToAddress = String.join(email.toAddresses, ', ');
                            }
                            emailMsgListToCreate.add(emailMsg);
                        } else {
                            System.debug('Cannot attach. Account is Private.');
                            emailFailedToAttachNotification(emailSubject, email.fromAddress);
                        }
                    }
                }

                if (!emailMsgListToCreate.isEmpty()) {
                    uowEmail.registerNew(emailMsgListToCreate);
                    uowEmail.commitWork();
                }
            }

            // Mark the email as processed successfully
            result.success = true;

        } catch (Exception e) {
            // Log the error and mark the email as failed
            System.debug('Error occurred: ' + e.getMessage());
            result.success = false;

            // Log the error in Nebula Logger
            Logger.error(e.getMessage());
            Logger.saveLog();
        }

        return result;
    }

    public void emailFailedToAttachNotification(String subject, String toEmailAddr){

        try {

        List<Messaging.SingleEmailMessage> notifEmailList = new List<Messaging.SingleEmailMessage>();

        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        // Set email details
        email.setToAddresses(new String[] { toEmailAddr }); // Recipient email
        email.setSubject('Email Failed to Attach to Account.');
        email.setPlainTextBody('Your email with subject: "' + subject + '" failed to attach as the Account is a "Private" record type.');

        notifEmailList.add(email);

        if (!notifEmailList.isEmpty()) {
            Messaging.sendEmail(notifEmailList);
        }

        } catch (Exception e) {
            // Log the error
            System.debug('Error occurred: ' + e.getMessage());

            // Log the error in Nebula Logger
            Logger.error(e.getMessage());
            Logger.saveLog();
        }
    }
}
