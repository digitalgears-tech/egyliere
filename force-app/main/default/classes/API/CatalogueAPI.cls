/**
 * @description       :
 * @author            : Ahmed Abdelraouf
 * @group             :
 * @last modified on  : 01-24-2023
 * @last modified by  : Ahmed Abdelraouf
 **/

@RestResource(urlMapping='/CatalogueListAPI/*')
global class CatalogueAPI {
  public static CatalogueService CatalogueServiceInstance = CatalogueService.getInstance();
  private CatalogueAPI() {
  }

  @HttpGet
  global static List<CatalogueMapper> getCatalogueList() {
    RestRequest getReuest = RestContext.request;
    RestResponse requestResponse= RestContext.response;
    String app = getReuest.params.get('App');
    String type = getReuest.params.get('Type');

    try{
    if (app.equals('Internal')) {
      if (type == null) {
        return CatalogueServiceInstance.GetCatalogueList();
      } else {
        return CatalogueServiceInstance.GetCatalogueListByRecordType(type);
      }
    }else{
        requestResponse.statusCode=400;
        throw new GeneralException('Not allowed for External apps');
    }
}  
catch (System.NullPointerException e) {
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