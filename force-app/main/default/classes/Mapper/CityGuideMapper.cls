global class CityGuideMapper {
    String name;
    List<String> image;
    String city;
    Decimal price;
    Decimal duration;
    String Id;
   //List<CatalogueMapper> catalogs;
    public CityGuideMapper() {

    }

    public CityGuideMapper CityGuideobjectToMapper( City_Guide__c cityGuidesObject){
        
        CityGuideMapper cityGuideMapper = new CityGuideMapper();
        ImageListMapper ImageListMapperInstance = ImageListMapper.getInstance();
        cityGuideMapper.name = cityGuidesObject.Name;
        cityGuideMapper.image = ImageListMapperInstance.ConvertToImageList(cityGuidesObject.Image__c);
        cityGuideMapper.city = cityGuidesObject.City__c;
        cityGuideMapper.price = cityGuidesObject.Price__c;
        cityGuideMapper.duration = cityGuidesObject.Duration__c;
        cityGuideMapper.Id = cityGuidesObject.Id;

      return cityGuideMapper;
    }

    public  List<CityGuideMapper> CityGuideobjectListToMapperList(List<City_Guide__c> cityGuideObjectList){

        List<CityGuideMapper> mapperList = new List<CityGuideMapper>();

        for( City_Guide__c c : cityGuideObjectList ){

            mapperList.add(CityGuideobjectToMapper(c));
        }

        return mapperList;
      }

}