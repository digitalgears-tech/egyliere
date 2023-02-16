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
        String id= getRequest.params.get('recordID');
        System.debug(id);
        VoucherService voucherServiceInstance=VoucherService.getInstance();

        return voucherServiceInstance.getVoucherById(id);

    }
    
}
