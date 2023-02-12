@RestResource(urlMapping='/ForgetPasswordAPI/*')
global class ForgetPasswordAPI {
    public static ContactService contactServiceInstance = ContactService.getInstance();

    public ForgetPasswordAPI() {

    }

    @HttpPost
    global static void forgetPassword() {
      RestRequest getReuest = RestContext.request;
      RestResponse requestResponse= RestContext.response;
      String app;
  
      try{
        app = getReuest.params.get('App');
      if (app.equals('Internal')) {
        List< Object> body = (List< Object>)JSON.deserializeUntyped(RestContext.request.requestbody.tostring());  
        contactServiceInstance.setNewPassword(body);
        requestResponse.statusCode=200;
          requestResponse.responseBody = Blob.valueOf('Password updated successfully');
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

