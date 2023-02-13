/**
 * @description       : 
 * @author            : Mohamed Tarek
 * @group             : 
 * @last modified on  : 02-12-2023
 * @last modified by  : Mohamed Tarek
**/
public  class ContactCityGuideRepository {
    private static ContactCityGuideRepository instance = null;
    private ContactCityGuideRepository() {}

    public static ContactCityGuideRepository getInstance() {
        if (instance == null) {
          instance = new ContactCityGuideRepository();
        }
        return instance;
      }
      public List<Contact_City_Guide__c> FindAllCityGuidesbyContactAndActive(String contactId){
        return [
            SELECT
            Name,
            City_Guide__c,
            End_Date__c
            FROM Contact_City_Guide__c
            WHERE Contact__c =: contactId
            AND Active__c =: true
          ];

      }

}