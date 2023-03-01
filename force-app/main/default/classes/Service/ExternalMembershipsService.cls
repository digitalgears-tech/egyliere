public class ExternalMembershipsService {
   
    private static ExternalMembershipsService instance = null;
    public  ContactRepository contactRepositoryInstance;
    public ExternalMembershipsRepository externalMembershipsRepositoryInstance;
    public ExternalMembershipsMapper externalMembershipsMapperInstance;

    public ExternalMembershipsService() {
        contactRepositoryInstance = ContactRepository.getInstance();
        externalMembershipsRepositoryInstance = ExternalMembershipsRepository.getInstance();
        externalMembershipsMapperInstance = new ExternalMembershipsMapper();
    }

    public static ExternalMembershipsService getInstance() {
        if (instance == null) {
          instance = new ExternalMembershipsService();
        }
        return instance;
      }

      public  List<ExternalMembershipsMapper> GetContactMemberships(String id , String app){
            List<MemberShip__c> membershipsList;

            if (app.equals('orange')){
                membershipsList = externalMembershipsRepositoryInstance.findByContact(contactRepositoryInstance.findByOrangeId(id));
            }
            if (app.equals('Internal')){
                membershipsList = externalMembershipsRepositoryInstance.findByContact(contactRepositoryInstance.findByRecordId(id));
        
            }

            return externalMembershipsMapperInstance.MembershipListToObject(membershipsList);
      }
      
      public void AddContactMembership(String contactId , List<Object> membershipsList){
        
        List<MemberShip__c> externalMemberships = externalMembershipsMapperInstance.MembershipAPIListToObject(contactId, membershipsList);
       
        insert externalMemberships;
      }

      public void updateContactMembership(String contactId , List<Object> membershipsList){
        
        List<MemberShip__c> externalMemberships = externalMembershipsMapperInstance.MembershipAPIListToObject(contactId, membershipsList);
       
        update externalMemberships;
      }

      public  void deleteContactMembership(List<Object> membershipsList){
        
        List <String> id = new List<String>();
        Integer counter = 0;
        while (counter < membershipsList.size()){
            Map<String, Object> membershipmap =(Map<String, Object>)membershipsList.get(counter);
            id.add((String)membershipmap.get('id'));
            counter += 1;
        }
        try{
        List<MemberShip__c> membership = externalMembershipsRepositoryInstance.findById(id);
        delete membership;}
        catch(Exception e){
            RestResponse errorResponse = RestContext.response;
            errorResponse.statusCode = 400;
             errorResponse.responsebody = Blob.valueOf('error');
       
      }
}
}