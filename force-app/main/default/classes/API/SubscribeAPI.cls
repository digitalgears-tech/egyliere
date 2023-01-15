@RestResource(urlMapping='/SubscribeAPI/*')
global  class SubscribeAPI {
    public static AccountService accountServiceInstance = AccountService.getInstance();
    public static RequestService requestServiceInstance = RequestService.getInstance();
    public SubscribeAPI() {

    }

    @HttpPost
    global static void CreateSubscribtionRequest(){
        RestRequest postReuest= RestContext.request;
        RestResponse requestResponse= RestContext.response;
       try{ 
         String app = postReuest.params.get('App');
            if(app.equals('Internal')){
                 String recordId = postReuest.params.get('recordID');
                 List< Object> body = (List< Object>)JSON.deserializeUntyped(RestContext.request.requestbody.tostring());
                 requestServiceInstance.CreateSubscribeRequest(recordId , body);           
                 requestResponse.responseBody=Blob.valueOf(' Subscribtion request Submited' );
                 requestResponse.statusCode=200;
             }
        }catch(Exception e){
            requestResponse.statusCode=400;
            requestResponse.responseBody = Blob.valueOf('ERROR: ' + e.getMessage());
        }
    }
}
