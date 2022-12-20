public class ExternalMembershipsRepository {
    private static ExternalMembershipsRepository instance = null;
    private ExternalMembershipsRepository() {}

    public static ExternalMembershipsRepository getInstance() {
        if (instance == null) {
          instance = new ExternalMembershipsRepository();
        }
        return instance;
      }

    public List<MemberShip__c> findByContact(Contact contact){

        return [
          SELECT
          Name,
          MemberShip_Provider__c,
          Expiration_Date__c,
          Id		
          FROM MemberShip__c
          WHERE Contact__c = :contact.Id
          ];
    }

    public List<MemberShip__c>  findById(List<String> id){

        return [
          SELECT
          Name,
          MemberShip_Provider__c,
          Id,
          Expiration_Date__c
          FROM MemberShip__c
          WHERE Id = : id
          ];
    }

}
