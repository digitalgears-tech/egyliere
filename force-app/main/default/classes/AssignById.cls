global class AssignById {

    public AssignById(){}
    
    @InvocableMethod
    public static void assignById(List<Request> R1) {
        Request input = R1.get(0);
        List<Opprtunity_Line_Item_Details__c> oppItem = input.opportunityItemDetails;
        List<OpportunityLineItem> oppProduct= input.opportunityProduct;
        
        for(Integer i = 0; i < oppItem.size(); i++){
            oppProduct.get(i).Opportunity_Line_Item_Details__c = oppItem.get(i).Id;
            oppProduct.get(i).Quantity=oppItem.get(i).Booking__c;
       }
       update oppItem;
       update oppProduct;
    }

     global class  Request {

        @InvocableVariable
        global List<Opprtunity_Line_Item_Details__c> opportunityItemDetails;
    
        @InvocableVariable
        global List<OpportunityLineItem> opportunityProduct;

        public Request() {
    
        }
    }
}
