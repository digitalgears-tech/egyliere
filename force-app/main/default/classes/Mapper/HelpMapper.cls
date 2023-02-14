/**
 * @description       : 
 * @author            : Mohamed Tarek
 * @group             : 
 * @last modified on  : 02-13-2023
 * @last modified by  : Mohamed Tarek
**/
global class HelpMapper {
    public String header;
    public String body;
    public String id;


    public HelpMapper HelpMapperToObject(Help_QA__c helpObject){
        HelpMapper mapper=new HelpMapper();
        mapper.header=helpObject.Header__c;
        mapper.body=helpObject.Body__c;
        mapper.Id=helpObject.Id;
        return mapper;
    }
    public Map<String,List<HelpMapper>> helpListToObject(List<Help_QA__c> helpObjectList){
       Map<String,list<HelpMapper>> helpMap=new Map<String,List<HelpMapper>>();


       
        for( Help_QA__c p : helpObjectList ){
            List<HelpMapper> currentList=helpMap.get(p.Category__c);
            if(currentList==null){
                helpMap.put(p.Category__c,new List<HelpMapper>{helpMapperToObject(p)});
                
            }else{
                currentList.add(helpMapperToObject(p));
            }

        }

        return helpMap;

    }

}