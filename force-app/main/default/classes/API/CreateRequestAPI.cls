@RestResource(urlMapping='/CreateRequestAPI/*')
global class CreateRequestAPI {
    public static AccountService accountServiceInstance = AccountService.getInstance();
    public static RequestService requestServiceInstance = RequestService.getInstance();
    public CreateRequestAPI() {
     
    }

    @HttpPost
    global static void CreateRequest(){
        RestRequest postReuest= RestContext.request;
        RestResponse requestResponse= RestContext.response;
        try{
        String app = postReuest.params.get('App');
        if(app.equals('Internal')){
           
            String recordId = postReuest.params.get('recordID');
            List< Object> body = (List< Object>)JSON.deserializeUntyped(RestContext.request.requestbody.tostring());
             requestServiceInstance.CreateReservationRequest(recordId , body);
           
         }
        }catch(Exception e){
            requestResponse.statusCode=400;
            requestResponse.responseBody = Blob.valueOf('ERROR: ' + e.getMessage());
         }
     }
}
