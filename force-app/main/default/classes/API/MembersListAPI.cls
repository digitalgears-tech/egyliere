@RestResource(urlMapping='/MembersListAPI/*')
global class MembersListAPI {
    public static ContactService contactServiceInstance = ContactService.getInstance();

    public MembersListAPI() {

    }


    @HttpGet
    global static List<Contact> getMembersList(){

        try{
            RestRequest getReuest= RestContext.request;
            RestResponse requestResponse= RestContext.response;
            String app = getReuest.params.get('App');
        
          if(app.equals('Internal')){
            String recordId = getReuest.params.get('recordID');
            return contactServiceInstance.getContactMembers(recordId);
          }
        }catch(Exception e){
            
        }
        return null;
    }
}