/**
 * @description       : 
 * @author            : Mohamed Tarek
 * @group             : 
 * @last modified on  : 02-22-2023
 * @last modified by  : Mohamed Tarek
**/
@RestResource(urlMapping='/Notifications/*')
global class NotificationAPI {
    public static NotificationService notificationServiceInstance=NotificationService.getInstance();

    @HttpGet
    global static  List<NotificationMapper>  getNotifications(){
        RestRequest getReuest= RestContext.request;
        RestResponse requestResponse= RestContext.response;
    {
        String app = getReuest.params.get('App');
      if(app.equals('Internal')){
        String recordId = getReuest.params.get('recordID');
        return notificationServiceInstance.mapObjectListToMapper(recordId);
      }else{
            requestResponse.statusCode=503;
            throw new GeneralException('Not allowed for External apps');}

        
      


    }
}
}
