public class PublicationService {
    private static PublicationService instance = null;
    public  PublicationRepository publicationRepositoryInstance;
    public  PreferenceRepository preferenceRepositoryInstance;
    public  ContactRepository contactRepositoryInstance;
    private PublicationService() {
        publicationRepositoryInstance = PublicationRepository.getInstance();
        preferenceRepositoryInstance = PreferenceRepository.getInstance();
        contactRepositoryInstance = ContactRepository.getInstance();
    }

    public static PublicationService getInstance() {
        if (instance == null) {
          instance = new PublicationService();
        }
        return instance;
      }

      public List<Publication__c> getPublicationByTags(String ID, String app){
        PublicationService publicationServiceInstance = PublicationService.getInstance();
        Contact contact;
        List<preference__c>  preference;
        if (app.equals('orange')){
        contact =contactRepositoryInstance.findByOrangeId(ID);
      }else{
        contact =contactRepositoryInstance.findByRecordId(ID); 
      }
      preference =preferenceRepositoryInstance.findByContact(contact);
        List<String> tagslist= new List<String>();
        for (preference__c p : preference) {
         tagslist.add(p.Main_Tag__c);
      }
        if (app.equals('orange')){
          return publicationRepositoryInstance.findExternalappByTags(tagslist);
        }else{
        return publicationRepositoryInstance.findByTags(tagslist);}
      }

      public List<Publication__c> getPublicationByTags(String app){
        List<Publication__c>  publication;
        if (app.equals('Internal')){
          publication = publicationRepositoryInstance.findAllPublications();
        }else if(app.equals('orange')){
          publication = publicationRepositoryInstance.findAllPublicationsShowOnExternalApp();
        }
        return publication;
      }
}
