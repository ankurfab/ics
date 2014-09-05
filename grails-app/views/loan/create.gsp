

<%@ page import="ics.Loan" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="Advance Donation" />
        <title>New Advance Donation</title>
        <gui:resources components="['expandablePanel','accordion', 'dataTable', 'richEditor', 'tabView','autoComplete']"/>
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
        </div>
  
        <div class="body">
        
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${loanInstance}">
            <div class="errors">
                <g:renderErrors bean="${loanInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="loanDate"><g:message code="loan.loanDate.label" default="Advance Donation Date" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: loanInstance, field: 'loanDate', 'errors')}">
                                    <g:textField name="loanDate" precision="day" value="${(loanInstance?.loanDate?:new Date())?.format('dd-MM-yyyy')}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="loanedBy"><g:message code="loan.loanedBy.label" default="Advance Donation By" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: loanInstance, field: 'loanedBy', 'errors')}">
							   <div style="width: 300px">
									<gui:autoComplete
										id="acIndividual"
										width="200px"
										controller="individual"
										action="allIndividualsExceptDummyDonorAsJSON"
										useShadow="true"
										queryDelay="0.5" minQueryLength='3'

									/>
								</div>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="reference1"><g:message code="loan.reference1.label" default="Reference1" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: loanInstance, field: 'reference1', 'errors')}">
							   <div style="width: 300px">
								<gui:autoComplete
									id="acReference1"
									width="200px"
									controller="individual"
									action="findDepCouncellorAsJSON"
									dependsOn="[
											label:'individualid',
											value:'acIndividual',
											useId:true
									]"
									useShadow="true"
									queryDelay="0.5" minQueryLength='3'
								/>
							</div>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="reference2"><g:message code="loan.reference2.label" default="Reference2" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: loanInstance, field: 'reference2', 'errors')}">
                                    <g:select name="reference2.id" from="${ics.Individual.findByLegalName('Srigurucharan Das')}" optionKey="id" value="${loanInstance?.reference2?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="amount"><g:message code="loan.amount.label" default="Amount" /></label>
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
                                    <g:select name="status" from="${['PENDING','ACCEPTED','MATURED','INVALID']}" value="${loanInstance?.status}" />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="loanReceiptNo"><g:message code="loan.loanReceiptNo.label" default="Advance Donation Receipt No" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: loanInstance, field: 'loanReceiptNo', 'errors')}">
                                    <g:textField name="loanReceiptNo" value="${loanInstance?.loanReceiptNo}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="mode"><g:message code="loan.mode.label" default="Mode" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: loanInstance, field: 'mode', 'errors')}">
                                    <g:select name="mode.id" from="${ics.PaymentMode.list()}" optionKey="id" value="${loanInstance?.mode?.id}"  noSelection="['null':'-Select-']"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="bank"><g:message code="loan.bank.label" default="Bank" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: loanInstance, field: 'bank', 'errors')}">
                                    <!--<g:select name="bank.id" from="${ics.Bank.list()}" optionKey="id" value="${loanInstance?.bank?.id}" noSelection="['null': '']" />-->
                                    <g:textField name="bankName" value="${loanInstance?.bankName}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="bankBranch"><g:message code="loan.bankBranch.label" default="Bank Branch" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: loanInstance, field: 'bankBranch', 'errors')}">
                                    <g:textField name="bankBranch" value="${loanInstance?.bankBranch}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
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
                                    <g:textField name="chequeDate" precision="day" value="${loanInstance?.chequeDate?.format('dd-MM-yyyy')}" />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="loanStartDate"><g:message code="loan.loanStartDate.label" default="Advance Donation Start Date" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: loanInstance, field: 'loanStartDate', 'errors')}">
                                    <g:textField name="loanStartDate" precision="day" value="${loanInstance?.loanStartDate?.format('dd-MM-yyyy')}"  />
                                </td>
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="loanEndDate"><g:message code="loan.loanEndDate.label" default="Advance Donation End Date" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: loanInstance, field: 'loanEndDate', 'errors')}">
                                    <g:textField name="loanEndDate" precision="day" value="${loanInstance?.loanEndDate?.format('dd-MM-yyyy')}"  />
                                </td>
                            </tr>
                        
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
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
            </g:form>
        
			
        </div>
    </body>
</html>
