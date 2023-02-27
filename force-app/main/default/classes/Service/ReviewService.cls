public with sharing class ReviewService {
    public static ReviewService instance = null;
    public ContactRepository contactRepositoryInstance;
    public OpportunityRepository opportunityRepositoryInstance;


    public ReviewService() {
        contactRepositoryInstance = ContactRepository.getInstance();
        opportunityRepositoryInstance = OpportunityRepository.getInstance();
    }

    public static ReviewService getInstance(){
        if(instance == null){
            instance = new ReviewService();
        }
        return instance;
    }

    // Creates a new review and inserts it to the database
    public void SetReview(String comment, String ratingValue, String contactId, String packageId){
        Contact contact = contactRepositoryInstance.findByRecordId(contactId);
        Opportunity pack = opportunityRepositoryInstance.findOpportunityById(packageId);
        Review__c review = new Review__c();
        review.Comment__c = comment;
        review.Rating_Value__c = ratingValue;
        review.Contact__c = contact.Id;
        review.Package__c = pack.Id;

        insert review;
    }

}