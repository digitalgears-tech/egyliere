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
          Name,
          Total_Points__c,
          Opportunity.StageName	
          FROM OpportunityLineItem
          ];
    }

    public List<OpportunityLineItem> findAllPackageServiceByOpportunity(List<String> opportunityId){

        return [
          SELECT
          Id,
          Name,
          Opportunity_Line_Item_Details__c,
          PricebookEntry.Product2.Logo__c,
          Total_Points__c,
          Opportunity.StageName		
          FROM OpportunityLineItem
          WHERE OpportunityId = :opportunityId
          ];
    }

    public OpportunityLineItem findPackageServiceById(String id){

      return [
        SELECT
        Id,
        Name,
        Opportunity_Line_Item_Details__c,
        PricebookEntry.Product2.Logo__c,
        Total_Points__c,
        Opportunity.StageName		
        FROM OpportunityLineItem
        WHERE Id = :id
        ];
  }
    
}