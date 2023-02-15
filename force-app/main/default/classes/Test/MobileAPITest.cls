/**
 * @description       : 
 * @author            : Mohamed Tarek
 * @group             : 
 * @last modified on  : 02-15-2023
 * @last modified by  : Mohamed Tarek
**/
@istest
public class MobileAPITest {
   
    public MobileAPITest() {

    }

    @istest
  static void TestEventsAPI() {
    DataFactoryTest dataFactory = DataFactoryTest.getInstance();
    dataFactory.CreatePublication('Concerts','Tamer Hosney');
    RestRequest req = new RestRequest(); 
    RestResponse res = new RestResponse();

    req.requestURI = '/PublicationListAPI';  
    req.httpMethod = 'GET';
    req.params.put('App', 'Internal');
    RestContext.request = req;
    RestContext.response = res;
    Test.startTest();
    PublicationAPI.upsertPublication();
    Test.stopTest();

  }

  @istest
  static void TestPerferencesListAPI() {
    RestRequest req = new RestRequest(); 
    RestResponse res = new RestResponse();
    req.requestURI = '/PerferencesList';  
    req.httpMethod = 'GET';
    req.params.put('App', 'Internal');
    RestContext.request = req;
    RestContext.response = res;
    Test.startTest();
    PerferenceAPI.sendPerferencesList();
    Test.stopTest();
    
  }

  @istest
  static void TestCustomerPerferencesListAPI() {
    DataFactoryTest dataFactory = DataFactoryTest.getInstance();
    Account account = dataFactory.CreateAccount('Test', '1');
    Contact contact = dataFactory.CreateContact('Test', '1', '1234','Test1@test.com',account.Id);
    RestRequest req = new RestRequest(); 
    RestResponse res = new RestResponse();
    req.requestURI = '/CustomerPerferencesList';  
    req.httpMethod = 'GET';
    req.params.put('App', 'Internal');
    req.params.put('recordID', contact.Id);
    RestContext.request = req;
    RestContext.response = res;
    Test.startTest();
    CustomerPerferenceAPI.sendContactPerferencesList();
    Test.stopTest();
    
  }

  @istest
  static void TestCustomerPerferencesListUpdateAPI() {
    DataFactoryTest dataFactory = DataFactoryTest.getInstance();
    Account account = dataFactory.CreateAccount('Test', '1');
    Contact contact = dataFactory.CreateContact('Test', '1', '1234','Test1@test.com',account.Id);
    RestRequest req = new RestRequest(); 
    RestResponse res = new RestResponse();
    req.requestURI = '/CustomerPerferencesList';  
    req.httpMethod = 'POST';
    req.params.put('App', 'Internal');
    req.params.put('recordID', contact.Id);
    RestContext.request = req;
    RestContext.response = res;
    Map<String, List<String>> preference = new Map<String, List<String>>();
    List<String> preferenceDetails = new List<String>();
    preferenceDetails.add('Water Sports');
    preference.put('Adventure',preferenceDetails);
    Test.startTest();
    CustomerPerferenceAPI.setContactPerferencesList(preference);
    Test.stopTest();
    
  }


  @istest
  static void TestPlansAPI() {
    DataFactoryTest dataFactory = DataFactoryTest.getInstance();
    dataFactory.CreatePlan('Dedicated Private',750);
    RestRequest req = new RestRequest(); 
    RestResponse res = new RestResponse();
    req.requestURI = '/PlansAPI';  
    req.httpMethod = 'GET';
    req.params.put('App', 'Internal');
    RestContext.request = req;
    RestContext.response = res;
    Test.startTest();
    PlansAPI.getPlansDetails();
    Test.stopTest();
    
  }

  @istest
  static void TestCustomerLoginAPI() {
    DataFactoryTest dataFactory = DataFactoryTest.getInstance();
    Account account = dataFactory.CreateAccount('Test', '1');
    Contact contact = dataFactory.CreateContact('Test', '1', '1234','Test1@test.com',account.Id);
    RestRequest req = new RestRequest(); 
    RestResponse res = new RestResponse();
    req.requestURI = '/CustomerLoginAPI';  
    req.httpMethod = 'POST';
    req.params.put('App', 'Internal');
    RestContext.request = req;
    RestContext.response = res;
    Map<String, String> credentials = new Map<String, String>();
    credentials.put('username',contact.UserName__c);
    credentials.put('password',contact.Password__c);
    Test.startTest();
    CustomerLoginAPI.contactLogin(credentials);
    Test.stopTest();
    
  }

  @istest
  static void TestGetExternalMembershipsAPI() {
    DataFactoryTest dataFactory = DataFactoryTest.getInstance();
    Account account = dataFactory.CreateAccount('Test', '1');
    Contact contact = dataFactory.CreateContact('Test', '1', '1234','Test1@test.com',account.Id);
    dataFactory.CreateExternalMemberShip(contact, date.today(),'1234','test');
    RestRequest req = new RestRequest(); 
    RestResponse res = new RestResponse();
    req.requestURI = '/ExternalMembershipsAPI';  
    req.httpMethod = 'GET';
    req.params.put('App', 'Internal');
    req.params.put('recordID', contact.Id);
    RestContext.request = req;
    RestContext.response = res;
    Test.startTest();
    ExternalMembershipsAPI.getCustomerExternalMemberships();
    Test.stopTest();
    
  }

  @istest
  static void TestSetExternalMembershipsAPI() {
    DataFactoryTest dataFactory = DataFactoryTest.getInstance();
    Account account = dataFactory.CreateAccount('Test', '1');
    Contact contact = dataFactory.CreateContact('Test', '1', '1234','Test1@test.com',account.Id);
    String jsonString = '[' + '{' +'"memberShipProvider": "CIB Wealth",'+
    '"memberShipId": "1234567",'+'"id": "a0D7X000002674GUAQ",'+
    '"expirationDate": "10/14/2011"'+'}'+' ]';
    RestRequest req = new RestRequest(); 
    RestResponse res = new RestResponse();
    req.requestURI = '/ExternalMembershipsAPI';  
    req.httpMethod = 'POST';
    req.params.put('App', 'Internal');
    req.params.put('recordID', contact.Id);
    req.requestBody =blob.valueOf(jsonString);
    RestContext.request = req;
    RestContext.response = res;
    Test.startTest();
    ExternalMembershipsAPI.SetCustomerExternalMemberships();
    Test.stopTest();
    
  }
  @istest
  static void TestDeleteExternalMembershipsAPI() {
    DataFactoryTest dataFactory = DataFactoryTest.getInstance();
    Account account = dataFactory.CreateAccount('Test', '1');
    Contact contact = dataFactory.CreateContact('Test', '1', '1234','Test1@test.com',account.Id);
    Membership__c memberShips = dataFactory.CreateExternalMemberShip(contact,date.today(),'1234567','CIB Wealth');
    String jsonString = '[' + '{' +'"memberShipProvider": "CIB Wealth",'+
    '"memberShipId": "1234567",'+'"id": "a0D7X000002674GUAQ",'+
    '"expirationDate": "10/14/2011"'+'}'+' ]';
    RestRequest req = new RestRequest(); 
    RestResponse res = new RestResponse();
    req.requestURI = '/ExternalMembershipsAPI';  
    req.httpMethod = 'DELETE';
    req.params.put('App', 'Internal');
    req.params.put('recordID', contact.Id);
    req.requestBody =blob.valueOf(jsonString);
    RestContext.request = req;
    RestContext.response = res;
    Test.startTest();
    ExternalMembershipsAPI.DeleteCustomerExternalMemberships();
    Test.stopTest();
    
  }

  @istest
  static void TestSubscribeAPI() {
    DataFactoryTest dataFactory = DataFactoryTest.getInstance();
    Account account = dataFactory.CreateAccount('Test', '1');
    Contact contact = dataFactory.CreateContact('Test', '1', '1234','Test1@test.com',account.Id);
    dataFactory.CreatePlan('Dedicated Private',750);
    RestRequest req = new RestRequest(); 
    RestResponse res = new RestResponse();
    String jsonString = '[' + '{' +' "price": 5500,'+
    '"points": 750,'+'"name": "Dedicated Private",'+
    '"logo": []'+'}'+' ]';
    req.requestURI = '/SubscribeAPI';  
    req.httpMethod = 'POST';
    req.params.put('App', 'Internal');
    req.params.put('recordID', contact.Id);
    RestContext.request = req;
    RestContext.response = res;
    req.requestBody =blob.valueOf(jsonString);
    Test.startTest();
    SubscribeAPI.CreateSubscribtionRequest();
    Test.stopTest();
    
  }

  @istest
  static void TestRegisterAPI() {
    RestRequest req = new RestRequest(); 
    RestResponse res = new RestResponse();
    String jsonString = '[' + '{' +'"First Name": "Rania",'+
    '"Last Name": "Shawaay",'+'"Email": "RShawaay@tech.com",'+
    '"Phone": "01006030650",'+'"Password" : "123456"'+'}'+' ]';
    req.requestURI = '/RegisterAPI';  
    req.httpMethod = 'POST';
    req.params.put('App', 'Internal');
    RestContext.request = req;
    RestContext.response = res;
    req.requestBody =blob.valueOf(jsonString);
    Test.startTest();
    RegisterAPI.setRegisterRequest();
    Test.stopTest();
    
  }

  @istest
  static void TestCreateRequestAPI() {
    DataFactoryTest dataFactory = DataFactoryTest.getInstance();
    Account account = dataFactory.CreateAccount('Test', '1');
    Contact contact = dataFactory.CreateContact('Test', '1', '1234','Test1@test.com',account.Id);
    RestRequest req = new RestRequest(); 
    RestResponse res = new RestResponse();
    String jsonString = '[' + '{' +' "subType": "Visa Management",'+
    '"Citizenship": "Egyption",'+' "Type of visa": "US",'+'"Adult": 1,'+
    '"Child": 2,'+'"Infant": 1,'+'"End Date":"11/23/2023",'+'"Start Date":"9/19/2023"'+'},'
    +'{'+'"subType": "Health and Vaccine",'+'"Category": "PCR",'
    +' "Destination": "Egypt",'+'"Adult": 1,'+
    '"Child": 2,'+'"Infant": 1,'+'  "Preferences":" ",'+'"Date Time":"11/22/2023, 03:00 AM"'+'}'+' ]';
    req.requestURI = '/CreateRequestAPI';  
    req.httpMethod = 'POST';
    req.params.put('App', 'Internal');
    req.params.put('recordID', contact.Id);
    RestContext.request = req;
    RestContext.response = res;
    req.requestBody =blob.valueOf(jsonString);
    Test.startTest();
    CreateRequestAPI.CreateRequest();
    Test.stopTest();
    
  }

  @istest
  static void TestUpdateProfileAPI() {
    DataFactoryTest dataFactory = DataFactoryTest.getInstance();
    Account account = dataFactory.CreateAccount('Test', '1');
    Contact contact = dataFactory.CreateContact('Test', '1', '1234','Test1@test.com',account.Id);
    RestRequest req = new RestRequest(); 
    RestResponse res = new RestResponse();
    String jsonString = '[' + '{' +'"First Name": "Test",'+
    '"Last Name": "1",'+' "Email": "Test1@test.com",'+
    '"Phone": "01009999999",'+'"Password" : "1234"'+'}'+' ]';
    req.requestURI = '/UpdateProfileAPI';  
    req.httpMethod = 'POST';
    req.params.put('App', 'Internal');
    req.params.put('recordID', contact.Id);
    RestContext.request = req;
    RestContext.response = res;
    req.requestBody =blob.valueOf(jsonString);
    Test.startTest();
    UpdateProfileAPI.UpdateProfile();
    Test.stopTest();
    
  }

  @istest
  static void TestCatalogueListAPI() {
    DataFactoryTest dataFactory = DataFactoryTest.getInstance();
    DataFactory.CreateCatalogue('Accommodation','Marriott Marbella Beach Resort Hotel','src="https://egylieretravel--dev.sandbox.file.force.com/servlet/rtaImage?eid=a017X00000CPnM2&amp;feoid=00N7X000003itop&amp;refid=0EM7X000000Dhfy"','Spain');
    RestRequest req = new RestRequest(); 
    RestResponse res = new RestResponse();
    req.requestURI = '/CatalogueListAPI';  
    req.httpMethod = 'GET';
    req.params.put('App', 'Internal');
    req.params.put('Type', 'Accommodation');
    RestContext.request = req;
    RestContext.response = res;
    Test.startTest();
    CatalogueAPI.getCatalogueList();
    Test.stopTest();
    
  }

  @istest
  static void TestSetCityGuideDetailsAPI() {
    DataFactoryTest dataFactory = DataFactoryTest.getInstance();
    Account account = dataFactory.CreateAccount('Test', '1');
    Contact contact = dataFactory.CreateContact('Test', '1', '1234','Test1@test.com',account.Id);
    City_Guide__c cityGuide = dataFactory.CreateCityGuide('cityGuideName',  'city', 30, 20);
    RestRequest req = new RestRequest(); 
    RestResponse res = new RestResponse();
    String jsonString = '{' +'"cityGuide":"'+cityGuide.Id+'"'+'}';
    req.requestURI = '/CityGuideDetailsAPI';  
    req.httpMethod = 'POST';
    req.params.put('App', 'Internal');
    req.params.put('recordID', contact.Id);
    RestContext.request = req;
    RestContext.response = res;
    req.requestBody =blob.valueOf(jsonString);
    Test.startTest();
    CityGuideDetailsAPI.setCityGuide();
    Test.stopTest();
    
  }

  @istest
  static void TestGetCityGuideDetailsAPI() {
    DataFactoryTest dataFactory = DataFactoryTest.getInstance();
    Account account = dataFactory.CreateAccount('Test', '1');
    Contact contact = dataFactory.CreateContact('Test', '1', '1234','Test1@test.com',account.Id);
    City_Guide__c cityGuide = dataFactory.CreateCityGuide('cityGuideName',  'city', 30, 20);
    RestRequest req = new RestRequest(); 
    RestResponse res = new RestResponse();
    String jsonString = '{' +'"cityGuide":"'+cityGuide.Id+'"'+'}';
    req.requestURI = '/CityGuideDetailsAPI';  
    req.httpMethod = 'GET';
    req.params.put('App', 'Internal');
    req.params.put('recordID', contact.Id);
    RestContext.request = req;
    RestContext.response = res;
    req.requestBody =blob.valueOf(jsonString);
    Test.startTest();
    CityGuideDetailsAPI.getAllCityGuideDetails();
    Test.stopTest();
    
  }


  @istest
  static void TestCityGuideAPI() {
    DataFactoryTest dataFactory = DataFactoryTest.getInstance();
    City_Guide__c cityGuide = dataFactory.CreateCityGuide('cityGuideName',  'city', 30, 20);
    RestRequest req = new RestRequest(); 
    RestResponse res = new RestResponse();
    req.requestURI = '/CityGuideAPI';  
    req.httpMethod = 'GET';
    req.params.put('App', 'Internal');
    RestContext.request = req;
    RestContext.response = res;
    Test.startTest();
    CityGuideAPI.getAllCityGuide();
    Test.stopTest();
    
  }

  @istest
  static void TestMyBookingsAPI() {
    DataFactoryTest dataFactory = DataFactoryTest.getInstance();
    Account account = dataFactory.CreateAccount('Test', '1');
    Contact contact = dataFactory.CreateContact('Test', '1', '1234','Test1@test.com',account.Id);
    RestRequest req = new RestRequest(); 
    RestResponse res = new RestResponse();
    req.requestURI = '/MyBookingsAPI';  
    req.httpMethod = 'GET';
    req.params.put('App', 'Internal');
    req.params.put('recordID', contact.Id);
    RestContext.request = req;
    RestContext.response = res;
    Test.startTest();
    MyBookingsAPI.getAllService();
    Test.stopTest();
    
  }
  @istest
  static void TestRequestSelectionListAPI() {
    RestRequest req = new RestRequest(); 
    RestResponse res = new RestResponse();
    req.requestURI = '/RequestSelectionListAPI';  
    req.httpMethod = 'GET';
    req.params.put('App', 'Internal');
    req.params.put('Type', 'Visa Management');
    RestContext.request = req;
    RestContext.response = res;
    Test.startTest();
    RequestSelectionListAPI.getRequestSelectionList();
    Test.stopTest();
    
  }

  @istest
  static void TestHelpApi() {
    RestRequest req = new RestRequest(); 
    RestResponse res = new RestResponse();
    DataFactoryTest dataFactory = DataFactoryTest.getInstance();
    dataFactory.createHelp('Help',null,'Testing?','Yes testing');
    req.requestURI = '/Help';  
    req.httpMethod = 'GET';
    req.params.put('Type', 'Help');
    RestContext.request = req;
    RestContext.response = res;
    Test.startTest();
    HelpApi.getHelpByType();
    Test.stopTest();
    
  }
}