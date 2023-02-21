/**
 * @description       : 
 * @author            : Mohamed Tarek
 * @group             : 
 * @last modified on  : 02-16-2023
 * @last modified by  : Mohamed Tarek
**/
@RestResource(urlMapping='/VoucherAPI/*')
global class VoucherAPI {
    @HttpGet
    global static VoucherMapper getVoucher(){
        RestRequest getRequest= RestContext.request;
        RestResponse requestResponse= RestContext.response;
        String app;
        try{
        app = getRequest.params.get('App');
            if(app.equals('Internal')){
             String id= getRequest.params.get('bookingID');
             System.debug(id);
             VoucherService voucherServiceInstance=VoucherService.getInstance();
             return voucherServiceInstance.getVoucherById(id);
            }else{
             requestResponse.statusCode=503;
             throw new GeneralException('Not allowed for External apps');}

        }  catch (System.NullPointerException e) {
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
