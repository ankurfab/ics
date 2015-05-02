<%@ page import="ics.EnglishNumberToWords" %>
 
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
                height: 130mm;
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
            
             table#advancetoptable{width:100%;}
	     #advancetoptable tr td {height:10px; font: 9pt "Tahoma"; }  
	            
	     table#advancebottomtable{width:100%;  }
             #advancebottomtable tr td {height:10px; font: 9pt "Tahoma";  } 
        </style>


 <div class="page">
 
 <div class="subpageTop">
 
  <fieldset>

  <h4>International Society For Krishna Consciousness</h4>
  <h5>(Regd.Office:Hare Krishna Land,Juhu, Mumbai 400 049),</h5>
  <h5>(Branch:S.No.50/2,Katraj-Kondhwa Bypass Rd.,Opp. Shatrunjay Temple ,Kondhawa Bk,Pune-48,Ph.020-41033247/222.)</h5> 
  
  <table id="advancetoptable">
  <div class="header1">
  <tr> </tr>
            <tr>
             <td><span style="float: left;"> Expense Ref No: ${projectInstance?.ref} </span></td>
             <td>Date:${new Date()?.format('dd-MM-yyyy')}</td>
            </tr>
         </div>
         
            <tr><h4><u>ADVANCE REQUISITION SLIP</u></h4></tr>
          <div class="header1">
           <tr> 
           <td><span style="float: left;"> Vr. No: ${projectInstance?.advancePaymentVoucher?.voucherNo}</span></td>
            <td>Department:${projectInstance?.costCenter?.name}</td>
           </tr>
           </div>
         
       </table>
      To<br>
            The President,<br>
            ISKCON,Pune.<br>
            Dear Prabhu,<br>
            <br>
           
            
            Please grant me an advance of Rs.<b> ${projectInstance?.advanceAmountIssued} /- </b> for the following expenses:<br>
            In Words <b> ${org.apache.commons.lang.WordUtils.capitalize(EnglishNumberToWords.convert(projectInstance?.advanceAmountIssued?.toString()?:'0'))} Only </b><br>
           <br>
           <div id="description" > 
           <b> ${projectInstance?.name}</b> <br>  
           Description:<br>
            ${projectInstance?.description}<br>    
	  </div>
	  <br>
            I will settle the above amount by producing the necessary documents in  <b>  30  </b>  days <br><br>
            
          Thanking You. <br>
<table id="advancebottomtable">
             <div class="header1">
             <tr> </tr> 
                  <tr>  
                      <td><span style="float: left;padding-right:20px;">Your Servant,</span></td>
	       	      <td><p>Electronically Sanctioned By</p></td>
	          </tr>
	                       
	           <tr>  
	              <td><span style="float: left;padding-right:20px;"></span></td>
	       	      <td><p><b>${projectInstance?.reviewer1}</b> </p></td>
  		   </tr>
                 
                   <tr>
                      <td><span style="float: left;padding-right:20px;">(Signature) </span></td>
  		      <td><p>(Autorised Signatory) </p></td>
  	           </tr>  
              
                   <tr>
                      <td><span style="float: left;padding-right:20px;"> Name:  <b>${projectInstance?.submitter?:''}</b>  </span></td>
  		      <td><span style="float: right;"> </span></td>
  		   </tr> 
  		   
  		 </div>
            </table>
 
  </fieldset>

  </div> 
  
  <div class="subpageBottom">  <!-- bottom Copy -->
  
  <fieldset>

  <h4>International Society For Krishna Consciousness</h4>
  <h5>(Regd.Office:Hare Krishna Land,Juhu, Mumbai 400 049),</h5>
  <h5>(Branch:S.No.50/2,Katraj-Kondhwa Bypass Rd.,Opp. Shatrunjay Temple ,Kondhawa Bk,Pune-48,Ph.020-41033247/222.)</h5> 
  
  <table id="advancetoptable">
  <div class="header1">
  <tr> </tr>
            <tr>
             <td><span style="float: left;"> Expense Ref No: ${projectInstance?.ref} </span></td>
             <td>Date:${new Date()?.format('dd-MM-yyyy')}</td>
            </tr>
         </div>
         
            <tr><h4><u>ADVANCE REQUISITION SLIP</u></h4></tr>
          <div class="header1">
           <tr> 
           <td><span style="float: left;"> Vr. No: ${projectInstance?.advancePaymentVoucher?.voucherNo}</span></td>
            <td>Department:${projectInstance?.costCenter?.name}</td>
           </tr>
           </div>
         
       </table>
      To<br>
            The President,<br>
            ISKCON,Pune.<br>
            Dear Prabhu,<br>
            <br>
           
            
            Please grant me an advance of Rs.<b> ${projectInstance?.advanceAmountIssued} /- </b> for the following expenses:<br>
            In Words <b> ${org.apache.commons.lang.WordUtils.capitalize(EnglishNumberToWords.convert(projectInstance?.advanceAmountIssued?.toString()?:'0'))} Only </b><br>
           <br>
           <div id="description" > 
           <b> ${projectInstance?.name}</b> <br>  
           Description:<br>
            ${projectInstance?.description}<br>    
	  </div>
	  <br>
            I will settle the above amount by producing the necessary documents in  <b>  30  </b>  days <br><br>
            
          Thanking You. <br>
<table id="advancebottomtable">
             <div class="header1">
             <tr> </tr> 
                  <tr>  
                      <td><span style="float: left;padding-right:20px;">Your Servant,</span></td>
	       	      <td><p>Electronically Sanctioned By</p></td>
	          </tr>
	                       
	           <tr>  
	              <td><span style="float: left;padding-right:20px;"></span></td>
	       	      <td><p><b>${projectInstance?.reviewer1}</b> </p></td>
  		   </tr>
                 
                   <tr>
                      <td><span style="float: left;padding-right:20px;">(Signature) </span></td>
  		      <td><p>(Autorised Signatory) </p></td>
  	           </tr>  
              
                   <tr>
                      <td><span style="float: left;padding-right:20px;"> Name:  <b>${projectInstance?.submitter?:''}</b>  </span></td>
  		      <td><span style="float: right;"> </span></td>
  		   </tr> 
  		   
  		 </div>
            </table>
 
  </fieldset>
 
  
  
  
                    </div>   <!-- End of subpageBottom Div -->  
                </div>    <!-- End of Page Div --> 
</div>                    <!-- End of allBody Div --> 