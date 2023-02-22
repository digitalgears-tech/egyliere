/**
 * @description       : 
 * @author            : Mohamed Tarek
 * @group             : 
 * @last modified on  : 02-21-2023
 * @last modified by  : Mohamed Tarek
**/
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
    public Firebase_Credential__mdt getFirebaseCredentials(){
      return [
        SELECT
        API_Key__c
        FROM
        Firebase_Credential__mdt
        WHERE
        Label='Credentials'

      ];
    }
}
