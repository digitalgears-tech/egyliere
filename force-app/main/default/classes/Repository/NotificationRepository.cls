/**
 * @description       : 
 * @author            : Mohamed Tarek
 * @group             : 
 * @last modified on  : 02-26-2023
 * @last modified by  : Mohamed Tarek
**/
public class NotificationRepository {
    private static NotificationRepository instance=null; 

    public static NotificationRepository getInstance() {
        if (instance == null) {
          instance = new NotificationRepository();
        }
        return instance;
      }

    public List<Notification__c> getNotificationsByContact(String contactId){
        return [SELECT Id,Title__c,Body__c,Data__c FROM Notification__c WHERE Contact__c=:contactId ORDER BY createddate DESC];
    }
}