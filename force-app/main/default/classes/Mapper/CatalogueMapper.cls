global class CatalogueMapper {

    public String name;
    public List<String> Logo;
    public String city;
    public String address;
    public Map<String,Double> location;
    public String phone;
    public String emergencyNumber;
    public String type;
    public String category;
    public String description;
    public String houseRules;
    public String changePolicy;
    public String cancellationPolicy;
    public String benefits;
    public String recommendations;
    public Map<String,List<String>> photoCatalogues;
    public Map<String,String> linksCatalogues;
   


    public CatalogueMapper() {
    }

    public  CatalogueMapper CatalogueObjectToMapper(Catalogue__c catalogueObject){
        CatalogueMapper catalogueMap = new CatalogueMapper();
        ImageListMapper ImageListMapperInstance = ImageListMapper.getInstance(); 
        RecordTypeRepository recordTypeRepositoryInstance = RecordTypeRepository.getInstance();

        catalogueMap.name = catalogueObject.name;
        catalogueMap.Logo = ImageListMapperInstance.ConvertToImageList(catalogueObject.Logo__c);
        catalogueMap.city = catalogueObject.City__c;
        catalogueMap.address = catalogueObject.Address__c;
        Location loc = catalogueObject.Location__c;
        catalogueMap.location =  new Map<String,Double>();
        If(!(loc == null)){
        catalogueMap.location.put('Latitude', loc.latitude);
        catalogueMap.location.put('Longitude',loc.longitude);}
        catalogueMap.phone = catalogueObject.Phone__c;
        catalogueMap.emergencyNumber = catalogueObject.Emergency_Number__c;
        catalogueMap.type = catalogueObject.Type__c;
        catalogueMap.description = catalogueObject.Description__c;
        catalogueMap.houseRules = catalogueObject.House_Rules__c;
        catalogueMap.changePolicy = catalogueObject.Change_Policy__c;
        catalogueMap.cancellationPolicy = catalogueObject.Cancellation_Policy__c;
        catalogueMap.benefits = catalogueObject.Benefits__c;
        catalogueMap.category  = recordTypeRepositoryInstance.getRecordTypebyId(catalogueObject.RecordTypeId).Name;
        catalogueMap.recommendations = catalogueObject.Recommendations__c;
        catalogueMap.photoCatalogues = photoCataloguesMap(catalogueObject);
        catalogueMap.linksCatalogues = linkCataloguesMap(catalogueObject);

        return catalogueMap;
    }
    
    public Map<String,List<String>> photoCataloguesMap(Catalogue__c catalogueObject){
        CataloguePhotosRepository cataloguePhotosRepositoryInstance = CataloguePhotosRepository.getInstance();
        ImageListMapper ImageListMapperInstance = ImageListMapper.getInstance(); 
        Map<String,List<String>> photoCataloguesMap = new Map<String,List<String>>();
        RecordType rt =[select Id from RecordType where Name = 'Photo Gallery' and SobjectType = 'Catalogue_Photos__c'];
        List<Catalogue_Photos__c> photoCatalogues = cataloguePhotosRepositoryInstance.FindPhotoByCatalogueandRecordType(catalogueObject.Id, rt);

        for(Catalogue_Photos__c c :photoCatalogues ){
            photoCataloguesMap.put(c.Name, ImageListMapperInstance.ConvertToImageList(c.Photos__c));
        }
            return photoCataloguesMap;
    }

    public Map<String,String> linkCataloguesMap(Catalogue__c catalogueObject){
         CataloguePhotosRepository cataloguePhotosRepositoryInstance = CataloguePhotosRepository.getInstance();

        Map<String,String> linkCataloguesMap = new Map<String,String>();
        RecordType rt =[select Id from RecordType where Name = 'Link' and SobjectType = 'Catalogue_Photos__c'];
        List<Catalogue_Photos__c> LinkCatalogues = cataloguePhotosRepositoryInstance.FindPhotoByCatalogueandRecordType(catalogueObject.Id, rt);
        for(Catalogue_Photos__c c :LinkCatalogues ){
            linkCataloguesMap.put(c.Name, c.Link__c);
        }
        return linkCataloguesMap;
    }


    global  List<CatalogueMapper> catalogueObjectListToMapperList(List<Catalogue__c> catalogueObjectList){

        List<CatalogueMapper> mapperList = new List<CatalogueMapper>();

        for( Catalogue__c c : catalogueObjectList ){

            mapperList.add(CatalogueObjectToMapper(c));
        }

        return mapperList;
      }

}
