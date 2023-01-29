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
            if(app.equals('Internal')){
                return cityGuideServiceInstance.GetCityGuideList();
              }
        }catch(Exception e){
            requestResponse.statusCode=400;
            requestResponse.responseBody = Blob.valueOf('ERROR: ' + e.getMessage());
        }

        return null;
}

}