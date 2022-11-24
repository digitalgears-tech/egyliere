public class PublicationRepository {

    private static PublicationRepository instance = null;
    private PublicationRepository(){}

    public static PublicationRepository getInstance() {
        if (instance == null) {
          instance = new PublicationRepository();
        }
        return instance;
      }

      public List<Publication__c> findAllPublications(){

        return [
          SELECT
            Name,
            Start_Date__c,
            End_Date__c,
            Discount_Amount__c,
            Discount_Type__c,
            Image__c,
            Promo_code__c,
            Tags__c,
            Show_on_External_App__c,
            Description__c
          FROM Publication__c];
      }
      public List<Publication__c> findAllPublicationsShowOnExternalApp(){

        return [
          SELECT
            Name,
            Start_Date__c,
            End_Date__c,
            Discount_Amount__c,
            Discount_Type__c,
            Image__c,
            Promo_code__c,
            Tags__c,
            Show_on_External_App__c,
            Description__c
          FROM Publication__c
          WHERE Show_on_External_App__c = true];
      }

      public List<Publication__c> findByTags(List<String> tagslist){

        return [
          SELECT
            Name,
            Start_Date__c,
            End_Date__c,
            Discount_Amount__c,
            Discount_Type__c,
            Image__c,
            Tags__c,
            Description__c
          FROM Publication__c
          WHERE Tags__c = :tagslist
          AND Active__c = true];
      }

      public List<Publication__c> findExternalappByTags(List<String> tagslist){

        return [
          SELECT
            Name,
            Start_Date__c,
            End_Date__c,
            Discount_Amount__c,
            Discount_Type__c,
            Image__c,
            Tags__c,
            Description__c
          FROM Publication__c
          WHERE Tags__c = :tagslist
          AND Active__c = true
          AND Show_on_External_App__c = true];
      }
}
