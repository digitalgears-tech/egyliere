public class PublicationService {
    private static PublicationService instance = null;
    public  PublicationRepository publicationRepositoryInstance;
    public  PreferenceRepository preferenceRepositoryInstance;
    public  ContactRepository contactRepositoryInstance;
    public  PublicationMapper publicationMapperInstance;
    private PublicationService() {
        publicationRepositoryInstance = PublicationRepository.getInstance();
        preferenceRepositoryInstance = PreferenceRepository.getInstance();
        contactRepositoryInstance = ContactRepository.getInstance();
        publicationMapperInstance = PublicationMapper.getInstance();
    }

    public static PublicationService getInstance() {
        if (instance == null) {
          instance = new PublicationService();
        }
        return instance;
      }

      public  List<PublicationMapper> getPublicationByTags(String ID, String app){
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
          List<String> subTags=p.Sub_Tags__c.split(';');
          for(String tag : subTags) {
            if(!(tagslist.contains(tag)))
              tagslist.add(tag);}
           }
        if (app.equals('orange')){
          return publicationMapperInstance.PublicationObjectListToMapperList(publicationRepositoryInstance.findExternalappByTags(tagslist));
        }else{
        return publicationMapperInstance.PublicationObjectListToMapperList(publicationRepositoryInstance.findByTags(tagslist));}
      }

      public  List<PublicationMapper> getPublicationByTags(String app){
        List<Publication__c>  publication;
        if (app.equals('Internal')){
          publication = publicationRepositoryInstance.findAllPublications();
        }else if(app.equals('orange')){
          publication = publicationRepositoryInstance.findAllPublicationsShowOnExternalApp();
        }
        return publicationMapperInstance.PublicationObjectListToMapperList(publication);
      }
}
