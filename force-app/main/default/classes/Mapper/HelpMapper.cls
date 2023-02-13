/**
 * @description       : 
 * @author            : Mohamed Tarek
 * @group             : 
 * @last modified on  : 02-13-2023
 * @last modified by  : Mohamed Tarek
**/
global class HelpMapper {
    public String question;
    public String answer;
    public String id;


    public HelpMapper HelpMapperToObject(Help_QA__c helpObject){
        HelpMapper mapper=new HelpMapper();
        mapper.question=helpObject.Question__c;
        mapper.answer=helpObject.Answer__c;
        mapper.Id=helpObject.Id;
        return mapper;
    }
    public List<HelpMapper>  helpListToObject(List<Help_QA__c> helpObjectList){
        List<HelpMapper> helpMapper = new List<HelpMapper>();
       
        for( Help_QA__c p : helpObjectList ){

            helpMapper.add(HelpMapperToObject(p));
        }

        return helpMapper;

    }}