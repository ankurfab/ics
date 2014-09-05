

<%@ page import="ics.Loan" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="Advance Donation" />
        <title>New Advance Donation</title>

	<gui:resources components="['autoComplete']" />
	<style>
	.yui-skin-sam .yui-ac-content {
	  width: 350px !important;
	</style>

	<link rel="stylesheet" href="${resource(dir: 'css/start', file: 'jquery-ui-1.8.18.custom.css')}" type="text/css">
    </head>
    <body>

    	<g:javascript src="jquery-ui-1.8.18.custom.min.js" />
    	<script type="text/javascript">
        	$(document).ready(function()
        	{
          		$("#chequeDate").datepicker({yearRange: "-5:+5",changeMonth: true,changeYear: true,
			dateFormat: 'dd-mm-yy'});
          		$("#loanDate").datepicker({yearRange: "-5:+5",changeMonth: true,changeYear: true,
			dateFormat: 'dd-mm-yy'});

			
          	newFilterPaymentMode();
        	})
    	</script>
  
        <!--<div class="body">-->
        
            <h1>Enter Payment Details</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${loanInstance}">
            <div class="errors">
                <g:renderErrors bean="${loanInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" onsubmit="return validate();">
				<g:hiddenField name="loanedBy" value="${loanedBy}" />
				<g:hiddenField name="loanedById" value="${loanedById}" />
				<g:hiddenField name="councellor" value="${councellor}" />
				<g:hiddenField name="councellorId" value="${councellorId}" />
				<g:hiddenField name="reference2Id" value="${reference2Id}" />
				<g:hiddenField name="reference2" value="${reference2}" />
				<g:hiddenField name="nomineeId" value="${nomineeId}" />
				<g:hiddenField name="nominee" value="${nominee}" />
				<g:hiddenField name="fatherOrSpouse" value="${fatherOrSpouse}" />
				<g:hiddenField name="nomineeRelation" value="${nomineeRelation}" />
                        
           
                <div class="dialog">
                    <table>
                        <tbody>
                        	<tr>
                                <td valign="top" class="name" width="22%">
                                    <label for="loanedBy">Advance Donation By</label>
                                </td>
                                <td valign="top" class="name">
                                    <g:link controller="individual" action="show" id="${loanedById}">${loanedBy}</g:link>
                                </td>
                        		
                        	</tr>
                        	
                        	<tr>
                                <td valign="top" class="name">
                                    <label for="reference1"><g:message code="loan.reference1.label" default="Witness" /></label>
                                </td>
                                <td valign="top" class="name">
                                    <g:link controller="individual" action="show" id="${councellorId}">${councellor}</g:link>
                                </td>
                        		
                        	</tr>
                        	
                        	<tr>
                                <td valign="top" class="name">
                                    <label for="reference2"><g:message code="loan.reference2.label" default="Project Co-ordinator- Finance" /></label>
                                </td>
                                <td valign="top" class="name">
                                    <g:link controller="individual" action="show" id="${reference2Id}">${reference2}</g:link>
                                </td>
                        		
                        	</tr>

                        	<tr>
                                <td valign="top" class="name">
                                    <label for="fatherOrSpouse"><g:message code="loan.fatherOrSpouse.label" default="Father/Spouse" /></label>
                                </td>
                                <td valign="top" class="name">
                                    ${fatherOrSpouse}
                                </td>
                        		
                        	</tr>
                        	
                        	<tr>
                                <td valign="top" class="name">
                                    <label for="nominee"><g:message code="loan.nominee.label" default="Nominee" /></label>
                                </td>
                                <td valign="top" class="name">
                                    ${nominee}
                                </td>
                        		
                        	</tr>
                        
                        	<tr>
                                <td valign="top" class="name">
                                    <label for="nomineeRelation"><g:message code="loan.nomineeRelation.label" default="Relationship with Donor" /></label>
                                </td>
                                <td valign="top" class="name">
                                    ${nomineeRelation}
                                </td>
                        		
                        	</tr>
                        	

   						</tbody>
                    </table>
                </div>             				
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="loanDate"><g:message code="loan.loanDate.label" default="Loan Date" /></label>*
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: loanInstance, field: 'loanDate', 'errors')}">
                                    <g:textField name="loanDate" precision="day" value="${(loanInstance?.loanDate?:new Date())?.format('dd-MM-yyyy')}"  />
                                </td>
                            </tr>
                        
                        	<tr>
                                <td valign="top" class="name">
                                    <label for="panNo"><g:message code="individual.panNo.label" default="PAN No." /></label>*
                                </td>
                                <td valign="top" class="name">
                                    <g:textField name="panNo" value="${panNo}"  />
                                </td>
                        		
                        	</tr>
                                                
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="amount"><g:message code="loan.amount.label" default="Amount" /></label>*
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: loanInstance, field: 'amount', 'errors')}">
                                    <g:textField name="amount" value="${fieldValue(bean: loanInstance, field: 'amount')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="term"><g:message code="loan.term.label" default="Term" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: loanInstance, field: 'term', 'errors')}">
                                    <g:select name="term" from="${['5 Year']}" value="${loanInstance?.term}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="category"><g:message code="loan.category.label" default="Category" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: loanInstance, field: 'category', 'errors')}">
                                    <g:select name="category" from="${['Default']}" value="${loanInstance?.category}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="status"><g:message code="loan.status.label" default="Status" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: loanInstance, field: 'status', 'errors')}">
                                <label for="status">PENDING</label>
                                    <!--<g:select name="status" from="${['PENDING','SUBMITTED','ACCEPTED','MATURED','INVALID','CLOSED']}" value="${loanInstance?.status}" />-->
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="loanReceiptNo"><g:message code="loan.loanReceiptNo.label" default="Loan Receipt No" /></label>*
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: loanInstance, field: 'loanReceiptNo', 'errors')}">
                                    <g:textField name="loanReceiptNo" value="${loanInstance?.loanReceiptNo}" />
                                </td>
                            </tr>
   						</tbody>
                    </table>
                </div>             				
						<div id="paymentMode" class="dialog">
							<table>
								<tbody>
									<tr class="prop">
										<td valign="top" class="name">
											<label for="mode"><g:message code="loan.mode.label" default="Mode" /></label>*
										</td>
										<td valign="top" class="value ${hasErrors(bean: loanInstance, field: 'mode', 'errors')}">
										
										<!--<g:select name="mode.id" from="${ics.PaymentMode.list(sort:'name')}" optionKey="id" value="${loanInstance?.mode?.id}"  onChange="newFilterPaymentMode()"/>-->
										<g:select name="mode.id" from="${paymentModeList}"  value="${loanInstance?.mode?.id}"  onChange="newFilterPaymentMode();"/>
										
										 <!--<select name="mode.id" onChange="newFilterPaymentMode()"> 
										    <g:each in="${paymentModeList}" status="i" var="payMode">
										    <g:if test = "${payMode == 'Direct-Cheque'}">
										    	<option value="${loanInstance?.mode?.id}" selected>${payMode}</option>
										    </g:if>
										    <g:else>
												<option value="${loanInstance?.mode?.id}">${payMode}</option>
											</g:else>
										    </g:each> 										 
										 </select>-->
										
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					   <div id="cardType" class="dialog" style="display:none">
						<table>
							<tbody>
								<tr class="prop">
								<td valign="top" class="name">
									Card Type
								</td>
								<td valign="top" class="value">
									<g:select name="ctype" from="${['AMERICAN EXPRESS', 'MAESTRO', 'MASTER','VISA']}" value="${loanInstance?.bankBranch}" noSelection="['':'-Select-']" onchange="setCardType();"/>
								</td>
								</tr>
							</tbody>
						</table>
						</div>
						<div id="chequedetails" class="dialog" style="display: none">
							<table>
								<tbody>
								<tr class="prop">
									<td valign="top" class="name">
										Instrument No*
									</td>
									<td valign="top" class="value ${hasErrors(bean: loanInstance, field: 'chequeNo', 'errors')}">
										<g:textField name="chequeNo" value="${loanInstance?.chequeNo}" />
									</td>
								</tr>

								<tr class="prop">
									<td valign="top" class="name">
										Instrument Date*
									</td>
									<td valign="top" class="value ${hasErrors(bean: loanInstance, field: 'chequeDate', 'errors')}">
										<!--<g:datePicker name="chequeDate" precision="day" value="${loanInstance?.chequeDate}"  noSelection="['':'-Select-']" default="none"/>-->
										<g:textField name="chequeDate" value="${loanInstance?.chequeDate?.format('dd-MM-yyyy')}" />
									</td>
								</tr>


								<tr class="prop">
									<td valign="top" class="name">
										<label for="bank"><g:message code="loan.bank.label" default="Bank" /></label>*
									</td>
									<td valign="top" class="value ${hasErrors(bean: loanInstance, field: 'bank', 'errors')}">
										<!--<g:select name="bank.id" from="${ics.Bank.list(sort:'name')}" optionKey="id" value="${loanInstance?.bank?.id}"  noSelection="['':'-Select-']"/>-->
										<g:textField name="bankName" value="${loanInstance?.bankName}" />
									</td>
								</tr>

								<tr class="prop">
									<td valign="top" class="name">
										<label for="bankBranch"><g:message code="loan.bankBranch.label" default="Bank Branch" /></label>*
									</td>
									<td valign="top" class="value ${hasErrors(bean: loanInstance, field: 'bankBranch', 'errors')}">
										<g:textField name="bankBranch" value="${loanInstance?.bankBranch}" />
									</td>
								</tr>
							</tbody>
						</table>
					</div>

					 <div>
					 <table>

						<!--<tr class="prop">
							<td valign="top" class="name">
								<label for="chequeNo"><g:message code="loan.chequeNo.label" default="Cheque No" /></label>
							</td>
							<td valign="top" class="value ${hasErrors(bean: loanInstance, field: 'chequeNo', 'errors')}">
								<g:textField name="chequeNo" value="${loanInstance?.chequeNo}" />
							</td>
						</tr>

						<tr class="prop">
							<td valign="top" class="name">
								<label for="chequeDate"><g:message code="loan.chequeDate.label" default="Cheque Date" /></label>
							</td>
							<td valign="top" class="value ${hasErrors(bean: loanInstance, field: 'chequeDate', 'errors')}">
								<g:textField name="chequeDate" precision="day" value="${loanInstance?.chequeDate?.format('dd-MM-yyyy')}"/>
							</td>
						</tr>-->

						<!--<tr class="prop">
							<td valign="top" class="name">
								<label for="loanStartDate"><g:message code="loan.loanStartDate.label" default="Loan Start Date" /></label>*
							</td>
							<td valign="top" class="value ${hasErrors(bean: loanInstance, field: 'loanStartDate', 'errors')}">
								<g:textField name="loanStartDate" precision="day" value="${loanInstance?.loanStartDate?.format('dd-MM-yyyy')}" />
							</td>
						</tr>-->

						<!--<tr class="prop">
							<td valign="top" class="name">
								<label for="loanEndDate"><g:message code="loan.loanEndDate.label" default="Loan End Date" /></label>
							</td>
							<td valign="top" class="value ${hasErrors(bean: loanInstance, field: 'loanEndDate', 'errors')}">
								<g:textField name="loanEndDate" precision="day" value="${loanInstance?.loanEndDate?.format('dd-MM-yyyy')}"  />
							</td>
						</tr>-->

						<tr class="prop">
							<td valign="top" class="name">
								<label for="paymentComments"><g:message code="loan.paymentComments.label" default="Payment Comments" /></label>
							</td>
							<td valign="top" class="value ${hasErrors(bean: loanInstance, field: 'paymentComments', 'errors')}">
								<g:textArea name="paymentComments" value="${loanInstance?.paymentComments}" rows="5" cols="40"/>
							</td>
						</tr>

						<tr class="prop">
							<td valign="top" class="name">
								<label for="comments"><g:message code="loan.comments.label" default="Comments" /></label>
							</td>
							<td valign="top" class="value ${hasErrors(bean: loanInstance, field: 'comments', 'errors')}">
								<g:textArea name="comments" value="${loanInstance?.comments}"  rows="5" cols="40"/>
							</td>
						</tr>
					</table>
				</div>
                      
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
               
            </g:form>
        
			
        <!--</div>-->
    
        <script language="javascript">

			
			function validate()
			{
				if(document.getElementById('panNo').value == '')
				{
					alert("Please enter PAN No.!");
					document.getElementById('panNo').focus();
					return false;
				}
				if(document.getElementById('loanDate').value == '')
				{
					alert("Please enter Loan Date!");
					document.getElementById('loanDate').focus();
					return false;
				}
				if(document.getElementById('amount').value == '')
				{
					alert("Please enter Amount!");
					document.getElementById('amount').focus();
					return false;
				}
			}


			function setCardType() {
				document.getElementById('bankBranch').value = document.getElementById('ctype').value;
			}

			/*function setLoanStartDate()
			{
				document.getElementById("loanStartDate").value = document.getElementById("chequeDate").value;
			}*/

			function newFilterPaymentMode() {

				var m = document.getElementById('mode.id');
				var pm = m.options[m.selectedIndex];

				if (pm.text.search(/Card/)>-1)
					{
						var ele = document.getElementById("cardType");
						ele.style.display = "block";
							var ele = document.getElementById("chequedetails");
						ele.style.display = "none";
				}
				else if (pm.text.search(/Direct-Cash/)>-1)
					{
						var ele = document.getElementById("cardType");
						ele.style.display = "none";
							var ele = document.getElementById("chequedetails");
						ele.style.display = "none";
				}
				
				else if (pm.text.search(/Bank-Cash/)>-1)
					{
						var ele = document.getElementById("cardType");
						ele.style.display = "none";
							var ele = document.getElementById("chequedetails");
						ele.style.display = "block";
				}
				else
					{

						var ele = document.getElementById("cardType");
						ele.style.display = "none";

							var ele = document.getElementById("chequedetails");
						ele.style.display = "block";
				}
			}
	    

	    
	    
        </script>
    </body>
</html>
