/**
 * @description       : 
 * @author            : Mohamed Tarek
 * @group             : 
 * @last modified on  : 02-21-2023
 * @last modified by  : Mohamed Tarek
**/
global class VisaAndPassportExpirySchedule implements Schedulable {
    
    global void execute(SchedulableContext sc)
    {
        // Implement any logic to be scheduled
       
        // We now call the batch class to be scheduled
        PassportExpiryBatch passportExpiryBatch = new PassportExpiryBatch ();
       
        //Parameters of ExecuteBatch(context,BatchSize)
        database.executebatch(passportExpiryBatch,200);

        VisaExpiryBatch visaExpiryBatch=new VisaExpiryBatch();
        database.executebatch(visaExpiryBatch,200);
    } 
   
}