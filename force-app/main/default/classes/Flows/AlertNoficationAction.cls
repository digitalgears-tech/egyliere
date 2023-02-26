/**
 * @description       : 
 * @author            : Mohamed Tarek
 * @group             : 
 * @last modified on  : 02-23-2023
 * @last modified by  : Mohamed Tarek
**/
global class AlertNoficationAction {

    @InvocableMethod(label='SendAlertNotification')
    global static void SendNotification (List<NotificationAlertInput> input){
        NotificationAlertInput inputDetails=input[0];
        String title=inputDetails.title; 
        String body=inputDetails.body;
        Map<String,String> data=new Map<String,String>{'recordId'=>inputDetails.recordId,'notificationType'=>inputDetails.type};
        FirebaseService.pushFireBaseNotification(inputDetails.deviceToken, body, title, data);
        Notification__c newNotification=new Notification__c();
        newNotification.Contact__c=inputDetails.contactId;
        newNotification.Title__c=title;
        newNotification.Body__c=body;
        newNotification.Data__c=JSON.serialize(data);
        insert newNotification;
    } 

    global class NotificationAlertInput{
        @InvocableVariable
        public String deviceToken;
        @InvocableVariable
        public String contactId;
        @InvocableVariable
        public String title;
        @InvocableVariable
        public String body;
        @InvocableVariable
        public String type;
        @InvocableVariable
        public String recordId;
    }
   
}