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

      public List<Catalogue__c> FindAllCatalogue(Integer pageSize,Integer pageNumber){
        Integer offset = pageSize*(pageNumber-1);

        return [
          SELECT
          Name,
          Id,
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
          ORDER BY createddate 
          DESC LIMIT :pageSize OFFSET :offset
        ];
      }

      public List<Catalogue__c> FindAllCatalogueByType(String type){
       // Integer offset = pageSize*(pageNumber-1);
        return [
          SELECT
          Name,
          Id,
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
         // ORDER BY createddate 
         // DESC LIMIT :pageSize OFFSET :offset
        ];
      }

      public List<Catalogue__c> FindAllCatalogueByCityGuide(String cityGuideId){
       // Integer offset = pageSize*(pageNumber-1);
        return [
          SELECT
          Name,
          Id,
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
         // ORDER BY createddate 
         // DESC LIMIT :pageSize OFFSET :offset
        ];
      }
      public List<Catalogue__c> FindAllCatalogueByCityGuideType(String cityGuideId, String recordTypeId){
        return [
          SELECT
          Name,
          Id,
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


      public List<Catalogue__c> FindAllCatalogueByRecordType(String recordTypeId ,Integer pageSize,Integer pageNumber){
        Integer offset = pageSize*(pageNumber-1);
        return [
          SELECT
          Name,
          Id,
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
          ORDER BY createddate 
          DESC LIMIT :pageSize OFFSET :offset
        ];
      }
      
      public List<Catalogue__c> FindAllCatalogueByType(String type ,Integer pageSize,Integer pageNumber){
        Integer offset = pageSize*(pageNumber-1);
        return [
          SELECT
          Name,
          Id,
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
          ORDER BY createddate 
          DESC LIMIT :pageSize OFFSET :offset
        ];
      }
}