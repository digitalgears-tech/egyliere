@RestResource(urlMapping='/PublicationListAPI/*')
global with sharing class PublicationAPI {
    public static PublicationService publicationServiceInstance = PublicationService.getInstance();

    @HttpGet
    global static  List<PublicationMapper> upsertPublication() {
        RestRequest getReuest= RestContext.request;
        String app = getReuest.params.get('App');
        if(app.equals('orange')){
            try{String orangeId = getReuest.params.get('orangeID');
                System.debug(publicationServiceInstance.getPublicationByTags(orangeId ,app));
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
