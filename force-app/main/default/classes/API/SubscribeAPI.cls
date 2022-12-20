@RestResource(urlMapping='/SubscribeAPI/*')
global class SubscribeAPI {
    public static ContactService contactServiceInstance = ContactService.getInstance();
    public static AccountService accountServiceInstance = AccountService.getInstance();
    public static RequestService requestServiceInstance = RequestService.getInstance();
    public SubscribeAPI() {

    }

    @HttpPost
    global static void setSubscribtionRequest(){
        RestRequest getReuest= RestContext.request;
        RestResponse requestResponse= RestContext.response;
        String app = getReuest.params.get('App');
        if(app.equals('Internal')){
            try{
            List< Object> body = (List< Object>)JSON.deserializeUntyped(RestContext.request.requestbody.tostring());
           Account account = accountServiceInstance.CreateSubscribeAccount(body);
           Contact contact = contactServiceInstance.CreateSubscribeContact(body, account);
           requestServiceInstance.CreateSubscribeRequest(contact, account);
           requestResponse.statusCode=200;
           requestResponse.responseBody=Blob.valueOf(' Accepted subscription');
            }catch(Exception e){
                requestResponse.statusCode=400;
                requestResponse.responseBody = Blob.valueOf('ERROR: ' + e.getMessage());
            }
         }
    }
}
