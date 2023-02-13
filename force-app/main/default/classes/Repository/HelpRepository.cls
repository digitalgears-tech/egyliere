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
    public List<Help_QA__c> getHelpQAByType(String Type){
        return [SELECT Id,Body__c,Header__c,Category__c From Help_QA__c WHERE Type__c=:type];
    }

}