public class ServiceContactMap {
    @AuraEnabled
    public  Contact selectedContact;
    @AuraEnabled
    public Product2 service;
    @AuraEnabled
    public Boolean extraCharge;
    public ServiceContactMap() {

    }
}