global class VideoMapper {
    String name;
    String thumbnailImage;
    String videoLink;

    public VideoMapper() {

    }
    public VideoMapper convertVideo(Catalogue_Photos__c videoCatalogue){
        ImageListMapper ImageListMapperInstance = ImageListMapper.getInstance(); 
        VideoMapper videoMapper = new VideoMapper();
        videoMapper.name = videoCatalogue.Name;
        videoMapper.thumbnailImage = ImageListMapperInstance.ConvertToImageList(videoCatalogue.thumbnail_Image__c).get(0);
        videoMapper.videoLink = videoCatalogue.Video_Link__c;
        return videoMapper;
    }
    public List<VideoMapper> convertVideos(List<Catalogue_Photos__c> videoCatalogues){
        List<VideoMapper> videoMap = new List<VideoMapper>();
        for(Catalogue_Photos__c v :videoCatalogues ){
            videoMap.add(convertVideo(v));
        }

        return videoMap;
    }
}
