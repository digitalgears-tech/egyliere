/**
 * @description       : 
 * @author            : Mohamed Tarek
 * @group             : 
 * @last modified on  : 03-01-2023
 * @last modified by  : Mohamed Tarek
**/
@IsTest
public  class ActionTests {

    @istest
    static void TestSendNotification() {
        DataFactoryTest dataFactoryTestInstance=DataFactoryTest.getInstance();
        Account testingAccount=dataFactoryTestInstance.CreateAccount('Testing', 'Account');
        Contact testingContact=dataFactoryTestInstance.CreateContact('testing', '2', '123', 'test@gmail.com', testingAccount.Id);
        
        AlertNoficationAction.NotificationAlertInput alert=new AlertNoficationAction.NotificationAlertInput();
        alert.devicetoken='test';
        alert.contactId=testingContact.Id;
        alert.title='testing';
        alert.body='testing notification';
        alert.type='Alert';
        alert.recordId='testingid';

        Map<String, String> headers = new Map<String, String>();
        headers.put('Content-Type', 'application/json');
    
        SingleRequestMock firebaseMock = new SingleRequestMock(
            200,
            '',
            '{ "replyCode": 0, "replyMessage": "Request handled successfully", "requestId": "2fbc0560-6187-11e7-b60b-77c0e21cef84", "clientRequestId": 0, "requestTime": "2017-07-05T15:38:10.742", "data": { "SentSMSIDs": [ { "SMSId": "0461f8f4-4c4f-4dc0-b7ed-097f4f9f85f4" } ], "InvalidRecipients": "" } }',
            headers
          );
          Test.setMock(HttpCalloutMock.class, firebaseMock);
      
        AlertNoficationAction.SendNotification(new List<AlertNoficationAction.NotificationAlertInput>{alert});

      
    }
  
    
}