@RestResource(urlMapping='/PlansAPI/*')
global class PlansAPI {
    public static PlansService plansServiceInstance = PlansService.getInstance();
    public PlansAPI() {

    }

    @HttpGet
    global static List<PlansMapper> getPlansDetails(){
        RestRequest getReuest= RestContext.request;
        RestResponse requestResponse= RestContext.response;
        try{
        String app = getReuest.params.get('App');
        if(app.equals('Internal')){
           return plansServiceInstance.getPlanList();
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