public  class QuoteService {
    private static QuoteService instance = null;
    public  QuoteRepository quoteRepositoryInstance;
    public  QuoteLineItemRepository quoteLineItemRepositoryInstance;
    public  QuoteLineItemDetailRepository quoteLineItemDetailRepositoryInstance;
    private QuoteService() {
        quoteRepositoryInstance = QuoteRepository.getInstance();
        quoteLineItemRepositoryInstance = QuoteLineItemRepository.getInstance();
        quoteLineItemDetailRepositoryInstance = QuoteLineItemDetailRepository.getInstance();
    }

    public static QuoteService getInstance() {
        if (instance == null) {
          instance = new QuoteService();
        }
        return instance;
      }
}
