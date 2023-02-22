/**
 * @description       : 
 * @author            : Mohamed Tarek
 * @group             : 
 * @last modified on  : 02-22-2023
 * @last modified by  : Mohamed Tarek
**/
public class FirebaseService {
    @Future (callout=true)
    public static void pushFireBaseNotification ( String to, String Msg, String MsgTitle,Map<String,String> data ){
        CustomMetadataRepository customMetadataRepositoryInstance=CustomMetadataRepository.getInstance();
        Firebase_Credential__mdt credentials = customMetadataRepositoryInstance.getFirebaseCredentials();
        
        Http http = new Http(); 
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://fcm.googleapis.com/fcm/send');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        request.setHeader('Authorization', credentials.API_Key__c); //legacy server key
        // Set the body as a JSON object
        Map<String,String> notification=new Map<String,String>{'body'=>Msg,'title'=>MsgTitle};
        Map<String,Object> requestBody=new Map<String,Object>{'to'=>to,'notification'=>notification,'data'=>data};




        request.setBody(JSON.serialize(requestBody));
        HttpResponse response = http.send(request);
        System.debug(response.getBody());
         
       
        
    }

}