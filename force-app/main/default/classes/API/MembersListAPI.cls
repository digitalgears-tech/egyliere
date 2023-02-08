@RestResource(urlMapping='/MembersListAPI/*')
global class MembersListAPI {
    public static ContactService contactServiceInstance = ContactService.getInstance();

    public MembersListAPI() {

    }


    @HttpGet
    global static List<Contact> getMembersList(){

            RestRequest getReuest= RestContext.request;
            RestResponse requestResponse= RestContext.response;
            try{
            String app = getReuest.params.get('App');
        
          if(app.equals('Internal')){
            String recordId = getReuest.params.get('recordID');
            return contactServiceInstance.getContactMembers(recordId);
          }else{
            throw new GeneralException(' not allowed for external apps');
          }
        } catch (System.NullPointerException e) {
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