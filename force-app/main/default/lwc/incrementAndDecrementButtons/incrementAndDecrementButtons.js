import { LightningElement, api, track } from 'lwc';
import {
    FlowAttributeChangeEvent,
    FlowNavigationNextEvent,
} from 'lightning/flowSupport';

export default class GenericFlowButton extends LightningElement {
    @api Current_Number_Of_Fields;
    @api Add_Button_Label;
    @api Remove_Button_Label;
    @api Maximum_Number_Of_Fields;
    Show_Remove_Button;
    Show_Add_Button;

    connectedCallback() {
        if(this.Current_Number_Of_Fields == null){
            this.Current_Number_Of_Fields=0;
        }
        this.Show_Remove_Button=(this.Current_Number_Of_Fields!=0);
        this.Show_Add_Button=(this.Maximum_Number_Of_Fields== null || this.Current_Number_Of_Fields<this.Maximum_Number_Of_Fields);
   
    }


       handleClickAdd() {
        console.log('Add '+this.Current_Number_Of_Fields)
        if(this.Current_Number_Of_Fields<this.Maximum_Number_Of_Fields || this.Maximum_Number_Of_Fields==null){
            console.log('added');
        this.Current_Number_Of_Fields++;
        const attributeChangeEvent = new FlowAttributeChangeEvent('Current_Number_Of_Fields',this.Current_Number_Of_Fields);
        this.dispatchEvent(attributeChangeEvent);  
        }
        this.Show_Add_Button=(this.Maximum_Number_Of_Fields== null || this.Current_Number_Of_Fields<this.Maximum_Number_Of_Fields);
        this.Show_Remove_Button=(this.Current_Number_Of_Fields!=0);

    }
       handleClickSubtract(){
        console.log('remove '+this.Current_Number_Of_Fields+' '+this.Maximum_Number_Of_Fields)

        if(this.Current_Number_Of_Fields>0){
            this.Current_Number_Of_Fields--;
            const attributeChangeEvent = new FlowAttributeChangeEvent('Current_Number_Of_Fields',this.Current_Number_Of_Fields);
            this.dispatchEvent(attributeChangeEvent);  
    
            }
            this.Show_Remove_Button=(this.Current_Number_Of_Fields!=0);
            this.Show_Add_Button=(this.Maximum_Number_Of_Fields== null || this.Current_Number_Of_Fields<this.Maximum_Number_Of_Fields)

    }


}