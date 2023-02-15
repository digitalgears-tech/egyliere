global class QuoteMapper {

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
String room;
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
        return null;
    }
    public  List<QuoteMapper> quoteObjectListToMapperList( List<Quote_Line_Item_Detail__c> quoteLineItemDetails, Map<Id,QuoteLineItem> quoteLineItemDetailsIdQuoteLineItem){

        List<QuoteMapper> mapperList = new List<QuoteMapper>();

        for( Quote_Line_Item_Detail__c q : quoteLineItemDetails ){

            mapperList.add(quoteObjectToMapper(q,quoteLineItemDetailsIdQuoteLineItem.get(q.Id)));
        }

        return mapperList;
      }

}
