
<%@ page import="ics.Project" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main-jqm-landing" />
        <title>File Expense Report</title>
    </head>
    <body>

    <div role="main" class="ui-content">
    
<div class="allbody"> 

<g:set var="modes" value="${ics.PaymentMode.findAllByInpersonAndNameInList(true,['Cash','Cheque','RTGS','Transfer'])}" />

<h1>Expense Reimbursement Form</h1>
			
			 
<g:form name="expenseReimbursementForm" controller="project" action="saveReport"   method="POST">
			
<fieldset class="form">

<g:hiddenField name="projectid" value="${projectInstance.id}" />

<div>
	
	<!--@TODO: This should be per row or automatically determined if invoice raised by is populated
	<h3><input type="checkbox" id="invoicehide-chk" name="invoicehide-chk" value="1"><span id="spn_invoice">Disable Invoice Details</span></h3>
	-->
	<table>
	<thead>        
	               <th>Ref</th>
	              <th>Name</th>
	               <th></th>
	               <th>Amount</th>
	</thead>               
	<tr><td>${projectInstance.ref }</td> <td>${projectInstance.name}</td>  <td> </td>  <td>${projectInstance.amount } </td> </tr>
	</table>
	<table id="expenseReimbursementtb">
		<thead>
<!--mode..Particulars,,Bill Availability...amount,vendor,bill no(Not Compulsary),,Bill date/Expense date -->

			<th>Bill Payment Mode</th>
			<!--<th>Date</th>-->
			<th>Particulars</th>
			<th>Bill Availability</th>
			<th>Amount </th>
			<th>Vendor</th>
			<th>Bill No</th>
			<th>Bill Date</th>
			
			
		</thead>
		<g:set var="totalExp" value="${new BigDecimal(0)}" />
		<g:set var="advance" value="${projectInstance.advanceIssued?projectInstance.advanceAmountIssued:new BigDecimal(0)}" />
		<g:set var="balance" value="${new BigDecimal(0)}" />
		
		<g:each in="${0..9}" var="i">
			<tr>
				
				<td class="invoice">
					<g:select name="${'mode.id_'+i}" from="${modes}" value=""
						  optionKey="id" optionValue="name" noSelection="['':'-Select Payment Mode-']" class="billpaymentmode"/>				
				</td> 
				<!-- <td><g:textField class="date-input-css" name="${'expdate_'+i}"  value="" placeholder="dd-MM-yyyy"/></td> <--for id becoz id was random with input type="text" -->
					
				
				 
				<td>
					<g:textField name="${'part_'+i}" value="" placeholder="Description" />
				</td> 
				
				
				<td> 
				
				
				          				
          				
          				
				<select id="${'invoiceAvailable_'+i}"  name="${'invoiceAvailable_'+i}">
				 <option value="">-Select Bill Availability-</option>
				  <option value="Available">Available</option>
				  <option value="Not Available">Not Available</option>
				  <option value="Adjustment against previous Bill">Adjustment against previous bill</option>
				  <option value="Advance against future bill">Advance against future bill</option>
				</select>		
				</td>
				
				
				<td>
					<g:textField name="${'amount_'+i}" value="" class="amount" placeholder="Amount" type="number" min="1"/>
				</td>
				
                    
				 
				
		        <td class="invoice">
				<g:textField name="${'invoiceRaisedBy_'+i}" value=""  placeholder="Invoice Raised By"/>
				 </td>	
				              
			        <td class="invoice" id="${'invoiceNum_'+i}">
				<g:textField name="${'invoiceNo_'+i}" value=""   placeholder="Invoice Number"/>
				</td>	
				                 
			        <td class="invoice" >
				<g:textField class="date-input-invoice" name="${'invoiceDate_'+i}" value=""    placeholder="Invoice Date" />
				</td>
				

                                     
				  	
			</tr>
		        </g:each> 
		        
			       <tr><td></td> <td></td> <td>totalCashAmount: </td> <td><div id="totalcash"></div></td></tr>
			       <tr><td></td> <td></td> <td>totalChequesAmount: </td> <td><div id="totalothers"></div></td></tr>
			       <tr><td></td> <td></td> <td>total : </td> <td><div id="total"></div></td></tr>
			       <tr><td></td> <td></td> <td>advance:  </td> <td><div id="advance">${advance}</div></td></tr>
			       <tr><td></td> <td></td> <td>balance: </td> <td><div id="payable"></div></td></tr>
			       <tr><td></td> <td></td> <td> balancecash: </td> <td><div id="balancecash"></td></tr>
			       <tr><td></td> <td></td> <td><input type="button" id="gettotalamt" value="getTotals"></td> <td></td></tr>
	</table>		       
		
        </div>
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
			<g:submitButton name="save" value="Save" />
		</div>

		</fieldset>

		</g:form>

		</div>

		 <script>
		 $(document).ready(function()
		 {   
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
		  var advance = parseFloat(${advance?:0})
		 // InitializeDate();
		  
		 $("table input").on('change blur input', function ()
		      {

		       var row = $(this).closest('tr'),
		       amount = row.find('.amount').val();
		       temp = parseFloat(1);
		       row.find('.amount').text(amount * temp);

		       var sum = 0;
		       $('.amount').each(function () {
			      sum += parseFloat($(this).text()) || 0;
			      console.log(sum)
			     });
			  $('#total').text(sum);
			  totalamt=sum;
			  $('#payable').text(advance-totalamt);   
		       });


		      $("#expenseReimbursementForm").submit(function(e){

			if(!validateFirstRow())
			    return false;

			if(!validate())
			    return false;

			return true;

			    });
      
		    function validate()  
		      {

			//1. check total amount
			if(!validateTotal())
			{
			return false
			}                     

			//2. check cash amount
			/* if(!validateCash())
			{
			return false
			}  */

			//3. check if payment mode is selected


			//alert("Expense Reimbursement Form will get Submitted");
			return true;
		      }
		    


	     $( "#gettotalamt" ).click(function() {

		totalother=0;
		cashamt=0;
	        var validcash=18000;
		  for (i=0;i<10;i++)
		      {
		          var selected = $('#mode\\.id_'+i+' :selected').val();
			  
			  if(selected=='')
			  {
			  //nothing to do
			  }
			  else if(selected=="Cash") 
			  {
			     validatefields(i);
			     if(parseFloat($('#amount_'+i).val())>validcash){
			     alert("Amount More than 18000/- in Cash  is not allowed for the row  "+((parseFloat(i))+(parseFloat(1))));
			     return false }
			     else
			     {
			      if($('#amount_'+i).val()=='')
			        $('#amount_'+i).val(0);
			     cashamt=cashamt+parseFloat($('#amount_'+i).val());
			     }
			     
			  }
			  
			  else
			 {
			 validatefields(i);
			 if($('#amount_'+i).val()=='')
			        $('#amount_'+i).val(0);
			 totalother =totalother+parseFloat($('#amount_'+i).val());
			  }
			  

			   }
			      $("#totalcash").text(cashamt);
			      $("#totalothers").text(totalother);  
			      var balancecashtemp=parseFloat(advance)-parseFloat(cashamt);
			      $("#balancecash").text(balancecashtemp);
			      var balance1 =totalamt-advance;
			      $("#balanceother").text(balance1-balancecashtemp);
			  return false;
		});
	
	
                function  validatefields(i)
		      {
	                     var somePopulated = false;
	                     if($('#part_'+i).val() || $('#invoiceAvailable_'+i).val() || $('#amount_'+i).val() || $('#invoiceRaisedBy_'+i).val() || $('#invoiceDate_'+i).val())
	                     	somePopulated = true;
	                     	
	                     if(!somePopulated)
	                     	return true;
	                     	
	                     if($('#part_'+i).val()=='')
			      {
			      alert("Please select the Particulars for the row  "+((parseFloat(i))+(parseFloat(1)))); return false}
			      
			     else if($('#invoiceAvailable_'+i).val()=='')
			      { 
			      alert("Please select the Bill Availability   for the row  "+((parseFloat(i))+(parseFloat(1)))); return false} 
			      
			     else if($('#amount_'+i).val()=='')
			      { 
			      alert("Please select the amount   for the row  "+((parseFloat(i))+(parseFloat(1)))); return false}
			      
			     else if($('#invoiceRaisedBy_'+i).val()==''){
			      alert("Please select the Vendor   for the row  "+((parseFloat(i))+(parseFloat(1)))); return false}
			       
			     else if($('#invoiceDate_'+i).val()==''){
			      alert("Please select the Bill Date   for the row  "+((parseFloat(i))+(parseFloat(1)))); return false}
			     return 
		        }	        
		 function validateTotal()
		    {     
		    return validateamount(totalamt);
		    }
     
		 function validateamount(totalamt)
		 {
		   var advanceIssued = ${advance}

		   var projectamount = ${projectInstance.amount?:0}

		   var newamount=parseFloat(totalamt)-parseFloat(advanceIssued);

		   if(newamount>projectamount)
		   {

		   alert("Expenses exceed sanctioned amount!!");
		   return false;
		   }
		   else
		   {
		    //alert("OK..(totalAmount-advanceIssued)is less than the total Project Amount")
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
          
	        var count=10;
		var advance = parseFloat(${advance?:0})
		for (k = 0; k < count; k++)
		{ 

		$('#part_'+k).focusout(function(){


		if($(this).val()=="" || $(this).val()==null)
		{
		alert("Please fill the Particulars ");
		}
		});

		$('#type_'+k).focusout(function(){


		if($(this).val()=="" || $(this).val()==null)
		{
		alert("Please fill the Type ");
		}
		});

		$('#amount_' + k).blur(function(){

                
		if($(this).val()=="" || $(this).val()==null||$('#amount_' + k).val==0)
		{
		alert("Please fill the Amount ");
		}
		else
		{
		
              
		}
		});
               var  cashamount=parseFloat(totalamt);
		$("#payable").text(cashamount-advance);

		}


		$('#invoicehide-chk').click(function() 
		{

		  if ($('#invoicehide-chk').is(':checked')) {
		  $("#expenseReimbursementtb .invoice input").attr('disabled', 'disabled');
		  $('#spn_invoice').text(' Enable Invoice Details');

		  } else {
		  $("#expenseReimbursementtb .invoice input").removeAttr('disabled');
		  $('#spn_invoice').text('Disable Invoice Details');
		    }
		  });


		

	     //  $( ".date-input-invoice" ).datepicker({dateFormat: 'dd-mm-yy'});
               $( ".date-input-invoice" ).datepicker({
                    dateFormat: 'dd-mm-yy',
                    maxDate: 0
                    
                      });
                  
	     });  
            
       
	</script>

	    </body>
	</html>