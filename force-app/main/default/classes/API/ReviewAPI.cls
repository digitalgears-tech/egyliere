@RestResource(urlMapping = '/ReviewAPI/*')
global with sharing class ReviewAPI {
    public static ReviewService reviewServiceInstance = ReviewService.getInstance();
    public ReviewAPI() {
    }

    @HttpPost
    global static void SetReview(){
        RestRequest request = RestContext.request;
        RestResponse response = RestContext.response;
        try{
            String app = request.params.get('App');
            if(app.equals('Internal')){
                Map<String,Object> body = (Map<String,Object>)JSON.deserializeUntyped(request.requestBody.toString());
                String comment = (String) body.get('comment');
                String ratingValue = (String) body.get('ratingValue');
                String contactId = (String) body.get('contactId');

                reviewServiceInstance.SetReview(comment, ratingValue, contactId);
                response.statusCode = 200;
                response.responseBody = Blob.valueOf('Review Set.');
            }
        }
        catch (System.NullPointerException e) {
            response.statusCode=500;
            response.responseBody = Blob.valueOf('ERROR: ' + e.getMessage());
         throw new GeneralException(e.getMessage());}

        catch (System.DmlException e) {
            response.statusCode=500;
            response.responseBody = Blob.valueOf('ERROR: ' + e.getMessage());
       throw new GeneralException(e.getMessage());}

        catch(GeneralException e){
            response.statusCode=400;
        throw new GeneralException(e.getMessage());}
    }
}