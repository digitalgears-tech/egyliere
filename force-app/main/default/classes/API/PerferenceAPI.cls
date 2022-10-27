@RestResource(urlMapping='/PerferencesList/*')
global with sharing class PerferenceAPI {
    public static PreferenceService preferenceServiceInstance = PreferenceService.getInstance();
    public PerferenceAPI() {

    }

    @HttpPatch
    global static List<String> sendPerferencesList(){
        return preferenceServiceInstance.getMainTagsFromPreferences();
    }
}
