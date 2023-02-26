public with sharing class ReviewMapper {
    public String comment;
    public String ratingValue;
    public String contact;

    public ReviewMapper() {
    }
    
    public ReviewMapper ReviewObjectToMapper (Review__c reviewObject){
        ReviewMapper reviewMap = new ReviewMapper();
        reviewMap.comment = reviewObject.Comment__c;
        reviewMap.ratingValue = reviewObject.Rating_Value__c;
        reviewMap.contact = reviewObject.Contact__c;

        return reviewMap;
    }

    public List<ReviewMapper> ReviewObjectToListMapper(List<Review__c> reviewObject){
        List<ReviewMapper> mapperList = new List<ReviewMapper>();

        for(Review__c r : reviewObject){
            mapperList.add(ReviewObjectToMapper(r));
        }

        return mapperList;
    }

}