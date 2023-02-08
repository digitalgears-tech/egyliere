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
        RestResponse requestResponse= RestContext.response;

        try{
        String app = getReuest.params.get('App');
        if(app.equals('orange')){
        return preferenceServiceInstance.getTagsMap();}
        else if(app.equals('Internal')){
            return preferenceServiceInstance.getTagsMap();
        }else{
            throw new GeneralException(' not allowed for external apps');
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