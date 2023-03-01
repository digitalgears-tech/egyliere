@RestResource(urlMapping='/BookingCountAPI/*')
global class BookingCountAPI {
    public static OpportunityService OpportunityServiceInstance = OpportunityService.getInstance();
    public BookingCountAPI() {

    }

    @HttpGet
    global static Integer getBookingCountAPI() {
      RestRequest getReuest = RestContext.request;
      RestResponse requestResponse= RestContext.response;
      String app = getReuest.params.get('App');
  
      try{
      if (app.equals('Internal')) {
        String recordId = getReuest.params.get('recordID');
         return OpportunityServiceInstance.getCountOpportunity(recordId);
      }else{
          requestResponse.statusCode=503;
          throw new GeneralException('Not allowed for External apps');
      }
   }  
  catch (System.NullPointerException e) {
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
