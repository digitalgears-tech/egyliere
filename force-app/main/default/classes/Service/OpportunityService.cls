public class OpportunityService {
    private static OpportunityService instance = null;
    public OpportunityRepository opportunityRepositoryInstance;
    public PackageServiceRepository packageServiceRepositoryInstance;
    public ServiceRepository serviceRepositoryInstance;
    public ServiceMapper serviceMapper = new ServiceMapper();
    public PackageMapper packageMapper = new PackageMapper();


    public OpportunityService() {
        opportunityRepositoryInstance = OpportunityRepository.getInstance();
        serviceRepositoryInstance = ServiceRepository.getInstance();  
        packageServiceRepositoryInstance = PackageServiceRepository.getInstance();
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
        update opportunity;

      }
 
      public List<packageMapper> getOpportunity(String opportunityId){

       Opportunity opportunity = opportunityRepositoryInstance.findOpportunityById(opportunityId);
      
         List<OpportunityLineItem> packageServices = new List<OpportunityLineItem>();
         List<Opprtunity_Line_Item_Details__c> services = new List<Opprtunity_Line_Item_Details__c>();
  
         List<String> opportunitiesIDs = new List<String>();
            opportunitiesIDs.add(opportunity.Id);
    
         packageServices.addAll(packageServiceRepositoryInstance.findAllPackageServiceByOpportunity(opportunitiesIDs));
  
         List <String> packageServicesIDs=  new List<String>();
         Map<String,PackageServiceMapper> packageServiceMap = new Map<String,PackageServiceMapper>();
  
         for(OpportunityLineItem o :packageServices){
            packageServiceMap.put(o.Id, new PackageServiceMapper(o));
            packageServicesIDs.add(o.Id);
         }
         services.addAll(serviceRepositoryInstance.findServiceByOpportunityProduct(packageServicesIDs));
         List<PackageMapper> packageMapperList = new List<PackageMapper>();
         packageMapperList.add(packageMapper.PackageobjectToMapper(opportunity, serviceMapper.ServiceobjectListToMapperList(services, packageServiceMap)));
         return packageMapperList;

      }



}
