
@RestResource(urlMapping='/CatalogueListAPI/*')
global class CatalogueAPI {
    public static CatalogueService CatalogueServiceInstance = CatalogueService.getInstance();
    private CatalogueAPI() {

    }

    @HttpGet
    global static List<CatalogueMapper> getCatalogueList(){
        RestRequest getReuest= RestContext.request;
        String app = getReuest.params.get('App');
        if(app.equals('Internal')){
        return CatalogueServiceInstance.GetCatalogueList();}

        return null;
    }
}
