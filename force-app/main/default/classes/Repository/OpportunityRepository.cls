public class OpportunityRepository {
    private static OpportunityRepository instance = null;

    public OpportunityRepository() {

    }

    public static OpportunityRepository getInstance() {
        if (instance == null) {
          instance = new OpportunityRepository();
        }
        return instance;
      }

    public Opportunity findByCase(String requestID){

        return [
          SELECT
          Id,
          Name
          FROM Opportunity
          WHERE Request__c = :requestID
          ];
    }
}
