public class RequestService {
    private static RequestService instance = null;
    public  ContactRepository contactRepositoryInstance;
    public AccountRepository accountRepositoryInstance;
    public OpportunityRepository opportunityRepositoryInstance;
    public ProductRepository productRepositoryInstance;
    public RequestMapper requestMapper = new RequestMapper();

    private RequestService() {
        contactRepositoryInstance = ContactRepository.getInstance();
        accountRepositoryInstance = AccountRepository.getInstance();
        opportunityRepositoryInstance = OpportunityRepository.getInstance();
        productRepositoryInstance = productRepository.getInstance();
    }

    public static RequestService getInstance() {
        if (instance == null) {
          instance = new RequestService();
        }
        return instance;
      }

      public void CreateSubscribeRequest(String recordId , List<Object> plan){
         
         Contact contact = contactRepositoryInstance.findByRecordId(recordId);
         Account account = accountRepositoryInstance.findByAccountId(contact.AccountId);
         RecordType rt =[select Id from RecordType where Name = 'Subscription' and SobjectType = 'Case'];
         Map<String,Object> planDetails = (Map<String,Object>) plan.get(0);
        Case subscribeRequest = new Case(
            Subject= contact.Name +' Subscription Request '+ planDetails.get('name'),
            AccountId=account.id,
            ContactId=contact.id,
            Origin='web',
            Status='New',
            RecordType=rt);

            insert subscribeRequest;
      }

      public void CreateReservationRequest(String recordId , List<Object> requestDetails){

        Contact contact = contactRepositoryInstance.findByRecordId(recordId);
        Account account = accountRepositoryInstance.findByAccountId(contact.AccountId);
        RecordType rt =[select Id from RecordType where Name = 'Reservation' and SobjectType = 'Case'];
        Case reservationRequest = new Case(
            Subject= contact.Name +' Reservation Request ',
            AccountId=account.id,
            ContactId=contact.id,
            Origin='web',
            Status='New',
            RecordType=rt);
            insert reservationRequest;
            Opportunity packages = opportunityRepositoryInstance.findByCase(reservationRequest.Id);
            List<OpportunityLineItem> packageServices= new List<OpportunityLineItem>();
            List<Opprtunity_Line_Item_Details__c> services = new List<Opprtunity_Line_Item_Details__c>();
            List<Service_Member__c> serviceMembers = new List<Service_Member__c>();
            Integer counter = 0;
            while(counter < requestDetails.size()){
                OpportunityLineItem packageService = new OpportunityLineItem();
                Map<String,Object> serviceDetails = (Map<String,Object>) requestDetails.get(counter);
                String productFamily = (String)serviceDetails.get('subType');
                packageService.OpportunityId = packages.Id;
                packageService.Product2Id = productRepositoryInstance.findByName(productFamily).Id;
                packageService.Quantity= 1;
                packageService.UnitPrice =0;
                packageServices.add(packageService);
                counter++;
            }

            insert packageServices;
            counter = 0;
            while(counter < requestDetails.size()){
              
                Map<String,Object> serviceDetails = (Map<String,Object>) requestDetails.get(counter);
                Opprtunity_Line_Item_Details__c service= RequestMapper.CreateRequest(serviceDetails);
                service.Opportunity_Product__c = packageServices.get(counter).Id;
                services.add(service);
                counter++;
            }
            insert services;
            counter = 0;
            while(counter < requestDetails.size()){
            Service_Member__c servicemember = new Service_Member__c();
            servicemember.Contact__c = contact.Id;
            servicemember.Opportunity_Product__c=packageServices.get(counter).Id;
            servicemember.Name=contact.Name;
            packageServices.get(counter).Opportunity_Line_Item_Details__c = services.get(counter).Id;
            serviceMembers.add(servicemember);
            counter++;
            }
            insert serviceMembers;
            update packageServices;
           
      }
}
