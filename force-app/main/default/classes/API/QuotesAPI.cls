@RestResource(urlMapping='/QuotesAPI/*')
global class QuotesAPI {
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
                String packageServiceId = getReuest.params.get('recordID');

            }

       
            return null;

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
}
