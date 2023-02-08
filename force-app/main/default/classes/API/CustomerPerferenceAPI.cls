@RestResource(urlMapping='/CustomerPerferencesList/*')
global  class CustomerPerferenceAPI {
    public static PreferenceService preferenceServiceInstance = PreferenceService.getInstance();
    private CustomerPerferenceAPI() {

    }
    @HttpGet
    global static Map<String, List<String>> sendContactPerferencesList(){
        RestRequest getReuest= RestContext.request;
        RestResponse requestResponse= RestContext.response;

        try{
        String app = getReuest.params.get('App');
        if(app.equals('orange')){
        String orangeId = getReuest.params.get('orangeID');
        return preferenceServiceInstance.getContactTagsMap(orangeId ,app);
        }else{
        String recordId = getReuest.params.get('recordID');
        return preferenceServiceInstance.getContactTagsMap(recordID ,app);
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


    @HttpPost
    global static void setContactPerferencesList(Map<String, List<String>> preference){
        RestRequest postReuest= RestContext.request;
        RestResponse requestResponse= RestContext.response;

        try{
        String app = postReuest.params.get('App');
       if(app.equals('orange')){
            String orangeId = postReuest.params.get('orangeID');
            preferenceServiceInstance.updateContactPreferenceByID(orangeId, app, preference);
        }else{
            String recordId = postReuest.params.get('recordID');
            preferenceServiceInstance.updateContactPreferenceByID(recordId, app, preference);
        }
         }catch (System.NullPointerException e) {
                requestResponse.statusCode=500;
                requestResponse.responseBody = Blob.valueOf('ERROR: ' + e.getMessage());
    }

        catch (System.DmlException e) {
                requestResponse.statusCode=500;
                requestResponse.responseBody = Blob.valueOf('ERROR: ' + e.getMessage());
   }

        catch(GeneralException e){
                requestResponse.statusCode=400;
                requestResponse.responseBody = Blob.valueOf('ERROR: ' + e.getMessage());
   }
  
    }


}