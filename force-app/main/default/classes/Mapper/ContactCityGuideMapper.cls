/**
 * @description       : 
 * @author            : Mohamed Tarek
 * @group             : 
 * @last modified on  : 02-13-2023
 * @last modified by  : Mohamed Tarek
**/
Global  class ContactCityGuideMapper {
   public String Id;
   public String expiryDate;
   public String name;

   public ContactCityGuideMapper mapObjectToMapper(Contact_City_Guide__c guide){
    ContactCityGuideMapper cityGuideMapper=new ContactCityGuideMapper();
    cityGuideMapper.Id=guide.Id;
    cityGuideMapper.expiryDate=guide.End_Date__c.Day()+'/'+guide.End_Date__c.Month()+'/'+guide.End_Date__c.Year();
    cityGuideMapper.name=guide.Name;
    return cityGuideMapper;
   }

   global ContactCityGuideMapper[] mapObjectListToMapper(List<Contact_City_Guide__c> contactCityGuideObjectList){
    List<ContactCityGuideMapper> contactCityGuideList=new List<ContactCityGuideMapper>();
    for(Contact_City_Guide__c cityGuide:contactCityGuideObjectList){
        contactCityGuideList.add(mapObjectToMapper(cityGuide));
    }
    return contactCityGuideList;
   }
}