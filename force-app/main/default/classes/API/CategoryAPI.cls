@RestResource(urlMapping='/CategoryListAPI/*')
global class CategoryAPI {
    public static CatalogueService CatalogueServiceInstance = CatalogueService.getInstance();
    public CategoryAPI() {

    }

    @HttpGet
    global static  Map<String, List<String>> sendCategoryList(){
        RestRequest getReuest= RestContext.request;
        RestResponse requestResponse= RestContext.response;
        try{
            String app = getReuest.params.get('App');
        if(app.equals('Internal')){
                return CatalogueServiceInstance.getCategoriesMap();
        }else{
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
    
}
    }
