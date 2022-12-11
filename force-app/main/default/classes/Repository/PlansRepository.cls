public with sharing class PlansRepository {
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

}
