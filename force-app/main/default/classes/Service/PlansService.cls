public class PlansService {

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
       public List<PlansMapper> getPlanListByName(String name) {
        List<PlansMapper> planMapper = new List<PlansMapper>();
         planMapper.add(plansMapperInstance.PlansMapperToObject(planRepositoryInstance.FindPlansByName(name)));
         return planMapper;
       }

}