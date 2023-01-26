public class PlansRepository {
    private static PlansRepository instance = null;
    public PlansRepository() {

    }

    public static PlansRepository getInstance() {
        if (instance == null) {
          instance = new PlansRepository();
        }
        return instance;
      }

        public List<Plan__c> FindAllPlans() {
            return [
                SELECT
                Name,
                Points__c,
                Price__c,
                Benefits__c,
                Logo__c	
                FROM Plan__c
                
              ];
        }
        public Plan__c FindPlansById(String id) {
          
          return [
            SELECT
            Name,
            Points__c,
            Price__c,
            Benefits__c,
            Logo__c	
            FROM Plan__c
            WHERE Id = :id];

        }

        public Plan__c FindPlansByName(String name) {
          
          return [
            SELECT
            Name,
            Id,
            Points__c,
            Price__c,
            Benefits__c,
            Logo__c	
            FROM Plan__c
            WHERE Name = :name];

        }

}