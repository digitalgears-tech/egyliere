public with sharing class PreferenceService {
    private static PreferenceService instance = null;
    public  PreferenceRepository preferenceRepositoryInstance;
    private PreferenceService() {
       preferenceRepositoryInstance = PreferenceRepository.getInstance();
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


}
