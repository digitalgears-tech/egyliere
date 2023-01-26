public class ProductRepository {

    private static ProductRepository instance = null;

    private ProductRepository() {

    }

    public static ProductRepository getInstance() {
        if (instance == null) {
          instance = new ProductRepository();
        }
        return instance;
      }

      public Product2 findByName(String name){

        return [
          SELECT
          Id,
          Name,
          Family
          FROM Product2
          WHERE Name = :name
          ];
      }
          public Product2 findById(String id){

            return [
              SELECT
              Id,
              Name,
              Family,
              Logo__c
              FROM Product2
              WHERE Id = :id
              ];
    }
}