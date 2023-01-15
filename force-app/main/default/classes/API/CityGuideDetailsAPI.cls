@RestResource(urlMapping='/CityGuideDetailsAPI/*')
global class CityGuideDetailsAPI {
    public static CatalogueService CatalogueServiceInstance = CatalogueService.getInstance();
    public static CityGuideService cityGuideServiceInstance = CityGuideService.getInstance(); 
    public CityGuideDetailsAPI() {

    }

    @HttpGet
    global static List<CatalogueMapper> getAllCityGuideDetails(){
        RestRequest getReuest= RestContext.request;
        RestResponse requestResponse= RestContext.response;
        try{
          
            String app = getReuest.params.get('App');
            if(app.equals('Internal')){
                   Map< String,Object> body = (Map< String,Object>)JSON.deserializeUntyped(RestContext.request.requestbody.tostring());  
                   String id = (String)body.get('cityGuide');
                return CatalogueServiceInstance.GetCityGuideCatalogueList(id);
              }
        }catch(Exception e){
            requestResponse.statusCode=400;
            requestResponse.responseBody = Blob.valueOf('ERROR: ' + e.getMessage());
        }
        return null;
    }

    @HttpPost
    global static void setCityGuide(){
        RestRequest postReuest= RestContext.request;
        RestResponse requestResponse= RestContext.response;
        try{
          
            String app = postReuest.params.get('App');
            if(app.equals('Internal')){
                   Map< String,Object> body = (Map< String,Object>)JSON.deserializeUntyped(RestContext.request.requestbody.tostring());  
                   String recordId = postReuest.params.get('recordID');
                   String id = (String)body.get('cityGuide');
                   cityGuideServiceInstance.SetContactCityGuideList(recordId,id);
                
             }
       }catch(Exception e){
            requestResponse.statusCode=400;
            requestResponse.responseBody = Blob.valueOf('ERROR: ' + e.getMessage());
        }

    }

}
