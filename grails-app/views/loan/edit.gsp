

<%@ page import="ics.Loan" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="Advance Donation" />
        <title>Edit Advance Donation</title>
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
          		$("#loanStartDate").datepicker({yearRange: "-5:+5",changeMonth: true,changeYear: true,
			dateFormat: 'dd-mm-yy'});
          		$("#loanEndDate").datepicker({yearRange: "-5:+5",changeMonth: true,changeYear: true,
			dateFormat: 'dd-mm-yy'});
			
          	newFilterPaymentMode();
        	})
    	</script>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create0"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${loanInstance}">
            <div class="errors">
                <g:renderErrors bean="${loanInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${loanInstance?.id}" />
                <g:hiddenField name="version" value="${loanInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="loanDate">Advance Donation Date</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: loanInstance, field: 'loanDate', 'errors')}">
                                    <!--<g:datePicker name="loanDate" precision="day" value="${loanInstance?.loanDate}"  />-->
                                    ${loanInstance?.loanDate?.format('dd-MM-yyyy')}
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="loanedBy">Advance Donation By</label>
                                </td>
                                
                           
                                <!--<td valign="top" class="value ${hasErrors(bean: loanInstance, field: 'loanedBy', 'errors')}">
									<div style="width: 300px">

										<gui:autoComplete
											id="acIndividual"
											width="300px"
											controller="individual"
											action="allIndividualsExceptDummyDonorAsJSON"
											useShadow="true"
											queryDelay="0.5" minQueryLength='3'

										/>
									</div>
                                </td>
                            </tr>

                            <g:if test="${loanInstance?.loanedBy}">
                            <tr class="prop">
                                <td valign="top" class="value ${hasErrors(bean: loanInstance, field: 'loanedBy', 'errors')}" width="25%">
	                               <g:hiddenField name="h_loanedBy.id" value="${loanInstance?.loanedBy}" />
	                               <g:checkBox name="loanedByChkBox" value="${true}"/> Use This Name?
                                </td>-->
                                <td valign="top" class="name" align="left">
                                    ${loanInstance?.loanedBy}
                                </td>
                            </tr>
                            </g:if>
                                
                            
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="reference1"><g:message code="loan.reference1.label" default="Witness" /></label>
                                </td>
                                <!--<td valign="top" class="value ${hasErrors(bean: loanInstance, field: 'reference1', 'errors')}">
								   <div style="width: 300px">

										<gui:autoComplete
											id="acWitness1"
											width="200px"
											controller="individual"
											action="findCollectorsAsJSON"
											useShadow="true"
											queryDelay="0.5" minQueryLength='3'

										/>
									</div>
          
                                </td>
                            </tr>
                            <g:if test="${loanInstance?.reference1}">
                            <tr class="prop">
                                <td valign="top" class="value ${hasErrors(bean: loanInstance, field: 'reference1', 'errors')}" width="25%">
	                               <g:hiddenField name="h_reference1.id" value="${loanInstance?.reference1}" />
	                               <g:checkBox name="loanedByChkBox" value="${true}"/> Use This Name?
                                </td>-->
                                <td valign="top" class="name" align="left">
                                    ${loanInstance?.reference1}
                                </td>
                            </tr>
                            </g:if>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="reference2"><g:message code="loan.reference2.label" default="Project Co-ordinator- Finance" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: loanInstance, field: 'reference2', 'errors')}">
                                    <!--<g:select name="reference2.id" from="${ics.Individual.findByLegalName('Srigurucharan Das')}" optionKey="id" value="${loanInstance?.reference2?.id}"  />-->
                                    ${ics.Individual.findByLegalName('Srigurucharan Das')}
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="nominee"><g:message code="loan.nominee.label" default="Nominee" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: loanInstance, field: 'nominee', 'errors')}">
                                    ${loanInstance?.nominee}
                                </td>
                            </tr>

						   <tr class="prop">
								<td valign="top" class="name"><g:message code="individual.panNo.label" default="IT PAN No." /></td>

								<td valign="top" class="value">${loanInstance?.loanedBy?.panNo}</td>
							</tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="amount"><g:message code="loan.amount.label" default="Amount" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: loanInstance, field: 'amount', 'errors')}">
                                    ${fieldValue(bean: loanInstance, field: 'amount')}
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="term"><g:message code="loan.term.label" default="Term" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: loanInstance, field: 'term', 'errors')}">
                                    ${loanInstance?.term}
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="category"><g:message code="loan.category.label" default="Category" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: loanInstance, field: 'category', 'errors')}">
                                    ${loanInstance?.category}
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="loanReceiptNo">Advance Donation Receipt No</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: loanInstance, field: 'loanReceiptNo', 'errors')}">
                                    ${loanInstance?.loanReceiptNo}
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="mode"><g:message code="loan.mode.label" default="Mode" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: loanInstance, field: 'mode', 'errors')}">
                                    <!--<g:select name="mode.id" from="${ics.PaymentMode.list()}" optionKey="id" value="${loanInstance?.mode?.id}"  />-->
                                    ${loanInstance?.mode}
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="bank"><g:message code="loan.bank.label" default="Bank" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: loanInstance, field: 'bank', 'errors')}">
                                    <!--<g:select name="bank.id" from="${ics.Bank.list()}" optionKey="id" value="${loanInstance?.bank?.id}" noSelection="['null': '']" />-->
                                    <!--${loanInstance?.bank}-->
                                    <g:textField name="bankName" value="${loanInstance?.bankName}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="bankBranch"><g:message code="loan.bankBranch.label" default="Bank Branch" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: loanInstance, field: 'bankBranch', 'errors')}">
                                    ${loanInstance?.bankBranch}
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="chequeNo"><g:message code="loan.chequeNo.label" default="Cheque No" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: loanInstance, field: 'chequeNo', 'errors')}">
                                    ${loanInstance?.chequeNo}
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="chequeDate"><g:message code="loan.chequeDate.label" default="Cheque Date" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: loanInstance, field: 'chequeDate', 'errors')}">
                                    <!--<g:datePicker name="chequeDate" precision="day" value="${loanInstance?.chequeDate}" noSelection="['': '']" />-->
                                    ${loanInstance?.chequeDate?.format('dd-MM-yyyy')}
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="paymentComments"><g:message code="loan.paymentComments.label" default="Payment Comments" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: loanInstance, field: 'paymentComments', 'errors')}">
                                    ${loanInstance?.paymentComments}
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="comments"><g:message code="loan.comments.label" default="Comments" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: loanInstance, field: 'comments', 'errors')}">
                                    <g:textArea name="comments" value="${loanInstance?.comments}" rows="5" cols="40"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="loanStartDate">Advance Donation Start Date</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: loanInstance, field: 'loanStartDate', 'errors')}">
                                    <!--<g:datePicker name="loanStartDate" precision="day" value="${loanInstance?.loanStartDate}" noSelection="['': '']" />-->
                                    ${loanInstance?.loanStartDate?.format('dd-MM-yyyy')}
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="loanEndDate">Advance Donation End Date</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: loanInstance, field: 'loanEndDate', 'errors')}">
                                    <!--<g:datePicker name="loanEndDate" precision="day" value="${loanInstance?.loanEndDate}" noSelection="['': '']" />-->
                                    ${loanInstance?.loanEndDate?.format('dd-MM-yyyy')}
                                </td>
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="accoutsReceiptNo"><g:message code="loan.accoutsReceiptNo.label" default="Accounts Receipt No" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: loanInstance, field: 'accoutsReceiptNo', 'errors')}">
                                	<g:textField name="accoutsReceiptNo" value="${loanInstance?.accoutsReceiptNo}"  />
                                    
                                </td>
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="status"><g:message code="loan.status.label" default="Status" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: loanInstance, field: 'status', 'errors')}">
                                	<g:if test = "${toBeSubmitted == '1'}">
                                		${loanInstance?.status}
                                	</g:if>
                                	<g:else>
                                    	<g:select name="status" from="${['PENDING','SUBMITTED','ACCEPTED','MATURED','INVALID','CLOSED']}" value="${loanInstance?.status}" />
                                    </g:else>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="creator"><g:message code="loan.creator.label" default="Creator" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: loanInstance, field: 'creator', 'errors')}">
                                    ${loanInstance?.creator}
                                </td>
                            </tr>
                        
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="updator"><g:message code="loan.updator.label" default="Updator" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: loanInstance, field: 'updator', 'errors')}">
                                    ${loanInstance?.updator}
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
					<g:if test = "${toBeSubmitted == '1'}">
						<g:hiddenField name="toSubmit" value="" />
						<span class="button"><g:actionSubmit class="save" action="update" value="Mark as Submitted" onclick="markSubmitted();"/></span>
					</g:if>
						
					<g:else>
                    	<span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    </g:else>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </div>
            </g:form>
        </div>
        <script language="javascript">
        	function markSubmitted()
        	{
        		document.getElementById("toSubmit").value = 1;
        	}
        </script>
        
    </body>
</html>
