public class PublicationService {
    private static PublicationService instance = null;
    public  PublicationRepository publicationRepositoryInstance;
    
    private PublicationService() {
        publicationRepositoryInstance = PublicationRepository.getInstance();
    }

    public static PublicationService getInstance() {
        if (instance == null) {
          instance = new PublicationService();
        }
        return instance;
      }

      public List<Publication__c> getPublicationByTags(List<String> tagslist){
        
        PublicationService publicationServiceInstance = PublicationService.getInstance();
        return publicationRepositoryInstance.findByTags(tagslist);
      }
}
