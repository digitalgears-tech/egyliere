/**
 * @description       : 
 * @author            : Mohamed Tarek
 * @group             : 
 * @last modified on  : 02-21-2023
 * @last modified by  : Mohamed Tarek
**/
public class VisaExpiryBatch implements Database.Batchable<sObject>  { 
    public Set<String> activeUsersIds=new Set<String>();

    public VisaExpiryBatch(){
      User[] activeUsers=[SELECT Id FROM User WHERE isActive=true];
      for(User user:activeUsers){
        activeUsersIds.add(user.Id);
      }
    }
  
    
      public Database.QueryLocator start(Database.BatchableContext bc) {
        // collect the batches of records or objects to be passed to execute
    
  
        // Code Review:  convert to query not string query
        return Database.getQueryLocator(
          [
            SELECT 
            Contact__r.Name,
            Contact__c
            FROM Visa__c
            WHERE Expiration_Date__c< :Date.Today()
          
  
          ] 
        );
      }
      public void execute(
        Database.BatchableContext bc, 
        List<Visa__c> expiredVisas
      ) {
                  // Get the Id for our custom notification type


    for(Visa__c visa:expiredVisas){
        CustomNotificationType notificationType = 
        [SELECT Id, DeveloperName 
         FROM CustomNotificationType 
         WHERE DeveloperName='Notification'];
    
    // Create a new custom notification
    Messaging.CustomNotification notification = new Messaging.CustomNotification();

    // Set the contents for the notification
    notification.setTitle('Visa Expired');
    notification.setBody('The Visa expired for the following Contact '+visa.Contact__r.Name);

    // Set the notification type and target
    notification.setNotificationTypeId(notificationType.Id);
    notification.setTargetId(visa.Id);
    
    // Actually send the notification
    try {
        notification.send(activeUsersIds);
    }
    catch (Exception e) {
        System.debug('Problem sending notification: ' + e.getMessage());
    }
}
      }
      public void finish(Database.BatchableContext bc) {
      }
}