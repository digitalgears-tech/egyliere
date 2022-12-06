public with sharing class DependencyForPicklistApex {
    public DependencyForPicklistApex() {

    }
    public static Map<String, List<String>> getFieldDependencies(String objectName, String controllingField, String dependentField){
        Map<String, List<String>> controllingInfo = new Map<String, List<String>>();
        Schema.SObjectType objType = Schema.getGlobalDescribe().get(objectName);
        Schema.DescribeSObjectResult describeResult = objType.getDescribe();
        Schema.DescribeFieldResult controllingFieldInfo = describeResult.fields.getMap().get(controllingField).getDescribe();
        Schema.DescribeFieldResult dependentFieldInfo = describeResult.fields.getMap().get(dependentField).getDescribe();
        List<Schema.PicklistEntry> controllingValues = controllingFieldInfo.getPicklistValues();
        List<Schema.PicklistEntry> dependentValues = dependentFieldInfo.getPicklistValues();
        for(Schema.PicklistEntry currControllingValue : controllingValues){
            controllingInfo.put(currControllingValue.getValue(), new List<String>());
        }
        for(Schema.PicklistEntry currDependentValue : dependentValues){
            String jsonString = JSON.serialize(currDependentValue);
            MyPickListInfo info = (MyPickListInfo) JSON.deserialize(jsonString, MyPickListInfo.class);
            String hexString = EncodingUtil.convertToHex(EncodingUtil.base64Decode(info.validFor)).toUpperCase();
            Integer baseCount = 0;
//toLowerCase can be changed to uppercase and getLabel() can be changed to getValue() based on requirement.
            for(Integer curr : hexString.getChars()){
                Integer val = (curr >= 65)?(curr - 65 + 10):(curr - 48);
                    if((val & 8) == 8){controllingInfo.get(controllingValues[baseCount + 0].getValue()).add(currDependentValue.getLabel().toLowerCase());}
                if((val & 4) == 4){controllingInfo.get(controllingValues[baseCount + 1].getValue()).add(currDependentValue.getLabel().toLowerCase());}
                if((val & 2) == 2){controllingInfo.get(controllingValues[baseCount + 2].getValue()).add(currDependentValue.getLabel().toLowerCase());}
                if((val & 1) == 1){controllingInfo.get(controllingValues[baseCount + 3].getValue()).add(currDependentValue.getLabel().toLowerCase());}
                baseCount += 4;
            }            
        } 
        return controllingInfo;
    }
    
    public class MyPickListInfo{
        public String validFor;
    }
}