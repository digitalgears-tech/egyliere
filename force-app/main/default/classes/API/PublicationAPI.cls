@RestResource(urlMapping='/UpdatePublicationList/*')
global with sharing class PublicationAPI {
    public static PublicationService publicationServiceInstance = PublicationService.getInstance();

    @HttpGet
    global static List<Publication__c>  upsertPublication() {
        RestRequest getReuest= RestContext.request;
        String orangeId = getReuest.requestURI.substring(getReuest.requestURI.lastIndexOf('/') + 1);
        return publicationServiceInstance.getPublicationByTags(orangeId);
    }

    
}
