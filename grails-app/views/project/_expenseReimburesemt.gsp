<div class="allbody">
<style>
 .maintable th
 {
 border:1px solid black;
 }

fieldset 
{
border:1px solid black 
}

h1,h2,h4,h5,h5 
{
 text-align: center;
}
p
{
text-align: center;
}
</style>

 <style type='text/css' media='print'>
             body {
                 margin: 0;
                 padding: 0;
                 background-color: #FAFAFA;
                 font: 12pt "Tahoma";
             }
             * {
                 box-sizing: border-box;
                 -moz-box-sizing: border-box;
             }
             .page {
                 width: 21cm;
                 height: 29.7cm;
                 #padding-left: 1.6cm;
                 #margin: 1cm;
                 #border: 1px #D3D3D3 solid;
                 #border-radius: 5px;
                 background: white;
                 #box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
             }
             .subpageTop{
                // padding: 0.5cm;
                 #border: 5px red solid;
                 #height: 148mm;
                 #outline: 2cm #FFEAEA solid;
             }
             .subpageBottom {
                 //padding-top: 0.5cm;
                 #border: 5px red solid;
                 #height: 130mm;
                 #outline: 0.5cm #FFEAEA solid;
             }
 
             @page {
                 size: A4;
               
             }
             @media print {
                 html, body {
                     width: 210mm;
                     height: 297mm;
                 }
                 .page {
                     margin: 0;
                     border: initial;
                     border-radius: initial;
                     width: initial;
                     min-height: initial;
                     box-shadow: initial;
                     background: initial;
                     page-break-after:always;
                 }
             }
        </style>


 <div class="page">
 
 <div class="subpageTop">
  <fieldset>

  <h4>International Society For Krishna Consciousness(ISKCON)</h4>
  <h5>(Regd.Office,:Hare Krishna Land,Juhu, Mumbai-400 049.)</h5>
  <h5>(Branch:4,Tarapore Road,Camp,Pune411 001.)</h4> 
  
  <table style="width:100%">
  
        <tr>
         <td><span style="float: left;">   </span></td>
         <td><span style="float: right; padding-right:20px;"><h5>   No:${projectInstance.ref}  <h5></span></td>
        </tr>
     
     
        <tr><h4>DEBIT VOUCHER</h4></tr>
   
        <tr>  
          <td><span style="float: left;"><h5>  Department: ${projectInstance?.costCenter?.name} <h5></span></td>
          <td><span style="float: right;padding-right:20px;"><h5>   Date:${new Date()?.format('dd-MM-yyyy')}    <h5></span></td>
       </tr> 
      
  </table>
    

<g:render template="expenseItems" model="['projectInstance':projectInstance,'expenses':expenses]" />     
 
  
  <table class="maintable" style="border: 1px solid black;width:100%">
  
          
           <tbody>        
                     
           <tr>
	          <td>(Sactionary Autority)</td>
	          <td><p>(Receiver)</p> </td>
	         <td><p>(Accountant)</p></td>
           </tr> 
           
        </tbody> 
        
       </table>
       
  </fieldset>
  
    </div>    
       
    <div class="subpageBottom">  <!-- subpageBottom Copy -->
  <fieldset>

  <h4>International Society For Krishna Consciousness(ISKCON)</h4>
  <h5>(Regd.Office,:Hare Krishna Land,Juhu, Mumbai-400 049.)</h5>
  <h5>(Branch:4,Tarapore Road,Camp,Pune411 001.)</h4> 
  
  <table style="width:100%">
  
        <tr>
         <td><span style="float: left;">   </span></td>
         <td><span style="float: right; padding-right:20px;"><h5>   No:${projectInstance.ref}  <h5></span></td>
        </tr>
     
     
        <tr><h4>DEBIT VOUCHER</h4></tr>
   
        <tr>  
          <td><span style="float: left;"><h5>  Department: ${projectInstance?.costCenter?.name} <h5></span></td>
          <td><span style="float: right;padding-right:20px;"><h5>   Date:${new Date()?.format('dd-MM-yyyy')}    <h5></span></td>
       </tr> 
      
  </table>
    

<g:render template="expenseItems" model="['projectInstance':projectInstance,'expenses':expenses]" />     
 
  
  <table class="maintable" style="border: 1px solid black;width:100%">
  
          
           <tbody>        
                     
           <tr>
	          <td>(Sactionary Autority)</td>
	          <td><p>(Receiver)</p> </td>
	         <td><p>(Accountant)</p></td>
           </tr> 
           
        </tbody> 
        
       </table>
       
  </fieldset>

    </div>   <!-- End of subpageOffice Div -->  
</div>    <!-- End of Page Div --> 
</div>                    <!-- End of allBody Div --> 