/**
 * @description       : 
 * @author            : Mohamed Tarek
 * @group             : 
 * @last modified on  : 02-19-2023
 * @last modified by  : Mohamed Tarek
**/
global class CreditCardMapper {
    public String id;
    public String creditCardToken;
    public String creditCardDigits;

    public CreditCardMapper mapObjectToMapper(Credit_Card__c card){
        CreditCardMapper creditMapper=new CreditCardMapper();
        creditMapper.Id=card.Id;
        creditMapper.creditCardToken=card.Token__c;
        creditMapper.creditCardDigits=card.Card_Number__c;
        return creditMapper;
    }
    public List<CreditCardMapper> mapObjectListToMapper(List<Credit_Card__c> cards){
        List<CreditCardMapper> creditMappers=new List<CreditCardMapper>();
        for(Credit_Card__c card:cards){
            creditMappers.add(mapObjectToMapper(card));
        }
        return creditMappers;
    }
}