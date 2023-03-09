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
      public List<CatalogueMapper> getCatalogueListById(String recordId) {
        return CatalogueMapper.catalogueObjectListToMapperList(CatalogueRepositoryInstance.FindAllCatalogueByID(recordId));
 
       }

      public List<CatalogueMapper> GetCatalogueList(Integer pageSize,Integer pageNumber) {
        List<Catalogue__c> catalogueObjectList = CatalogueRepositoryInstance.FindAllCatalogue(pageSize, pageNumber);
        return CatalogueMapper.catalogueObjectListToMapperList(catalogueObjectList);
 
       }
       public List<CatalogueMapper> GetCatalogueListByType(String subType, Integer pageSize,Integer pageNumber) {
        List<Catalogue__c> catalogueObjectList = CatalogueRepositoryInstance.FindAllCatalogueByType(subType,pageSize, pageNumber);
        return CatalogueMapper.catalogueObjectListToMapperList(catalogueObjectList);
 
       }
       public List<CatalogueMapper> GetCatalogueListByRecordType(String type,Integer pageSize,Integer pageNumber) {
        RecordType rt =[
          SELECT
          Id
          FROM RecordType
          WHERE Name = :type
          ];
        List<Catalogue__c> catalogueObjectList = CatalogueRepositoryInstance.FindAllCatalogueByRecordType(rt.Id,pageSize,pageNumber);
        return CatalogueMapper.catalogueObjectListToMapperList(catalogueObjectList);
 
       }

       public List<CatalogueMapper> GetCityGuideCatalogueList(String id) {
        List<Catalogue__c> catalogueObjectList = CatalogueRepositoryInstance.FindAllCatalogueByCityGuide(id);
        return CatalogueMapper.catalogueObjectListToMapperList(catalogueObjectList);
 
       }
       public List<CatalogueMapper> GetCatalogueListByCountry(String country) {
        List<Catalogue__c> catalogueObjectList = CatalogueRepositoryInstance.FindCatalogueByCountry(country);
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

        public List<String> GetCountryList() {
          List<Catalogue__c> catalogueObjectList = CatalogueRepositoryInstance.FindAllCatalogue(200,1);
          List<String>  country = new List<String>();
          for(Catalogue__c c : catalogueObjectList){
            if(!(country.contains(c.Country__c) || c.Country__c==null)){
              country.add(c.Country__c);
            }
          }
          return country;
   
         }

}