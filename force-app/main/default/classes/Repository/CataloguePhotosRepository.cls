public class CataloguePhotosRepository {
    private static CataloguePhotosRepository instance = null;

    private CataloguePhotosRepository() {

    }

    public static CataloguePhotosRepository getInstance() {
        if (instance == null) {
          instance = new CataloguePhotosRepository();
        }
        return instance;
      }

      public List<Catalogue_Photos__c> FindPhotoByCatalogue(String catalogueid){
        return [
          SELECT
          Name,
          Photos_Or_Links__c
          FROM Catalogue_Photos__c
          WHERE Catalogue__c = :catalogueid
        ];}
}
