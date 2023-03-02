public class OpportunityService {
    private static OpportunityService instance = null;
    public OpportunityRepository opportunityRepositoryInstance;
    public PackageServiceRepository packageServiceRepositoryInstance;
    public ServiceRepository serviceRepositoryInstance;
    public RequestRepository requestRepositoryInstance;
    public  ContactRepository contactRepositoryInstance;
    public ServiceMapper serviceMapper = new ServiceMapper();
    public PackageMapper packageMapper = new PackageMapper();


    public OpportunityService() {
        requestRepositoryInstance = RequestRepository.getInstance();
        contactRepositoryInstance = ContactRepository.getInstance();
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

      public Integer getCountOpportunity(String recordId){
        Contact contact = contactRepositoryInstance.findByRecordId(recordId);
        RecordType rt =[select Id from RecordType where Name = 'Reservation' and SobjectType = 'Case'];
        List<Case> reservationRequests = requestRepositoryInstance.findReservationRequestByContact(contact , rt.Id);
        List<Opportunity> opportunities = new List<Opportunity>();
        for(Case r : reservationRequests){
         opportunities.addAll(opportunityRepositoryInstance.findByCase(r.Id));
      }
      List<OpportunityLineItem> packageServices = new List<OpportunityLineItem>();
      List<String> opportunitiesIDs = new List<String>();
      for(Opportunity o : opportunities){
         opportunitiesIDs.add(o.Id);
      }
      packageServices.addAll(packageServiceRepositoryInstance.findAllPackageServiceByOpportunity(opportunitiesIDs));
         return packageServices.size();
      }


}
