@RestResource(urlMapping='/QuotesAPI/*')
global class QuotesAPI {
    public static QuoteService quoteServiceInstance = QuoteService.getInstance();

    public QuotesAPI() {

    }

    @HttpGet
    global static  List<QuoteMapper> getQuotes() {
        RestRequest getReuest= RestContext.request;
        RestResponse requestResponse= RestContext.response;
        Integer pageSize;
        Integer pageNumber;
        String app;
        String page;
        try{
         pageSize = Integer.valueOf(getReuest.params.get('PageSize'));
         pageNumber = Integer.valueOf(getReuest.params.get('PageNumber'));
        }catch(Exception e){
            pageSize=100;
            pageNumber=1;
        }
        try{
         app = getReuest.params.get('App');
        if(app.equals('Internal')){
            if(getReuest.params.get('QuoteId')!= null){
                return quoteServiceInstance.GetQuoteDetailsById(getReuest.params.get('QuoteId'));}
            else if(getReuest.params.get('bookingID')!= null){
                return quoteServiceInstance.GetQuoteDetails(getReuest.params.get('bookingID'));
            }else {
                requestResponse.statusCode=503;
            throw new GeneralException('No enough information');}
            }else{
                requestResponse.statusCode=503;
                throw new GeneralException('Not allowed for External apps');}


        }catch (System.NullPointerException e) {
            requestResponse.statusCode=500;
            requestResponse.responseBody = Blob.valueOf('ERROR: ' + e.getMessage());
            throw new GeneralException(e.getMessage());
       }
    
        catch (System.DmlException e) {
            requestResponse.statusCode=500;
            requestResponse.responseBody = Blob.valueOf('ERROR: ' + e.getMessage());
            throw new GeneralException(e.getMessage());
        }
    
        catch(GeneralException e){
            requestResponse.statusCode=400;
            requestResponse.responseBody = Blob.valueOf('ERROR: ' + e.getMessage());
            throw new GeneralException(e.getMessage());
        }catch(NoRecordsException e){
          requestResponse.statusCode=404;
          return new List<QuoteMapper>();
      }
        
}


@HttpPost
global static void updateQuotes() {
    RestRequest getReuest= RestContext.request;
    RestResponse requestResponse= RestContext.response;
    Integer pageSize;
    Integer pageNumber;
    String app;
    String page;
    try{
     pageSize = Integer.valueOf(getReuest.params.get('PageSize'));
     pageNumber = Integer.valueOf(getReuest.params.get('PageNumber'));
    }catch(Exception e){
        pageSize=100;
        pageNumber=1;
    }try{
        app = getReuest.params.get('App');
           if(app.equals('Internal')){
               List< Object> body = (List< Object>)JSON.deserializeUntyped(RestContext.request.requestbody.tostring());  
               quoteServiceInstance.setQuoteStatus(body);
               requestResponse.statusCode=200;
               requestResponse.responseBody=Blob.valueOf('Quotes Updated successfully');


           }else{
               requestResponse.statusCode=503;
               throw new GeneralException('Not allowed for External apps');}


       }catch (System.NullPointerException e) {
           requestResponse.statusCode=500;
           requestResponse.responseBody = Blob.valueOf('ERROR: ' + e.getMessage());
           throw new GeneralException(e.getMessage());
      }
   
       catch (System.DmlException e) {
           requestResponse.statusCode=500;
           requestResponse.responseBody = Blob.valueOf('ERROR: ' + e.getMessage());
           throw new GeneralException(e.getMessage());
       }
   
       catch(GeneralException e){
           requestResponse.statusCode=400;
           requestResponse.responseBody = Blob.valueOf('ERROR: ' + e.getMessage());
           throw new GeneralException(e.getMessage());
       }catch(NoRecordsException e){
         requestResponse.statusCode=404;
        
     }
}
}
