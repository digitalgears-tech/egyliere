/**
 * @description       : 
 * @author            : Mohamed Tarek
 * @group             : 
 * @last modified on  : 02-16-2023
 * @last modified by  : Mohamed Tarek
**/
global class VoucherMapper {

    public String previewLink;
    public String downloadableLink;

    public VoucherMapper publicContentToVoucherMapper(ContentDistribution contentDistribution){
        
        VoucherMapper voucherMapper = new VoucherMapper();
        voucherMapper.previewLink=contentDistribution.DistributionPublicUrl;
        voucherMapper.downloadableLink=contentDistribution.ContentDownloadUrl;
   
      return voucherMapper;
    }



}