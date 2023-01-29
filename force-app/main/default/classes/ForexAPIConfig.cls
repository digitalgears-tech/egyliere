public class ForexAPIConfig {
    private static final String BASE_URL = 'https://fcsapi.com/api-v3/forex';
  
    public static String getAccessToken() {
      List<Forex_API_Config__c> forexConfigs = [
        SELECT Access_Token__c
        FROM Forex_API_Config__c
      ];
      return forexConfigs.get(0).Access_Token__c;
    }

    public static String valueURL(List<String> values) {
        return BASE_URL +
          '/latest?symbol=' +
          '&access_key=' +
          getAccessToken();
      }
    
}