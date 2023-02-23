/**
 * @description       : 
 * @author            : Mohamed Tarek
 * @group             : 
 * @last modified on  : 02-13-2023
 * @last modified by  : Mohamed Tarek
**/
public class ContactService {
    private static ContactService instance = null;
    public  ContactRepository contactRepositoryInstance;
    public AccountRepository accountRepositoryInstance;
    public PlansRepository  plansRepositoryInstance;
    public ContactCityGuideRepository contactCityGuideRepositoryInstance;
    public ContactService() {
        contactRepositoryInstance = ContactRepository.getInstance();
        accountRepositoryInstance = AccountRepository.getInstance();
        plansRepositoryInstance = PlansRepository.getInstance();
        contactCityGuideRepositoryInstance = ContactCityGuideRepository.getInstance();
    }

    public static ContactService getInstance() {
        if (instance == null) {
          instance = new ContactService();
        }
        return instance;
      }
     
      
    public Map<String,Object> checkContactPassword(Map<String, String> credentials, String app) {

      Map<String,Object> contactMap = new Map<String,Object>();
      String username = credentials.get('username');
      String password = credentials.get('password');
      String deviceToken= credentials.get('Device Token');
      Contact contact = contactRepositoryInstance.findByUsername(username);
      Account account = accountRepositoryInstance.findByAccountId(contact.AccountId);
      if(password.equals(contact.Password__c)) {
        if(credentials.get('Device Token')!=null){
          contact.Device_Token__c=credentials.get('Device Token');
          update contact;
        }
        contactMap.put('Status', 'Accepted');
        contactMap.put('First Name', contact.FirstName);
        contactMap.put('Last Name', contact.LastName);
        contactMap.put('Email', contact.Email);
        contactMap.put('Phone', contact.Phone);
        If(app.equals('orange')){
        contactMap.put('ID', contact.Orange_ID__c);
         }else{
        contactMap.put('ID', contact.Id);}
        contactMap.put('Account ID', Account.Id);
        if(!Account.Guest__c){
        contactMap.put('Total Points', Account.Balance__c +'');
        contactMap.put('Consumed Points', Account.Consumed__c+'');
        contactMap.put('Total Hold', Account.Total_Hold__c+'');}
        contactMap.put('Guest', Account.Guest__c+'');
        If(Account.Guest__c){
          List<Contact_City_Guide__c> contactCityGuide=contactCityGuideRepositoryInstance.FindAllCityGuidesbyContactAndActive(contact.Id);
          ContactCityGuideMapper mapperInstance=new ContactCityGuideMapper();
          List<ContactCityGuideMapper> contactCityGuideMapperList=mapperInstance.mapObjectListToMapper(contactCityGuide); 

          contactMap.put('CityGuide', contactCityGuideMapperList);
        }
        try{      
          Plan__c plan = plansRepositoryInstance.FindPlansById(Account.Plan__c);
          contactMap.put('MmeberShip', plan.Name);
        }catch(Exception e){
      

        }

     }else{
      throw new GeneralException('invalid password');
     }
   
     return contactMap;
  }

  public contact CreateRegisterContact(List<Object> contactDetails, Account account){

    List <Contact> contacts = new List<Contact>();
    Integer counter = 0;
    while (counter < contactDetails.size()){
      Map<String, Object> contactsmap = (Map<String, Object>) contactDetails.get(counter);
      Contact contact = new Contact( 
      FirstName=contactsmap.get('First Name')+'',
      LastName=contactsmap.get('Last Name')+'',
      Phone=contactsmap.get('Phone')+'',
      Email=contactsmap.get('Email')+'',
      Country__c=contactsmap.get('Country')+'',
      Password__c=contactsmap.get('Password')+'',
      UserName__c=contactsmap.get('Email')+'',
      AccountId=account.Id);

        contacts.add(contact);
        counter++;
    }
    insert contacts;
    return contacts.get(0);
  }

  public void updateContactInfo(List< Object> contactDetails, String app, String id){

    Map<String, Object> contactsmap = (Map<String, Object>) contactDetails.get(0);
    Contact contact = contactRepositoryInstance.findByRecordId(id);
   
      contact.FirstName = (String)contactsmap.get('First Name');
      contact.LastName = (String)contactsmap.get('Last Name');
      contact.Email = (String)contactsmap.get('Email');
      contact.Phone = (String)contactsmap.get('Phone');

      if(contactsmap.get('New Password') != null && contact.Password__c.equals(contactsmap.get('Password'))){
        contact.Password__c= (String)contactsmap.get('New Password');
      }
      else{
      throw new DMLException('Wrong Password');
    }
  
    update contact;
  }

  public void setNewPassword(List< Object> contactDetails){
    Map<String, Object> contactsmap = (Map<String, Object>) contactDetails.get(0);
    Contact contact = contactRepositoryInstance.findByUsername((String)contactsmap.get('username'));
      contact.Password__c =(String)contactsmap.get('password');
      update contact;
  }

 public List<Contact> getContactMembers( String id){
  Contact contact = contactRepositoryInstance.findByRecordId(id);
  List<Contact> members = contactRepositoryInstance.findByAccountId(contact.AccountId);
  return members;
 }


}