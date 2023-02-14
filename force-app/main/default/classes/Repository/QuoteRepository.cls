public class QuoteRepository {
    private static QuoteRepository instance = null;
    private QuoteRepository(){}

    public static QuoteRepository getInstance() {
        if (instance == null) {
          instance = new QuoteRepository();
        }
        return instance;
      }
      public List<Quote> findAllQuotes(){
        return [
        SELECT
        OpportunityId,
        Phone,
        Name,
        TotalPrice,
        Discount
        FROM Quote
        ];
      }

      public List<Quote> findQuoteByOpportunityId(String opportunityId){
        return [
        SELECT
        OpportunityId,
        Phone,
        Name,
        TotalPrice,
        Discount,
        ExpirationDate
        FROM Quote
        WHERE OpportunityId =:opportunityId
        ];
      }
}
