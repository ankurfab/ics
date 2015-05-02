
<%@ page import="ics.Project" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>File Expense Report</title>
	<r:require module="jqui" />
    </head>
<body>

<div class="nav">
    <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
    <span class="menuButton"><g:link class="list" action="selectProject">File Report</g:link></span>
</div>

<div class="body">
    

<g:set var="modes" value="${ics.PaymentMode.findAllByInpersonAndNameInList(true,['Cash','Cheque','RTGS','Transfer'])}" />

<h1>Expense Reimbursement Form for ${projectInstance.ref +" "+ projectInstance.name +" "+projectInstance.amount.toString()}</h1>

<g:if test="${creditProjects.size()==1}">
	<g:set var="creditSettlementProject" value="${creditProjects[0]}" />
	<div>
	Linking Part Payment Expenses (${ppProjects}) with Credit Expense: ${creditSettlementProject}
	</div>
</g:if>
			 
<g:form name="expenseReimbursementForm" controller="project" action="saveReport"   method="POST">

<g:set var="numItems" value="${new Integer(numRows?:'10')}" />
			

<g:hiddenField name="projectid" value="${projectInstance.id}" />
<g:hiddenField name="ppProjectIds" value="${ppProjects?.collect{it.id}?.join(',')}" />
<g:hiddenField name="settlementAmount" value="" />
<g:hiddenField name="numRows" value="${numRows}" />

    <div>
	<table>
		<thead>
			<th>Bill Payment Mode</th>
			<th>Particulars</th>
			<th>Bill Availability</th>
			<th>Amount </th>
			<th>Vendor</th>
			<th>Bill No</th>
			<th>Bill Date</th>
		</thead>
		
		<g:set var="totalExp" value="${new BigDecimal(0)}" />
		<g:set var="advance" value="${projectInstance.advanceAmountIssued?:new BigDecimal(0)}" />
		<g:set var="balance" value="${new BigDecimal(0)}" />
		<g:set var="ppTotalAmount" value="${new BigDecimal(0)}" />

		<g:if test="${creditSettlementProject}">
		<!-- show the credit row -->
			<tr>				
				<td>${creditSettlementProject.advancePaymentMode}</td> 
				<td>${creditSettlementProject.advancePaymentComments}</td>
				<td>${creditSettlementProject.advancePaymentVoucher?.voucherNo}</td>
				<td>${creditSettlementProject.amount}</td>
				<td>${creditSettlementProject.advanceIssuedTo}</td>
				<td>${creditSettlementProject.billNo}</td>
				<td>${creditSettlementProject.billDate?.format('dd-MM-yyyy')}</td>
			</tr>
		
		<!-- show the part payment row(s) if any -->
		<g:each in="${ppProjects}" var="ppProject">
			<tr>				
				<td>${ppProject.advancePaymentVoucher?.mode}</td> 
				<td>${ppProject.advancePaymentVoucher?.description}</td> 
				<td>${ppProject.advancePaymentVoucher?.voucherNo}</td>
				<td>${ppProject.advancePaymentVoucher?.amount}</td>
				<td>${ppProject.advanceIssuedTo}</td>
				<td>${ppProject.advancePaymentVoucher?.voucherNo}</td>
				<td>${ppProject.advancePaymentVoucher?.voucherDate?.format('dd-MM-yyyy')}</td>
				
				<g:set var="ppTotalAmount" value="${ppTotalAmount+ppProject.advancePaymentVoucher?.amount}" />
			</tr>
		</g:each>
		
		</g:if>

		<g:if test="${!expenses}">
		<!-- data entry first rows  -->
		<g:each in="${0..0}" var="i">
			<tr>				
				<td>
					<g:select name="${'mode.id_'+i}" from="${modes}" value="${projectInstance?.advancePaymentMode}"
					optionKey="id" optionValue="name" noSelection="['':'-Select Payment Mode-']" class="billpaymentmode"/>				
				</td> 
				<td><g:textField name="${'part_'+i}" value="" placeholder="Description" /></td> 
				<td>
					<select id="${'invoiceAvailable_'+i}"  name="${'invoiceAvailable_'+i}">
					 <option value="">-Select Bill Availability-</option>
					  <option value="Available" <g:if test="${creditSettlementProject}">selected="selected"</g:if> >Available</option>
					  <option value="Not Available">Not Available</option>
					  <!--<option value="Adjustment against previous Bill">Adjustment against previous bill</option>
					  <option value="Advance against future bill">Advance against future bill</option>-->
					</select>		
				</td>
				<td><g:textField name="${'amount_'+i}" value="" class="amount" placeholder="Amount" type="number" min="1" value="${(projectInstance?.amount?:0)}"/></td>
				<td><g:textField name="${'invoiceRaisedBy_'+i}" value="${projectInstance?.advanceIssuedTo}"  placeholder="Invoice Raised By"/></td>
				<td><g:textField name="${'invoiceNo_'+i}" value="${projectInstance?.billNo}"   placeholder="Invoice Number"/></td>
				<td><g:textField class="date-input-invoice" name="${'invoiceDate_'+i}" value="${projectInstance?.billDate?.format('dd-MM-yyyy')}"    placeholder="Invoice Date" /></td>
			</tr>
		</g:each>
		<!-- data entry rows  -->
		<g:each in="${1..((numItems?:10)-1)}" var="i">
			<tr>				
				<td>
					<g:select name="${'mode.id_'+i}" from="${modes}" value=""
					optionKey="id" optionValue="name" noSelection="['':'-Select Payment Mode-']" class="billpaymentmode"/>				
				</td> 
				<td><g:textField name="${'part_'+i}" value="" placeholder="Description" /></td> 
				<td>
					<select id="${'invoiceAvailable_'+i}"  name="${'invoiceAvailable_'+i}">
					 <option value="">-Select Bill Availability-</option>
					  <option value="Available">Available</option>
					  <option value="Not Available">Not Available</option>
					  <!--<option value="Adjustment against previous Bill">Adjustment against previous bill</option>
					  <option value="Advance against future bill">Advance against future bill</option>-->
					</select>		
				</td>
				<td><g:textField name="${'amount_'+i}" value="" class="amount" placeholder="Amount" type="number" min="1" value=""/></td>
				<td><g:textField name="${'invoiceRaisedBy_'+i}" value=""  placeholder="Invoice Raised By"/></td>
				<td><g:textField name="${'invoiceNo_'+i}" value=""   placeholder="Invoice Number"/></td>
				<td><g:textField class="date-input-invoice" name="${'invoiceDate_'+i}" value=""    placeholder="Invoice Date" /></td>
			</tr>
		</g:each>
		</g:if>
		<g:else> <!-- edit scenario begins-->
			<!-- existing expenses rows  -->
			<g:if test="${expenses.size()>0}">
				<g:each in="${expenses}" var="expense" status="i">
					<tr>				
						<g:hiddenField name="${'expid_'+i}" value="${expense.id}" />
						<td>
							<g:select name="${'mode.id_'+i}" from="${modes}" value="${expense.invoicePaymentMode?.id}"
							optionKey="id" optionValue="name" noSelection="['':'-Select Payment Mode-']" class="billpaymentmode"/>				
						</td> 
						<td><g:textField name="${'part_'+i}" value="${expense.description}" placeholder="Description" /></td> 
						<td>
							<select id="${'invoiceAvailable_'+i}"  name="${'invoiceAvailable_'+i}">
							 <option value="">-Select Bill Availability-</option>
							  <option value="Available" <g:if test="${expense.invoiceAvailable=='Available'}">selected="selected"</g:if>>Available</option>
							  <option value="Not Available" <g:if test="${expense.invoiceAvailable=='Not Available'}">selected="selected"</g:if>>Not Available</option>
							  <!--<option value="Adjustment against previous Bill">Adjustment against previous bill</option>
							  <option value="Advance against future bill">Advance against future bill</option>-->
							</select>		
						</td>
						<td><g:textField name="${'amount_'+i}" value="" class="amount" placeholder="Amount" type="number" min="1" value="${expense.amount}"/></td>
						<td><g:textField name="${'invoiceRaisedBy_'+i}" value="${expense.invoiceRaisedBy}"  placeholder="Invoice Raised By"/></td>
						<td><g:textField name="${'invoiceNo_'+i}" value="${expense.invoiceNo}"   placeholder="Invoice Number"/></td>
						<td><g:textField class="date-input-invoice" name="${'invoiceDate_'+i}" value="${expense.invoiceDate?.format('dd-MM-yyyy')}"    placeholder="Invoice Date" /></td>
					</tr>
				</g:each>
			</g:if>
			<!-- data entry rows  -->
			<g:each in="${expenses.size()..(numItems-1)}" var="i">
				<tr>				
					<td>
						<g:select name="${'mode.id_'+i}" from="${modes}" value=""
						optionKey="id" optionValue="name" noSelection="['':'-Select Payment Mode-']" class="billpaymentmode"/>				
					</td> 
					<td><g:textField name="${'part_'+i}" value="" placeholder="Description" /></td> 
					<td>
						<select id="${'invoiceAvailable_'+i}"  name="${'invoiceAvailable_'+i}">
						 <option value="">-Select Bill Availability-</option>
						  <option value="Available">Available</option>
						  <option value="Not Available">Not Available</option>
						  <!--<option value="Adjustment against previous Bill">Adjustment against previous bill</option>
						  <option value="Advance against future bill">Advance against future bill</option>-->
						</select>		
					</td>
					<td><g:textField name="${'amount_'+i}" value="" class="amount" placeholder="Amount" type="number" min="1" value=""/></td>
					<td><g:textField name="${'invoiceRaisedBy_'+i}" value=""  placeholder="Invoice Raised By"/></td>
					<td><g:textField name="${'invoiceNo_'+i}" value=""   placeholder="Invoice Number"/></td>
					<td><g:textField class="date-input-invoice" name="${'invoiceDate_'+i}" value=""    placeholder="Invoice Date" /></td>
				</tr>
			</g:each>		
		</g:else> <!-- edit scenario ends-->

			       <tr><td></td> <td></td> <td>Total Expense Amount : </td> <td><div id="total">${projectInstance?.amount}</div></td></tr>
			       <tr><td></td> <td></td> <td>Less Advance Taken:  </td> <td><div id="advance">${advance+(ppTotalAmount?:0)}</div></td></tr>
			       <tr><td></td> <td></td> <td>Balance Returned/Payable: </td> <td><div id="payable">${projectInstance?.amount - (ppTotalAmount?:0) - advance}</div></td></tr>
		
		        
	</table>		       
		
        </div>

	<!--<g:hiddenField name="reportstatus" value="SUBMIT" />-->
	
	<div>
	<fieldset data-role="controlgroup" data-type="horizontal">
		<legend>Status:</legend>
		<input name="reportstatus" id="reportstatus-1" value="DRAFT" type="radio">
		<label for="reportstatus-1">DRAFT</label>
		<input name="reportstatus" id="reportstatus-2" value="SUBMIT" type="radio" checked="checked">
		<label for="reportstatus-2">SUBMIT</label>
	</fieldset>
	</div>
		
	<div>
		<g:submitButton name="save" value="Submit" />
	</div>

</g:form>

</div>

<script>
 $(document).ready(function()
 {   
	$( ".date-input-invoice" ).datepicker({dateFormat: 'dd-mm-yy',maxDate: 0});
	
		 /*  // var numDaysSinceSubmitted = ${projectInstance.submitDate - new Date()};
		  
		  submitDate = '${projectInstance.submitDate?:0}';
		  var dateTimeSplit =submitDate.split(' ');
		  var dateSplit = dateTimeSplit[0].split('-');
		  var currentDate = dateSplit[2] + '-' + dateSplit[1] + '-' + dateSplit[0];
		  var curday=dateSplit[2];
		  var start = new Date(submitDate);
		  var end = new Date();
		  var oneDay = 24 * 60 * 60 * 1000;
		  var diffDays = Math.round(Math.abs((start.getTime() - end.getTime()) / (oneDay))); *\
                   */
                  
                  
                  
		  var totalamt=0;//first initilized totalamount to zero
		  var cashamt=0;
		  var totalother=0;
		  var advance = parseFloat(${(advance?:0)+(ppTotalAmount?:0)})
		 // InitializeDate();
		  
		 $("table input").on('change blur input', function ()
		      {

		       //buggy: doesnt consider existing values in case of edit
		       /*var row = $(this).closest('tr'),
		       amount = row.find('.amount').val();
		       temp = parseFloat(1);
		       row.find('.amount').text(amount * temp);

		       var sum = 0;
		       $('.amount').each(function () {
			      sum += parseFloat($(this).text()) || 0;
			      //console.log(sum)
			     });
			     
			*/
			
			var sum = 0;
			for (k = 0; k < ${numItems?:10}; k++)
			{ 
				if($('#amount_'+k).val())
					sum += parseFloat($('#amount_'+k).val());
			}
			
			  $('#total').text(sum);
			  totalamt=sum;
			  $('#payable').text(totalamt-advance);   
		       });


		      $("#expenseReimbursementForm").submit(function(e){

			if(!validate())
			    return false;

			return true;

			    });
      
		    function validate()  
		      {

			//check if all relevant fields are selected
			var incompleteRows = checkEachRow();
			if(incompleteRows)
			{
			alert("Please fill all mandatory fields for rows: "+incompleteRows);
			return false;
			}

			//check total amount
			if(!validateTotal())
			{
			return false
			}                     

			return true;
		      }
		    
                     
		 function validateTotal()
		 {
		   var totalamt = 0;
			for (k = 0; k < ${numItems?:10}; k++)
			{ 
				if($('#amount_'+k).val())
					totalamt += parseFloat($('#amount_'+k).val());
			}
		   

		   var projectamount = parseFloat(${projectInstance.amount?:0})
		   var ppTotalAmount = parseFloat(${ppTotalAmount?:0})

		   if(totalamt>projectamount)
		   {
			   alert("Expenses exceed sanctioned amount!!");
			   return false;
		   }
		   else
		   {
			   $('#settlementAmount').val(totalamt);
			   return true;
		   }

		   return true;
		 } 

	/*	 function validateCash()
		 {
		   var flag=true;
		   var  cashamount=parseFloat(totalamt);
		   if(cashamount>18000)
		  {
		   alert("Total Cash payment exceeds 18,000/- It is not allowed!!!")
		   flag=false; 
		   }
		   else
		   {
		   //alert("Cash payment  are (total)  not exceeded 18,000/-")
		   flag=true;
		   }
		     return flag;
		 }  */
                         
	    
		$(".datepicker").change(function()
		 {

		  validateDate();

		    });   
		  function  validateDate()
		   {
		     $( "#expenseReimbursementForm").validate({
		     rules: {
		     expdate_0 : {
		     required: false,
		     date: true
		     }

		     }
		   });
		  }
          
	   function checkEachRow() {
	        var incompleteRows="";
		for (k = 0; k < ${numItems?:10}; k++)
		{ 
			if(!validatefields(k))
				incompleteRows += (k+1) +", ";
		}
		return incompleteRows;
	   }

                function  validatefields(i)
		      {
	                     var somePopulated = false;
	                     var mandatoryFieldsFlag = true;
	                     var billFieldsFlag = true;
	                     if($('#mode\\.id_'+i).val() || $('#part_'+i).val() || $('#invoiceAvailable_'+i).val() || $('#amount_'+i).val() || $('#invoiceRaisedBy_'+i).val() || $('#invoiceNo_'+i).val() || $('#invoiceDate_'+i).val())
	                     	somePopulated = true;
	                     	
	                     if(somePopulated) {
	                     	//check if relevant fields are populated
	                     	
	                     	mandatoryFieldsFlag = checkMandatoryFields(i);
	                     	
	                     	billFieldsFlag = true;
	                     	var mode = $('#mode\\.id_'+i).find(":selected").text();
	                     	if(mode.toUpperCase()!='CASH' && $('#invoiceAvailable_'+i).val()!='Not Available') {
	                     		billFieldsFlag = checkBillDetails(i);
	                     	}
	                     	
	                     }
	                     if(mandatoryFieldsFlag && billFieldsFlag)
	                     	return true;
	                     else
	                     	return false;
		        }	        

                function  checkMandatoryFields(i)
		      {
	                     var allPopulated = true;
	                     if(!$('#mode\\.id_'+i).val() || !$('#part_'+i).val() || !$('#invoiceAvailable_'+i).val() || !$('#amount_'+i).val())
	                     	allPopulated = false;
	                     
	                     var mode = $('#mode\\.id_'+i).find(":selected").text();
	                     if(mode.toUpperCase()=='CASH' && $('#amount_'+i).val()) {
	                     	var cashAmt = $('#amount_'+i).val()
				if(parseFloat(cashAmt)>18000){
					alert("Amount More than 18000/- in Cash  is not allowed for the row  "+(i+1));
					allPopulated = false;
				}
	                     }
	                     
	                     return allPopulated;
	                     	
		        }	        

                function  checkBillDetails(i)
		      {
	                     var allPopulated = true;
	                     if(!$('#invoiceRaisedBy_'+i).val() || !$('#invoiceNo_'+i).val() || !$('#invoiceDate_'+i).val())
	                     	allPopulated = false;
	                     
	                     return allPopulated;
	                     	
		        }	        

 });  


</script>

</body>
</html>