/**
 * @description       : 
 * @author            : Mohamed Tarek
 * @group             : 
 * @last modified on  : 02-13-2023
 * @last modified by  : Mohamed Tarek
**/
public  class HelpRepository {
    private static HelpRepository instance=null; 

    public static HelpRepository getInstance() {
        if (instance == null) {
          instance = new HelpRepository();
        }
        return instance;
      }
    public List<Help_QA__c> getHelpQAByCategory(String category){
        return [SELECT Id,Question__c,Answer__c From Help_QA__c WHERE Category__c=:category];
    }

}