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

.header1
{
text-align: center;
font: 8pt "Tahoma";
}

h5
{
text-align: center;
font: 8pt "Tahoma";
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
                 font: 8pt "Tahoma";
             }
             * {
                 box-sizing: border-box;
                 -moz-box-sizing: border-box;
             }
             .page {
                 width: 21cm;
                 height: 29.7cm;
                 #padding-left: 1.6cm;
                 margin: 1cm;
                 #border: 1px #D3D3D3 solid;
                 border-radius: 5px;
                 background: white;
                 box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
             }
             .subpageTop{
                 padding: 0.5cm;
                 #border: 5px red solid;
                 height: 148mm;
                 #outline: 2cm #FFEAEA solid;
             }
             .subpageBottom {
                  padding: 0.5cm;
                  #border: 5px red solid;
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
        
         table.reimtoptable{width:100%;}
 	     .reimtoptable tr td {height:10px; font: 8pt "Tahoma"; } 
        
         table.reimbursetoptable{width:100%;}
 	     .reimbursetoptable tr td {height:10px; font: 8pt "Tahoma"; }         
             
             
          table.middletable{width:100%;  }
             .middletable tr td {height:5px; font: 8pt "Tahoma"; }  
             
             
          table.bottomtable{width:100%;  }
             .bottomtable tr td {height:5px; font: 8pt "Tahoma";  }  
             
          table.signtable{width:100%;  }
             .signtable tr td {height:5px; font: 8pt "Tahoma";  } 
             

             
             
        </style>


 <div class="page">
 
 <div class="subpageTop">
  <fieldset>
  
    <h4>International Society For Krishna Consciousness(ISKCON)</h4>
    <h5>(<b>Regd.Office:</b>Hare Krishna Land,Juhu, Mumbai-400 049.)</h5>
    <h5>(<b>Branch:</b>Survey No. 50/2, Katraj Kondhwa Road, Opp Shantrujay Temple, Kondhwa Budruk,Pune-411 048.)</h5>
    <h5>(<b>Branch:</b>4,Tarapore Road,Camp,Pune-411 001.)</h5> <br>
 <div id="barCode"></div>
 <table class="reimtoptable">
             <tr></tr>       
                     <tr>
                         <td><span style="float: left;"></span></td>
                         <td></td>						 
                     </tr>
                      
                     <tr>
                          <td><span style="float: left;"></span></td>
	                  <td><h4>DEBIT VOUCHER</h4></td>
                          <td></td>
                     </tr>
                     
                      
                       
                      <tr> 
                        <td><span style="float: left;">Department: ${projectInstance?.costCenter?.name}</span></td>
                        <td><p>     </p></td>
                        <td><p><span style="float: right;">Date:${voucherInstance.voucherDate?.format('dd-MM-yyyy')}</span></p> </td>
                      </tr>
                   
        
           </table>
      
  
<g:set var="ppTotalAmount" value="${childProjects?.sum{it.advanceAmountIssued?:0}}" />
<g:set var="ppDetails" value="${childProjects?.collect{it.advancePaymentVoucher}}" />

<div>
	<table class="middletable">
		<thead>
			<td><b>S.No</b></td>
			<td><b>Particulars</b></td>
			<td><b>Ledger</b></td>
			<td><b>Amount</b></td>
			<td><b>TDS</b></td>
			<td><b>TDS Amount</b></td>
			<td><b>NetAmount</b></td>
		</thead>
		<g:set var="totalExp" value="${new BigDecimal(0)}" />
		<g:set var="totalNetExp" value="${new BigDecimal(0)}" />
		<g:set var="totalTdsAmount" value="${new BigDecimal(0)}" />
		<g:set var="advance" value="${projectInstance.advanceAmountIssued?:new BigDecimal(0)}" />
		<g:set var="advance" value="${advance+(ppTotalAmount?:0)}" />
		<g:set var="advanceDetails" value="${(projectInstance.advancePaymentVoucher?.voucherNo?:'')+' '+(projectInstance.advancePaymentVoucher?.voucherDate?.format('dd-MM-yyyy')?:'')}" />
		<g:each in="${expenses}" var="expense" status="i">
			<tr>
				<td>
					${i+1}
				</td>
				<td>
					${expense.description}
				</td>
				<td>
					${expense.ledgerHead?.name}
				</td>
				<td>
					${expense.amount}
					<g:set var="totalExp" value="${totalExp+expense.amount}" />
				</td>
				<td>
					${expense.deductionPercentage?(expense.deductionPercentage+' %'):''}
				</td>
				<td>
					<g:set var="tdsAmount" value="${expense.amount*(expense.deductionPercentage?:0)/100}" />
					<g:set var="totalTdsAmount" value="${totalTdsAmount+tdsAmount}" />
					${tdsAmount}					
				</td>
				<td>
					${expense.amount - tdsAmount}
					<g:set var="totalNetExp" value="${totalNetExp+expense.amount- tdsAmount}" />
				</td>
			</tr>
		</g:each>

			<tr>
				<td>
				</td>
				<td>
				</td>
				<td>
					Totals
				</td>
				<td>
					${totalExp}
				</td>
				<td>
				</td>
				<td>
					${totalTdsAmount}
				</td>
				<td>
					${totalNetExp}
				</td>
			</tr>

			<tr>
				<td>
				Less: Advance Taken
				</td>
				<td>
				${(advanceDetails?:'') +' ' + (ppDetails?:'')}
				</td>
				<td>
					
				</td>
				<td>
					
				</td>
				<td>
					
				</td>
				<td>
					<div id="advance">${advance}</div>
				</td>
				<td>
					
				</td>
			</tr>
			<tr>
				<td>
					Balance returned/payable
				</td>
				<td>
				</td>
				<td>
				</td>
				<td>
					<g:set var="balance" value="${totalExp-advance}" />
					<div id="balance">${balance}</div>
				</td>
				<td>					
				</td>
				<td>
				</td>
				<td>
					<g:set var="netbalance" value="${totalNetExp-advance}" />
					<div id="netbalance">${netbalance}</div>					
				</td>
			</tr>

	</table>
</div>
		   
    
    <table class="bottomtable">
            
              <tr>
                   <td>Narration:</td>
                   <td>${voucherInstance.description?:''}</td>
                   <td></td>
                   <td></td>
                   <td></td>
             </tr>
             
              <tr>
                   <td>Name:</td>
                   <td></td>
                   <td></td>
                   <td></td>
                   <td></td>
             </tr>

              <tr>
  	         <td>Rupees</td>
  	          <td colspan="3"><b> ${org.apache.commons.lang.WordUtils.capitalize(EnglishNumberToWords.convert(totalNetExp.toString()?:'0'))} Only </b></td>
  	         <td></td>
  	      </tr
  	      
          </table>
          
          <table class="signtable">
             <br><br>
             <tr>
  	         <td><p>${projectInstance.reviewer1?:''}</p></td>
  	         <td><p></p> </td>
  	         <td><p></p></td>
             </tr>
             <tr>
  	         <td><p>(Electronically Sactioned By)</p></td>
  	         <td><p>(Receiver)</p> </td>
  	         <td><p>(Accountant)</p></td>
  	     </tr> 
          </table>
         
  </fieldset>
  
    </div>    
       
    <div class="subpageBottom">  <!-- subpageBottom Copy -->

    </div>   <!-- End of subpageOffice Div -->  
</div>    <!-- End of Page Div --> 
</div>                    <!-- End of allBody Div --> 

<script>
$(document).ready(function()
{
	$("#barCode").barcode(
		"${voucherInstance.voucherNo}", // Value barcode (dependent on the type of barcode)
		"code39" // type (string)
	);
});
</script>