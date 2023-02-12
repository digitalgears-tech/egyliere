global class CompanyInfoMapper {
String address;
String email;
String licenseNo;
String phone;
String regNo;
String taxID;
String url;
    public CompanyInfoMapper() {

    }

    public CompanyInfoMapper CompanyInfoMapper(Company_Info__mdt companyInfo){
        CompanyInfoMapper companyInfoMapper= new CompanyInfoMapper();
        companyInfoMapper.address = companyInfo.Address__c;
        companyInfoMapper.email = companyInfo.Email__c;
        companyInfoMapper.licenseNo = companyInfo.License_No__c;
        companyInfoMapper.phone = companyInfo.Phone__c;
        companyInfoMapper.regNo = companyInfo.Reg_No__c;
        companyInfoMapper.taxID =companyInfo.Tax_ID__c;

        return companyInfoMapper;
    }
}
