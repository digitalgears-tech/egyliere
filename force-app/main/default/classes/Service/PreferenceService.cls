public with sharing class PreferenceService {
    private static PreferenceService instance = null;
    public  PreferenceRepository preferenceRepositoryInstance;
    public  ContactRepository contactRepositoryInstance;
    private PreferenceService() {
       preferenceRepositoryInstance = PreferenceRepository.getInstance();
       contactRepositoryInstance = ContactRepository.getInstance();
    }

    public static PreferenceService getInstance() {
        if (instance == null) {
          instance = new PreferenceService();
        }
        return instance;
      }

    public List<String> getMainTagsList() {
       
        List<String> tagslist = new List<String>();
       
        Schema.DescribeFieldResult fieldResult = preference__c.Main_Tag__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
         for( Schema.PicklistEntry f : ple)
        {
            tagslist.add(f.getLabel());
        }     
    
        return tagslist;
    
    }
    public List<String> getContactMainTagsList(String Id , String app) {
        List<String> tagslist = new List<String>();
        List<preference__c>  preferences ;
        if(app.equals('orange')){
        preferences = preferenceRepositoryInstance.findByContact(contactRepositoryInstance.findByOrangeId(Id));
        }else{
        preferences = preferenceRepositoryInstance.findByContact(contactRepositoryInstance.findByRecordId(Id));
        }
        for( preference__c p : preferences)
        {
            if (!(tagslist.contains(p.Main_Tag__c))){
            tagslist.add(p.Main_Tag__c);}
        }   

        return tagslist;
    }

}
