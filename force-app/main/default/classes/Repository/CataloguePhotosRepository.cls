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

      public List<Catalogue_Photos__c> FindPhotoByCatalogueandRecordType(String catalogueid , RecordType rt){
        return [
          SELECT
          Name,
          Link__c,
          Photos__c	
          FROM Catalogue_Photos__c
          WHERE Catalogue__c = :catalogueid
          AND RecordTypeId = :rt.Id
        ];
    }
}