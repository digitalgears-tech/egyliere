public class CompanyInfoService {

    private static CompanyInfoService instance = null;
    public  CustomMetadataRepository customMetadataRepositoryInstance;
    public CompanyInfoMapper companyInfoMapper = new CompanyInfoMapper();

    public CompanyInfoService() {

    }

    public static CompanyInfoService getInstance() {
        if (instance == null) {
          instance = new CompanyInfoService();
        }
        return instance;
      }

      public CompanyInfoMapper getCompanyInfo() {
        Company_Info__mdt companyInfo = [SELECT  Address__c,
        Email__c,
        License_No__c,
        Phone__c,
        Reg_No__c,
        Tax_ID__c,
        Url__c  from Company_Info__mdt];  
        return companyInfoMapper.CompanyInfoMapper(companyInfo);
 
       }
}
