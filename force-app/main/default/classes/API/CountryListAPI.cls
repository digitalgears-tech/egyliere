@RestResource(urlMapping='/CountryListAPI/*')
global class CountryListAPI {
    public static CatalogueService CatalogueServiceInstance = CatalogueService.getInstance();

    public CountryListAPI() {
    }

    @HttpGet
    global static List<String> getCountryList() {
      RestRequest getReuest = RestContext.request;
      RestResponse requestResponse= RestContext.response;
      String app = getReuest.params.get('App');
  
      try{
      if (app.equals('Internal')) {
         return CatalogueServiceInstance.GetCountryList();
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
