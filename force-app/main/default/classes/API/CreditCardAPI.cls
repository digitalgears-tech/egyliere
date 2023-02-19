/**
 * @description       : 
 * @author            : Mohamed Tarek
 * @group             : 
 * @last modified on  : 02-19-2023
 * @last modified by  : Mohamed Tarek
**/
@RestResource(urlMapping='/CreditCard/*')
global class CreditCardAPI {

    @HttpPost
    global static CreditCardMapper addCreditCard(String creditCardDigits,String token,String contactId){
        CreditCardMapper mapper=new CreditCardMapper();
        Credit_Card__c creditCard=new Credit_Card__c();
        creditCard.Card_Number__c=creditCardDigits;
        creditCard.Token__c=token;
        creditCard.Contact__c=contactId;
        insert creditCard;
        return mapper.mapObjectToMapper(creditCard);

    }

    @HttpDelete
    global static String removeCreditCard(){
        RestRequest request= RestContext.request;
        RestResponse requestResponse= RestContext.response;

        Credit_Card__c creditCard=new Credit_Card__c();
        creditCard.Id=request.params.get('recordId');
        delete creditCard;
        return 'Card Deleted Succesfully';

    }

    
}