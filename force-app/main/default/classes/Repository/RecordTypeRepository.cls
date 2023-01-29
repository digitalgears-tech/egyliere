public class RecordTypeRepository {
    private static RecordTypeRepository instance = null;

    private RecordTypeRepository() {

    }

    public static RecordTypeRepository getInstance() {
        if (instance == null) {
          instance = new RecordTypeRepository();
        }
        return instance;
      }

    public RecordType getRecordTypebyId(String id){
      return [
          SELECT
            Name
            FROM RecordType
            WHERE Id =: id];
    }
}