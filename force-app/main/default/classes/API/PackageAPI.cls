@RestResource(urlMapping='/PackageAPI/*')
global class PackageAPI {
    public static OpportunityService opportunityServiceInstance = OpportunityService.getInstance();
    public PackageAPI() {

    }
    @HttpGet
    global static List<PackageMapper> getPayment(){
        RestRequest getReuest= RestContext.request;
        RestResponse requestResponse= RestContext.response;
        try{
        String app = getReuest.params.get('App');
        if(app.equals('Internal')){
            if(getReuest.params.get('packageID')!=null){
            return opportunityServiceInstance.getOpportunity(getReuest.params.get('packageID'));
            }else{
                requestResponse.statusCode=503;
             throw new GeneralException('No PackageID found');
            }
          
         }else{
             requestResponse.statusCode=503;
             throw new GeneralException('Not allowed for External apps');}
         }
         catch (System.NullPointerException e) {
              requestResponse.statusCode=500;
              requestResponse.responseBody = Blob.valueOf('ERROR: ' + e.getMessage());
              throw new GeneralException(e.getMessage());}
          catch (System.DmlException e) {
                requestResponse.statusCode=500;
                requestResponse.responseBody = Blob.valueOf('ERROR: ' + e.getMessage());
                throw new GeneralException(e.getMessage());}
          catch(System.Exception e){
                requestResponse.statusCode=400;
                requestResponse.responseBody = Blob.valueOf('ERROR: ' + e.getMessage());
                throw new GeneralException(e.getMessage());}
             
     }   
    

    @HttpPost
    global static void UpdatePayment(){
       RestRequest getReuest= RestContext.request;
       RestResponse requestResponse= RestContext.response;
       try{
       String app = getReuest.params.get('App');
       if(app.equals('Internal')){
           if( getReuest.params.get('packageID')!=null && getReuest.params.get('Status').equals('Paid')){
           opportunityServiceInstance.updatePaidOpportunity(getReuest.params.get('packageID'));       
           requestResponse.responseBody=Blob.valueOf('Updated' );
           requestResponse.statusCode=200;}
         
        }else{
            requestResponse.statusCode=503;
            throw new GeneralException('Not allowed for External apps');}
        }
        catch (System.NullPointerException e) {
             requestResponse.statusCode=500;
             requestResponse.responseBody = Blob.valueOf('ERROR: ' + e.getMessage());}
         catch (System.DmlException e) {
               requestResponse.statusCode=500;
               requestResponse.responseBody = Blob.valueOf('ERROR: ' + e.getMessage());}
         catch(System.Exception e){
               requestResponse.statusCode=400;
               requestResponse.responseBody = Blob.valueOf('ERROR: ' + e.getMessage());}
            
    }
}
