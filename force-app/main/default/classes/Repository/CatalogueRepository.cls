public class CatalogueRepository {
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
          Logo__c,
          City__c,
          Address__c,
          Location__c,
          Phone__c,
          Emergency_Number__c,
          Type__c,
          Description__c,
          House_Rules__c,
          Change_Policy__c,
          Cancellation_Policy__c,
          Benefits__c,
          Recommendations__c,
          RecordTypeId	
          FROM Catalogue__c
        ];
      }

      public List<Catalogue__c> FindAllCatalogueByType(String type){
        return [
          SELECT
          Name,
          Logo__c,
          City__c,
          Address__c,
          Location__c,
          Phone__c,
          Emergency_Number__c,
          Type__c,
          Description__c,
          House_Rules__c,
          Change_Policy__c,
          Cancellation_Policy__c,
          Benefits__c,
          Recommendations__c,
          RecordTypeId	
          FROM Catalogue__c
          WHERE Type__c = :type
        ];
      }

      public List<Catalogue__c> FindAllCatalogueByCityGuide(String cityGuideId){
        return [
          SELECT
          Name,
          Logo__c,
          City__c,
          Address__c,
          Location__c,
          Phone__c,
          Emergency_Number__c,
          Type__c,
          Description__c,
          House_Rules__c,
          Change_Policy__c,
          Cancellation_Policy__c,
          Benefits__c,
          Recommendations__c,
          RecordTypeId	
          FROM Catalogue__c
          WHERE City_Guide__c =: cityGuideId
        ];
      }
      public List<Catalogue__c> FindAllCatalogueByCityGuideType(String cityGuideId, String recordTypeId){
        return [
          SELECT
          Name,
          Logo__c,
          City__c,
          Address__c,
          Location__c,
          Phone__c,
          Emergency_Number__c,
          Type__c,
          Description__c,
          House_Rules__c,
          Change_Policy__c,
          Cancellation_Policy__c,
          Benefits__c,
          Recommendations__c,
          RecordTypeId	
          FROM Catalogue__c
          WHERE City_Guide__c =: cityGuideId
          AND RecordTypeId =: recordTypeId
        ];
      }


      public List<Catalogue__c> FindAllCatalogueByRecordType(String recordTypeId){
        return [
          SELECT
          Name,
          Logo__c,
          City__c,
          Address__c,
          Location__c,
          Phone__c,
          Emergency_Number__c,
          Type__c,
          Description__c,
          House_Rules__c,
          Change_Policy__c,
          Cancellation_Policy__c,
          Benefits__c,
          Recommendations__c,
          RecordTypeId	
          FROM Catalogue__c
          WHERE RecordTypeId = :recordTypeId
        ];
      }
      
}