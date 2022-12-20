public class RequestRepository {
    private static RequestRepository instance = null;
    private RequestRepository() {

    }

    public static RequestRepository getInstance() {
        if (instance == null) {
          instance = new RequestRepository();
        }
        return instance;
      }

      public List<Case> findRequestByContact(Contact contact) {

        return [
          SELECT
          RecordTypeId,
          CaseNumber
          FROM Case
          WHERE Contact__c = :contact.Id
           ];
      }
}
