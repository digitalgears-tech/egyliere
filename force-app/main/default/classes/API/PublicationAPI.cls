@RestResource(urlMapping='/UpdatePublicationList/*')
global with sharing class PublicationAPI {
    public static PublicationService publicationServiceInstance = PublicationService.getInstance();

    @HttpGet
    global static List<Publication__c>  upsertPublication() {
        RestRequest getReuest= RestContext.request;
        String app = getReuest.params.get('App');
        if(app.equals('orange')){
            try{String orangeId = getReuest.params.get('orangeID');
                return publicationServiceInstance.getPublicationByTags(orangeId ,app);
            }catch(Exception e){
                return publicationServiceInstance.getPublicationByTags(app);
             }
        }else{
        try{ String recordId = getReuest.params.get('recordID');
            return publicationServiceInstance.getPublicationByTags(recordId ,app);
            }catch(Exception e){
                return publicationServiceInstance.getPublicationByTags(app);
            }
         }
}

    
}
