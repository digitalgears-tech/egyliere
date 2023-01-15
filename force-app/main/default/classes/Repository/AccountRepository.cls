public class AccountRepository {
  
    private static AccountRepository instance = null;
    private AccountRepository() {}

    public static AccountRepository getInstance() {
        if (instance == null) {
          instance = new AccountRepository();
        }
        return instance;
     
     }  

     public Account findByAccountId(String accountId){

        return [
            SELECT
            Name,
            Balance__c,
            Consumed__c,
            Plan__c,
            Total_Hold__c,
            Guest__c
            FROM Account
            WHERE Id = :accountId
            ];
  
     }

}
