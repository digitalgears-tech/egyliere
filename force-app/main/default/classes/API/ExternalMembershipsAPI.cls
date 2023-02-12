@RestResource(urlMapping='/ExternalMembershipsAPI/*')
global  class ExternalMembershipsAPI {
    public static ExternalMembershipsService externalMembershipsServiceInstance = ExternalMembershipsService.getInstance();
    public ExternalMembershipsAPI() {

    }

    @HttpGet
    global static List<ExternalMembershipsMapper>  getCustomerExternalMemberships(){
        RestRequest getReuest= RestContext.request;
        RestResponse requestResponse= RestContext.response;

        try{
        String app = getReuest.params.get('App');
        String id;

        if(app.equals('orange')){
            id = getReuest.params.get('orangeID');
            return externalMembershipsServiceInstance.GetContactMemberships(id, app);
        }
        else if(app.equals('Internal')){
            id = getReuest.params.get('recordID');
           return externalMembershipsServiceInstance.GetContactMemberships(id, app);
        }else{
            throw new GeneralException('No allowed for external apps');
        }
   }catch (System.NullPointerException e) {
        requestResponse.statusCode=500;
        requestResponse.responseBody = Blob.valueOf('ERROR: ' + e.getMessage());
        throw new GeneralException(e.getMessage());
   }

    catch (System.DmlException e) {
        requestResponse.statusCode=500;
        requestResponse.responseBody = Blob.valueOf('ERROR: ' + e.getMessage());
        throw new GeneralException(e.getMessage());
    }

    catch(GeneralException e){
        requestResponse.statusCode=400;
        requestResponse.responseBody = Blob.valueOf('ERROR: ' + e.getMessage());
        throw new GeneralException(e.getMessage());
    }
    }
    @HttpPost
    global static void SetCustomerExternalMemberships(){
        RestRequest getReuest= RestContext.request;
        RestResponse requestResponse= RestContext.response;
        try{
        String app = getReuest.params.get('App');
        String id;
        if(app.equals('Internal')){
            id = getReuest.params.get('recordID');
            List< Object> body = (List< Object>)JSON.deserializeUntyped(RestContext.request.requestbody.tostring());
            externalMembershipsServiceInstance.AddContactMembership(id, body);
        }else{
            throw new GeneralException(' not allowed for external apps');

        }
    }catch (System.NullPointerException e) {
        requestResponse.statusCode=500;
        requestResponse.responseBody = Blob.valueOf('ERROR: ' + e.getMessage());
   
   }

    catch (System.DmlException e) {
        requestResponse.statusCode=500;
        requestResponse.responseBody = Blob.valueOf('ERROR: ' + e.getMessage());
   
    }

    catch(GeneralException e){
        requestResponse.statusCode=400;
        requestResponse.responseBody = Blob.valueOf('ERROR: ' + e.getMessage());
  
    }

    }

    @HttpDelete
    global static void DeleteCustomerExternalMemberships(){
       RestRequest getReuest= RestContext.request;
       RestResponse requestResponse= RestContext.response;

       String app = getReuest.params.get('App');
       String id;
       try{ 
          if(app.equals('Internal')){
            id = getReuest.params.get('recordID');
            List< Object> body = (List< Object>)JSON.deserializeUntyped(RestContext.request.requestbody.tostring());
            externalMembershipsServiceInstance.deleteContactMembership(body);
         }
        }catch (System.NullPointerException e) {
            requestResponse.statusCode=500;
            requestResponse.responseBody = Blob.valueOf('ERROR: ' + e.getMessage());
}

    catch (System.DmlException e) {
            requestResponse.statusCode=500;
            requestResponse.responseBody = Blob.valueOf('ERROR: ' + e.getMessage());
}

    catch(GeneralException e){
            requestResponse.statusCode=400;
            requestResponse.responseBody = Blob.valueOf('ERROR: ' + e.getMessage());
}

    }
}