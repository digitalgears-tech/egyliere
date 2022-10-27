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

      public List<Publication__c> getPublicationByTags(String orangeID){
        
        PublicationService publicationServiceInstance = PublicationService.getInstance();
        Contact contact =contactRepositoryInstance.findByOrangeId(orangeId);
        List<preference__c>  preference =preferenceRepositoryInstance.findByContact(contact);
        List<String> tagslist= new List<String>();
        for (preference__c p : preference) {
         tagslist.add(p.Main_Tag__c);
      }
      System.debug('preference' + tagslist.toString());
        return publicationRepositoryInstance.findByTags(tagslist);
      }
}
