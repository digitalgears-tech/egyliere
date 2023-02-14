/**
 * @description       : 
 * @author            : Mohamed Tarek
 * @group             : 
 * @last modified on  : 02-13-2023
 * @last modified by  : Mohamed Tarek
**/
@RestResource(urlMapping='/PublicationListAPI/*')
global class PublicationAPI {
    public static PublicationService publicationServiceInstance = PublicationService.getInstance();

    @HttpGet
    global static  List<PublicationMapper> upsertPublication() {
        RestRequest getReuest= RestContext.request;
        RestResponse requestResponse= RestContext.response;
        Integer pageSize;
        Integer pageNumber;
        String app;
        String page;
        try{
         pageSize = Integer.valueOf(getReuest.params.get('PageSize'));
         pageNumber = Integer.valueOf(getReuest.params.get('PageNumber'));
        }catch(Exception e){
            pageSize=100;
            pageNumber=1;
        }
        
       try{
        app = getReuest.params.get('App');
        if(getReuest.params.get('Page')!=null){
            return publicationServiceInstance.getPublicationbyPage('Internal',getReuest.params.get('Page'));
        }
         if(getReuest.params.get('Type')==null && getReuest.params.get('orangeID')==null && getReuest.params.get('recordID') == null){
            List<PublicationMapper> publications=publicationServiceInstance.getPublicationByTags(app,pageSize,pageNumber);
            if(publications.size()==0){
                throw new NoRecordsException('No records found');
            }
            return publications;
            }else if(getReuest.params.get('Type')==null){
           
            switch on app {
                when 'orange' {
                String orangeId = getReuest.params.get('orangeID');
                List<PublicationMapper> publications=publicationServiceInstance.getPublicationByTags(orangeId ,app,pageSize,pageNumber);
                if(publications.size()==0){
                    throw new NoRecordsException('No records found');
                }
                return publications;
                }
                when 'Internal' {
                 String recordId = getReuest.params.get('recordID');
                 List<PublicationMapper> publications=publicationServiceInstance.getPublicationByTags(recordId ,app,pageSize,pageNumber);
                 if(publications.size()==0){
                    throw new NoRecordsException('No records found');
                 }
                return publications;
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
                        List<PublicationMapper> publications=publicationServiceInstance.getPublicationByTagsandType(orangeId ,app,type,pageSize,pageNumber);
                        if(publications.size()==0){
                            throw new NoRecordsException('No records found');
                         }
                        return publications;
                        }
                        when 'Internal' {
                         String recordId = getReuest.params.get('recordID');
                         List<PublicationMapper> publications=publicationServiceInstance.getPublicationByTagsandType(recordId ,app,type,pageSize,pageNumber);
                         if(publications.size()==0){
                            throw new NoRecordsException('No Records found');

                         }
                         return publications;
                        }
                        when else{
                            throw new GeneralException(' not allowed for external apps');
                        }
                    }
                }else{
                         String type = getReuest.params.get('Type');
                         List<PublicationMapper> publications=publicationServiceInstance.getPublicationByTagsandType(app,type,pageSize,pageNumber);
                         if(publications.size()==0){
                            throw new NoRecordsException('No records found');
                         }
                        return publications;
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
                }catch(NoRecordsException e){
                    requestResponse.statusCode=404;
                    return new List<PublicationMapper>();
                }
           

}

    
}