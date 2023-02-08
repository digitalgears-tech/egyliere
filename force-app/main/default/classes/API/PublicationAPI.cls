@RestResource(urlMapping='/PublicationListAPI/*')
global class PublicationAPI {
    public static PublicationService publicationServiceInstance = PublicationService.getInstance();

    @HttpGet
    global static  List<PublicationMapper> upsertPublication() {
        RestRequest getReuest= RestContext.request;
        RestResponse requestResponse= RestContext.response;
       try{
        String app = getReuest.params.get('App');
      
        
         if(getReuest.params.get('Type')==null && getReuest.params.get('orangeID')==null && getReuest.params.get('recordID') == null){
            return publicationServiceInstance.getPublicationByTags(app);
            }else if(getReuest.params.get('Type')==null){
           
            switch on app {
                when 'orange' {
                String orangeId = getReuest.params.get('orangeID');
                return publicationServiceInstance.getPublicationByTags(orangeId ,app);
                }
                when 'Internal' {
                 String recordId = getReuest.params.get('recordID');
                return publicationServiceInstance.getPublicationByTags(recordId ,app);
                }
                when else{
                    throw new GeneralException(' not allowed for external apps');
                }
            }
       
            } else if (!(getReuest.params.get('Type')==null) && (!(getReuest.params.get('orangeID')==null) || !(getReuest.params.get('recordID') == null))){
                String type = getReuest.params.get('Type');
                    switch on app {
                        when 'orange' {
                        String orangeId = getReuest.params.get('orangeID');
                        return publicationServiceInstance.getPublicationByTagsandType(orangeId ,app,type);
                        }
                        when 'Internal' {
                         String recordId = getReuest.params.get('recordID');
                        return publicationServiceInstance.getPublicationByTagsandType(recordId ,app,type);
                        }
                        when else{
                            throw new GeneralException(' not allowed for external apps');
                        }
                    }
                }else{
                         String type = getReuest.params.get('Type');
                        return  publicationServiceInstance.getPublicationByTagsandType(app,type);
                    }

            
                }catch (System.NullPointerException e) {
                    requestResponse.statusCode=500;
                    requestResponse.responseBody = Blob.valueOf('ERROR: ' + e.getMessage());
                    throw new GeneralException(e.getMessage());
               }
            
                catch (System.DmlException e) {
                    requestResponse.statusCode=500;
                    requestResponse.responseBody = Blob.valueOf('ERROR: ' + e.getMessage());
                    throw new GeneralException(e.getMessage());
                }
            
                catch(GeneralException e){
                    requestResponse.statusCode=400;
                    requestResponse.responseBody = Blob.valueOf('ERROR: ' + e.getMessage());
                    throw new GeneralException(e.getMessage());
                }
           

}

    
}