@RestResource(urlMapping='/MyBookingsAPI/*')
global class MyBookingsAPI {
    public static RequestService requestServiceInstance = RequestService.getInstance();
    public MyBookingsAPI() {

    }
@HttpGet
global static  List<ServiceMapper>  getAllService(){
   // try{
        RestRequest getReuest= RestContext.request;
        RestResponse requestResponse= RestContext.response;
        String app = getReuest.params.get('App');
    
      if(app.equals('Internal')){
        String recordId = getReuest.params.get('recordID');
        return requestServiceInstance.GetReservationsRequest(recordId);
      }
   // }catch(Exception e){

   // }
   return null;
    }

}