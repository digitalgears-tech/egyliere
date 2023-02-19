public class OpportunityService {
    private static OpportunityService instance = null;
    public OpportunityRepository opportunityRepositoryInstance;

    public OpportunityService() {
        opportunityRepositoryInstance = OpportunityRepository.getInstance();
    }
    public static OpportunityService getInstance() {
        if (instance == null) {
          instance = new OpportunityService();
        }
        return instance;
      }

      public void updatePaidOpportunity(String opportunityId){

        Opportunity opportunity = opportunityRepositoryInstance.findOpportunityById(opportunityId);
        opportunity.StageName = 'Paid';
        insert opportunity;

      }
}
