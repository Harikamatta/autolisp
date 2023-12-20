aied : dialog {

  label = "1st QUADRANT'S Fire Door Automation ";
  : row
  {
    :column
    {
  : boxed_radio_column
   {
    label = "Types of door";
    : radio_button
     { 
      label = "Single  Door";
      key = "rbsd";
     }
     : radio_button
     { 
      label = "Double Door Equal Shutter";
      key = "rbde";
      
     }
     : radio_button
     { 
      label = "Double Door Unequal Shutter";
      key = "rbdu";
     }

     }
    }

  : image
  {
    key= "logo";
    height = 5.5;
    width = 10;
    fixed_height = true;
    fixed_width = true;
    aspect_ratio = 1.0;
    
  }

  }
      : boxed_radio_column 
      {
        label = "Select Door orientation";
        :radio_button 
        { 
          label = "Right Push Active";
          key = "rbrp";
        }
      : radio_button 
        { 
          label = "Left Push Active";
          key = "rblp";
          
        }
        

      }
 


      : column 
     {
        : boxed_column 
        {
         label = "Select the Frame thicnkess" ;
         : popup_list 
          { 
            label = "Frame Thicnkess";
            value = "0";
            key = "framesel";
            edit_width = 20;
          
          }
        }
        : boxed_column 
        {
          : popup_list 
          {
            label = "Types of frame";
            value = "0";
            key = "tof";
            edit_width = 20;
          }
         
        }

        :boxed_column
        {
	:edit_box
	{
	label = "Enter Quantity of Door : - ";
	key = "eqd";
	width = 25;
	value = 1;

	
        }
        }
      : column 
      {
        label = "Enter Dimensions of door";
        : edit_box 
        { 
          label = "Enter width of the Door : ";
          key = "width";
          edit_width = 20;
         }
         : edit_box 
         {  
           label = "Enter the Heigth of the Door :";
           key = "height";
           edit_width = 20;
         }
      }
      spacer;
      : text 
      { label = "";
        key = "warning";
        alignment = centered;
        }

      }

     

    
   
  ok_cancel;

  

}