/**
 * @description       : 
 * @author            : Mohamed Tarek
 * @group             : 
 * @last modified on  : 02-13-2023
 * @last modified by  : Mohamed Tarek
**/
public class HelpService {
    private static HelpService instance = null;
    public HelpRepository helpRepositoryInstance;
    public HelpMapper helpMapperInstance=new HelpMapper();

    public HelpService() {
       helpRepositoryInstance=HelpRepository.getInstance();
    }

    public static HelpService getInstance() {
        if (instance == null) {
          instance = new HelpService();
        }
        return instance;
      }
    public Map<String,List<HelpMapper>> mapObjectListToMapper(String type){
        return helpMapperInstance.helpListToObject(helpRepositoryInstance.getHelpQAByType(type));  
    }
}