public class ServiceRepository {
private static ServiceRepository instance = null;

    public ServiceRepository() {

    }

    public static ServiceRepository getInstance() {
        if (instance == null) {
          instance = new ServiceRepository();
        }
        return instance;
      }

    public Opprtunity_Line_Item_Details__c findAllService(){

        return [
          SELECT
          Id,
          Name,
          Additional_Details__c,
          Adult__c,
          Airline__c,
          Arival_Date__c,
          Arival_Date1__c,
          Bed_size__c,
          Cancellation_Policy__c,
          Category__c,
          Change_Policy__c,
          Child_0_2yr__c,
          Child_3_12yr__c,
          Citizenship__c,
          Class__c,
          Confirmation_Number__c,
          Contact__c,
          Contact_Name__c,
          Contact_Number__c,
          Departure_1__c,
          Departure_2__c,
          Departure_3__c,
          Departure_4__c,
          Departure__c,
          Departure_Date_2__c,
          Departure_Date_3__c,
          Departure_Date_4__c,
          Departure_Date_1__c,
          Departure_Date__c,
          Destination_1__c,
          Destination_2__c,
          Destination_3__c,
          Destination_4__c,
          Destination__c,
          Event_Name__c,
          Flight_Number__c,
          Hotel__c,
          Meal_Plan__c,
          Booking__c,
          Operation_Details__c,
          Opportunity_Product__c,
          Prefrence__c,
          Promo_code__c,
          Request_Details__c,
          Room__c,
          Sub_Type__c,
          Supplier__c,
          Ticket_Type__c,
          Time_slot__c,
          Transport_Type__c,
          Trip_type__c,
          Type__c,
          Type_of_visa__c,
          Venu__c
          FROM Opprtunity_Line_Item_Details__c
          ];
    }
          public List<Opprtunity_Line_Item_Details__c> findServiceByOpportunityProduct(List<String> opportunityProductId){

            return [
              SELECT
              Id,
              Name,
              Additional_Details__c,
              Adult__c,
              Airline__c,
              Arival_Date__c,
              Arival_Date1__c,
              Bed_size__c,
              Cancellation_Policy__c,
              Category__c,
              Change_Policy__c,
              Child_0_2yr__c,
              Child_3_12yr__c,
              Citizenship__c,
              Class__c,
              Confirmation_Number__c,
              Contact__c,
              Contact_Name__c,
              Contact_Number__c,
              Departure_1__c,
              Departure_2__c,
              Departure_3__c,
              Departure_4__c,
              Departure__c,
              Departure_Date_2__c,
              Departure_Date_3__c,
              Departure_Date_4__c,
              Departure_Date_1__c,
              Departure_Date__c,
              Destination_1__c,
              Destination_2__c,
              Destination_3__c,
              Destination_4__c,
              Destination__c,
              Event_Name__c,
              Flight_Number__c,
              Hotel__c,
              Meal_Plan__c,
              Booking__c,
              Operation_Details__c,
              Opportunity_Product__c,
              Prefrence__c,
              Promo_code__c,
              Request_Details__c,
              Room__c,
              Sub_Type__c,
              Supplier__c,
              Ticket_Type__c,
              Time_slot__c,
              Transport_Type__c,
              Trip_type__c,
              Type__c,
              Type_of_visa__c,
              Venu__c
              FROM Opprtunity_Line_Item_Details__c
              WHERE Opportunity_Product__c = :opportunityProductId	
              ];
          

    }

}