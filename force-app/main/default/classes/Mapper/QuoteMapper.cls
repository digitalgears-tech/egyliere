global class QuoteMapper {
String id;
String status;
String airline;
String airline2;
String airline4;
String airline1;
String airline3;
String airport;
DateTime arivalDate;
DateTime arivalDate4;
DateTime arivalDate1;
DateTime arivalDate2;
DateTime arivalDate3;
String bedSize;
String Catalogue;
String class0;
String class1;
String class2;
String class3;
String class4;
String departure;
String departure1;
String departure2;
String departure3;
String departure4;
DateTime departureDate;
DateTime departureDate1;
DateTime departureDate2;
DateTime departureDate3;
DateTime departureDate4;
String description;
String destination;
String destination1;
String destination2;
String destination3;
String destination4;
String eventName;
String hotel;
Decimal listPrice;
String mealPlan;
Decimal Bookings;
String preferences;
String name;
Decimal room;
Decimal salesPrice;
String serviceName;
String subType;
String Supplier;
String transportType;
String triptype;
String venu;

public QuoteMapper() {

    }
    public QuoteMapper quoteObjectToMapper(Quote_Line_Item_Detail__c quoteLineItemDetails, QuoteLineItem quoteLineItem){
        QuoteMapper mapper =new QuoteMapper();
        mapper.id = quoteLineItem.QuoteId;
        mapper.status = quoteLineItem.Quote.Status;
        mapper.Catalogue = quoteLineItemDetails.Catalogue__c;
        mapper.Supplier	= quoteLineItemDetails.Supplier__c;
        mapper.subType	= quoteLineItemDetails.SubType__c;
        mapper.salesPrice =	quoteLineItem.TotalPrice;		
        mapper.description = quoteLineItemDetails.Description__c;		

        if(quoteLineItem.Product2.Name.equals('Flight Management')){
            mapper.triptype	= quoteLineItemDetails.Trip_type__c;		
            mapper.airline = quoteLineItemDetails.Airline__c;		
            mapper.airline2	= quoteLineItemDetails.Airline2__c;		
            mapper.airline4	= quoteLineItemDetails.Airline4__c;		
            mapper.airline1	= quoteLineItemDetails.Airline1__c;		
            mapper.airline3	= quoteLineItemDetails.Airline3__c;		
            mapper.airport	= quoteLineItemDetails.Airport__c;		
            mapper.arivalDate =	quoteLineItemDetails.Arival_Date__c;		
            mapper.arivalDate4 = quoteLineItemDetails.Arival_Date4__c;		
            mapper.arivalDate1	= quoteLineItemDetails.Arival_Date1__c;		
            mapper.arivalDate2	= quoteLineItemDetails.Arival_Date2__c;		
            mapper.arivalDate3	= quoteLineItemDetails.Arival_Date3__c;	
            mapper.class0 = quoteLineItemDetails.Class__c;		
            mapper.class1 =	quoteLineItemDetails.Class1__c;		
            mapper.class2 = quoteLineItemDetails.Class2__c;		
            mapper.class3 =	quoteLineItemDetails.Class3__c;		
            mapper.class4 =	quoteLineItemDetails.Class4__c;		
            mapper.departure =	quoteLineItemDetails.Departure__c;		
            mapper.departure1 =	quoteLineItemDetails.Departure1__c;		
            mapper.departure2 =	quoteLineItemDetails.Departure2__c;		
            mapper.departure3 =	quoteLineItemDetails.Departure3__c;		
            mapper.departure4 =	quoteLineItemDetails.Departure4__c;		
            mapper.departureDate =	quoteLineItemDetails.Departure_Date__c;		
            mapper.departureDate1 =	quoteLineItemDetails.Departure_Date1__c;		
            mapper.departureDate2 =	quoteLineItemDetails.Departure_Date2__c;		
            mapper.departureDate3 =	quoteLineItemDetails.Departure_Date3__c;		
            mapper.departureDate4 =	quoteLineItemDetails.Departure_Date4__c;		
            mapper.destination = quoteLineItemDetails.Destination__c;		
            mapper.destination1 = quoteLineItemDetails.Destination1__c;		
            mapper.destination2	= quoteLineItemDetails.Destination2__c;		
            mapper.destination3	= quoteLineItemDetails.Destination3__c;		
            mapper.destination4	= quoteLineItemDetails.Destination4__c;		
            return mapper;
        }
        if(quoteLineItem.Product2.Name.equals('Accommodation Management')){

            mapper.arivalDate =	quoteLineItemDetails.Arival_Date__c;
            mapper.departureDate =	quoteLineItemDetails.Departure_Date__c;		
            mapper.destination = quoteLineItemDetails.Destination__c;			
            mapper.mealPlan	= quoteLineItemDetails.Meal_Plan__c;

            if(mapper.subType.equals('Hotel')){
            mapper.hotel = quoteLineItemDetails.Hotel__c;	
            mapper.bedSize	= quoteLineItemDetails.Bed_size__c;		
            mapper.Bookings	= quoteLineItemDetails.Bookings__c;	
            mapper.room	= quoteLineItemDetails.Room__c;
            mapper.preferences	= quoteLineItemDetails.Preferences__c;
        }else{	
            mapper.Bookings	= quoteLineItemDetails.Bookings__c;	
            mapper.room	= quoteLineItemDetails.Room__c;}

            return mapper;
        }
  	
        if(quoteLineItem.Product2.Name.equals('Transport Arrangement - Booking')){
            mapper.departure =	quoteLineItemDetails.Departure__c;	
            mapper.destination = quoteLineItemDetails.Destination__c;	
            mapper.arivalDate =	quoteLineItemDetails.Arival_Date__c;
            mapper.transportType = quoteLineItemDetails.Transport_Type__c;		
            return mapper;
        }
        if(quoteLineItem.Product2.Name.equals('Event Ticketing')){
            mapper.eventName =	quoteLineItemDetails.Event_Name__c;			
            return mapper;
        }
        if(quoteLineItem.Product2.Name.equals('Dining & Nightspots Reservations')){
            mapper.venu	= quoteLineItemDetails.Venu__c;	
            return mapper;
        }
		
            

        return mapper;
    }

    public  List<QuoteMapper> quoteObjectListToMapperList( List<Quote_Line_Item_Detail__c> quoteLineItemDetails, Map<Id,QuoteLineItem> quoteLineItemDetailsIdQuoteLineItem){

        List<QuoteMapper> mapperList = new List<QuoteMapper>();

        for( Quote_Line_Item_Detail__c q : quoteLineItemDetails ){

            mapperList.add(quoteObjectToMapper(q,quoteLineItemDetailsIdQuoteLineItem.get(q.Id)));
        }

        return mapperList;
      }

}
