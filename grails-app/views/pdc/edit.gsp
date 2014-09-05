

<%@ page import="ics.Pdc" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'pdc.label', default: 'Pdc')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
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
          $("#chequeDate").datepicker({yearRange: "-0:+5",changeMonth: true,changeYear: true,
			dateFormat: 'dd-mm-yy'});
        })
    </script>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${pdcInstance}">
            <div class="errors">
                <g:renderErrors bean="${pdcInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post"  onsubmit="return validate();">
                <g:hiddenField name="id" value="${pdcInstance?.id}" />
                <g:hiddenField name="version" value="${pdcInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="receivedBy"><g:message code="pdc.receivedBy.label" default="Received By" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: pdcInstance, field: 'receivedBy', 'errors')}">
                                    ${session.individualname}
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  Current Issued By
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: pdcInstance, field: 'issuedBy', 'errors')}">
                                    ${pdcInstance?.issuedBy}
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  Modified Issued By
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: pdcInstance, field: 'issuedBy', 'errors')}">
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
                                  Current Collected By
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: pdcInstance, field: 'collectedBy', 'errors')}">
                                    ${pdcInstance?.collectedBy}
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  Modified Collected By
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: pdcInstance, field: 'collectedBy', 'errors')}">
			       <div style="width: 300px">
				<gui:autoComplete
				    id="acCollector"
				    width="200px"
				    controller="individual"
				    action="findCollectorsAsJSON"
				    useShadow="true"
				    queryDelay="0.5" minQueryLength='3'
			    />
			    </div>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="scheme"><g:message code="pdc.scheme.label" default="Scheme" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: pdcInstance, field: 'scheme', 'errors')}">
                                    <g:select name="scheme.id" from="${ics.Scheme.list(sort:'name')}" optionKey="id" value="${pdcInstance?.scheme?.id}" noSelection="['null': '--Select Scheme--']" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="chequeNo"><g:message code="pdc.chequeNo.label" default="Cheque No" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: pdcInstance, field: 'chequeNo', 'errors')}">
                                    <g:textField name="chequeNo" value="${pdcInstance?.chequeNo}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="chequeDate"><g:message code="pdc.chequeDate.label" default="Cheque Date" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: pdcInstance, field: 'chequeDate', 'errors')}">
                                    <g:textField name="chequeDate" value="${pdcInstance?.chequeDate?.format('dd-MM-yyyy')}"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="bank"><g:message code="pdc.bank.label" default="Bank" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: pdcInstance, field: 'bank', 'errors')}">
                                    <g:select name="bank.id" from="${ics.Bank.listOrderByName()}" optionKey="id" value="${pdcInstance?.bank?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="branch"><g:message code="pdc.branch.label" default="Branch" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: pdcInstance, field: 'branch', 'errors')}">
                                    <g:textField name="branch" value="${pdcInstance?.branch}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="amount"><g:message code="pdc.amount.label" default="Amount" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: pdcInstance, field: 'amount', 'errors')}">
                                    <g:textField name="amount" value="${fieldValue(bean: pdcInstance, field: 'amount')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="comments"><g:message code="pdc.comments.label" default="Comments" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: pdcInstance, field: 'comments', 'errors')}">
                                    <g:textArea name="comments" value="${pdcInstance?.comments}" rows="5" cols="40"/>
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </div>
            </g:form>
        </div>

       <script language="javascript"> 
	function validate() {   
		if (document.getElementById("amount").value>0)
			{
			alert("Please provide a valid amount");
			document.getElementById('amount').focus();
			return false;
			}
		return true;
	}
	    
	    </script>

    </body>


</html>
