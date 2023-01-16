global class ServiceMapper {
    String serviceName;
    String destination;
    List<String> logo;

    public ServiceMapper() {

    }

    public ServiceMapper ServiceobjectToMapper( Opprtunity_Line_Item_Details__c servicesObject , String logo){
        
        ServiceMapper serviceMapper = new ServiceMapper();
        ImageListMapper ImageListMapperInstance = ImageListMapper.getInstance();
        serviceMapper.serviceName = servicesObject.Name;
        serviceMapper.destination = servicesObject.Destination__c;
        ServiceMapper.logo = ImageListMapperInstance.ConvertToImageList(logo);
        

      return serviceMapper;
    }


    public  List<ServiceMapper> ServiceobjectListToMapperList(List<Opprtunity_Line_Item_Details__c> servicesObjectList , Map<String,String> logoMap){

        List<ServiceMapper> mapperList = new List<ServiceMapper>();

        for( Opprtunity_Line_Item_Details__c c : servicesObjectList ){
            
            mapperList.add(ServiceobjectToMapper(c ,logoMap.get(c.Opportunity_Product__c)));
        }

        return mapperList;
      }
}
