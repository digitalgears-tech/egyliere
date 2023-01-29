@RestResource(urlMapping='/CustomerLoginAPI/*')
global  class CustomerLoginAPI {
    public static ContactService contactServiceInstance = ContactService.getInstance();
    public CustomerLoginAPI() {

    }
 
    @HttpPost
    global static Map<String, String> contactLogin( Map<String, String> credentials ) {
      Map<String, String> responseMap = new  Map<String, String>();
     try{
        RestRequest getReuest= RestContext.request;
        String app = getReuest.params.get('App');
     
      
      if(app.equals('Internal')|| app.equals('orange')){
        try{
        String username = credentials.get('username');
        String password = credentials.get('password');
       return contactServiceInstance.checkContactPassword(username, password, app);
        }catch(Exception e){
        RestContext.response.statusCode = 400;
        responseMap.put('Status', 'error');
        responseMap.put('Message', 'Please enter username and password in correct format');
        return responseMap;
        }
      }
    }catch(Exception e){
        RestContext.response.statusCode = 400;
        responseMap.put('Status', 'error');
        responseMap.put('Message', 'Please enter your application name');
        return responseMap;
      }
      return null;
     
    }

}