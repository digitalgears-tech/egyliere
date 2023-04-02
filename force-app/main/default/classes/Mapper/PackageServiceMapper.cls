public class PackageServiceMapper {
     public String logo;
     public Decimal totalPoints; 
     public String status;
     public String id;
     public Decimal totalPrice;
     public String packageID;
     public String sequenceNumber;


    public PackageServiceMapper() {

    }
    public PackageServiceMapper(OpportunityLineItem packageservice) {
        this.logo = packageservice.PricebookEntry.Product2.Logo__c;
        this.totalPoints = packageservice.Total_Points__c;
        this.status = packageservice.Opportunity.StageName;
        this.id = packageservice.id;
        this.totalPrice = packageservice.TotalPrice;
        this.packageID =packageservice.OpportunityId;
        this.sequenceNumber= packageservice.Sequence_Number__c;
    }

   
}