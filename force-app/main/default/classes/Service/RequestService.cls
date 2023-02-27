public class RequestService {
    private static RequestService instance = null;
    public  ContactRepository contactRepositoryInstance;
    public AccountRepository accountRepositoryInstance;
    public OpportunityRepository opportunityRepositoryInstance;
    public ProductRepository productRepositoryInstance;
    public RequestRepository requestRepositoryInstance;
    public ServiceRepository serviceRepositoryInstance;
    public PackageServiceRepository packageServiceRepositoryInstance;
    public PlansRepository plansRepositoryInstance;
    public RequestMapper requestMapper = new RequestMapper();
    public ServiceMapper serviceMapper = new ServiceMapper();

    private RequestService() {
        contactRepositoryInstance = ContactRepository.getInstance();
        accountRepositoryInstance = AccountRepository.getInstance();
        opportunityRepositoryInstance = OpportunityRepository.getInstance();
        productRepositoryInstance = productRepository.getInstance();
        requestRepositoryInstance = RequestRepository.getInstance();
        serviceRepositoryInstance = ServiceRepository.getInstance();
        plansRepositoryInstance = PlansRepository.getInstance();

        packageServiceRepositoryInstance = PackageServiceRepository.getInstance();
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
            Plan__c = (String)planDetails.get('name'),
            RecordTypeId=rt.Id);

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
            RecordTypeId=rt.Id);
            insert reservationRequest;
            Opportunity packages = opportunityRepositoryInstance.findByCase(reservationRequest.Id).get(0);
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

            Map<String,Object> serviceDetails = (Map<String,Object>) requestDetails.get(counter);
            //List<String> members = (String)serviceDetails.get('Members');
            List<Contact> contacts = new List<Contact>();
           // for(String m : members){
                //Contact contact = contactRepositoryInstance.findByRecordId(m);
            //    contacts.add(contact);
           // }
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

      public List<ServiceMapper>  GetReservationsRequest(String recordId){

        Contact contact = contactRepositoryInstance.findByRecordId(recordId);
        Account account = accountRepositoryInstance.findByAccountId(contact.AccountId);
        RecordType rt =[select Id from RecordType where Name = 'Reservation' and SobjectType = 'Case'];
        List<Case> reservationRequests = requestRepositoryInstance.findReservationRequestByContact(contact , rt.Id);
        List<Opportunity> opportunities = new List<Opportunity>();
        for(Case r : reservationRequests){
         opportunities.addAll(opportunityRepositoryInstance.findByCase(r.Id));}
         List<OpportunityLineItem> packageServices = new List<OpportunityLineItem>();
         List<Opprtunity_Line_Item_Details__c> services = new List<Opprtunity_Line_Item_Details__c>();

         List<String> opportunitiesIDs = new List<String>();
         for(Opportunity o : opportunities){
            opportunitiesIDs.add(o.Id);
         }
         packageServices.addAll(packageServiceRepositoryInstance.findAllPackageServiceByOpportunity(opportunitiesIDs));

         List <String> packageServicesIDs=  new List<String>();
         Map<String,PackageServiceMapper> packageServiceMap = new Map<String,PackageServiceMapper>();

         for(OpportunityLineItem o :packageServices){
            packageServiceMap.put(o.Id, new PackageServiceMapper(o));
            packageServicesIDs.add(o.Id);
         }
         services.addAll(serviceRepositoryInstance.findServiceByOpportunityProduct(packageServicesIDs));

        return  serviceMapper.ServiceobjectListToMapperList(services, packageServiceMap);

      }

      public List<ServiceMapper>  GetReservationsRequestByStatus(String recordId,String status){
         List <String> statusList = new List<String>();
         if(status.equals('completed')){
          statusList.add('Closed Won');
         }else if(status.equals('cancelled')){
            statusList.add('Closed Lost');
         }else if(status.equals('ongoing')){
           statusList.add('Qualification');
           statusList.add('Pricing');
           statusList.add('Proposal');
           statusList.add('Negotiation');
         }else if(status.equals('history')){
          statusList.add('Closed Lost');
          statusList.add('Closed Won');
         }else if(status.equals('approved')){
          statusList.add('Ready for payment');
          statusList.add('Paid');
         }else{
            statusList.add('Qualification');
            statusList.add('Pricing');
            statusList.add('Proposal');
            statusList.add('Negotiation');
            statusList.add('Ready for payment');
            statusList.add('Paid');
            statusList.add('Closed Lost');
            statusList.add('Closed Won');
         }
        Contact contact = contactRepositoryInstance.findByRecordId(recordId);
        Account account = accountRepositoryInstance.findByAccountId(contact.AccountId);
        RecordType rt =[select Id from RecordType where Name = 'Reservation' and SobjectType = 'Case'];
        List<Case> reservationRequests = requestRepositoryInstance.findReservationRequestByContact(contact , rt.Id);
        List<Opportunity> opportunities = new List<Opportunity>();
        for(Case r : reservationRequests){
         opportunities.addAll(opportunityRepositoryInstance.findByCaseandStatus(r.Id,statusList));
      }
         List<OpportunityLineItem> packageServices = new List<OpportunityLineItem>();
         List<Opprtunity_Line_Item_Details__c> services = new List<Opprtunity_Line_Item_Details__c>();

         List<String> opportunitiesIDs = new List<String>();
         for(Opportunity o : opportunities){
            opportunitiesIDs.add(o.Id);
         }
         packageServices.addAll(packageServiceRepositoryInstance.findAllPackageServiceByOpportunity(opportunitiesIDs));

         List <String> packageServicesIDs=  new List<String>();
         Map<String,PackageServiceMapper> packageServiceMap = new Map<String,PackageServiceMapper>();

         for(OpportunityLineItem o :packageServices){
            packageServiceMap.put(o.Id, new PackageServiceMapper(o));
            packageServicesIDs.add(o.Id);
         }
         services.addAll(serviceRepositoryInstance.findServiceByOpportunityProduct(packageServicesIDs));

        return  serviceMapper.ServiceobjectListToMapperList(services, packageServiceMap);

      }

      
}