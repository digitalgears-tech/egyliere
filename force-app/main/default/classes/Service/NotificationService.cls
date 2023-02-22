/**
 * @description       : 
 * @author            : Mohamed Tarek
 * @group             : 
 * @last modified on  : 02-22-2023
 * @last modified by  : Mohamed Tarek
**/
public  class NotificationService {
    private static NotificationService instance = null;
    public NotificationRepository notificationRepositoryInstance;
    public NotificationMapper notificationMapperInstance=new NotificationMapper();

    public NotificationService() {
       notificationRepositoryInstance=NotificationRepository.getInstance();
    }

    public static NotificationService getInstance() {
        if (instance == null) {
          instance = new NotificationService();
        }
        return instance;
      }
    public List<NotificationMapper> mapObjectListToMapper(String contactId){
        return notificationMapperInstance.notificationsListToObject(notificationRepositoryInstance.getNotificationsByContact(contactId));  
    }
}