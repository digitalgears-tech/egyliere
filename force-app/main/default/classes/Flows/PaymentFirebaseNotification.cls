/**
 * @description       : 
 * @author            : Mohamed Tarek
 * @group             : 
 * @last modified on  : 02-22-2023
 * @last modified by  : Mohamed Tarek
**/
global class PaymentFirebaseNotification {
    @InvocableMethod(label='SendPaymentMobileNotification')
    Global static void SendNotification (List<Opportunity> opps){
        
       
        Opportunity opp=opps[0];
        Contact currentContact=[SELECT Id,Device_Token__c FROM Contact WHERE AccountId=:opp.AccountId LIMIT 1];
        String deviceToken=currentContact.Device_Token__c;
        String title='Package ready for payment!';
        String body='Your package is now ready for payment !';
        Map<String,String> data=new Map<String,String>{'recordId'=>opp.Id,'notificationType'=>'Payment'};
        FirebaseService.pushFireBaseNotification(deviceToken, body, title, data);
        Notification__c newNotification=new Notification__c();
        newNotification.Contact__c=currentContact.Id;
        newNotification.Title__c=title;
        newNotification.Body__c=body;
        newNotification.Data__c=JSON.serialize(data);
        insert newNotification;

      
        
        
    } 

}