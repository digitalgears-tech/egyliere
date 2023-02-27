/**
 * @description       :
 * @author            : Ahmed Abdelraouf
 * @group             :
 * @last modified on  : 02-15-2023
 * @last modified by  : Mohamed Tarek
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
      String app = getReuest.params.get('App');
      String type = getReuest.params.get('Type');
      String subtype = getReuest.params.get('subType');

    if (app.equals('Internal')) {
      if (subtype != null) {
        List<CatalogueMapper> catalogueListByType= CatalogueServiceInstance.GetCatalogueListByType(subtype,pageSize, pageNumber);
        return catalogueListByType;

      }else if (type != null) {
        List<CatalogueMapper> catalogueListByRecordType= CatalogueServiceInstance.GetCatalogueListByRecordType(type,pageSize, pageNumber);
        return catalogueListByRecordType;

      } else {
        List<CatalogueMapper> catalogueList= CatalogueServiceInstance.GetCatalogueList(pageSize, pageNumber); 
        return catalogueList;
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