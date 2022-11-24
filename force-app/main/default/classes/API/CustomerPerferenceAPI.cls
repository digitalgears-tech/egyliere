@RestResource(urlMapping='/CustomerPerferencesList/*')
global with sharing class CustomerPerferenceAPI {
    public static PreferenceService preferenceServiceInstance = PreferenceService.getInstance();
    public CustomerPerferenceAPI() {

    }
    @HttpGet
    global static List<String> sendContactPerferencesList(){
        RestRequest getReuest= RestContext.request;
        String app = getReuest.params.get('App');
        if(app.equals('orange')){
        String orangeId = getReuest.params.get('orangeID');
        return preferenceServiceInstance.getContactMainTagsList(orangeId ,app);
    }else{
        String recordId = getReuest.params.get('recordID');
        return preferenceServiceInstance.getContactMainTagsList(recordID ,app);
    }
        
    }


    @HttpPost
    global static void setContactPerferencesList(List<String> preference){
        RestRequest postReuest= RestContext.request;
        String app = postReuest.params.get('App');
        String orangeId = postReuest.params.get('orangeID');
    }


}
