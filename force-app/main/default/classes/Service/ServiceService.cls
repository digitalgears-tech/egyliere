public  class ServiceService {
    private static ServiceService instance = null;

    private ServiceService() {
    }

    public static ServiceService getInstance() {
        if (instance == null) {
          instance = new ServiceService();
        }
        return instance;
      }

      public Map<String, List<String>> getServiceCategoryList(String type) {
        Map<String, List<String>> categoryMap= DependencyForPicklistApex.getFieldDependencies('Opprtunity_Line_Item_Details__c','Sub_Type__c','Category__c');
        List<String> category = categoryMap.get(type);

        Map<String, List<String>> selectionLists = new Map<String,List<String>>();
        selectionLists.put('Category', category);

        if(type.equals('Visa Management')){
            
         selectionLists.put('Type of Visa', DependencyForPicklistApex.getPickList('Opprtunity_Line_Item_Details__c', 'Type_of_visa__c'));
        }

        if(type.equals('Transport Arrangement - Booking')){
            selectionLists.put('Class', DependencyForPicklistApex.getPickList('Opprtunity_Line_Item_Details__c', 'Class__c'));
            selectionLists.put('Transportation Type', DependencyForPicklistApex.getPickList('Opprtunity_Line_Item_Details__c', 'Transport_Type__c'));
        }
        if(type.equals('Accommodation Management')){
          selectionLists.put('Meal Plan', DependencyForPicklistApex.getPickList('Opprtunity_Line_Item_Details__c', 'Meal_Plan__c'));
          selectionLists.put('Bed size', DependencyForPicklistApex.getPickList('Opprtunity_Line_Item_Details__c', 'Bed_size__c'));
      }
      if(type.equals('Dining & Nightspots Reservations')){
        selectionLists.put('Time slot', DependencyForPicklistApex.getPickList('Opprtunity_Line_Item_Details__c', 'Time_slot__c'));
    }
    if(type.equals('Lifestyle Management')){
      List<Product2> product = [SELECT Name FROM Product2 WHERE Family ='Lifestyle Management Services'];
      List<String> productName = new List<String>();
      for(Product2 p : product){
        productName.add(p.Name);
      }
      selectionLists.put('subType', productName);
    }
       return selectionLists;
   
        }
}