/**
 * @description       : 
 * @author            : Mohamed Tarek
 * @group             : 
 * @last modified on  : 02-13-2023
 * @last modified by  : Mohamed Tarek
**/
@RestResource(urlMapping='/CityGuideAPI/*')
global class CityGuideAPI {
    public static CityGuideService cityGuideServiceInstance = CityGuideService.getInstance();

    public CityGuideAPI() {

    }
    @HttpGet
    global static List<CityGuideMapper> getAllCityGuide(){
        RestRequest getReuest= RestContext.request;
        RestResponse requestResponse= RestContext.response;
    
        try{
            
            String app = getReuest.params.get('App');

            if(getReuest.params.get('Featured')!=null){
                List<CityGuideMapper> featuredCityGuides=cityGuideServiceInstance.GetFeaturedCityGuide();
                if(featuredCityGuides.size()==0){
                    throw new NoRecordsException('No records found');
                }
                return featuredCityGuides;}  
            if(app.equals('Internal')){
                List<CityGuideMapper> cityGuides=cityGuideServiceInstance.GetCityGuideList();
                if(cityGuides.size()==0){
                    throw new NoRecordsException('No records found');
                }

                return cityGuides;}  
              else{
                requestResponse.statusCode=503;
                throw new GeneralException('Not allowed for External apps');}
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
           catch(NoRecordsException e){
            requestResponse.statusCode=404;
            return new List<CityGuideMapper>();
        }
 
           }
        
    }
