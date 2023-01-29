public class CityGuideRepository {
    private static CityGuideRepository instance = null;
    private CityGuideRepository() {}

    public static CityGuideRepository getInstance() {
        if (instance == null) {
          instance = new CityGuideRepository();
        }
        return instance;
      }

      public List<City_Guide__c> FindAllCityGuides(){
        return [
          SELECT
          Name,
          Id,
          Image__c,
          City__c,
          Price__c,
          Duration__c	
          FROM City_Guide__c
        ];
      }
      public City_Guide__c FindAllCityGuideById(String id){
        return [
          SELECT
          Name,
          Id,
          Image__c,
          City__c,
          Price__c,
          Duration__c	
          FROM City_Guide__c
          WHERE Id =:id
        ];
      }
}