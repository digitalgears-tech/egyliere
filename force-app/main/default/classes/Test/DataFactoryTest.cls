/**
 * @description       : 
 * @author            : Mohamed Tarek
 * @group             : 
 * @last modified on  : 02-15-2023
 * @last modified by  : Mohamed Tarek
**/
@isTest
public class DataFactoryTest {
    private static DataFactoryTest instance;


    private DataFactoryTest() {

    }

    public static DataFactoryTest getInstance(){
        if(instance == null){
            instance = new DataFactoryTest();
        }
        return instance;
    }
    
    public Account CreateAccount(String firstName, String lastName){
        Account account = new Account(
            Name = firstName + '  ' + lastName,
            Type= 'Prospect');
        insert account;
        return account;
    } 
    public Contact CreateContact(String firstName, String lastName, String password, String email, String accountId){
        Contact contact = new Contact( 
            FirstName=firstName,
            LastName=lastName,
            Password__c=password,
            UserName__c=email,
            AccountId=accountId);
        insert contact;
        return contact;
    } 

    public Membership__c CreateExternalMemberShip(Contact contact, Date expirationDate, String membershipID, String membershipProvider){
         Membership__c	membership = new Membership__c( 
            Contact__c=contact.Id,
            Expiration_Date__c=expirationDate,
            Name=membershipID,
            MemberShip_Provider__c=membershipProvider);
        insert membership;
        return membership;
    } 
    public City_Guide__c CreateCityGuide(String cityGuideName, String city, Integer duration, Decimal price){
        City_Guide__c	CityGuide = new City_Guide__c( 
           Name=cityGuideName,
           City__c=city,
           Duration__c=duration,
           Price__c=price);
       insert CityGuide;
       return CityGuide;
   } 
    public Contact_City_Guide__c CreateContactCityGuide(Contact contact, City_Guide__c cityGuide, Date startDate, Date endDate){
        Contact_City_Guide__c	contactCityGuide = new Contact_City_Guide__c( 
           Contact__c=contact.Id,
           City_Guide__c=cityGuide.Id,
           End_Date__c=endDate,
           Start_Date__c=startDate);
       insert contactCityGuide;
       return contactCityGuide;
   } 

   public Catalogue__c CreateCatalogue( String recordType ,String name, String logo, String city){
    Id recordTypeId = Schema.SObjectType.Catalogue__c.getRecordTypeInfosByName().get(recordType).getRecordTypeId();
    Catalogue__c catalogue = new Catalogue__c( 
       Name=name,
       Logo__c=logo,
       City__c=city,
       RecordTypeId=recordTypeId);
   insert catalogue;
   return catalogue;
} 
public Publication__c CreatePublication( String tag ,String name){
    Publication__c publication = new Publication__c( 
       Name=name,
       Tag__c=tag,
       Active__c = true);
   insert publication;
   return publication;
} 
public Plan__c CreatePlan(String planName, Integer points){
    Plan__c	plan = new Plan__c( 
       Name=planName,
       Points__c=points);
   insert plan;
   return plan;
} 
public Case CreateCase(String contactId	, String accountId){
    Id recordTypeId = Schema.SObjectType.Catalogue__c.getRecordTypeInfosByName().get('Reservation').getRecordTypeId();
    Case caseTest = new Case( 
       ContactId= contactId,
       AccountId=accountId,
       Origin='Web',
       Status='Paid',
       RecordTypeId=recordTypeId);
   insert caseTest;
   return caseTest;
} 
public Opprtunity_Line_Item_Details__c createOpprtunity_Line_Items_Details(String type,String subtype,DateTime arrival,DateTime departure){
    Opprtunity_Line_Item_Details__c opprtunityLineItemDetailsMock=new Opprtunity_Line_Item_Details__c();
    opprtunityLineItemDetailsMock.Type__c=type;
    opprtunityLineItemDetailsMock.Sub_Type__c=subType;
    opprtunityLineItemDetailsMock.Arival_Date__c=arrival;
    opprtunityLineItemDetailsMock.Departure_Date__c=departure;
    insert opprtunityLineItemDetailsMock;
    return opprtunityLineItemDetailsMock;
}
public Help_QA__c createHelp(String type,String category,String header,String body){
    Help_QA__c helpMock=new Help_QA__c();
    helpMock.Type__c=type;
    helpMock.Category__c=null;
    helpMock.Header__c=header;
    helpMock.Body__c=body;
    insert helpMock;
    return helpMock;
}

 
}