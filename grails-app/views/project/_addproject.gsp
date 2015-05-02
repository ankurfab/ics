<%@ page import="ics.Project" %>

<g:form name="addprojectForm" controller="project" action="save" id="${projectInstance?.id}" method="POST">

<div class="allbody"> 

<g:set var="modes" value="${ics.PaymentMode.findAllByInpersonAndNameInList(true,['Cash','Cheque','RTGS','Transfer'])}" />

   
<h1>Expense Approval Form</h1>
 <table>
	<thead>
	<th>Consumed Budget</th>
	<th>Available Budget</th>
	 <th>Total Budget</th>
	</thead>  
	<tr><td>${costCenter?.balance?:0}</td>  <td>${(costCenter?.budget?:0)- (costCenter?.balance?:0)}</td> <td>${costCenter?.budget?:0}</td></tr>
 </table> 			
						
<fieldset class="form">

<div>
	<label for="name">Name:</label>
	<g:textField name="name" value="${projectInstance?.name}" placeholder="Expense name in brief." required="required"/>
</div>

<div>
	<label for="name">Description:</label>
	<g:textArea name="description" cols="40" rows="5" maxlength="500" value="${projectInstance?.description}" placeholder="Expense description." required="required"/>
</div>

<div>
    <fieldset data-role="controlgroup" data-type="horizontal">
        <legend>Type:</legend>
        <input name="type" id="type-1" value="NORMAL" checked="checked" type="radio">
        <label for="type-1">NORMAL</label>
        <input name="type" id="type-2" value="PARTPAYMENT" type="radio">
        <label for="type-2">PARTPAYMENT ADVANCE</label>
        <input name="type" id="type-3" value="CREDIT" type="radio">
        <label for="type-3">PARTPAYMENT SETTLEMENT</label>
    </fieldset>
</div>


<div id="divApprovalAmount">
	<label for="amount">Total Approval Amount:</label>
	<g:field name="amount" value="${projectInstance?.amount}" placeholder="Total Approval Amount" type="number" required="required" min= "1"/>
</div>

<div id="divAdvanceAmount">
	<label for="advanceAmount">Advance Amount:</label>
	<g:field name="advanceAmount" value="${projectInstance?.advanceAmount}" placeholder="Advance(if needed, <= Approval Amount)" type="number"/>
</div>


<div id="divVendors">
	<label for="vendorid">Vendor:</label>
	<g:select id="vendorid" name='vendorid' value=""
	noSelection="${['':'Select Vendor...']}"
	from='${vendors}'
	optionKey="id" optionValue="legalName"></g:select>
</div>

<div id="divAdvanceDetails">

	<label for="advanceIssuedToName">Issue To (New Vendor):</label>
	<g:textField name="advanceIssuedToName" value="${projectInstance?.advanceIssuedTo}" placeholder="For New Vendor only..If existing vendor then pls choose from dropdown above!!"/>

	<div id="divAdvanceModeDetails">
		<label for="advancePaymentModeName">Issue Mode:</label>
		<g:select name="${'advancePaymentModeName'}" from="${modes}" value=""
			  optionKey="id" optionValue="name" noSelection="['':'-Select Payment Mode-']"/>				

		<label for="advancePaymentComments">Issue Comments:</label>
		<g:textArea name="advancePaymentComments" cols="40" rows="5" maxlength="500" value="${projectInstance?.advancePaymentComments}" placeholder="Issue comments."/>
	</div>

</div>


<div id="divBillDetails">
	<label for="billNo">Bill No:</label>
	<g:textField name="billNo" value="${projectInstance?.billNo}" placeholder="Bill no.."/>

	<label for="billDate">Bill Date:</label>
	<g:textField name="billDate" value="${projectInstance?.billDate}" placeholder="Bill date.."/>

</div>

<div data-role="controlgroup" data-type="horizontal">

<div>
    <fieldset data-role="controlgroup" data-type="horizontal">
        <legend>Priority:</legend>
        <input name="priority" id="priority-p1" value="P1(URGENT)" type="radio">
        <label for="priority-p1">P1(URGENT)</label>
        <input name="priority" id="priority-p2" value="P2(HIGH)" type="radio">
        <label for="priority-p2">P2(HIGH)</label>
        <input name="priority" id="priority-p3" value="P3(MEDIUM)" checked="checked" type="radio">
        <label for="priority-p3">P3(MEDIUM)</label>
        <input name="priority" id="priority-p4" value="P4(LOW)" type="radio">
        <label for="priority-p4">P4(LOW)</label>
    </fieldset>
</div>

<div>
    <fieldset data-role="controlgroup" data-type="horizontal">
        <legend>Category:</legend>
        <input name="category" id="category-1" value="REVENUE" checked="checked" type="radio">
        <label for="category-1">REVENUE</label>
        <!--<input name="category" id="category-2" value="CAPITAL" type="radio">
        <label for="category-2">CAPITAL</label>-->
    </fieldset>
</div>

<div>
    <fieldset data-role="controlgroup" data-type="horizontal">
        <legend>Status:</legend>
        <input name="submitStatus" id="submitStatus-1" value="SUBMITTED_REQUEST" checked="checked" type="radio">
        <label for="submitStatus-1">SUBMIT</label>
        <input name="submitStatus" id="submitStatus-2" value="DRAFT_REQUEST" type="radio">
        <label for="submitStatus-2">DRAFT</label>
    </fieldset>
</div>

</div>

<div>
<g:actionSubmit value="Submit" action="Save" />
</div>

</fieldset>

</div>

</g:form>

<script>
$(document).ready(function(){

	$("#divAdvanceDetails").hide();
	$("#divBillDetails").hide();
	$("#divVendors").hide();

       $( "#billDate" ).datepicker({
	    dateFormat: 'dd-mm-yy',
	    maxDate: 0
	      });
	      
$("#type-1").click(function(){
	clearSpecialFields();
	$('#divApprovalAmount').show();
	$('#divAdvanceAmount').show();
	$("#divAdvanceDetails").hide();
	$("#divBillDetails").hide();
	$("#divVendors").hide();
	});

$("#type-2").click(function(){
	clearSpecialFields();
	$('#divApprovalAmount').hide();
	$('#divAdvanceAmount').show();
	$("#divAdvanceDetails").show();
	$("#divAdvanceModeDetails").show();	
	$("#divVendors").show();
	$("#divBillDetails").hide();
	});

$("#type-3").click(function(){
	clearSpecialFields();
	clearAndHideAdvanceAmount();
	$('#divApprovalAmount').show();
	$("#divAdvanceDetails").hide();
	$("#divAdvanceModeDetails").hide();	
	$("#divVendors").show();
	$("#divBillDetails").show();
	});

function clearSpecialFields()  {
	$('#advanceIssuedToName').val('');
	$('#advancePaymentModeName').val('');
	$('#advancePaymentComments').val('');
	$('#billNo').val('');
	$('#billDate').val('');
}

function clearAndHideAdvanceAmount()  {
	$('#advanceAmount').val('');
	$('#divAdvanceAmount').hide();
}

$('#advanceAmount').change(function() { 
	var selectedType = $('input[name=type]:checked', '#addprojectForm').val();
	if(selectedType=='PARTPAYMENT') {
		$('#amount').val($('#advanceAmount').val());
	}
});


/* make placeholder for bill amount
$('#type').change(function() {
	var selectedType = $('input[name=type]:checked', '#addprojectForm').val();
	if(selectedType=='CREDIT') {
		$('#amount').attr("placeholder", "Please enter bill amount here..");
	}
});*/


$( "#addprojectForm" ).submit(function( event ) {
	//alert( "Handler for .submit() called." );
	//event.preventDefault();
	var selectedType = $('input[name=type]:checked', '#addprojectForm').val();
	if(selectedType=='PARTPAYMENT') {
		if(!$('#advanceAmount').val()) {
			alert("Please provide advance amount!!");
			return false;
			}
		if(!$('#advanceIssuedToName').val()) {
			alert("Please provide vendor name!!");
			return false;
			}
		if(!$('#advancePaymentModeName').val()) {
			alert("Please provide advance payment mode!!");
			return false;
			}
	}
	if(selectedType=='CREDIT') {
		if(!$("#vendorid").val()) {
			alert("Please select the vendor!!");
			return false;
		}
		if(!$('#advanceIssuedToName').val()) {
			alert("Please provide vendor name!!");
			return false;
			}
		if(!$('#billNo').val()) {
			alert("Please provide bill no.!!");
			return false;
			}
		if(!$('#billDate').val()) {
			alert("Please provide bill date!!");
			return false;
			}
	}
	return true;
});


$("#vendorid").change(function(){
	$('#advanceIssuedToName').val($( "#vendorid option:selected" ).text());
});

});
</script>