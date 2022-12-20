public class RequestService {
    private static RequestService instance = null;
    public  ContactRepository contactRepositoryInstance;
    private RequestService() {

    }

    public static RequestService getInstance() {
        if (instance == null) {
          instance = new RequestService();
        }
        return instance;
      }

      public void CreateSubscribeRequest(Contact contact, Account account){
         
         RecordType rt =[select Id from RecordType where Name = 'Subscription' and SobjectType = 'Case'];
        Case subscribeRequest = new Case(
            Subject= account.Name +' Subscription Request',
            AccountId=account.id,
            ContactId=contact.id,
            Origin='web',
            Status='New',
            RecordType=rt);

            insert subscribeRequest;
      }
}
