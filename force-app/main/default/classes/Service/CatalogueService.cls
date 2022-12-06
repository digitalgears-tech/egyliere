public with sharing class CatalogueService {
    private static CatalogueService instance = null;
    public  CatalogueRepository CatalogueRepositoryInstance;

    public CatalogueService() {
        CatalogueRepositoryInstance = CatalogueRepository.getInstance();
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

}
