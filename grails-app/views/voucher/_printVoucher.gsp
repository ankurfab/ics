<%@ page import="ics.EnglishNumberToWords" %>
<%@ page import="ics.Voucher" %>

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
 
 h1,h2,h4
 {
  text-align: center;
 }
 h5
 {
 text-align: center;
 font: 9pt "Tahoma";
 }
 .header1
 {
 text-align: center;
 font: 9pt "Tahoma";
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
                 font: 9pt "Tahoma";
             }
             * {
                 box-sizing: border-box;
                 -moz-box-sizing: border-box;
             }
             .page {
                 width: 21cm;
                 height: 297mm;
                 #padding-left: 1.6cm;
                 margin: 1cm;
                 #border: 1px #D3D3D3 solid;
                 border-radius: 5px;
                 background: white;
                 box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
             }
             .subpageTop{
                 padding: 0.5cm;
                 #border: 1px blue solid;
                 height: 148mm;
                 #outline: 1cm #FFEAEA solid;
             }
             .subpageBottom {
                 padding-top: 0.5cm;
                 #border: 1px red solid;
                 height: 148mm;
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
             
              table.advancetoptable{width:100%;}
 	     .advancetoptable tr td {height:10px; font: 9pt "Tahoma"; }  
 	            
 	     table.advancebottomtable{width:100%;  }
              .advancebottomtable tr td {height:10px; font: 9pt "Tahoma";  } 
              
             table.signtable{width:100%;  }
             .signtable tr td {height:10px; font: 9pt "Tahoma";  }     
              
              .header1
	      {
	      text-align: center;
	      font: 9pt "Tahoma";
               }
         </style>
          <!-- domain class values:
	       amount
	       description
	       amountSettled
	       amount
	       ledger
	       anotherLedger
	       amount
	       debit
	       ${voucherInstance?.departmentCode?.id}
      status  -->
<div id="barCode"></div>
   <div class="page">
    
    <div class="subpageTop">
       <g:render template="voucherItems"  />
    </div> 
     
     <div class="subpageBottom">  <!-- bottom Copy -->
      <g:render template="voucherItems"  />
     </div>   <!-- End of subpageBottom Div -->  
     
   </div> 

</div>
<script>
$(document).ready(function()
{
	$("#barCode").barcode(
		"${voucherInstance.voucherNo}", // Value barcode (dependent on the type of barcode)
		"code39" // type (string)
	);
});
</script>