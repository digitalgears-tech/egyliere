global class ExternalMembershipsMapper {

    String memberShipId;
    String memberShipProvider;
    String  expirationDate;
    String id;
    public ExternalMembershipsMapper() {

    }
    public ExternalMembershipsMapper MembershipMapperToObject(MemberShip__c membershipObject){

        ExternalMembershipsMapper externalMembershipsMapper = new ExternalMembershipsMapper();
        externalMembershipsMapper.memberShipId = membershipObject.Name;
        externalMembershipsMapper.memberShipProvider = membershipObject.MemberShip_Provider__c;
        externalMembershipsMapper.expirationDate = (membershipObject.Expiration_Date__c.format()).replace('-','/');
        externalMembershipsMapper.id = membershipObject.Id;
        return externalMembershipsMapper;
    }

    public List<ExternalMembershipsMapper>  MembershipListToObject(List<MemberShip__c> membershipObjectList){
        List<ExternalMembershipsMapper> externalMembershipsMapper = new List<ExternalMembershipsMapper>();
       
        for( MemberShip__c p : membershipObjectList ){

            externalMembershipsMapper.add(MembershipMapperToObject(p));
        }

        return externalMembershipsMapper;

    }

    public List<MemberShip__c> MembershipAPIListToObject(String contactId , List<Object> membershipMapper){
        List<MemberShip__c> externalMemberships = new List<MemberShip__c>();
        Integer counter = 0;
        while (counter < membershipMapper.size()){
            MemberShip__c membership = new MemberShip__c();
            Map<String, Object> membershipmap =(Map<String, Object>)membershipMapper.get(counter);
           
           if((String)membershipmap.get('id')!=null){
            membership.Id = (String)membershipmap.get('id');
            membership.Expiration_Date__c =Date.parse((String)membershipmap.get('expirationDate'));
            membership.MemberShip_Provider__c =(String) membershipmap.get('memberShipProvider');
            membership.Name = (String)membershipmap.get('memberShipId');
            membership.Password__c = (String)membershipmap.get('Password');
           }else{
            membership.Expiration_Date__c =Date.parse((String)membershipmap.get('expirationDate'));
            membership.MemberShip_Provider__c =(String) membershipmap.get('memberShipProvider');
            membership.Name = (String)membershipmap.get('memberShipId');
            membership.Password__c = (String)membershipmap.get('Password');
            membership.Contact__c= contactId;}
            externalMemberships.add(membership);
            counter += 1;
        }

        return externalMemberships;
    }
}