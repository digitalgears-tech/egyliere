public class PackageServiceRepository {
    private static PackageServiceRepository instance = null;

    public PackageServiceRepository() {

    }

    public static PackageServiceRepository getInstance() {
        if (instance == null) {
          instance = new PackageServiceRepository();
        }
        return instance;
      }

    public OpportunityLineItem findAllPackageService(){

        return [
          SELECT
          Id,
          Name
          FROM OpportunityLineItem
          ];
    }

    public List<OpportunityLineItem> findAllPackageServiceByOpportunity(String opportunityId){

        return [
          SELECT
          Id,
          Name,
          Opportunity_Line_Item_Details__c
          FROM OpportunityLineItem
          WHERE OpportunityId = :opportunityId
          ];
    }

    
}
