/**
 * @description       : 
 * @author            : Mohamed Tarek
 * @group             : 
 * @last modified on  : 02-15-2023
 * @last modified by  : Mohamed Tarek
**/
@RestResource(urlMapping='/MyBookingsAPI/*')
global class MyBookingsAPI {
    public static RequestService requestServiceInstance = RequestService.getInstance();
    public MyBookingsAPI() {

    }
@HttpGet
global static  List<ServiceMapper>  getAllService(){
    
        RestRequest getReuest= RestContext.request;
        RestResponse requestResponse= RestContext.response;
    try{
        String app = getReuest.params.get('App');
      if(app.equals('Internal')){
        String recordId = getReuest.params.get('recordID');
      if(getReuest.params.get('Status')!=null){
           return requestServiceInstance.GetReservationsRequestByStatus(recordId,getReuest.params.get('Status'));
        }else{ 
            return requestServiceInstance.GetReservationsRequest(recordId);}
            
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