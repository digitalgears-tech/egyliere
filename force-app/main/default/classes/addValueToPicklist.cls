public with sharing class addValueToPicklist {
    public addValueToPicklist() {

    }

    @InvocableMethod
    public static void addValueToPicklist(List<String> picklistValue){
        String Id =getPicklistId();
        updatePicklist(Id, picklistValue.get(0));

    }

    Public static String getPicklistId(){

        Http http = new Http();
        HttpRequest request= new HttpRequest();
        request.setEndpoint('https://egylieretravel--dev.sandbox.my.salesforce.com/services/data/v55.0/tooling/query/?q=select+Id+FROM+CustomField+WHERE+DeveloperName+=+’Tags’');
        request.setMethod('GET');
        request.setHeader('Authorization', 'Bearer '+'00D7X0000004mGz!AR0AQIOwx3jhiv0jnf9vOre8r3Er8DcUBZwAfX_Sd90fb_SO_vR9aswQBT7ab.98OmMW7ylmM6aeHpqRHu6UnoB7fN5jUJ6m');
        HttpResponse response = http.send(request);
        Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
        Map<String, Object> record = (Map<String, Object>) results.get('records');
        String picklistId = (String) record.get('Id');
        return picklistId;
    }

    Public static void updatePicklist(String Id, String picklistValue){
        Http http = new Http();
        HttpRequest request= new HttpRequest();
        request.setEndpoint('https://egylieretravel--dev.sandbox.my.salesforce.com/services/data/v55.0/tooling/sobjects/CustomField/'+Id);
        request.setMethod('GET');
        request.setHeader('Authorization', 'Bearer '+'00D7X0000004mGz!AR0AQIOwx3jhiv0jnf9vOre8r3Er8DcUBZwAfX_Sd90fb_SO_vR9aswQBT7ab.98OmMW7ylmM6aeHpqRHu6UnoB7fN5jUJ6m');
        HttpResponse response = http.send(request);
        Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
        Map<String, Object> body = (Map<String, Object>) results.get('Metadata');
        Map<String, Object> valueSet = (Map<String, Object>) body.get('valueSet');
        valueSet.put('valueSetName','[]');
        Map<String, Object> valueSetDefinition = (Map<String, Object>) valueSet.get('valueSetDefinition');
        Map<String, List<String>> value = (Map<String, List<String>>) valueSetDefinition.get('value');
        String valueTobeadded = '{'+'\n'+'"color": null,'+'\n'+'"default": false,'+'\n'+'"description": null,'+'\n'+'"isActive": null,'+'\n'+'"label": '+picklistValue+','+'\n'+'"urls": null,'+'\n'+'"valueName": '+picklistValue +'\n'+'}' ;

        valueSetDefinition.put('value', value+valueTobeadded);
       
        valueSet.put('valueSetDefinition', valueSetDefinition);
        body.put('valueSet', valueSet);

        HttpRequest patchRequest = new HttpRequest();
        patchRequest.setEndpoint('https://egylieretravel--dev.sandbox.my.salesforce.com/services/data/v55.0/tooling/sobjects/CustomField/'+Id);
        patchRequest.setMethod('PATCH');
        patchRequest.setHeader('Authorization', 'Bearer '+'00D7X0000004mGz!AR0AQIOwx3jhiv0jnf9vOre8r3Er8DcUBZwAfX_Sd90fb_SO_vR9aswQBT7ab.98OmMW7ylmM6aeHpqRHu6UnoB7fN5jUJ6m');
        patchRequest.setBody(JSON.serialize(body));
        http.send(patchRequest);
    }
}
