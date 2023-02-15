global class PublicationMapper {
    public String name;
    public Datetime startDate;
    public Datetime endDate;
    public String location;
    public String tags;
    public List<String> images;
    public String description;
    public String id;
    public String catalougeId;
    public String catalougeCategory;

    public PublicationMapper() {
       
    }



    public static PublicationMapper getInstance() {
       // if (instance == null) {
        PublicationMapper instance = new PublicationMapper();
       //}
        return instance;
      }
      public  PublicationMapper PublicationObjectToMapper(Publication__c publicationObject){
       RecordTypeRepository recordTypeRepositoryInstance = RecordTypeRepository.getInstance();

        PublicationMapper mapper = PublicationMapper.getInstance();
        ImageListMapper ImageListMapperInstance = ImageListMapper.getInstance();
        mapper.name = publicationObject.Name;
        mapper.id = publicationObject.Id;
        mapper.tags = publicationObject.Tag__c;
        mapper.location= publicationObject.Location__c;
        mapper.startDate= publicationObject.Start_Date__c;  
        mapper.endDate= publicationObject.End_Date__c;
        mapper.description= publicationObject.Description__c;
        //mapper.images= publicationObject.Image__c;
        mapper.images= ImageListMapperInstance.ConvertToImageList(publicationObject.Image__c);
        mapper.catalougeId = publicationObject.Catalogue__r.Id;
       mapper.catalougeCategory =publicationObject.Catalogue__r.RecordType.Name;
      
        return mapper;
      }

      public  List<PublicationMapper> PublicationObjectListToMapperList(List<Publication__c> publicationObjectList){

        List<PublicationMapper> mapperList = new List<PublicationMapper>();

        for( Publication__c p : publicationObjectList ){

            mapperList.add(PublicationObjectToMapper(p));
        }

        return mapperList;
      }
}