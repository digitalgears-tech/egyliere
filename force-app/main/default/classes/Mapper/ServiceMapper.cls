global class ServiceMapper {
    String serviceName;
    String destination;
    List<String> logo;
    Decimal totalPoints; 
    String status;
    String id;



    public ServiceMapper() {

    }

    public ServiceMapper ServiceobjectToMapper( Opprtunity_Line_Item_Details__c servicesObject , PackageServiceMapper packageService){
        
        ServiceMapper serviceMapper = new ServiceMapper();
        ImageListMapper ImageListMapperInstance = ImageListMapper.getInstance();
        serviceMapper.serviceName = servicesObject.Name;
        serviceMapper.destination = servicesObject.Destination__c;
        ServiceMapper.logo = ImageListMapperInstance.ConvertToImageList(packageService.logo);
        serviceMapper.totalPoints = packageService.totalPoints;
        serviceMapper.status = packageService.status;
        serviceMapper.id = packageService.id;
      return serviceMapper;
    }


    public  List<ServiceMapper> ServiceobjectListToMapperList(List<Opprtunity_Line_Item_Details__c> servicesObjectList , Map<String,PackageServiceMapper> packageServiceMap){

        List<ServiceMapper> mapperList = new List<ServiceMapper>();

        for( Opprtunity_Line_Item_Details__c c : servicesObjectList ){
            
            mapperList.add(ServiceobjectToMapper(c ,packageServiceMap.get(c.Opportunity_Product__c)));
        }

        return mapperList;
      }
}