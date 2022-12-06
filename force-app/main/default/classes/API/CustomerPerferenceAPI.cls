@RestResource(urlMapping='/CustomerPerferencesList/*')
global with sharing class CustomerPerferenceAPI {
    public static PreferenceService preferenceServiceInstance = PreferenceService.getInstance();
    private CustomerPerferenceAPI() {

    }
    @HttpGet
    global static Map<String, List<String>> sendContactPerferencesList(){
        RestRequest getReuest= RestContext.request;
        String app = getReuest.params.get('App');
        if(app.equals('orange')){
        String orangeId = getReuest.params.get('orangeID');
        return preferenceServiceInstance.getContactTagsMap(orangeId ,app);
    }else{
        String recordId = getReuest.params.get('recordID');
        return preferenceServiceInstance.getContactTagsMap(recordID ,app);
    }
        
    }


    @HttpPost
    global static void setContactPerferencesList(Map<String, List<String>> preference){
        RestRequest postReuest= RestContext.request;
        String app = postReuest.params.get('App');
       if(app.equals('orange')){
            String orangeId = postReuest.params.get('orangeID');
            preferenceServiceInstance.updateContactPreferenceByID(orangeId, app, preference);
        }else{
            String recordId = postReuest.params.get('recordID');
            preferenceServiceInstance.updateContactPreferenceByID(recordId, app, preference);
        }  
    }


}
