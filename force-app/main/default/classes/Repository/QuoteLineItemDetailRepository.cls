public class QuoteLineItemDetailRepository {
    private static QuoteLineItemDetailRepository instance = null;
    private QuoteLineItemDetailRepository(){}

    public static QuoteLineItemDetailRepository getInstance() {
        if (instance == null) {
          instance = new QuoteLineItemDetailRepository();
        }
        return instance;
      }
      public List<Quote_Line_Item_Detail__c> findAllQuoteLineItemDetails(){
        return [
            SELECT
            Airline__c,
            Airline2__c,
            Airline4__c,
            Airline1__c,
            Airline3__c,
            Airport__c,
            Arival_Date__c,
            Arival_Date4__c,
            Arival_Date1__c,
            Arival_Date2__c,
            Arival_Date3__c,
            Bed_size__c,
            Catalogue__c,
            Class__c,
            Class1__c,
            Class2__c,
            Class3__c,
            Class4__c,
            Departure__c,
            Departure1__c,
            Departure2__c,
            Departure3__c,
            Departure4__c,
            Departure_Date__c,
            Departure_Date1__c,
            Departure_Date2__c,
            Departure_Date3__c,
            Departure_Date4__c,
            Description__c,
            Destination__c,
            Destination1__c,
            Destination2__c,
            Destination3__c,
            Destination4__c,
            Event_Name__c,
            Hotel__c,
            List_Price__c,
            Meal_Plan__c,
            Bookings__c,
            Opportunity_Line_Item_Details__c,
            Preferences__c,
            Quote__c,
            Name,
            Room__c,
            Sales_Price__c,
            Service_Name__c,
            SubType__c,
            Supplier__c,
            Transport_Type__c,
            Trip_type__c,
            Venu__c
            FROM Quote_Line_Item_Detail__c
        ];
      }

      public List<Quote_Line_Item_Detail__c> findQuoteLineItemDetailBy(Id opportunityLineItemDetails){
        return [
            SELECT
            Airline__c,
            Airline2__c,
            Airline4__c,
            Airline1__c,
            Airline3__c,
            Airport__c,
            Arival_Date__c,
            Arival_Date4__c,
            Arival_Date1__c,
            Arival_Date2__c,
            Arival_Date3__c,
            Bed_size__c,
            Catalogue__c,
            Class__c,
            Class1__c,
            Class2__c,
            Class3__c,
            Class4__c,
            Departure__c,
            Departure1__c,
            Departure2__c,
            Departure3__c,
            Departure4__c,
            Departure_Date__c,
            Departure_Date1__c,
            Departure_Date2__c,
            Departure_Date3__c,
            Departure_Date4__c,
            Description__c,
            Destination__c,
            Destination1__c,
            Destination2__c,
            Destination3__c,
            Destination4__c,
            Event_Name__c,
            Hotel__c,
            List_Price__c,
            Meal_Plan__c,
            Bookings__c,
            Opportunity_Line_Item_Details__r.Category__c,
            Preferences__c,
            Quote__c,
            Name,
            Room__c,
            Sales_Price__c,
            Service_Name__c,
            SubType__c,
            Supplier__c,
            Transport_Type__c,
            Trip_type__c,
            Venu__c,
            Opportunity_Line_Item_Details__c
            FROM Quote_Line_Item_Detail__c
            WHERE Opportunity_Line_Item_Details__c =:opportunityLineItemDetails
        ];
      }
}