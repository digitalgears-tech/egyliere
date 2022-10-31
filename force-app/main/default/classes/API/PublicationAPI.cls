@RestResource(urlMapping='/UpdatePublicationList/*')
global with sharing class PublicationAPI {
    public static PublicationService publicationServiceInstance = PublicationService.getInstance();

    @HttpGet
    global static List<Publication__c>  upsertPublication() {
        RestRequest getReuest= RestContext.request;
        String app = getReuest.params.get('App');
        if(app.equals('orange')){
        String orangeId = getReuest.params.get('orangeID');
        return publicationServiceInstance.getPublicationByTags(orangeId);
    }else{
        return null;
    }
    }

    
}
