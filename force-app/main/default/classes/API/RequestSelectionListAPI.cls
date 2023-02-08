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
              }else{
                throw new GeneralException(' not allowed for external apps');
            }
        
            
            }catch (System.NullPointerException e) {
                requestResponse.statusCode=500;
                requestResponse.responseBody = Blob.valueOf('ERROR: ' + e.getMessage());
                throw new GeneralException(e.getMessage());
           }
        
            catch (System.DmlException e) {
                requestResponse.statusCode=500;
                requestResponse.responseBody = Blob.valueOf('ERROR: ' + e.getMessage());
                throw new GeneralException(e.getMessage());
            }
        
            catch(GeneralException e){
                requestResponse.statusCode=400;
                requestResponse.responseBody = Blob.valueOf('ERROR: ' + e.getMessage());
                throw new GeneralException(e.getMessage());
            }

}
}