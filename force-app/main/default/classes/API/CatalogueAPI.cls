
@RestResource(urlMapping='/CatalogueListAPI/*')
global class CatalogueAPI {
    public static CatalogueService CatalogueServiceInstance = CatalogueService.getInstance();
    private CatalogueAPI() {

    }

    @HttpGet
    global static List<CatalogueMapper> getCatalogueList(){
        RestRequest getReuest= RestContext.request;
        String app = getReuest.params.get('App');
        String type = getReuest.params.get('Type');
        if(app.equals('Internal')){
         if(type == null){
        return CatalogueServiceInstance.GetCatalogueList();
         }else{
          return CatalogueServiceInstance.GetCatalogueListByRecordType(type);
         }
       }

        return null;
    }
}
