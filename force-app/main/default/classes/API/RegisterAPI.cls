@RestResource(urlMapping='/RegisterAPI/*')
global class RegisterAPI {
    public static ContactService contactServiceInstance = ContactService.getInstance();
    public static AccountService accountServiceInstance = AccountService.getInstance();
    public static RequestService requestServiceInstance = RequestService.getInstance();
    public RegisterAPI() {

    }

    @HttpPost
    global static void setRegisterRequest(){
        RestRequest getReuest= RestContext.request;
        RestResponse requestResponse= RestContext.response;
        String app = getReuest.params.get('App');
        if(app.equals('Internal')){
            try{
            List< Object> body = (List< Object>)JSON.deserializeUntyped(RestContext.request.requestbody.tostring());
           Account account = accountServiceInstance.CreateRegisterAccount(body);
           Contact contact = contactServiceInstance.CreateRegisterContact(body, account);           
            requestResponse.responseBody=Blob.valueOf(' Accepted registeration');
            requestResponse.statusCode=200;
            }catch(Exception e){
               requestResponse.statusCode=400;
               requestResponse.responseBody = Blob.valueOf('ERROR: ' + e.getMessage());
            }
         }
        
    }
}