@RestResource(urlMapping='/PublicationListAPI/*')
global class PublicationAPI {
    public static PublicationService publicationServiceInstance = PublicationService.getInstance();

    @HttpGet
    global static  List<PublicationMapper> upsertPublication() {
        RestRequest getReuest= RestContext.request;
        RestResponse requestResponse= RestContext.response;
        Integer pageSize;
        Integer pageNumber;
        try{
         pageSize = Integer.valueOf(getReuest.params.get('PageSize'));
         pageNumber = Integer.valueOf(getReuest.params.get('PageNumber'));
        }catch(Exception e){
            pageSize=100;
            pageNumber=1;
        }
       try{
        String app = getReuest.params.get('App');
      
        
         if(getReuest.params.get('Type')==null && getReuest.params.get('orangeID')==null && getReuest.params.get('recordID') == null){
            return publicationServiceInstance.getPublicationByTags(app,pageSize,pageNumber);
            }else if(getReuest.params.get('Type')==null){
           
            switch on app {
                when 'orange' {
                String orangeId = getReuest.params.get('orangeID');
                return publicationServiceInstance.getPublicationByTags(orangeId ,app,pageSize,pageNumber);
                }
                when 'Internal' {
                 String recordId = getReuest.params.get('recordID');
                return publicationServiceInstance.getPublicationByTags(recordId ,app,pageSize,pageNumber);
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
                        return publicationServiceInstance.getPublicationByTagsandType(orangeId ,app,type,pageSize,pageNumber);
                        }
                        when 'Internal' {
                         String recordId = getReuest.params.get('recordID');
                        return publicationServiceInstance.getPublicationByTagsandType(recordId ,app,type,pageSize,pageNumber);
                        }
                        when else{
                            throw new GeneralException(' not allowed for external apps');
                        }
                    }
                }else{
                         String type = getReuest.params.get('Type');
                        return  publicationServiceInstance.getPublicationByTagsandType(app,type,pageSize,pageNumber);
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