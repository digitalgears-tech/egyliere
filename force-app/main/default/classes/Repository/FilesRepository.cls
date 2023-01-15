public class FilesRepository {
    private static FilesRepository instance = null;
    private FilesRepository() {}

    public static FilesRepository getInstance() {
        if (instance == null) {
          instance = new FilesRepository();
        }
        return instance;
      }


 /*   public AttachedContentDocument findByCase(String id){

        return [
          SELECT
          Id,
          ContentUrl	
          FROM AttachedContentDocument
          WHERE Parent = :id
          ];
    }*/
}
