
<%@ page import="ics.Project" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main-jqm-landing" />
        <title>New Expense Request</title>
    </head>
    <body>
    <div role="main" class="ui-content">

	<g:if test="${balCheck && !(balCheck?.allow)}">
	<div class="errors" role="status">
		<ul>
		<g:each in="${balCheck.msg}">
		    <li>${it}</li>
		</g:each>
		</ul>
	</div>
	</g:if>

	<g:if test="${locked=='LOCKED'}">
		<div class="errors" role="status">Budget updation in progress. Please try after some time. Thank you.</div>
	</g:if>
	<g:else>
		<g:if test="${!unsettledExpensesBeyondCutoff}">
			<g:render template="addproject" />
		</g:if>
		<g:else>
			<div class="errors" role="status">Sorry! You can not raise new request as you have un-settled expense for more than 30 days. Please settle it first. Thank you.</div>
		</g:else>
    	</g:else>
    </div>
   <style>
   #month-a{
       width:auto;
   }
   #month-b{
       width:auto;
   }
   
   #custom-slider .ui-rangeslider-sliders {
       margin: 0.5em 100px !important;
   }
   
   #custom-slider input.ui-input-text.ui-slider-input {
       width: 70px !important;
       
}
   </style>
<script>
$(document).ready(function () {
	<g:if test="${unsettledExpenses}">
	alert("Gentle reminder! You have the following unsettled expenses. Please settle them in time (max 30 days). Thank you.\n\n${unsettledExpenses?.collect{it.name+'/'+it.submitDate?.format('dd-MM-yyyy')+'/'+it.amount}}");
	</g:if>
	
	
	 
      $("#addprojectForm").submit(function(e){

     var amount=0;
     if($('#amount').val())
     	amount = parseFloat($('#amount').val());
     	
     if(amount<=0) {
	     alert("Please enter a positive amount !!")
	     return false;
     }
     
     var advanceAmount=0;
     if($('#advanceAmount').val())
     	advanceAmount = parseFloat($('#advanceAmount').val());

     if(advanceAmount<0) {
	     alert("Please enter a positive advance amount !!")
	     return false;
     }
     
     if(amount <advanceAmount)
     {
     alert("Advance amount can not be more than amount !!")
     return false;
     }
     else
     {
      //alert("Expense Approval form submitted sucessfully !!")
      return true;
     }
     
    });
	
});
</script>
    </body>
</html>
