public class ContactRepository {
    private static ContactRepository instance = null;
    private ContactRepository() {}

    public static ContactRepository getInstance() {
        if (instance == null) {
          instance = new ContactRepository();
        }
        return instance;
      }

    public Contact findByOrangeId(String orangeId){

        return [
          SELECT
          Orange_ID__c
          FROM Contact
          WHERE Orange_ID__c = :orangeId
          ];

    }

    public Contact findByRecordId(String recordId){

        return [
          SELECT
          Id
          FROM Contact
          WHERE Id= :recordId
          ];

    }
}
