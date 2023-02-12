public class CustomMetadataRepository {
    private static CustomMetadataRepository instance = null;

    public CustomMetadataRepository() {

    }
    public static CustomMetadataRepository getInstance() {
        if (instance == null) {
          instance = new CustomMetadataRepository();
        }
        return instance;
      }

    public Company_Info__mdt getCompanyInfo() {
    return [
        SELECT 
        Address__c,
        Email__c,
        License_No__c,
        Phone__c,
        Reg_No__c,
        Tax_ID__c,
        Url__c 
        from Company_Info__mdt]; 
    }
}
