/**
 * @description       :
 * @author            : Ahmed Abdelraouf
 * @group             :
 * @last modified on  : 01-28-2023
 * @last modified by  : Ahmed Abdelraouf
 **/
public class PricingQuotationExtension {
  public Boolean readValue { get; set; }

  public static final string FLIGHT_MANAGEMENT = 'Flight Management';
  public static final string ACCOMMODATION_MANAGEMENT = 'Accommodation Management';

  public static final string FLIGHT_MANAGEMENT_TRIP_TYPE_ONE_WAY = 'One-way';
  public static final string FLIGHT_MANAGEMENT_TRIP_TYPE_ROUNDTRIP = 'RoundTrip';
  public static final string FLIGHT_MANAGEMENT_TRIP_TYPE_MULTI_CITY = 'Multi-city';

  public Opportunity opportunity { get; set; }
  public PricingQuotationExtension(ApexPages.StandardController controller) {
    this.opportunity = (Opportunity) controller.getRecord();
    // this.opportunity = getOpportunityDetails('0067X00000DisRAQAZ');
    this.opportunity = getOpportunityDetails(this.opportunity.Id);
  }

  public Contact getContactInfo() {
    return [
        SELECT
          Id,
          Name,
          Phone,
          Account.Name,
          MailingStreet,
          MailingCity,
          MailingCountry
        FROM Contact
        WHERE Id = :this.opportunity.Request__r.ContactId
      ]
      .get(0);
  }

  // public Quote getQuote() {
  //   return [
  //       SELECT Id, Name, TotalPrice, OpportunityId
  //       FROM Quote
  //       WHERE OpportunityId = :this.opportunity.Id
  //     ]
  //     .get(0);
  // }

  public List<QuoteLineItem> getQuoteLineItemsAccomedation() {
    return [
      SELECT
        Id,
        QuoteId,
        Line_Item_Detail__c,
        Product2Id,
        Product2.Name,
        TotalPrice,
        Line_Item_Detail__r.Hotel__c,
        Line_Item_Detail__r.Bookings__c,
        Line_Item_Detail__r.Sales_Price__c,
        Line_Item_Detail__r.Room__c,
        Line_Item_Detail__r.Bed_size__c,
        Line_Item_Detail__r.Meal_Plan__c,
        Line_Item_Detail__r.Class__c,
        Line_Item_Detail__r.Class1__c,
        Line_Item_Detail__r.Class2__c,
        Line_Item_Detail__r.Class3__c,
        Line_Item_Detail__r.Class4__c,
        Line_Item_Detail__r.Arival_Date__c,
        Line_Item_Detail__r.Arival_Date1__c,
        Line_Item_Detail__r.Arival_Date2__c,
        Line_Item_Detail__r.Arival_Date3__c,
        Line_Item_Detail__r.Arival_Date4__c,
        Line_Item_Detail__r.Departure_Date__c,
        Line_Item_Detail__r.Departure_Date1__c,
        Line_Item_Detail__r.Departure_Date2__c,
        Line_Item_Detail__r.Departure_Date3__c,
        Line_Item_Detail__r.Departure_Date4__c,
        Line_Item_Detail__r.Destination__c,
        Line_Item_Detail__r.Destination1__c,
        Line_Item_Detail__r.Destination2__c,
        Line_Item_Detail__r.Destination3__c,
        Line_Item_Detail__r.Destination4__c,
        Line_Item_Detail__r.Departure__c,
        Line_Item_Detail__r.Departure1__c,
        Line_Item_Detail__r.Departure2__c,
        Line_Item_Detail__r.Departure3__c,
        Line_Item_Detail__r.Departure4__c,
        Line_Item_Detail__r.Airline__c,
        Line_Item_Detail__r.Airport__c,
        Line_Item_Detail__r.Airline1__c,
        Line_Item_Detail__r.Airline2__c,
        Line_Item_Detail__r.Airline3__c,
        Line_Item_Detail__r.Airline4__c,
        Line_Item_Detail__r.Trip_type__c,
        Line_Item_Detail__r.SubType__c,
        Line_Item_Detail__r.Description__c,
        Line_Item_Detail__r.Opportunity_Line_Item_Details__r.Category__c
      FROM QuoteLineItem
      WHERE
        Quote.OpportunityId = :this.opportunity.Id
        AND Product2.Name = :ACCOMMODATION_MANAGEMENT
    ];
  }

  public List<QuoteLineItem> getQuoteLineItemsFlightOneWay() {
    return [
      SELECT
        Id,
        QuoteId,
        Line_Item_Detail__c,
        Product2Id,
        Product2.Name,
        TotalPrice,
        Line_Item_Detail__r.Hotel__c,
        Line_Item_Detail__r.Bookings__c,
        Line_Item_Detail__r.Sales_Price__c,
        Line_Item_Detail__r.Room__c,
        Line_Item_Detail__r.Bed_size__c,
        Line_Item_Detail__r.Meal_Plan__c,
        Line_Item_Detail__r.Class__c,
        Line_Item_Detail__r.Class1__c,
        Line_Item_Detail__r.Class2__c,
        Line_Item_Detail__r.Class3__c,
        Line_Item_Detail__r.Class4__c,
        Line_Item_Detail__r.Arival_Date__c,
        Line_Item_Detail__r.Arival_Date1__c,
        Line_Item_Detail__r.Arival_Date2__c,
        Line_Item_Detail__r.Arival_Date3__c,
        Line_Item_Detail__r.Arival_Date4__c,
        Line_Item_Detail__r.Departure_Date__c,
        Line_Item_Detail__r.Departure_Date1__c,
        Line_Item_Detail__r.Departure_Date2__c,
        Line_Item_Detail__r.Departure_Date3__c,
        Line_Item_Detail__r.Departure_Date4__c,
        Line_Item_Detail__r.Destination__c,
        Line_Item_Detail__r.Destination1__c,
        Line_Item_Detail__r.Destination2__c,
        Line_Item_Detail__r.Destination3__c,
        Line_Item_Detail__r.Destination4__c,
        Line_Item_Detail__r.Departure__c,
        Line_Item_Detail__r.Departure1__c,
        Line_Item_Detail__r.Departure2__c,
        Line_Item_Detail__r.Departure3__c,
        Line_Item_Detail__r.Departure4__c,
        Line_Item_Detail__r.Airline__c,
        Line_Item_Detail__r.Airport__c,
        Line_Item_Detail__r.Airline1__c,
        Line_Item_Detail__r.Airline2__c,
        Line_Item_Detail__r.Airline3__c,
        Line_Item_Detail__r.Airline4__c,
        Line_Item_Detail__r.Trip_type__c,
        Line_Item_Detail__r.SubType__c,
        Line_Item_Detail__r.Description__c
      FROM QuoteLineItem
      WHERE
        Quote.OpportunityId = :this.opportunity.Id
        AND Product2.Name = :FLIGHT_MANAGEMENT
        AND Line_Item_Detail__r.Trip_type__c = :FLIGHT_MANAGEMENT_TRIP_TYPE_ONE_WAY
    ];
  }
  public List<QuoteLineItem> getQuoteLineItemsFlightRoundTrip() {
    return [
      SELECT
        Id,
        QuoteId,
        Line_Item_Detail__c,
        Product2Id,
        Product2.Name,
        TotalPrice,
        Line_Item_Detail__r.Hotel__c,
        Line_Item_Detail__r.Bookings__c,
        Line_Item_Detail__r.Sales_Price__c,
        Line_Item_Detail__r.Room__c,
        Line_Item_Detail__r.Bed_size__c,
        Line_Item_Detail__r.Meal_Plan__c,
        Line_Item_Detail__r.Class__c,
        Line_Item_Detail__r.Class1__c,
        Line_Item_Detail__r.Class2__c,
        Line_Item_Detail__r.Class3__c,
        Line_Item_Detail__r.Class4__c,
        Line_Item_Detail__r.Arival_Date__c,
        Line_Item_Detail__r.Arival_Date1__c,
        Line_Item_Detail__r.Arival_Date2__c,
        Line_Item_Detail__r.Arival_Date3__c,
        Line_Item_Detail__r.Arival_Date4__c,
        Line_Item_Detail__r.Departure_Date__c,
        Line_Item_Detail__r.Departure_Date1__c,
        Line_Item_Detail__r.Departure_Date2__c,
        Line_Item_Detail__r.Departure_Date3__c,
        Line_Item_Detail__r.Departure_Date4__c,
        Line_Item_Detail__r.Destination__c,
        Line_Item_Detail__r.Destination1__c,
        Line_Item_Detail__r.Destination2__c,
        Line_Item_Detail__r.Destination3__c,
        Line_Item_Detail__r.Destination4__c,
        Line_Item_Detail__r.Departure__c,
        Line_Item_Detail__r.Departure1__c,
        Line_Item_Detail__r.Departure2__c,
        Line_Item_Detail__r.Departure3__c,
        Line_Item_Detail__r.Departure4__c,
        Line_Item_Detail__r.Airline__c,
        Line_Item_Detail__r.Airport__c,
        Line_Item_Detail__r.Airline1__c,
        Line_Item_Detail__r.Airline2__c,
        Line_Item_Detail__r.Airline3__c,
        Line_Item_Detail__r.Airline4__c,
        Line_Item_Detail__r.Trip_type__c,
        Line_Item_Detail__r.SubType__c,
        Line_Item_Detail__r.Description__c
      FROM QuoteLineItem
      WHERE
        Quote.OpportunityId = :this.opportunity.Id
        AND Product2.Name = :FLIGHT_MANAGEMENT
        AND Line_Item_Detail__r.Trip_type__c = :FLIGHT_MANAGEMENT_TRIP_TYPE_ROUNDTRIP
    ];
  }

  public List<QuoteLineItem> getQuoteLineItemsFlightMultiCity() {
    return [
      SELECT
        Id,
        QuoteId,
        Line_Item_Detail__c,
        Product2Id,
        Product2.Name,
        TotalPrice,
        Line_Item_Detail__r.Hotel__c,
        Line_Item_Detail__r.Bookings__c,
        Line_Item_Detail__r.Sales_Price__c,
        Line_Item_Detail__r.Room__c,
        Line_Item_Detail__r.Bed_size__c,
        Line_Item_Detail__r.Meal_Plan__c,
        Line_Item_Detail__r.Class__c,
        Line_Item_Detail__r.Class1__c,
        Line_Item_Detail__r.Class2__c,
        Line_Item_Detail__r.Class3__c,
        Line_Item_Detail__r.Class4__c,
        Line_Item_Detail__r.Arival_Date__c,
        Line_Item_Detail__r.Arival_Date1__c,
        Line_Item_Detail__r.Arival_Date2__c,
        Line_Item_Detail__r.Arival_Date3__c,
        Line_Item_Detail__r.Arival_Date4__c,
        Line_Item_Detail__r.Departure_Date__c,
        Line_Item_Detail__r.Departure_Date1__c,
        Line_Item_Detail__r.Departure_Date2__c,
        Line_Item_Detail__r.Departure_Date3__c,
        Line_Item_Detail__r.Departure_Date4__c,
        Line_Item_Detail__r.Destination__c,
        Line_Item_Detail__r.Destination1__c,
        Line_Item_Detail__r.Destination2__c,
        Line_Item_Detail__r.Destination3__c,
        Line_Item_Detail__r.Destination4__c,
        Line_Item_Detail__r.Departure__c,
        Line_Item_Detail__r.Departure1__c,
        Line_Item_Detail__r.Departure2__c,
        Line_Item_Detail__r.Departure3__c,
        Line_Item_Detail__r.Departure4__c,
        Line_Item_Detail__r.Airline__c,
        Line_Item_Detail__r.Airport__c,
        Line_Item_Detail__r.Airline1__c,
        Line_Item_Detail__r.Airline2__c,
        Line_Item_Detail__r.Airline3__c,
        Line_Item_Detail__r.Airline4__c,
        Line_Item_Detail__r.Trip_type__c,
        Line_Item_Detail__r.SubType__c,
        Line_Item_Detail__r.Description__c
      FROM QuoteLineItem
      WHERE
        Quote.OpportunityId = :this.opportunity.Id
        AND Product2.Name = :FLIGHT_MANAGEMENT
        AND Line_Item_Detail__r.Trip_type__c = :FLIGHT_MANAGEMENT_TRIP_TYPE_MULTI_CITY
    ];
  }

  public List<QuoteLineItem> getQuoteLineItemsOtherProducts() {
    return [
      SELECT
        Id,
        QuoteId,
        Line_Item_Detail__c,
        Product2Id,
        Product2.Name,
        TotalPrice,
        Line_Item_Detail__r.Hotel__c,
        Line_Item_Detail__r.Bookings__c,
        Line_Item_Detail__r.Sales_Price__c,
        Line_Item_Detail__r.Room__c,
        Line_Item_Detail__r.Bed_size__c,
        Line_Item_Detail__r.Meal_Plan__c,
        Line_Item_Detail__r.Class__c,
        Line_Item_Detail__r.Class1__c,
        Line_Item_Detail__r.Class2__c,
        Line_Item_Detail__r.Class3__c,
        Line_Item_Detail__r.Class4__c,
        Line_Item_Detail__r.Arival_Date__c,
        Line_Item_Detail__r.Arival_Date1__c,
        Line_Item_Detail__r.Arival_Date2__c,
        Line_Item_Detail__r.Arival_Date3__c,
        Line_Item_Detail__r.Arival_Date4__c,
        Line_Item_Detail__r.Departure_Date__c,
        Line_Item_Detail__r.Departure_Date1__c,
        Line_Item_Detail__r.Departure_Date2__c,
        Line_Item_Detail__r.Departure_Date3__c,
        Line_Item_Detail__r.Departure_Date4__c,
        Line_Item_Detail__r.Destination__c,
        Line_Item_Detail__r.Destination1__c,
        Line_Item_Detail__r.Destination2__c,
        Line_Item_Detail__r.Destination3__c,
        Line_Item_Detail__r.Destination4__c,
        Line_Item_Detail__r.Departure__c,
        Line_Item_Detail__r.Departure1__c,
        Line_Item_Detail__r.Departure2__c,
        Line_Item_Detail__r.Departure3__c,
        Line_Item_Detail__r.Departure4__c,
        Line_Item_Detail__r.Airline__c,
        Line_Item_Detail__r.Airport__c,
        Line_Item_Detail__r.Airline1__c,
        Line_Item_Detail__r.Airline2__c,
        Line_Item_Detail__r.Airline3__c,
        Line_Item_Detail__r.Airline4__c,
        Line_Item_Detail__r.Trip_type__c,
        Line_Item_Detail__r.SubType__c,
        Line_Item_Detail__r.Description__c
      FROM QuoteLineItem
      WHERE
        Quote.OpportunityId = :this.opportunity.Id
        AND Product2.Name != :ACCOMMODATION_MANAGEMENT
        AND Product2.Name != :FLIGHT_MANAGEMENT
    ];
  }

  public Integer getQuoteLineItemsAccomedationSize() {
    Integer count = 0;
    for (AggregateResult groupedResult : [
      SELECT COUNT(Id)
      FROM QuoteLineItem
      WHERE
        Quote.OpportunityId = :this.opportunity.Id
        AND Product2.Name = :ACCOMMODATION_MANAGEMENT
    ]) {
      count = (Integer) groupedResult.get('expr0');
    }
    return count;
  }

  public Integer getQuoteLineItemsFlightOneWaySize() {
    Integer count = 0;
    for (AggregateResult groupedResult : [
      SELECT COUNT(Id)
      FROM QuoteLineItem
      WHERE
        Quote.OpportunityId = :this.opportunity.Id
        AND Product2.Name = :FLIGHT_MANAGEMENT
        AND Line_Item_Detail__r.Trip_type__c = :FLIGHT_MANAGEMENT_TRIP_TYPE_ONE_WAY
    ]) {
      count = (Integer) groupedResult.get('expr0');
    }
    return count;
  }

  public Integer getQuoteLineItemsFlightRoundTripSize() {
    Integer count = 0;
    for (AggregateResult groupedResult : [
      SELECT COUNT(Id)
      FROM QuoteLineItem
      WHERE
        Quote.OpportunityId = :this.opportunity.Id
        AND Product2.Name = :FLIGHT_MANAGEMENT
        AND Line_Item_Detail__r.Trip_type__c = :FLIGHT_MANAGEMENT_TRIP_TYPE_ROUNDTRIP
    ]) {
      count = (Integer) groupedResult.get('expr0');
    }
    return count;
  }

  public Integer getQuoteLineItemsFlightMultiCitySize() {
    Integer count = 0;
    for (AggregateResult groupedResult : [
      SELECT COUNT(Id)
      FROM QuoteLineItem
      WHERE
        Quote.OpportunityId = :this.opportunity.Id
        AND Product2.Name = :FLIGHT_MANAGEMENT
        AND Line_Item_Detail__r.Trip_type__c = :FLIGHT_MANAGEMENT_TRIP_TYPE_MULTI_CITY
    ]) {
      count = (Integer) groupedResult.get('expr0');
    }
    return count;
  }

  public Integer getQuoteLineItemsOtherProductsSize() {
    Integer count = 0;
    for (AggregateResult groupedResult : [
      SELECT COUNT(Id)
      FROM QuoteLineItem
      WHERE
        Quote.OpportunityId = :this.opportunity.Id
        AND Product2.Name != :ACCOMMODATION_MANAGEMENT
        AND Product2.Name != :FLIGHT_MANAGEMENT
    ]) {
      count = (Integer) groupedResult.get('expr0');
    }
    return count;
  }

  public Opportunity getOpportunityDetails(Id opportunityId) {
    return [
        SELECT Id, Request__c, Request__r.ContactId
        FROM Opportunity
        WHERE Id = :opportunityId
      ]
      .get(0);
  }
}