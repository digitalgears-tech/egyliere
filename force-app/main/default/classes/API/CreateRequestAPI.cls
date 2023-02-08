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
             requestResponse.statusCode=200;
            requestResponse.responseBody = Blob.valueOf('Request successfully created');
           
         }
        }catch (System.NullPointerException e) {
            requestResponse.statusCode=500;
            requestResponse.responseBody = Blob.valueOf('ERROR: ' + e.getMessage());
         throw new GeneralException(e.getMessage());}

        catch (System.DmlException e) {
            requestResponse.statusCode=500;
            requestResponse.responseBody = Blob.valueOf('ERROR: ' + e.getMessage());
       throw new GeneralException(e.getMessage());}

        catch(GeneralException e){
            requestResponse.statusCode=400;
       throw new GeneralException(e.getMessage());}
    
     }
}