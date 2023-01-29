/**
 * @description       : 
 * @author            : Mohamed Tarek
 * @group             : 
 * @last modified on  : 01-24-2023
 * @last modified by  : Mohamed Tarek
**/
@IsTest
public  class VoucherSdocsTest {

    @IsTest
    public static void getExtraInfoTest(){
       DataFactoryTest dataBaseFactoryTestInstance=DataFactoryTest.getInstance();
       Opprtunity_Line_Item_Details__c opp= dataBaseFactoryTestInstance.createOpprtunity_Line_Items_Details('Concierge Services','Transport Arrangement - Booking',Datetime.now(),Datetime.now());
       VoucherSdocs voucherSdocsTest=new VoucherSdocs();
       Map<String,String> info=new Map<String,String>();
       info.put('serviceId',opp.Id);
       voucherSdocsTest.call('getInfo', info);


    }
    @IsTest
    public static void getTransportServiceTest(){
        DataFactoryTest dataBaseFactoryTestInstance=DataFactoryTest.getInstance();
        Opprtunity_Line_Item_Details__c opp= dataBaseFactoryTestInstance.createOpprtunity_Line_Items_Details('Concierge Services','Transport Arrangement - Booking',Datetime.now(),Datetime.now());
        VoucherSdocs voucherSdocsTest=new VoucherSdocs();
        Map<String,String> info=new Map<String,String>();
        info.put('serviceId',opp.Id);
        voucherSdocsTest.call('getService', info);
        
    }

    @IsTest
    public static void getDiningServiceTest(){
        DataFactoryTest dataBaseFactoryTestInstance=DataFactoryTest.getInstance();
        Opprtunity_Line_Item_Details__c opp= dataBaseFactoryTestInstance.createOpprtunity_Line_Items_Details('Concierge Services','Dining & Nightspots Reservations',Datetime.now(),Datetime.now());
        VoucherSdocs voucherSdocsTest=new VoucherSdocs();
        Map<String,String> info=new Map<String,String>();
        info.put('serviceId',opp.Id);
        voucherSdocsTest.call('getService', info);

    }

    @IsTest
    public static void getAccomodationServiceTest(){
        DataFactoryTest dataBaseFactoryTestInstance=DataFactoryTest.getInstance();
        Opprtunity_Line_Item_Details__c opp= dataBaseFactoryTestInstance.createOpprtunity_Line_Items_Details('Travel Services','Accommodation Management',Datetime.now(),Datetime.now());
        VoucherSdocs voucherSdocsTest=new VoucherSdocs();
        Map<String,String> info=new Map<String,String>();
        info.put('serviceId',opp.Id);
        voucherSdocsTest.call('getService', info);

    }
  
}