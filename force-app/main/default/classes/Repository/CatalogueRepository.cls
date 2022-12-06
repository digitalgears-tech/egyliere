public with sharing class CatalogueRepository {
    private static CatalogueRepository instance = null;
    public CatalogueRepository() {

    }

    public static CatalogueRepository getInstance() {
        if (instance == null) {
          instance = new CatalogueRepository();
        }
        return instance;
      }

      public List<Catalogue__c> FindAllCatalogue(){
        return [
          SELECT
          Name,
          Image__c,
          City__c,
          Address__c,
          Phone__c
          FROM Catalogue__c
        ];
      }

      public List<Catalogue__c> FindAllCatalogueByType(String type){
        return [
          SELECT
          Name,
          Image__c,
          City__c,
          Address__c,
          Phone__c
          FROM Catalogue__c
          WHERE Type__c = :type
        ];
      }

      public List<Catalogue__c> FindAllCatalogueByCityGuide(){
        return [
          SELECT
          Name,
          Image__c,
          City__c,
          Address__c,
          Phone__c
          FROM Catalogue__c
          WHERE CityGuide__c = true
        ];
      }
}
