public class ContactService {
    private static ContactService instance = null;
    public  ContactRepository contactRepositoryInstance;
    public AccountRepository accountRepositoryInstance;

    public ContactService() {
        contactRepositoryInstance = ContactRepository.getInstance();
        accountRepositoryInstance = AccountRepository.getInstance();
    }

    public static ContactService getInstance() {
        if (instance == null) {
          instance = new ContactService();
        }
        return instance;
      }
     
      
    public Map<String,String> checkContactPassword(String username, String password , String app) {

      Map<String,String> contactMap = new Map<String,String>();
      try{
      Contact contact = contactRepositoryInstance.findByUsername(username);
      Account account = accountRepositoryInstance.findByAccountId(contact.AccountId);
      if(password.equals(contact.Password__c)) {
        contactMap.put('Status', 'Accepted');
        contactMap.put('Name', contact.Name);
        If(app.equals('orange')){
        contactMap.put('ID', contact.Orange_ID__c);
         }else{
        contactMap.put('ID', contact.Id);}
        contactMap.put('MmeberShip', contact.Tier__c);
        contactMap.put('Account ID', Account.Id);
        contactMap.put('Total Points', Account.Balance__c +'');
        contactMap.put('Consumed Points', Account.Consumed__c+'');

     }else{
      contactMap.put('Status', 'Rejected');
     }
    }catch(Exception e){
      

    }
     return contactMap;
  }

  public contact CreateSubscribeContact(List<Object> contactDetails, Account account){

    List <Contact> contacts = new List<Contact>();
    Integer counter = 0;
    while (counter < contactDetails.size()){
      Map<String, Object> contactsmap = (Map<String, Object>) contactDetails.get(counter);
      Contact contact = new Contact( 
      FirstName=contactsmap.get('First Name')+'',
      LastName=contactsmap.get('Last Name')+'',
      Phone=contactsmap.get('Phone')+'',
      Email=contactsmap.get('Email')+'',
      Password__c=contactsmap.get('Password')+'',
      AccountId=account.Id);

        contacts.add(contact);
        counter++;
    }
    insert contacts;
    return contacts.get(0);
  }
}
