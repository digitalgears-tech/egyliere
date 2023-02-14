/**
 * @description       : 
 * @author            : Mohamed Tarek
 * @group             : 
 * @last modified on  : 02-13-2023
 * @last modified by  : Mohamed Tarek
**/
@RestResource(urlMapping='/Help/*')
global class HelpAPI { 
    public static HelpService helpServiceInstance = HelpService.getInstance();
@HttpGet
global static  Map<String,List<HelpMapper>>  getHelpByCategory(){
    
        RestRequest getRequest= RestContext.request;
        RestResponse requestResponse= RestContext.response;
    try{
        String type = getRequest.params.get('Type');

    
        Map<String,List<HelpMapper>> helpQAs=helpServiceInstance.mapObjectListToMapper(type);
        if(helpQAs.size()==0){
          throw new NoRecordsException('No records found');
        }
 
        return helpQAs;
     
    }catch (System.NullPointerException e) {
        requestResponse.statusCode=500;
        requestResponse.responseBody = Blob.valueOf('ERROR: ' + e.getMessage());
        throw new GeneralException(e.getMessage());
   }

    catch (System.DmlException e) {
        requestResponse.statusCode=500;
        requestResponse.responseBody = Blob.valueOf('ERROR: ' + e.getMessage());
        throw new GeneralException(e.getMessage());
    }

    catch(GeneralException e){
        requestResponse.statusCode=400;
        requestResponse.responseBody = Blob.valueOf('ERROR: ' + e.getMessage());
        throw new GeneralException(e.getMessage());
    }catch(NoRecordsException e){
      requestResponse.statusCode=404;
      throw new NoRecordsException(e.getMessage());
  }

    }

}