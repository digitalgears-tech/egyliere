
// Rename Class ServiceMemberInvocable
global class SetServiceMember {


    
    // rename variable R1 to flowREquest Inputs
    // add label to the Invocable Method
    @InvocableMethod
    public static void setServiceMember(List <Request> R1){
        Request input = R1.get(0);
         // check this for naming conventions  https://www.javatpoint.com/java-naming-conventions
        // rename the list to opportunityLineItems for now it is okay rename it to opportunityProducts check this https://www.javatpoint.com/java-naming-conventions
        List <OpportunityLineItem> oppProduct= input.opportunityProduct;

        // rename Object ServiceContactMap. to ServiceContactMapper list name serviceContactMapperList 
        List <ServiceContactMap> memberMap = input.serviceContactMap;
        List <Service_Member__c> serviceMembers = new List <Service_Member__c>();
        List <Contact> contactsToUpdate = new List <Contact>();


          
        for(Integer j = 0; j< oppProduct.size(); j++){
        for(Integer i = 0; i < memberMap.size(); i++){
           // updated
           // donot comapre Id with name rename varibales
           // revisit the conditions reverse mindset 

            if((oppProduct.get(j).Product2Id)==(memberMap.get(i).service.Name)){
                Service_Member__c serviceMember = new Service_Member__c();
                serviceMember.Opportunity_Product__c = oppProduct.get(j).Id;
                serviceMember.Contact__c = memberMap.get(i).selectedContact.Id;
                
                String serviceMemberName ;
                if(memberMap.get(i).selectedContact.FirstName != null){
                serviceMemberName=memberMap.get(i).selectedContact.FirstName + ' ' + memberMap.get(i).selectedContact.LastName;
                }else{
                    serviceMemberName= memberMap.get(i).selectedContact.LastName;
                }
                serviceMember.Name = serviceMemberName;
                serviceMembers.add(serviceMember);

                System.debug(' service points 2' + memberMap.get(i).selectedContact.Is_Member__c);
                if(memberMap.get(i).selectedContact.Is_Member__c){
                     // rename x to variable 
                    decimal x= membermap.get(i).service.Points__c;
                    System.debug(' service points' + oppProduct.get(j).Product2.Points__c);
                 memberMap.get(i).selectedContact.Total_Hold__c = memberMap.get(i).selectedContact.Total_Hold__c + x;
                

                    if (contactsToUpdate.contains(memberMap.get(i).selectedContact)== false){
                     System.debug('check passed 1'+ memberMap.get(i).selectedContact);
                    contactsToUpdate.add(memberMap.get(i).selectedContact);
                    }
            }
           }
           }}

            insert serviceMembers;
           update contactsToUpdate;
    }
    public SetServiceMember() {

    }

global class  Request {
    
    @InvocableVariable
    global List <OpportunityLineItem> opportunityProduct;
    @InvocableVariable
    global List <ServiceContactMap> serviceContactMap;
    public Request() {
    
    }

         }

}
