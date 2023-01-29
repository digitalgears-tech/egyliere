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
          Id,
          RecordTypeId,
          CaseNumber
          FROM Case
          WHERE ContactId = :contact.Id
           ];
      }

      public List<Case> findReservationRequestByContact(Contact contact, string rtId) {

        return [
          SELECT
          Id,
          RecordTypeId,
          CaseNumber
          FROM Case
          WHERE ContactId = :contact.Id
          And RecordTypeId = :rtId
           ];
      }
}