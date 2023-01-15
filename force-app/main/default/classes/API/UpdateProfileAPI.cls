@RestResource(urlMapping='/UpdateProfileAPI/*')
global class UpdateProfileAPI {
    public static ContactService contactServiceInstance = ContactService.getInstance();
   
    public UpdateProfileAPI() {

    }

 @HttpPost
 global static void UpdateProfile(){
    RestRequest getReuest= RestContext.request;
    RestResponse requestResponse= RestContext.response;
    try{
    String app = getReuest.params.get('App');
    if(app.equals('Internal')){
        String id = getReuest.params.get('recordID');
        List< Object> body = (List< Object>)JSON.deserializeUntyped(RestContext.request.requestbody.tostring());  
        contactServiceInstance.updateContactInfo(body,app,id);        
        requestResponse.responseBody=Blob.valueOf(' Profile Updated' );
        requestResponse.statusCode=200;
      
     }
     }catch(Exception e){
      requestResponse.statusCode=400;
      requestResponse.responseBody = Blob.valueOf('ERROR: ' + e.getMessage());
    }
 }
}
