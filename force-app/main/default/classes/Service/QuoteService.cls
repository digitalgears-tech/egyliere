public  class QuoteService {
    private static QuoteService instance = null;
    public  QuoteRepository quoteRepositoryInstance;
    public  QuoteLineItemRepository quoteLineItemRepositoryInstance;
    public  QuoteLineItemDetailRepository quoteLineItemDetailRepositoryInstance;
    public PackageServiceRepository packageServiceRepositoryInstance;
    public QuoteMapper quoteMapper = new QuoteMapper();


    private QuoteService() {
        quoteRepositoryInstance = QuoteRepository.getInstance();
        quoteLineItemRepositoryInstance = QuoteLineItemRepository.getInstance();
        quoteLineItemDetailRepositoryInstance = QuoteLineItemDetailRepository.getInstance();
        packageServiceRepositoryInstance = PackageServiceRepository.getInstance();

    }

    public static QuoteService getInstance() {
        if (instance == null) {
          instance = new QuoteService();
        }
        return instance;
      }

      public List<QuoteMapper> GetQuoteDetails(String packageServiceId){

        OpportunityLineItem packageService = packageServiceRepositoryInstance.findPackageServiceById(packageServiceId);
        List<Quote_Line_Item_Detail__c> quoteLineItemDetails = quoteLineItemDetailRepositoryInstance.findQuoteLineItemDetailBy(packageService.Opportunity_Line_Item_Details__c);
        List<Id> quoteLineItemDetailsidList = new List<Id>();
        for(Quote_Line_Item_Detail__c qD : quoteLineItemDetails){
            quoteLineItemDetailsidList.add(qD.Id);
        }
        List<QuoteLineItem> quoteLineItems = quoteLineItemRepositoryInstance.findQuoteLineItemByQuoteLineItemDetailsId(quoteLineItemDetailsidList);
        Map<Id,QuoteLineItem> quoteLineItemDetailsIdQuoteLineItem = new Map<Id,QuoteLineItem>();
        for(QuoteLineItem q : quoteLineItems){
            quoteLineItemDetailsIdQuoteLineItem.put(q.Line_Item_Detail__c,q);
        }
        quoteMapper.quoteObjectListToMapperList(quoteLineItemDetails, quoteLineItemDetailsIdQuoteLineItem);
        return null;

      }
}
