/**
 * @description       : 
 * @author            : Mohamed Tarek
 * @group             : 
 * @last modified on  : 02-22-2023
 * @last modified by  : Mohamed Tarek
**/
global class NotificationMapper {
   
    public String title;
    public String body;
    public Map<String,String> data;


    public NotificationMapper notificationMapperToObject(Notification__c notification){  
        NotificationMapper mapper=new NotificationMapper();
        mapper.title=notification.Title__c;
        mapper.body=notification.Body__c;
        mapper.data=(Map<String,String>) JSON.deserialize(notification.Data__c, Map<String,String>.class); 
        return mapper;
    }
    public List<NotificationMapper> notificationsListToObject(List<Notification__c> notificationList){
      

        List<NotificationMapper> notificationMapperList=new List<NotificationMapper>();
       
        for( Notification__c p : notificationList ){
           notificationMapperList.add(notificationMapperToObject(p));

        }

        return notificationMapperList;

    }
}