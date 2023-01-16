public class RequestMapper {
   
    Datetime AppointmentDateTime;
    String Requirments;
    String destination;
    Decimal adult;
    Decimal infant;
    Decimal child;
    String additionalDetails;
    Datetime dateAndTime;
    String category;
    String location;
    String eventName;
    String ticketType;
    String promoCode;
    Decimal numberOfTicket;
    Datetime startDate;
    Datetime endDate;
    Decimal numberOfTravelers;
    String slot;
    String operatinghours;
    String cancellationPolicy;

    static final String VALUE_Flight = 'Flight Management';
    static final String VALUE_Visa = 'Visa Management';
    static final String VALUE_Accommodation = 'Accommodation Management';
    static final String VALUE_Specialty_Travel = 'Specialty Travel Planning';
    static final String VALUE_Health_Vaccine = 'Health and Vaccine';
    static final String VALUE_Excursions_Experiences = 'Excursions Planning / Travel Experiences';
    static final String VALUE_Event_Ticketing= 'Event Ticketing';
    static final String VALUE_Dining = 'Dining & Nightspots Reservations';
    static final String VALUE_VIPAirport_Services = 'VIP Airport Services';
    static final String VALUE_TransportArrangement= 'Transport Arrangement - Booking';
    static final String VALUE_Education_Planning = 'Education Planning';
    static final String VALUE_LuxuryGoods_Sourcing = 'Luxury Goods Sourcing';
    static final String VALUE_Property_Estate = 'Property Management / Estate Management';
    static final String VALUE_Yacht_Watercraft_PrivateJetManagement = 'Yacht / Watercraft / Private Jet Management';
    static final String VALUE_Commodity_Consultancy= 'Commodity Consultancy';
    static final String VALUE_Security_CloseProtection = 'Security & Close Protection';
    static final String VALUE_AircraftCharters = 'Aircraft Charters';
    static final String VALUE_LuxuryBoat_MotorYacht = 'Luxury Sailing Boat & Motor Yacht Charters';
    static final String VALUE_PrivateEvent_SpecialCelebrations = 'Private Event Planning / Special Celebrations';
    static final String VALUE_PersonalShopping = 'Personal Shopping & Styling';
    static final String VALUE_PersonalMembership = 'Personal Membership Management';
    static final String VALUE_ExclusiveVIPEvents = 'Exclusive Access to VIP / Invite-Only Events';
    static final String VALUE_PrivateIslandRentals = 'Private Island Rentals';
    static final String VALUE_CarRentals = 'Rare, Sport & Vintage Car Rentals';
    static final String VALUE_HistoricalVenues = 'Private Access to Historical Venues';
    static final String VALUE_PropertySourcing= 'Property Sourcing';
    static final String VALUE_GlobalEventCalendar = 'Yearly Tailored Global Event Calendar';
    static final String VALUE_LongHolidays= ' Villa & Chalet Rentals - Long Holidays';
    ProductRepository productRepositoryInstance = ProductRepository.getInstance();
    public RequestMapper() {

    }

    public Opprtunity_Line_Item_Details__c CreateRequest(Map<String,Object> serviceDetails){
        Opprtunity_Line_Item_Details__c service = new Opprtunity_Line_Item_Details__c();
        String subType = (String)serviceDetails.get('subType');
        service.Type__c = productRepositoryInstance.findByName(subType).Family;
        service.Sub_Type__c = (String)serviceDetails.get('subType');


        if (subType.equals(VALUE_Flight)){

            service.Citizenship__c = (String)serviceDetails.get('Citizenship'); 
            service.Airline__c = (String)serviceDetails.get('Airline');
            service.Trip_type__c= (String)serviceDetails.get('Trip Type');
            service.Adult__c = (Decimal)serviceDetails.get('Adult');
            service.Child_0_2yr__c = (Decimal)serviceDetails.get('Infant');
            service.Child_3_12yr__c = (Decimal)serviceDetails.get('Child');
            service.Class__c=(String)serviceDetails.get('Class');
            service.Additional_Details__c  =(String)serviceDetails.get('Additional details');
            if(service.Trip_type__c.equals('One-way')|| service.Trip_type__c.equals('RoundTrip') ){
                service.Departure__c = (String)serviceDetails.get('Depart Departure'); 
                service.Destination__c = (String)serviceDetails.get('Depart Destination'); 
                service.Departure_Date__c = DateTime.parse((String)serviceDetails.get('Depart Departure Date'));
                service.Arival_Date__c= DateTime.parse((String)serviceDetails.get('Depart Arrival Date'));
            }
            if(service.Trip_type__c.equals('RoundTrip')){
                service.Departure_Date_1__c= DateTime.parse((String)serviceDetails.get('return Departure Date'));
                service.Arival_Date1__c= DateTime.parse((String)serviceDetails.get('return Arrival Date'));
            }
            if(service.Trip_type__c.equals('Multi-city')){
                service.Departure__c=(String)serviceDetails.get('Flight1 Departure'); 
                service.Destination__c=(String)serviceDetails.get('Flight1 Destination'); 
                service.Departure_Date__c= DateTime.parse((String)serviceDetails.get('Flight1 Departure Date'));
                service.Departure_1__c=(String)serviceDetails.get('Flight2 Departure'); 
                service.Destination_1__c=(String)serviceDetails.get('Flight2 Destination'); 
                service.Departure_Date_1__c= DateTime.parse((String)serviceDetails.get('Flight2 Departure Date'));
                service.Departure_2__c=(String)serviceDetails.get('Flight3 Departure'); 
                service.Destination_2__c=(String)serviceDetails.get('Flight3 Destination'); 
                service.Departure_Date_2__c= DateTime.parse((String)serviceDetails.get('Flight3 Departure Date'));
                service.Departure_3__c=(String)serviceDetails.get('Flight4 Departure'); 
                service.Destination_3__c=(String)serviceDetails.get('Flight4 Destination'); 
                service.Departure_Date_3__c= DateTime.parse((String)serviceDetails.get('Flight4 Departure Date'));
                service.Departure_4__c=(String)serviceDetails.get('Flight5 Departure'); 
                service.Destination_4__c=(String)serviceDetails.get('Flight5 Destination'); 
                service.Departure_Date_4__c= DateTime.parse((String)serviceDetails.get('Flight5 Departure Date'));

            }
            return service;
        }
        if (subType.equals(VALUE_Visa)){

            service.Arival_Date__c = Date.parse((String)serviceDetails.get('End Date'));
            service.Departure_Date__c = Date.parse((String)serviceDetails.get('Start Date'));
            service.Type_of_visa__c	= (String)serviceDetails.get('Type of visa');
            service.Citizenship__c = (String)serviceDetails.get('Citizenship'); 
            service.Adult__c = (Decimal)serviceDetails.get('Adult');
            service.Child_0_2yr__c = (Decimal)serviceDetails.get('Infant');
            service.Child_3_12yr__c = (Decimal)serviceDetails.get('Child');
            service.Additional_Details__c  =(String)serviceDetails.get('Additional details');

            return service;
        }
        if (subType.equals(VALUE_Accommodation)){
          
            service.Category__c = (String)serviceDetails.get('Category');
            service.Citizenship__c = (String)serviceDetails.get('Citizenship'); 
            service.Arival_Date__c = Date.parse((String)serviceDetails.get('Check in Date'));
            service.Departure_Date__c = Date.parse((String)serviceDetails.get('Check out Date'));
            service.Destination__c = (String)serviceDetails.get('Destination');
            service.Meal_Plan__c = (String)serviceDetails.get('Meal Plan');
            service.Bed_size__c = (String)serviceDetails.get('Bed Size');
            if (service.Category__c.equals('Hotel')){
            service.Booking__c= (Decimal)serviceDetails.get('Number of rooms');
            }else{
            service.Booking__c= (Decimal)serviceDetails.get('Number of guests');
            }
            service.Room__c = (Decimal)serviceDetails.get('Room Occupancy');
            service.Prefrence__c = (String)serviceDetails.get('Room Preference');
            service.Additional_Details__c  =(String)serviceDetails.get('Additional details');

            return service;
        }
        if (subType.equals(VALUE_Specialty_Travel)){

            service.Booking__c = (Decimal)serviceDetails.get('Number of travelers');
            service.Arival_Date__c = Date.parse((String)serviceDetails.get('End Date'));
            service.Departure_Date__c = Date.parse((String)serviceDetails.get('Start Date'));
            service.Category__c = (String)serviceDetails.get('Category');
            service.Destination__c = (String)serviceDetails.get('Destination');
            service.Additional_Details__c  =(String)serviceDetails.get('Additional details');

            return service;
        }
        if (subType.equals(VALUE_Health_Vaccine)){

            service.Category__c = (String)serviceDetails.get('Category');
            service.Destination__c = (String)serviceDetails.get('Destination');
            service.Adult__c = (Decimal)serviceDetails.get('Adult');
            service.Child_0_2yr__c = (Decimal)serviceDetails.get('Infant');
            service.Child_3_12yr__c = (Decimal)serviceDetails.get('Child');
            service.Arival_Date__c = DateTime.parse((String)serviceDetails.get('Date Time'));
            service.Additional_Details__c  = (String)serviceDetails.get('Preferences');
            
            return service;
        }
        if (subType.equals(VALUE_Excursions_Experiences)){

            service.Booking__c = (Decimal)serviceDetails.get('Number of Guests');
            service.Arival_Date__c = DateTime.parse((String)serviceDetails.get('Date Time'));
            service.Category__c = (String)serviceDetails.get('Category');
            service.Destination__c = (String)serviceDetails.get('Location');
            service.Additional_Details__c  =(String)serviceDetails.get('Additional details');

            return service;
        }
        if (subType.equals( VALUE_Event_Ticketing)){

            service.Event_Name__c = (String)serviceDetails.get('Event Name');
            service.Booking__c = (Decimal)serviceDetails.get('Number of Tickets');
            service.Arival_Date__c = DateTime.parse((String)serviceDetails.get('Date Time'));
            service.Category__c = (String)serviceDetails.get('Category');
            service.Ticket_Type__c= (String)serviceDetails.get('Ticket Type');
            service.Destination__c = (String)serviceDetails.get('Location');
            service.Promo_code__c = (String)serviceDetails.get('Promo Code');
            service.Additional_Details__c  =(String)serviceDetails.get('Additional details');
            
            return service;
        }
        if (subType.equals(VALUE_Dining)){

            service.Arival_Date__c = DateTime.parse((String)serviceDetails.get('Date Time'));
            service.Booking__c = (Decimal)serviceDetails.get('Number of Guests');
            service.Venu__c = (String)serviceDetails.get('Venue');
            service.Time_slot__c = (String)serviceDetails.get('Meal Period');
            service.Prefrence__c = (String)serviceDetails.get('Seating');
            service.Additional_Details__c  =(String)serviceDetails.get('Additional details');
           
            return service;
        }
        if (subType.equals( VALUE_VIPAirport_Services)){
            
            service.Category__c = (String)serviceDetails.get('Category');
            service.Arival_Date__c = DateTime.parse((String)serviceDetails.get('Date Time'));
            service.Booking__c = (Decimal)serviceDetails.get('Number of travelers');
            service.Flight_Number__c = (String)serviceDetails.get('Flight Number');
            service.Destination__c= (String)serviceDetails.get('Destination');
            service.Departure__c= (String)serviceDetails.get('Pick-up Address');
            service.Additional_Details__c  =(String)serviceDetails.get('Additional details');

            return service;

        }
        if (subType.equals( VALUE_TransportArrangement)){

            service.Arival_Date__c = DateTime.parse((String)serviceDetails.get('Date Time'));
            service.Booking__c = (Decimal)serviceDetails.get('Number of travelers');
            service.Category__c = (String)serviceDetails.get('Category');
            service.Departure__c = (String)serviceDetails.get('Pick-up Address');
            service.Destination__c= (String)serviceDetails.get('Drop-off Address');
            service.Transport_Type__c = (String)serviceDetails.get('Transportation Type');
            service.Additional_Details__c  =(String)serviceDetails.get('Additional details');

            return service;
        }
        if (subType.equals( VALUE_Education_Planning)){

            
        }
        if (subType.equals(VALUE_LuxuryGoods_Sourcing)){
            
        }
        if (subType.equals(VALUE_Property_Estate)){
            
        }
        if (subType.equals(VALUE_Yacht_Watercraft_PrivateJetManagement)){
            
        }
        if (subType.equals(VALUE_Commodity_Consultancy)){
            
        }
        if (subType.equals( VALUE_Security_CloseProtection)){
            
        }
        if (subType.equals(VALUE_AircraftCharters)){
            
        }
        if (subType.equals(VALUE_LuxuryBoat_MotorYacht)){
            
        }
        if (subType.equals(VALUE_PrivateEvent_SpecialCelebrations)){
            
        }
        if (subType.equals(VALUE_PersonalShopping)){
            
        }
        if (subType.equals(VALUE_PersonalMembership)){
            
        }
        if (subType.equals(VALUE_ExclusiveVIPEvents)){
            
        }
        if (subType.equals(VALUE_PrivateIslandRentals)){
            
        }
        if (subType.equals(VALUE_CarRentals)){
            
        }
        if (subType.equals(VALUE_HistoricalVenues)){
            
        }
        if (subType.equals(VALUE_PropertySourcing)){
            
        }
        if (subType.equals(VALUE_GlobalEventCalendar)){
            
        }
        if (subType.equals(VALUE_LongHolidays)){
            
        }
        service.Additional_Details__c  =(String)serviceDetails.get('Additional details');
        return service;
        
       
    }


     
    public RequestMapper RetriveRequest(Opprtunity_Line_Item_Details__c serviceDetails ){
        String subType = serviceDetails.Sub_Type__c;
        RequestMapper operationDetails = new RequestMapper();

        if (subType.equals(VALUE_Flight)){
             
        }
        if (subType.equals(VALUE_Visa)){

            operationDetails.AppointmentDateTime = serviceDetails.Arival_Date1__c;
            operationDetails.Requirments = serviceDetails.Request_Details__c;

        }
        if (subType.equals(VALUE_Accommodation)){
            
        }
        if (subType.equals(VALUE_Specialty_Travel)){

            operationDetails.startDate = serviceDetails.Arival_Date__c;
            operationDetails.endDate = serviceDetails.Departure_Date__c;
            operationDetails.destination = serviceDetails.Destination__c;
            operationDetails.numberOfTravelers = serviceDetails.Booking__c;
            operationDetails.category = serviceDetails.Category__c;
            operationDetails.additionalDetails = serviceDetails.Additional_Details__c;

            
        }
        if (subType.equals(VALUE_Health_Vaccine)){
            operationDetails.adult = serviceDetails.Adult__c;
            operationDetails.infant = serviceDetails.Child_0_2yr__c;
            operationDetails.child = serviceDetails.Child_3_12yr__c;
            operationDetails.additionalDetails = serviceDetails.Additional_Details__c;
            operationDetails.dateAndTime = serviceDetails.Arival_Date__c;
            operationDetails.destination = serviceDetails.Destination__c;
            operationDetails.category = serviceDetails.Category__c;
            
        }
        if (subType.equals(VALUE_Excursions_Experiences)){
            
            operationDetails.startDate = serviceDetails.Arival_Date__c;
            operationDetails.numberOfTravelers = serviceDetails.Booking__c;
            operationDetails.category = serviceDetails.Category__c;
            operationDetails.location = serviceDetails.Destination__c;
            operationDetails.additionalDetails = serviceDetails.Additional_Details__c;
            operationDetails.slot = serviceDetails.Request_Details__c;
            operationDetails.operatinghours = serviceDetails.Operation_Details__c;
            operationDetails.cancellationPolicy = serviceDetails.Cancellation_Policy__c;



        }
        if (subType.equals( VALUE_Event_Ticketing)){
            operationDetails.eventName = serviceDetails.Event_Name__c;
            operationDetails.dateAndTime = serviceDetails.Arival_Date__c;
            operationDetails.ticketType  = serviceDetails.Ticket_Type__c;
            operationDetails.additionalDetails = serviceDetails.Additional_Details__c;
            operationDetails.promoCode = serviceDetails.Promo_Code__c;
            operationDetails.category = serviceDetails.Category__c;
            operationDetails.location = serviceDetails.Destination__c;
            operationDetails.numberOfTicket = serviceDetails.Booking__c;

            
        }
        if (subType.equals(VALUE_Dining)){
            
        }
        if (subType.equals( VALUE_VIPAirport_Services)){
            
        }
        if (subType.equals( VALUE_TransportArrangement)){
            
        }
        if (subType.equals( VALUE_Education_Planning)){
            
        }
        if (subType.equals(VALUE_LuxuryGoods_Sourcing)){
            
        }
        if (subType.equals(VALUE_Property_Estate)){
            
        }
        if (subType.equals(VALUE_Yacht_Watercraft_PrivateJetManagement)){
            
        }
        if (subType.equals(VALUE_Commodity_Consultancy)){
            
        }
        if (subType.equals( VALUE_Security_CloseProtection)){
            
        }
        if (subType.equals(VALUE_AircraftCharters)){
            
        }
        if (subType.equals(VALUE_LuxuryBoat_MotorYacht)){
            
        }
        if (subType.equals(VALUE_PrivateEvent_SpecialCelebrations)){
            
        }
        if (subType.equals(VALUE_PersonalShopping)){
            
        }
        if (subType.equals(VALUE_PersonalMembership)){
            
        }
        if (subType.equals(VALUE_ExclusiveVIPEvents)){
            
        }
        if (subType.equals(VALUE_PrivateIslandRentals)){
            
        }
        if (subType.equals(VALUE_CarRentals)){
            
        }
        if (subType.equals(VALUE_HistoricalVenues)){
            
        }
        if (subType.equals(VALUE_PropertySourcing)){
            
        }
        if (subType.equals(VALUE_GlobalEventCalendar)){
            
        }
        if (subType.equals(VALUE_LongHolidays)){
            
        }

        return operationDetails;
    }


  /*public DateTime StringtoDate(String stringDateTime){
        List <String> listDateTime= stringDateTime.split(',');
        List <String> listDate= listDateTime.get(0).split('-');
            Date dt = Date.newInstance(integer.valueof(listDate.get(0)), integer.valueof(listDate.get(1)),integer.valueof(listDate.get(2)));
            Datetime dtt;
           
            String testDateString = '10/14/2011, 11:46 AM';
            DateTime testDateTime = DateTime.parse('10-14-2011, 11:46 AM');
            //Date testDate= Date.parse(testDateString);
            return testDateTime;
  }
  */
}


