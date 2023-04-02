public class QuoteLineItemRepository {
    private static QuoteLineItemRepository instance = null;
    private QuoteLineItemRepository(){}

    public static QuoteLineItemRepository getInstance() {
        if (instance == null) {
          instance = new QuoteLineItemRepository();
        }
        return instance;
      }
      public List<QuoteLineItem> findAllQuoteLineItems(){
        return [
            SELECT
            Breakfast__c,
            Commission__c,
            Discount,
            Extra_Charges_Amount__c,
            Description,
            Line_Item_Detail__c,
            LineNumber,
            ListPrice,
            Markup__c,
            Markup_Amount__c,
            Product2Id,
            Quantity,
            QuoteId,
            Quote.Sequence_Number__c,
            UnitPrice,
            Subtotal,
            TotalPrice,
            Total_rate__c,
            VAT__c
            FROM QuoteLineItem
        ];
      }

      public List<QuoteLineItem> findQuoteLineItemByQuoteId(String quoteId){
        return [
            SELECT
            Breakfast__c,
            Commission__c,
            Discount,
            Extra_Charges_Amount__c,
            Description,
            Line_Item_Detail__c,
            LineNumber,
            ListPrice,
            Markup__c,
            Markup_Amount__c,
            Product2Id,
            Quantity,
            QuoteId,
            Quote.Sequence_Number__c,
            UnitPrice,
            Subtotal,
            TotalPrice,
            Total_rate__c,
            VAT__c
            FROM QuoteLineItem
            WHERE QuoteId = :quoteId
        ];
      }

      public List<QuoteLineItem> findQuoteLineItemByQuoteLineItemDetailsId(List<Id> quoteLineItemDetails){
        return [
            SELECT
            Breakfast__c,
            Commission__c,
            Discount,
            Extra_Charges_Amount__c,
            Description,
            Line_Item_Detail__c,
            LineNumber,
            ListPrice,
            Markup__c,
            Markup_Amount__c,
            Product2.Name,
            Quantity,
            QuoteId,
            Quote.Sequence_Number__c,
            Quote.Status,
            UnitPrice,
            Subtotal,
            TotalPrice,
            Total_rate__c,
            VAT__c
            FROM QuoteLineItem
            WHERE Line_Item_Detail__c = :quoteLineItemDetails
        ];
      }
}
