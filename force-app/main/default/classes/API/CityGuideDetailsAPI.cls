/**
 * @description       : 
 * @author            : Mohamed Tarek
 * @group             : 
 * @last modified on  : 02-15-2023
 * @last modified by  : Mohamed Tarek
**/
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
            String id =  getReuest.params.get('cityGuide');
            if(app.equals('Internal')){
                List<CatalogueMapper> catalogues=new List<CatalogueMapper>();

                if(type!=null){
                 catalogues=CatalogueServiceInstance.GetCityGuideCatalogueListType(id,type);
                

                }else{ 
                catalogues=CatalogueServiceInstance.GetCityGuideCatalogueList(id);
                }
               
                return catalogues;
              }
              else{
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
                   requestResponse.responseBody=Blob.valueOf('Cityguide set' );
                   requestResponse.statusCode=200;
              
                
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