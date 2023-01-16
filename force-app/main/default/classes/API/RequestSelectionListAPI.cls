@RestResource(urlMapping='/RequestSelectionListAPI/*')
global class RequestSelectionListAPI {
    public static RequestService requestServiceInstance = RequestService.getInstance();
    public static ServiceService serviceServiceInstance = ServiceService.getInstance();
    public RequestSelectionListAPI() {

    }

    @HttpGet
    global static Map<String, List<String>>  getRequestSelectionList(){
        RestRequest getReuest= RestContext.request;
        RestResponse requestResponse= RestContext.response;
        try{
            
            String app = getReuest.params.get('App');
            String type = getReuest.params.get('Type');

            if(app.equals('Internal')){
                return serviceServiceInstance.getServiceCategoryList(type);
              }
        }catch(Exception e){
            requestResponse.statusCode=400;
            requestResponse.responseBody = Blob.valueOf('ERROR: ' + e.getMessage());
        }

        return null;

}
}
