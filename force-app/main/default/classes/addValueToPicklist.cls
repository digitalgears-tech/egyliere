public with sharing class addValueToPicklist {
    static String picklistId;
    public addValueToPicklist() {

    }

    @InvocableMethod
    public static void addValueToPicklist(List<String> picklistValue){
        getPicklistId(picklistValue.get(0));
       //updatePicklist(picklistId, picklistValue.get(0));

    }
    @future(callout=true)
    public static void getPicklistId(String picklistValue){
        
        Http http = new Http();
        HttpRequest requestId= new HttpRequest();
        requestId.setEndpoint('callout:Tooling_Api/services/data/v55.0/tooling/query/?q=select%20Id%20FROM%20CustomField%20WHERE%20DeveloperName%20=%20'+  '\''+ 'Tags' + '\'');
        requestId.setMethod('GET');
        HttpResponse responseId = http.send(requestId);
        System.debug('test'+ responseId.getBody());
         Map<String, Object> resultsId = (Map<String, Object>) JSON.deserializeUntyped(responseId.getBody());
        List<Object>  record = (List<Object>) resultsId.get('records');
        String Id = (String) ((Map<String, Object>)record.get(0)).get('Id');
        System.debug('Id'+Id);


        HttpRequest request= new HttpRequest();
        request.setEndpoint('callout:Tooling_Api/services/data/v55.0/tooling/sobjects/CustomField/'+Id);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
        System.debug('GET'+response.getBody());
        Map<String, Object> metadata = (Map<String, Object>) results.get('Metadata');
        Map<String, Object> valueSet = (Map<String, Object>) metadata.get('valueSet');
        Map<String, Object> valueSetDefinition = (Map<String, Object>) valueSet.get('valueSetDefinition');
        List<Object> value = (List<Object>) valueSetDefinition.get('value');
        Map<String, Object> valueTobeAdd = new Map<String, Object> ();
        valueTobeAdd.put('color', null);
        valueTobeAdd.put('default',false);
        valueTobeAdd.put('description',null);
        valueTobeAdd.put('isActive',true);
        valueTobeAdd.put('label',picklistValue);
        valueTobeAdd.put('urls',null);
        valueTobeAdd.put('valueName',picklistValue);
        value.add(valueTobeAdd);

        valueSet.put('valueSettings',new List<String>());
        valueSetDefinition.put('value',value);
        valueSet.put('valueSetDefinition', valueSetDefinition);

        System.debug('valueSet'+ value.toString());
        Map<String, Object> body = new Map<String, Object>();
        body.put('Metadata', metadata);
        System.debug('PATCH'+JSON.serialize(body));
        
        HttpRequest patchRequest = new HttpRequest();
        patchRequest.setEndpoint('callout:Tooling_Api/services/data/v55.0/tooling/sobjects/CustomField/'+Id);
        patchRequest.setMethod('PATCH');
        patchrequest.setHeader('Content-Type', 'application/json;charset=UTF-8');
        patchRequest.setBody(JSON.serialize(body));
        HttpResponse patchResponse= http.send(patchRequest);
        System.debug('PATCH'+patchResponse.getBody() +' '+ patchResponse.getStatus());
          

        
    }
}