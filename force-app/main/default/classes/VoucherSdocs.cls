/**
 * @description       : 
 * @author            : Mohamed Tarek
 * @group             : 
 * @last modified on  : 02-14-2023
 * @last modified by  : Mohamed Tarek
**/
global class VoucherSdocs implements Callable {

    public Object call(String action, Map<String,Object> args) {
        switch on action {
          
           
            when 'getService'{
                
                return this.getServiceInfo((String) args.get('serviceId'));
            }
            when 'getInfo'{
                return this.getExtraInfo((String) args.get('serviceId'));
            }
            
            when else {
                throw new ExtensionMalformedCallException('Method not implemented');
            }
        }
    }
    public class ExtensionMalformedCallException extends Exception {}
    public Map<String,String> getExtraInfo(String id){
        Map<String,String> result=new Map<String,String>();
        Company_Info__mdt extraInfo=[SELECT Phone__c,Email__c,Address__c,Url__c,Reg_No__c,Tax_Id__c,License_No__c FROM Company_Info__mdt WHERE Label='Egyliere Info'];
        System.debug('ID: '+id);
        Opprtunity_Line_Item_Details__c oppItemDetails=[SELECT Id,Adult__c,Contact__r.Name,Arival_Date__c,Bed_size__c,Hotel__c,Room__c,Type__c,Departure_1__c,Meal_Plan__c,Confirmation_Number__c,Citizenship__c,Sub_Type__c,Number_Of_Guests__c,Catalogue__c,Catalogue__r.Name,Catalogue__r.Phone__c,Catalogue__r.Address__c,Category__c FROM Opprtunity_Line_Item_Details__c WHERE Id=:id];
        result.put('regNo',extraInfo.Reg_No__c);
        result.put('licenseNo',extraInfo.License_No__c); 
        result.put('email',extraInfo.Email__c);
        result.put('phone',extraInfo.Phone__c);
        result.put('address',extraInfo.Address__c);
        result.put('url',extraInfo.Url__c);
        result.put('licenseNo',extraInfo.License_No__c);
        result.put('taxId',extraInfo.Tax_Id__c);
        if(oppItemDetails.Sub_Type__c=='Transport Arrangement - Booking' || oppItemDetails.Sub_Type__c=='Health and Vaccine' ||  oppItemDetails.Sub_Type__c=='Visa Management'){
            result.put('title',oppItemDetails.Category__c);
        }else{
        if(oppItemDetails.Catalogue__c!=null){
        result.put('title',oppItemDetails.Catalogue__r.Name);
        }
    }
        return result;
    }
    public SDOC.SDUtil.SDocTable getServiceInfo(String id){
        SDOC.SDUtil.SDocTable table=new SDOC.SDUtil.SDocTable();
        Opprtunity_Line_Item_Details__c[] oppItemDetails=[SELECT  Id,Adult__c,Arival_Date1__c,End_Date__c,Type_Of_Visa__c,Additional_Details__c,Start_Date__c,Category__c,Contact__r.Name,Arival_Date__c,Bed_size__c,Hotel__c,Room__c,Type__c,Departure_1__c,Departure__c,Destination__c,Meal_Plan__c,Confirmation_Number__c,Citizenship__c,Sub_Type__c,Number_Of_Guests__c,Departure_Date__c,Prefrence__c,Request_Details__c,Flight_Number__c,Child_0_2yr__c,Child_3_12yr__c,Contact_name__c,Contact_number__c,Booking__c,Transport_Type__c,Operation_Details__c FROM Opprtunity_Line_Item_Details__c WHERE Id=:id];
        if(oppItemDetails.size()!=0){
            Opprtunity_Line_Item_Details__c oppItemDetail=oppItemDetails[0];
            if(oppItemDetail.Sub_Type__c=='Accommodation Management'){
                SDOC.SDUtil.SDocTableRow row=new SDOC.SDUtil.SDocTableRow();
                row.cells.add(new SDOC.SDUtil.SDocTableCell('label','Passenger Name:'));
                row.cells.add(new SDOC.SDUtil.SDocTableCell('value',oppItemDetail.Contact__r.Name));
                table.rows.add(row);
                row=new SDOC.SDUtil.SDocTableRow();
                row.cells.add(new SDOC.SDUtil.SDocTableCell('label','Service Type:'));
                row.cells.add(new SDOC.SDUtil.SDocTableCell('value',oppItemDetail.Sub_Type__c));
                table.rows.add(row);
                row=new SDOC.SDUtil.SDocTableRow();
                row.cells.add(new SDOC.SDUtil.SDocTableCell('label','Check-In:'));
                if(oppItemDetail.Arival_Date__c!=null){
                row.cells.add(new SDOC.SDUtil.SDocTableCell('value',oppItemDetail.Arival_Date__c.format('dd MMMM YYYY')));
                }
                table.rows.add(row);
                row=new SDOC.SDUtil.SDocTableRow();
                row.cells.add(new SDOC.SDUtil.SDocTableCell('label','Check-Out:'));
                if(oppItemDetail.Departure_Date__c!=null){
                row.cells.add(new SDOC.SDUtil.SDocTableCell('value',oppItemDetail.Departure_Date__c.format('dd MMMM YYYY')));
                }
                table.rows.add(row);

                row=new SDOC.SDUtil.SDocTableRow();
                row.cells.add(new SDOC.SDUtil.SDocTableCell('label','Room Occupancy:'));
                row.cells.add(new SDOC.SDUtil.SDocTableCell('value',''+oppItemDetail.Room__c));
                table.rows.add(row);

                row=new SDOC.SDUtil.SDocTableRow();
                row.cells.add(new SDOC.SDUtil.SDocTableCell('label','Bedding:'));
                row.cells.add(new SDOC.SDUtil.SDocTableCell('value',oppItemDetail.Bed_size__c));
                table.rows.add(row);


                row=new SDOC.SDUtil.SDocTableRow();
                row.cells.add(new SDOC.SDUtil.SDocTableCell('label','Room Type:'));
                row.cells.add(new SDOC.SDUtil.SDocTableCell('value',oppItemDetail.Prefrence__c));
                table.rows.add(row);



                row=new SDOC.SDUtil.SDocTableRow();
                row.cells.add(new SDOC.SDUtil.SDocTableCell('label','Meal Plan:'));
                row.cells.add(new SDOC.SDUtil.SDocTableCell('value',oppItemDetail.Meal_Plan__c));
                table.rows.add(row);


                row=new SDOC.SDUtil.SDocTableRow();
                row.cells.add(new SDOC.SDUtil.SDocTableCell('label','Confirmation Number:'));
                row.cells.add(new SDOC.SDUtil.SDocTableCell('value',oppItemDetail.Confirmation_Number__c));
                table.rows.add(row);


            }
            if(oppItemDetail.Sub_Type__c=='Dining & Nightspots Reservations'){
                SDOC.SDUtil.SDocTableRow row=new SDOC.SDUtil.SDocTableRow();
                row.cells.add(new SDOC.SDUtil.SDocTableCell('label','Passenger Name:'));
                row.cells.add(new SDOC.SDUtil.SDocTableCell('value',oppItemDetail.Contact__r.Name));
                table.rows.add(row);
                row=new SDOC.SDUtil.SDocTableRow();
                row.cells.add(new SDOC.SDUtil.SDocTableCell('label','Service Type:'));
                row.cells.add(new SDOC.SDUtil.SDocTableCell('value',oppItemDetail.Sub_Type__c));
                table.rows.add(row);
                row=new SDOC.SDUtil.SDocTableRow();
                row.cells.add(new SDOC.SDUtil.SDocTableCell('label','Date:'));
                if(oppItemDetail.Arival_Date__c!=null){
                row.cells.add(new SDOC.SDUtil.SDocTableCell('value',oppItemDetail.Arival_Date__c.format('dd MMMM YYYY')));
                }
                table.rows.add(row);
                row=new SDOC.SDUtil.SDocTableRow();
                row.cells.add(new SDOC.SDUtil.SDocTableCell('label','Time:'));
                if(oppItemDetail.Arival_Date__c!=null){
                row.cells.add(new SDOC.SDUtil.SDocTableCell('value',oppItemDetail.Arival_Date__c.format('hh:mm a')));
                }
                table.rows.add(row);

                row=new SDOC.SDUtil.SDocTableRow();
                row.cells.add(new SDOC.SDUtil.SDocTableCell('label','Number of guests:'));
                row.cells.add(new SDOC.SDUtil.SDocTableCell('value',''+oppItemDetail.Number_Of_Guests__c));
                table.rows.add(row);


                row=new SDOC.SDUtil.SDocTableRow();
                row.cells.add(new SDOC.SDUtil.SDocTableCell('label','Confirmed By:'));
                row.cells.add(new SDOC.SDUtil.SDocTableCell('value',oppItemDetail.Request_Details__c));
                table.rows.add(row);


                row=new SDOC.SDUtil.SDocTableRow();
                row.cells.add(new SDOC.SDUtil.SDocTableCell('label','Seating:'));
                row.cells.add(new SDOC.SDUtil.SDocTableCell('value',oppItemDetail.Prefrence__c));
                table.rows.add(row);

            }
           
            if(oppItemDetail.Sub_Type__c=='Transport Arrangement - Booking'){
                SDOC.SDUtil.SDocTableRow row=new SDOC.SDUtil.SDocTableRow();
                row.cells.add(new SDOC.SDUtil.SDocTableCell('label','Passenger Name:'));
                row.cells.add(new SDOC.SDUtil.SDocTableCell('value',oppItemDetail.Contact__r.Name));
                table.rows.add(row);
                row=new SDOC.SDUtil.SDocTableRow();
                row.cells.add(new SDOC.SDUtil.SDocTableCell('label','Service Type:'));
                row.cells.add(new SDOC.SDUtil.SDocTableCell('value',oppItemDetail.Sub_Type__c));
                table.rows.add(row);

                row=new SDOC.SDUtil.SDocTableRow(); 
                row.cells.add(new SDOC.SDUtil.SDocTableCell('label','Date & Time:'));
                if(oppItemDetail.Arival_Date__c!=null){
                row.cells.add(new SDOC.SDUtil.SDocTableCell('value',oppItemDetail.Arival_Date__c.format('dd MMMM YYYY - hh:mm a')));
                }
                table.rows.add(row);
                row=new SDOC.SDUtil.SDocTableRow();
                row.cells.add(new SDOC.SDUtil.SDocTableCell('label','Pick-up Address:'));
                row.cells.add(new SDOC.SDUtil.SDocTableCell('value',oppItemDetail.Departure__c));
                table.rows.add(row);

                row=new SDOC.SDUtil.SDocTableRow();
                row.cells.add(new SDOC.SDUtil.SDocTableCell('label','Drop-off Address:'));
                row.cells.add(new SDOC.SDUtil.SDocTableCell('value',oppItemDetail.Destination__c));
                table.rows.add(row);

                row=new SDOC.SDUtil.SDocTableRow();
                row.cells.add(new SDOC.SDUtil.SDocTableCell('label','Number of Travelers:'));
                row.cells.add(new SDOC.SDUtil.SDocTableCell('value',''+oppItemDetail.Booking__c));
                table.rows.add(row);

                row=new SDOC.SDUtil.SDocTableRow();
                row.cells.add(new SDOC.SDUtil.SDocTableCell('label','Transportation Type:'));
                row.cells.add(new SDOC.SDUtil.SDocTableCell('value',oppItemDetail.Transport_Type__c));
                table.rows.add(row);

                row=new SDOC.SDUtil.SDocTableRow();
                row.cells.add(new SDOC.SDUtil.SDocTableCell('label','Vehicle:'));
                row.cells.add(new SDOC.SDUtil.SDocTableCell('value',oppItemDetail.Request_Details__c));
                table.rows.add(row);

                row=new SDOC.SDUtil.SDocTableRow();
                row.cells.add(new SDOC.SDUtil.SDocTableCell('label','Plates Number:'));
                row.cells.add(new SDOC.SDUtil.SDocTableCell('value',oppItemDetail.Operation_Details__c));
                table.rows.add(row);




                row=new SDOC.SDUtil.SDocTableRow();
                row.cells.add(new SDOC.SDUtil.SDocTableCell('label','Driver name:'));
                row.cells.add(new SDOC.SDUtil.SDocTableCell('value',oppItemDetail.Contact_name__c));
                table.rows.add(row);

                row=new SDOC.SDUtil.SDocTableRow();
                row.cells.add(new SDOC.SDUtil.SDocTableCell('label','Driver number:'));
                row.cells.add(new SDOC.SDUtil.SDocTableCell('value',oppItemDetail.Contact_number__c));
                table.rows.add(row);


                row=new SDOC.SDUtil.SDocTableRow();
                row.cells.add(new SDOC.SDUtil.SDocTableCell('label','Confirmation number:'));
                row.cells.add(new SDOC.SDUtil.SDocTableCell('value',oppItemDetail.Confirmation_Number__c));
                table.rows.add(row);





            }

            if(oppItemDetail.Sub_Type__c=='Health and Vaccine'){
                SDOC.SDUtil.SDocTableRow row=new SDOC.SDUtil.SDocTableRow();
                row.cells.add(new SDOC.SDUtil.SDocTableCell('label','Name:'));
                row.cells.add(new SDOC.SDUtil.SDocTableCell('value',oppItemDetail.Contact__r.Name));
                table.rows.add(row);
                row=new SDOC.SDUtil.SDocTableRow();
                row.cells.add(new SDOC.SDUtil.SDocTableCell('label','Category:'));
                row.cells.add(new SDOC.SDUtil.SDocTableCell('value',oppItemDetail.Category__c));
                table.rows.add(row);

                row=new SDOC.SDUtil.SDocTableRow(); 
                row.cells.add(new SDOC.SDUtil.SDocTableCell('label','Date & Time:'));
                if(oppItemDetail.Arival_Date__c!=null){
                row.cells.add(new SDOC.SDUtil.SDocTableCell('value',oppItemDetail.Arival_Date__c.format('dd MMMM YYYY - hh:mm a')));
                }
                table.rows.add(row);
                row=new SDOC.SDUtil.SDocTableRow();
                row.cells.add(new SDOC.SDUtil.SDocTableCell('label','Destination:'));
                row.cells.add(new SDOC.SDUtil.SDocTableCell('value',oppItemDetail.Destination__c));
                table.rows.add(row);

                row=new SDOC.SDUtil.SDocTableRow();
                row.cells.add(new SDOC.SDUtil.SDocTableCell('label','Adult:'));
                row.cells.add(new SDOC.SDUtil.SDocTableCell('value',''+oppItemDetail.Adult__c));
                table.rows.add(row);
                
                row=new SDOC.SDUtil.SDocTableRow();
                row.cells.add(new SDOC.SDUtil.SDocTableCell('label','Infant:'));
                row.cells.add(new SDOC.SDUtil.SDocTableCell('value',''+oppItemDetail.Child_0_2yr__c));
                table.rows.add(row);


                row=new SDOC.SDUtil.SDocTableRow();
                row.cells.add(new SDOC.SDUtil.SDocTableCell('label','Child:'));
                row.cells.add(new SDOC.SDUtil.SDocTableCell('value',''+oppItemDetail.Child_3_12yr__c));
                table.rows.add(row);

                row=new SDOC.SDUtil.SDocTableRow();
                row.cells.add(new SDOC.SDUtil.SDocTableCell('label','Additional Details:'));
                row.cells.add(new SDOC.SDUtil.SDocTableCell('value',''+oppItemDetail.Additional_Details__c));
                table.rows.add(row);


            }


            if(oppItemDetail.Sub_Type__c=='Visa Management'){
                SDOC.SDUtil.SDocTableRow row=new SDOC.SDUtil.SDocTableRow();
                row.cells.add(new SDOC.SDUtil.SDocTableCell('label','Traveler Name:'));
                row.cells.add(new SDOC.SDUtil.SDocTableCell('value',oppItemDetail.Contact__r.Name));
                table.rows.add(row);
                row=new SDOC.SDUtil.SDocTableRow();
                row.cells.add(new SDOC.SDUtil.SDocTableCell('label','Start Date:'));
                if(oppItemDetail.Arival_Date__c!=null){
                row.cells.add(new SDOC.SDUtil.SDocTableCell('value',oppItemDetail.Arival_Date__c.format('dd MMMM YYYY - hh:mm a')));
                }
                table.rows.add(row);

                row=new SDOC.SDUtil.SDocTableRow();
                row.cells.add(new SDOC.SDUtil.SDocTableCell('label','End Date:'));
                if(oppItemDetail.Departure_Date__c!=null){
                row.cells.add(new SDOC.SDUtil.SDocTableCell('value',oppItemDetail.Departure_Date__c.format('dd MMMM YYYY - hh:mm a')));
                }
                table.rows.add(row);
                row=new SDOC.SDUtil.SDocTableRow(); 
                row.cells.add(new SDOC.SDUtil.SDocTableCell('label','Appointment:'));
                row.cells.add(new SDOC.SDUtil.SDocTableCell('value',oppItemDetail.Arival_Date1__c.format('dd MMMM YYYY - hh:mm a')));
                table.rows.add(row);
                row=new SDOC.SDUtil.SDocTableRow();
                row.cells.add(new SDOC.SDUtil.SDocTableCell('label','Type Of Visa:'));
                row.cells.add(new SDOC.SDUtil.SDocTableCell('value',oppItemDetail.Type_Of_Visa__c));
                table.rows.add(row);
                row=new SDOC.SDUtil.SDocTableRow();
                row.cells.add(new SDOC.SDUtil.SDocTableCell('label','Citizenship:'));
                row.cells.add(new SDOC.SDUtil.SDocTableCell('value',oppItemDetail.Citizenship__c));
                table.rows.add(row);
                row=new SDOC.SDUtil.SDocTableRow();
                row.cells.add(new SDOC.SDUtil.SDocTableCell('label','Requirements:'));
                row.cells.add(new SDOC.SDUtil.SDocTableCell('value',oppItemDetail.Request_Details__c));
                table.rows.add(row);



                row=new SDOC.SDUtil.SDocTableRow();
                row.cells.add(new SDOC.SDUtil.SDocTableCell('label','Adult:'));
                row.cells.add(new SDOC.SDUtil.SDocTableCell('value',''+oppItemDetail.Adult__c));
                table.rows.add(row);
                
                row=new SDOC.SDUtil.SDocTableRow();
                row.cells.add(new SDOC.SDUtil.SDocTableCell('label','Infant:'));
                row.cells.add(new SDOC.SDUtil.SDocTableCell('value',''+oppItemDetail.Child_0_2yr__c));
                table.rows.add(row);


                row=new SDOC.SDUtil.SDocTableRow();
                row.cells.add(new SDOC.SDUtil.SDocTableCell('label','Child:'));
                row.cells.add(new SDOC.SDUtil.SDocTableCell('value',''+oppItemDetail.Child_3_12yr__c));
                table.rows.add(row);

                row=new SDOC.SDUtil.SDocTableRow();
                row.cells.add(new SDOC.SDUtil.SDocTableCell('label','Additional Details:'));
                row.cells.add(new SDOC.SDUtil.SDocTableCell('value',''+oppItemDetail.Additional_Details__c));
                table.rows.add(row);


            }




                }
        return table;

    }
}