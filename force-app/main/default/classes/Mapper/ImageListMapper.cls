public class ImageListMapper {

    private static ImageListMapper instance = null;


    private ImageListMapper() {

    }

    public static ImageListMapper getInstance() {
      // if (instance == null) {
          instance = new ImageListMapper();
       // }
        return instance;
      }

      public List<String> ConvertToImageList(String images){

        List<String> imageList = new List<String>();
        if(images != null) {
        Matcher imgMatcher = Pattern.compile( '<img(.+?)>' ).matcher( images);

        // iterate each image tag found
        while ( imgMatcher.find() ) {
        
            // get the image tag html
            String imageTag = imgMatcher.group();
            System.debug( 'imageTag=' + imageTag );
        
            // get the value of the src attribute
            // the leading space is significant to avoid other attributes like data-cke-saved-src
            String imageURL = imageTag.substringBetween( ' src="', '"' );
            imageURL.replace('&amp;', '&');
             imageList.add(imageURL);
        }
    }

         return imageList;
      }
}