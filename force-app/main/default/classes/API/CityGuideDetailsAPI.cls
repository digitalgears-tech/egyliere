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
            String type = getReuest.params.get('Type');
            Map< String,Object> body = (Map< String,Object>)JSON.deserializeUntyped(RestContext.request.requestbody.tostring());  
            String id = (String)body.get('cityGuide');
            if(app.equals('Internal')){
                if(type!=null){
                return CatalogueServiceInstance.GetCityGuideCatalogueListType(id,type);

                }else{ 
                return CatalogueServiceInstance.GetCityGuideCatalogueList(id);}
              }else{
                requestResponse.statusCode=503;
                throw new GeneralException('Not allowed for External apps');
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