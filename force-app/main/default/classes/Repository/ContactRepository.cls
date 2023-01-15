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
          Orange_ID__c,
          Id
          FROM Contact
          WHERE Orange_ID__c = :orangeId
          ];

    }

    public Contact findByRecordId(String recordId){

        return [
          SELECT
          Id,
          Name,
          AccountId, 
          Password__c
          FROM Contact
          WHERE Id= :recordId
          ];

    }

    public Contact findByUsername(String userName){

      return [
        SELECT
        Id,
        Name,
        AccountId,
        Tier__c,
        Password__c
        FROM Contact
        WHERE UserName__c = :userName
        ];

  }

  public List<Contact> findByAccountId(String accountId){

    return [
      SELECT
      Id,
      Name,
      AccountId,
      Tier__c,
      Password__c
      FROM Contact
      WHERE AccountId = :accountId
      ];

}
}
