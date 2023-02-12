/**
 * @description       : 
 * @author            : Mohamed Tarek
 * @group             : 
 * @last modified on  : 02-12-2023
 * @last modified by  : Mohamed Tarek
**/
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
            List<Contact> members=contactServiceInstance.getContactMembers(recordId);
            if(members.size()==0){
              throw new NoRecordsException('No records found');
            }
            return members;
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
}catch(NoRecordsException e){
  requestResponse.statusCode=404;
  throw new NoRecordsException(e.getMessage());
}
    }
}