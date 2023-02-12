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
    Integer pageSize;
    Integer pageNumber;
    try{
     pageSize = Integer.valueOf(getReuest.params.get('PageSize'));
     pageNumber = Integer.valueOf(getReuest.params.get('PageNumber'));
    }catch(Exception e){
        pageSize=100;
        pageNumber=1;
    }

    try{
    if (app.equals('Internal')) {
      if (type == null) {
        return CatalogueServiceInstance.GetCatalogueList(pageSize, pageNumber);
      } else {
        return CatalogueServiceInstance.GetCatalogueListByRecordType(type,pageSize, pageNumber);
      }
    }else{
        requestResponse.statusCode=503;
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