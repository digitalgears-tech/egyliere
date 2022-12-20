
@RestResource(urlMapping='/EntitiesCatalogueList/*')
global class CatalogueAPI {
    public static CatalogueService CatalogueServiceInstance = CatalogueService.getInstance();
    private CatalogueAPI() {

    }

    @HttpGet
    global static List<Catalogue__c> getCatalogueListByType(){
        RestRequest getReuest= RestContext.request;
        String app = getReuest.params.get('App');
        if(app.equals('Internal')){
        String type = getReuest.params.get('Type');
        return CatalogueServiceInstance.getCatalogueListByType(type);}

        return null;
    }
}
