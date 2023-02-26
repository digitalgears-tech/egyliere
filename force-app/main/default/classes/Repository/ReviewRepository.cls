public with sharing class ReviewRepository {
    private static ReviewRepository instance = null;
    public ReviewRepository() {
    }
    public static ReviewRepository getInstance(){
        if(instance == null){
            instance = new ReviewRepository();
        }
        return instance;
    }

    public List<Review__c> GetAllReviews(){
        return [
            SELECT Comment__c, Rating_Value__c, Contact__c
            FROM Review__C
        ];
    }
}