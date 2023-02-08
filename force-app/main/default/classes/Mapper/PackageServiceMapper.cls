public class PackageServiceMapper {
     public String logo;
     public Decimal totalPoints; 
     public String status;
     public String id;

    public PackageServiceMapper() {

    }
    public PackageServiceMapper(String logo, Decimal totalPoints, String status,String id) {
        this.logo = logo;
        this.totalPoints = totalPoints;
        this.status = status;
        this.id = id;
    }

   
}