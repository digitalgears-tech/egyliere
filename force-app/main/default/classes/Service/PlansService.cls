public with sharing class PlansService {

    private static PlansService instance = null;
    public  PlansRepository planRepositoryInstance;
    public PlansMapper plansMapperInstance = new PlansMapper();

    private PlansService() {
        planRepositoryInstance = PlansRepository.getInstance();
    }

    public static PlansService getInstance() {
        if (instance == null) {
          instance = new PlansService();
        }
        return instance;
      }
      public List<PlansMapper> getPlanList() {
        return plansMapperInstance.PlansMapperListToObject(planRepositoryInstance.FindAllPlans());
 
       }


}
