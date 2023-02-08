public class CatalogueService {
    private static CatalogueService instance = null;
    public  CatalogueRepository CatalogueRepositoryInstance;
    public  RecordTypeRepository RecordTypeRepositoryInstance;
    public CatalogueMapper catalogueMapper = new CatalogueMapper();

    public CatalogueService() {
        CatalogueRepositoryInstance = CatalogueRepository.getInstance();
        RecordTypeRepositoryInstance = RecordTypeRepository.getInstance();
    }

    public static CatalogueService getInstance() {
        if (instance == null) {
          instance = new CatalogueService();
        }
        return instance;
      }

      public List<Catalogue__c> getCatalogueListByType(String type) {
       return CatalogueRepositoryInstance.FindAllCatalogueByType(type);

      }

      public List<CatalogueMapper> GetCatalogueList() {
        List<Catalogue__c> catalogueObjectList = CatalogueRepositoryInstance.FindAllCatalogue();
        return CatalogueMapper.catalogueObjectListToMapperList(catalogueObjectList);
 
       }

       public List<CatalogueMapper> GetCatalogueListByRecordType(String type) {
        RecordType rt =[
          SELECT
          Id
          FROM RecordType
          WHERE Name = :type
          ];
        List<Catalogue__c> catalogueObjectList = CatalogueRepositoryInstance.FindAllCatalogueByRecordType(rt.Id);
        return CatalogueMapper.catalogueObjectListToMapperList(catalogueObjectList);
 
       }

       public List<CatalogueMapper> GetCityGuideCatalogueList(String id) {
        List<Catalogue__c> catalogueObjectList = CatalogueRepositoryInstance.FindAllCatalogueByCityGuide(id);
        return CatalogueMapper.catalogueObjectListToMapperList(catalogueObjectList);
 
       }

       public List<CatalogueMapper> GetCityGuideCatalogueListType(String id,String type) {
        RecordType rt =[
          SELECT
          Id
          FROM RecordType
          WHERE Name = :type
          ];
        List<Catalogue__c> catalogueObjectList = CatalogueRepositoryInstance.FindAllCatalogueByCityGuideType(id,rt.Id);
        return CatalogueMapper.catalogueObjectListToMapperList(catalogueObjectList);
 
       }

       public Map<String, List<String>>  getCategoriesMap() {
        Map<String, List<String>> CategoriesMap= new Map<String, List<String>>();
        List<RecordType> recordTypeNames= RecordTypeRepositoryInstance.getRecordTypebyObject('Catalogue__c');

        for(RecordType r : recordTypeNames ){
        CategoriesMap.put(r.Name,PicklistUtilities.getPicklistValues('Catalogue__c',r.DeveloperName,'Type__c'));}


           return CategoriesMap;
   
}

}