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


    public Map<String, List<String>>  getTagsMap() {
         Map<String, List<String>> tagsMap= DependencyForPicklistApex.getFieldDependencies('preference__c','Main_Tag__c','Sub_Tags__c');
    
    
        return tagsMap;
    
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

    public  Map<String, List<String>>  getContactTagsMap(String Id , String app) {
        Map<String, List<String>> tagsMap = new Map<String, List<String>>();
        List<preference__c>  preferences ;
        if(app.equals('orange')){
        preferences = preferenceRepositoryInstance.findByContact(contactRepositoryInstance.findByOrangeId(Id));
        }else{
        preferences = preferenceRepositoryInstance.findByContact(contactRepositoryInstance.findByRecordId(Id));
        }
        for( preference__c p : preferences)
        {  
             List<String> subTags;
            if (!(tagsMap.containskey(p.Main_Tag__c))){
                subTags=  new List<String>();
                subTags.add(p.Sub_Tags__c);
                tagsMap.put(p.Main_Tag__c,subTags);
            }else{
                subTags = tagsMap.get(p.Main_Tag__c);
                subTags.add(p.Sub_Tags__c);
                tagsMap.put(p.Main_Tag__c, subTags);
            }
        
        }   

        return tagsMap;
    }
    public void updateContactPreferenceByID(String Id, String app, Map<String, List<String>> newTags){

        Contact contact;
        List<preference__c>  preferences = new List<preference__c>();
        if(app.equals('orange')) {
            contact = contactRepositoryInstance.findByOrangeId(Id);
        }else{
            contact = contactRepositoryInstance.findByRecordId(Id);
        }
        Map<String, List<String>> currentTagList = Instance.getContactTagsMap(Id,app); 
        for( string tag : newTags.keySet()){
            if(!(currentTagList.containskey(tag))){
                preference__c p = new preference__c();
                p.Main_Tag__c = tag;
                //p.Sub_Tags__c = newTags.get(tag);
                p.Contact__c = contact.Id;
                preferences.add(p);
            }
        }

        insert preferences;
      }

}
