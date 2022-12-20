public class AccountService {

    private static AccountService instance = null;
    public  AccountRepository accountRepositoryInstance;

    public AccountService() {
        accountRepositoryInstance = AccountRepository.getInstance();
    }

    public static AccountService getInstance() {
        if (instance == null) {
          instance = new AccountService();
        }
        return instance;
      }
   
      public Account CreateSubscribeAccount(List< Object> accountDetails){
        List <Account> accounts = new List<Account>();
        Integer counter = 0;
        RecordType rt = [select Id from RecordType where Name = 'Individual' and SobjectType = 'Account'];
        while (counter < accountDetails.size()){
          Map<String, Object> accountsmap = (Map<String, Object>) accountDetails.get(counter);
          Account account = new Account(
           Name = accountsmap.get('First Name') + '  ' + accountsmap.get('Last Name'),
           RecordType = rt,
           Type= 'Prospect');
           accounts.add(account);
           counter++;
        }
          insert accounts;
          return accounts.get(0);
      }
}
