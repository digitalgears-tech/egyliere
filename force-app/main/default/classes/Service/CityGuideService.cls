public class CityGuideService {
    private static CityGuideService instance = null;
    CityGuideRepository cityGuideRepositoryInstance;
    public  ContactRepository contactRepositoryInstance;
    public CityGuideMapper cityGuideMapper = new CityGuideMapper();


    public CityGuideService() {
        cityGuideRepositoryInstance = CityGuideRepository.getInstance();
        contactRepositoryInstance = ContactRepository.getInstance();
    }

    public static CityGuideService getInstance() {
        if (instance == null) {
          instance = new CityGuideService();
        }
        return instance;
      }
    
      public List<CityGuideMapper> GetCityGuideList() {
        List<City_Guide__c> cityGuideObjectList = cityGuideRepositoryInstance.FindAllCityGuides();
        return CityGuideMapper.CityGuideobjectListToMapperList(cityGuideObjectList);
 
       }

       public void SetContactCityGuideList(String contactId, String cityGuideId) {
        City_Guide__c cityGuide =cityGuideRepositoryInstance.FindAllCityGuideById(cityGuideId);
        Contact contact = contactRepositoryInstance.findByRecordId(contactId);
        Contact_City_Guide__c contactCityGuideObjectList = new Contact_City_Guide__c();
        contactCityGuideObjectList.Contact__c = contact.Id;
        contactCityGuideObjectList.City_Guide__c = cityGuideId;
        contactCityGuideObjectList.Start_Date__c = date.today();
        if(!(cityGuide.Duration__c== null)){
        contactCityGuideObjectList.End_Date__c = date.today().addDays((Integer)cityGuide.Duration__c);}
        contactCityGuideObjectList.Active__c = true;
         
        insert contactCityGuideObjectList;
 
       }

}