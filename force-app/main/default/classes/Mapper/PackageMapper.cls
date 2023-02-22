global class PackageMapper {
    List<ServiceMapper> services;
    Decimal totalPrice;

    public PackageMapper() {

    }

    public PackageMapper PackageobjectToMapper(Opportunity o , List<ServiceMapper> services){
        PackageMapper packagemapper = new PackageMapper();
        packagemapper.totalPrice = o.Amount;
        packagemapper.services = services;

        return packagemapper;
    }
}
