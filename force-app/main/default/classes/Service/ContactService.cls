public with sharing class ContactService {
    private static ContactService instance = null;
    public  ContactRepository contactRepositoryInstance;

    public ContactService() {
        contactRepositoryInstance = ContactRepository.getInstance();
    }

    public static ContactService getInstance() {
        if (instance == null) {
          instance = new ContactService();
        }
        return instance;
      }
     
      
}
