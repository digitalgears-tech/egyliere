@RestResource(urlMapping='/ExternalMembershipsAPI/*')
global  class ExternalMembershipsAPI {
    public static ExternalMembershipsService externalMembershipsServiceInstance = ExternalMembershipsService.getInstance();
    public ExternalMembershipsAPI() {

    }

    @HttpGet
    global static List<ExternalMembershipsMapper>  getCustomerExternalMemberships(){
        RestRequest getReuest= RestContext.request;
        String app = getReuest.params.get('App');
        String id;

        if(app.equals('orange')){
            id = getReuest.params.get('orangeID');
            return externalMembershipsServiceInstance.GetContactMemberships(id, app);
        }
        if (app.equals('Internal')){
            id = getReuest.params.get('recordID');
           return externalMembershipsServiceInstance.GetContactMemberships(id, app);
        }

        return null;
    }
    @HttpPost
    global static void SetCustomerExternalMemberships(){
        RestRequest getReuest= RestContext.request;
        String app = getReuest.params.get('App');
        String id;
        if(app.equals('Internal')){
            id = getReuest.params.get('recordID');
            List< Object> body = (List< Object>)JSON.deserializeUntyped(RestContext.request.requestbody.tostring());
            externalMembershipsServiceInstance.AddContactMembership(id, body);
        }
 
    }

    @HttpDelete
    global static void DeleteCustomerExternalMemberships(){
       RestRequest getReuest= RestContext.request;
       RestResponse errorResponse= RestContext.response;
       String app = getReuest.params.get('App');
       String id;
       try{ 
          if(app.equals('Internal')){
            id = getReuest.params.get('recordID');
            List< Object> body = (List< Object>)JSON.deserializeUntyped(RestContext.request.requestbody.tostring());
            externalMembershipsServiceInstance.deleteContactMembership(body);
         }
        }catch(Exception e){
            errorResponse.statusCode = 400; 
            errorResponse.responseBody = Blob.valueOf(e.getMessage());
        }

    }
}