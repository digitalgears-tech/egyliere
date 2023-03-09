public class OpportunityRepository {
    private static OpportunityRepository instance = null;

    public OpportunityRepository() {

    }

    public static OpportunityRepository getInstance() {
        if (instance == null) {
          instance = new OpportunityRepository();
        }
        return instance;
      }

    public List<Opportunity> findByCase(String requestID){

        return [
          SELECT
          Id,
          Name,
          StageName,
          CloseDate,
          Amount
          FROM Opportunity
          WHERE Request__c = :requestID
          ];
    }
    public List<Opportunity> findByCaseandStatus(String requestID, List<String> stageName){

      return [
        SELECT
        Id,
        Name,
        StageName,
        CloseDate,
        Amount
        FROM Opportunity
        WHERE Request__c = :requestID
        AND stageName = :stageName
        ];
  }
  public List<Opportunity> findByCaseandStatusId(String requestID, List<String> stageName , String id){

    return [
      SELECT
      Id,
      Name,
      StageName,
      Amount,
      CloseDate
      FROM Opportunity
      WHERE Request__c = :requestID
      AND stageName = :stageName
      AND Id =:id
      ];
}
  public Opportunity findOpportunityById(String id){

    return [
      SELECT
      Id,
      Name,
      StageName,
      CloseDate,
      Amount
      FROM Opportunity
      WHERE Id = :id
      ];
}
}