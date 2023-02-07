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
              }
            }catch(Exception e){

            }
            return null;
    }
}
