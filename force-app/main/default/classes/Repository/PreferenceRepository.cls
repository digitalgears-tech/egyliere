public class PreferenceRepository {
    private static PreferenceRepository instance = null;

    public PreferenceRepository() {}
    public static PreferenceRepository getInstance() {
        if (instance == null) {
          instance = new PreferenceRepository();
        }
        return instance;
      }

      public List<preference__c> findByContact(Contact contact) {

        return [
          SELECT
          Main_Tag__c,
          Sub_Tags__c,
          General_Preferences__c
          FROM preference__c
          WHERE Contact__c = :contact.Id
          ];
      }
      public List<preference__c> findExceptGeneralByContact(Contact contact) {

        return [
          SELECT
          Main_Tag__c,
          Sub_Tags__c
          FROM preference__c
          WHERE Contact__c = :contact.Id
          AND Main_Tag__c != 'General'  ];
      }
      public preference__c findGeneralByContact(Contact contact) {

        return [
          SELECT
          Main_Tag__c,
          Sub_Tags__c,
          General_Preferences__c
          FROM preference__c
          WHERE Contact__c = :contact.Id
          AND Main_Tag__c = 'General' ];
      }

      public List<preference__c> findAllPrefernces() {

        return [
          SELECT
          Main_Tag__c,
          Sub_Tags__c
          FROM preference__c
          ];
      }
}
