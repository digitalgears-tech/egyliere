/**
 * @description       : 
 * @author            : Mohamed Tarek
 * @group             : 
 * @last modified on  : 02-15-2023
 * @last modified by  : Mohamed Tarek
**/
@RestResource(urlMapping='/Help/*')
global class HelpAPI { 
    public static HelpService helpServiceInstance = HelpService.getInstance();
@HttpGet
global static  Map<String,List<HelpMapper>>  getHelpByType(){
    
        RestRequest getRequest= RestContext.request;
        RestResponse requestResponse= RestContext.response;
  
        String type = getRequest.params.get('Type');

    
        Map<String,List<HelpMapper>> helpQAs=helpServiceInstance.mapObjectListToMapper(type);
       
 
        return helpQAs;
     

    }

}