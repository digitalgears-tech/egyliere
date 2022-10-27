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

    public List<String> getMainTagsFromPreferences() {
        List<preference__c> preferences =preferenceRepositoryInstance.findAllPrefernces();
        List<String> tagslist = new List<String>();
             for (preference__c p : preferences) {
                tagslist.add(p.Main_Tag__c);
            }
        return tagslist;
    
    }


}
