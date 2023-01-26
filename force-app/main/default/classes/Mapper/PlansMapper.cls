global class PlansMapper {
    String name;
    Integer price;
    Integer points;
    List<String> logo;
    String benefits;

    public PlansMapper() {

    }

    public PlansMapper PlansMapperToObject(Plan__c planObject){

        PlansMapper planMapper = new PlansMapper();
        ImageListMapper ImageListMapperInstance = ImageListMapper.getInstance();
        planMapper.name = planObject.Name;
        planMapper.price = (Integer)planObject.Price__c;
        planMapper.points = (Integer)planObject.Points__c;
        planMapper.logo = ImageListMapperInstance.ConvertToImageList(planObject.Logo__c);
        planMapper.benefits = planObject.benefits__c;

        return planMapper;
    }

    public List<PlansMapper> PlansMapperListToObject(List<Plan__c> planObjectList){
        List<PlansMapper> plansMapper = new List<PlansMapper>();
       
        for( Plan__c p : planObjectList ){

            plansMapper.add(PlansMapperToObject(p));
        }

        return plansMapper;

    }
}