@RestResource(urlMapping='/PerferencesList/*')
global class PerferenceAPI {
    public static PreferenceService preferenceServiceInstance = PreferenceService.getInstance();
    public PerferenceAPI() {

    }

 /*   @HttpGet
    global static List<String> sendPerferencesList(){
        RestRequest getReuest= RestContext.request;
        String app = getReuest.params.get('App');
        if(app.equals('orange')){
        return preferenceServiceInstance.getMainTagsList();}
        else {
            return preferenceServiceInstance.getMainTagsList();
        }
    }
*/
    @HttpGet
    global static  Map<String, List<String>>   sendPerferencesList(){
        RestRequest getReuest= RestContext.request;
        String app = getReuest.params.get('App');
        if(app.equals('orange')){
        return preferenceServiceInstance.getTagsMap();}
        else {
            return preferenceServiceInstance.getTagsMap();
        }
    }
}