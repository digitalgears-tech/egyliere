@RestResource(urlMapping='/UpdatePublicationList/*')
global with sharing class PublicationAPI {
    public static PublicationService publicationServiceInstance = PublicationService.getInstance();

    @HttpPatch
    global static List<Publication__c>  upsertPublication(List<String> tags) {
        return publicationServiceInstance.getPublicationByTags(tags);
    }

    
}
