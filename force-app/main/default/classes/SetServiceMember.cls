global class SetServiceMember {

    @InvocableMethod
    public static void setServiceMember(List <Request> R1){
        Request input = R1.get(0);
        List <OpportunityLineItem> oppProduct= input.opportunityProduct;
        List <ServiceContactMap> memberMap = input.serviceContactMap;
        List <Service_Member__c> serviceMembers = new List <Service_Member__c>();
        List <Contact> contactsToUpdate = new List <Contact>();

        for(Integer j = 0; j< oppProduct.size(); j++){
        for(Integer i = 0; i < memberMap.size(); i++){
           
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
