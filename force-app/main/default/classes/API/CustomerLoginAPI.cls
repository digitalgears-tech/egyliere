/**
 * @description       : 
 * @author            : Mohamed Tarek
 * @group             : 
 * @last modified on  : 02-13-2023
 * @last modified by  : Mohamed Tarek
**/
@RestResource(urlMapping='/CustomerLoginAPI/*')
global  class CustomerLoginAPI {
    public static ContactService contactServiceInstance = ContactService.getInstance();
    public CustomerLoginAPI() {

    }
 
    @HttpPost
    global static void contactLogin( Map<String, String> credentials ) {
      RestResponse requestResponse= RestContext.response;
      requestResponse.addHeader('Content-Type', 'application/json');


      Map<String, Object> responseMap = new  Map<String, Object>();
    // try{
        RestRequest getReuest= RestContext.request;

        String app = getReuest.params.get('App');
     
      
      if(app.equals('Internal')|| app.equals('orange')){
       // try{
         if(getReuest.params.get('Provider')!=null){
          responseMap=contactServiceInstance.checkGoogleContact(credentials);

         }else{
        responseMap=contactServiceInstance.checkContactPassword(credentials, app);
        requestResponse.statusCode=200;}

        /*  }  catch(Exception e){
        RestContext.response.statusCode = 400;
        responseMap.put('Status', 'error');
        responseMap.put('Message', 'Invalid username or password');
        System.debug(e.getMessage());
         } */ 
      //}
        /*  }catch(Exception e){
        RestContext.response.statusCode = 400;
        responseMap.put('Status', 'error');
        responseMap.put('Message', 'Please enter your application name');
        System.debug(e.getMessage());
 */ 
      }
      requestResponse.responseBody=Blob.valueOf(Json.serialize(responseMap));

     
    }
  
}