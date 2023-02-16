/**
 * @description       : 
 * @author            : Mohamed Tarek
 * @group             : 
 * @last modified on  : 02-16-2023
 * @last modified by  : Mohamed Tarek
**/
public class VoucherService {
    private static VoucherService instance = null;
    public PackageServiceRepository packageServiceRepositoryInstance;

    private VoucherService() {
        packageServiceRepositoryInstance=PackageServiceRepository.getInstance();
    }

    public static VoucherService getInstance() {
        if (instance == null) {
          instance = new VoucherService();
        }
        return instance;
      }
    public VoucherMapper getVoucherById(String id){
        OpportunityLineItem packageService= packageServiceRepositoryInstance.findPackageServiceById(id);
        List<ContentDocumentLink> contentDocumentLinks = [
            SELECT ContentDocumentId
            FROM ContentDocumentLink
            WHERE LinkedEntityId = :packageService.Opportunity_Line_Item_Details__c
            ORDER BY SystemModstamp DESC LIMIT 1
          ];
          System.debug(contentDocumentLinks);
          if(contentDocumentLinks.size()==0){
            return null;
          }
          
         ContentVersion cv = [
            SELECT Id,Title
            FROM ContentVersion
            WHERE ContentDocumentId=:contentDocumentLinks[0].ContentDocumentId AND IsLatest = TRUE
          ];
      
       ContentDistribution conDis = new ContentDistribution();
              conDis.Name = cv.Title;
              conDis.ContentVersionId = cv.Id;
              conDis.PreferencesAllowViewInBrowser= true;
              insert conDis;
      conDis=[SELECT DistributionPublicUrl,ContentDownloadUrl FROM ContentDistribution WHERE Id=:conDis.Id];
      VoucherMapper voucherMapper=new VoucherMapper();
      return voucherMapper.publicContentToVoucherMapper(conDis);

    }
}