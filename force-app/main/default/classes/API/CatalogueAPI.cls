/**
 * @description       :
 * @author            : Ahmed Abdelraouf
 * @group             :
 * @last modified on  : 02-13-2023
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
        List<CatalogueMapper> catalogueList= CatalogueServiceInstance.GetCatalogueList(pageSize, pageNumber);
        if(catalogueList.size()==0){
          throw new NoRecordsException('No Catalogues Found');
 
        }
        return catalogueList;
      } else {
        List<CatalogueMapper> catalogueListByRecordType= CatalogueServiceInstance.GetCatalogueListByRecordType(type,pageSize, pageNumber);
        if(catalogueListByRecordType.size()==0){
          throw new NoRecordsException('No Catalogues Found');
        }
        return catalogueListByRecordType;
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
catch(NoRecordsException e){
        requestResponse.statusCode=404;
        return new List<CatalogueMapper>();
}
    
}

}