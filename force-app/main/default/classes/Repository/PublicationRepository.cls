public class PublicationRepository {

    private static PublicationRepository instance = null;
    private PublicationRepository(){}

    public static PublicationRepository getInstance() {
        if (instance == null) {
          instance = new PublicationRepository();
        }
        return instance;
      }

      public List<Publication__c> findAllPublications(Integer pageSize,Integer pageNumber){
        Integer offset = pageSize*(pageNumber-1);
        return [
          SELECT
            Name,
            Start_Date__c,
            End_Date__c,
            Discount_Amount__c,
            Discount_Type__c,
            Image__c,
            Promo_code__c,
            Tag__c,
            Location__c,
            Description__c,
            Catalogue__r.Id,
            Catalogue__r.RecordType.Name
          FROM Publication__c
          WHERE Active__c = true
          ORDER BY createddate 
          DESC LIMIT :pageSize OFFSET :offset];
      }
      public List<Publication__c> findPublicationsByRecordId( Id recordTypeId,Integer pageSize,Integer pageNumber){
        Integer offset = pageSize*(pageNumber-1);
        return [
          SELECT
            Name,
            Start_Date__c,
            End_Date__c,
            Discount_Amount__c,
            Discount_Type__c,
            Image__c,
            Promo_code__c,
            Tag__c,
            Location__c,
            Description__c,
            Catalogue__r.Id,
            Catalogue__r.RecordType.Name
          FROM Publication__c
          WHERE Active__c = true
          AND RecordTypeId =:recordTypeId
          ORDER BY createddate 
          DESC LIMIT :pageSize OFFSET :offset ];
      }

      public List<Publication__c> findPublicationsByRecordIdShowOnExternalApp( Id recordTypeId,Integer pageSize,Integer pageNumber){
        Integer offset = pageSize*(pageNumber-1);
        return [
          SELECT
            Name,
            Start_Date__c,
            End_Date__c,
            Discount_Amount__c,
            Discount_Type__c,
            Image__c,
            Promo_code__c,
            Tag__c,
            Location__c,
            Description__c,
            Catalogue__r.Id,
            Catalogue__r.RecordType.Name
          FROM Publication__c
          WHERE Active__c = true
          AND RecordTypeId =:recordTypeId 
          AND Show_on_External_App__c = true
          ORDER BY createddate 
          DESC LIMIT :pageSize OFFSET :offset];
      }
      public List<Publication__c> findAllPublicationsShowOnExternalApp(Integer pageSize,Integer pageNumber){
        Integer offset = pageSize*(pageNumber-1);
        return [
          SELECT
            Name,
            Start_Date__c,
            End_Date__c,
            Discount_Amount__c,
            Discount_Type__c,
            Image__c,
            Promo_code__c,
            Tag__c,
            Location__c,
            Description__c,
            Catalogue__r.Id,
            Catalogue__r.RecordType.Name
          FROM Publication__c
          WHERE Show_on_External_App__c = true
          AND Active__c = true
          ORDER BY createddate 
          DESC LIMIT :pageSize OFFSET :offset];
      }

      public List<Publication__c> findByTags(List<String> tagslist,Integer pageSize,Integer pageNumber){
        Integer offset = pageSize*(pageNumber-1);

        return [
          SELECT
            Name,
            Start_Date__c,
            End_Date__c,
            Discount_Amount__c,
            Discount_Type__c,
            Image__c,
            Tag__c,
            Location__c,
            Description__c,
            Catalogue__r.Id,
            Catalogue__r.RecordType.Name
          FROM Publication__c
          WHERE Tag__c = : tagslist
          AND Active__c = true
          ORDER BY createddate 
          DESC LIMIT :pageSize OFFSET :offset];
      }

      public List<Publication__c> findByTagsandRecordId(List<String> tagslist, Id recordTypeId,Integer pageSize,Integer pageNumber){
        Integer offset = pageSize*(pageNumber-1);
        return [
          SELECT
            Name,
            Start_Date__c,
            End_Date__c,
            Discount_Amount__c,
            Discount_Type__c,
            Image__c,
            Tag__c,
            Location__c,
            Description__c,
            Catalogue__r.Id,
            Catalogue__r.RecordType.Name
          FROM Publication__c
          WHERE Tag__c = : tagslist
          AND RecordTypeId =:recordTypeId 
          AND Active__c = true
          ORDER BY createddate 
          DESC LIMIT :pageSize OFFSET :offset];
      }

      public List<Publication__c> findExternalappByTags(List<String> tagslist,Integer pageSize,Integer pageNumber){
        Integer offset = pageSize*(pageNumber-1);
        return [
          SELECT
            Name,
            Start_Date__c,
            End_Date__c,
            Discount_Amount__c,
            Discount_Type__c,
            Image__c,
            Tag__c,
            Location__c,
            Description__c,
            Catalogue__r.Id,
            Catalogue__r.RecordType.Name
          FROM Publication__c
          WHERE Tag__c = :tagslist
          AND Show_on_External_App__c = true
          AND Active__c = true
          ORDER BY createddate 
          DESC LIMIT :pageSize OFFSET :offset];
      }
      public List<Publication__c> findExternalappByTagsandRecordId(List<String> tagslist,Id recordTypeId,Integer pageSize,Integer pageNumber){
        Integer offset = pageSize*(pageNumber-1);
        return [
          SELECT
            Name,
            Start_Date__c,
            End_Date__c,
            Discount_Amount__c,
            Discount_Type__c,
            Image__c,
            Tag__c,
            Location__c,
            Description__c,
            Catalogue__r.Id,
            Catalogue__r.RecordType.Name
          FROM Publication__c
          WHERE Tag__c = :tagslist
          AND Show_on_External_App__c = true
          AND RecordTypeId =:recordTypeId 
          AND Active__c = true
          ORDER BY createddate 
          DESC LIMIT :pageSize OFFSET :offset];
      }
      public Publication__c findPublicationbyPage(String page){
       
        return [
          SELECT
            Name,
            Start_Date__c,
            End_Date__c,
            Discount_Amount__c,
            Discount_Type__c,
            Image__c,
            Tag__c,
            Location__c,
            Description__c,
            Catalogue__r.Id,
            Catalogue__r.RecordType.Name
          FROM Publication__c
          WHERE Page__c	 = :page
          AND Active__c = true];
      }
      
}