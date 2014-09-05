
<%@ page import="ics.BouncedCheque" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'bouncedCheque.label', default: 'Dishonoured Cheque')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
	<link rel="stylesheet" href="${resource(dir: 'css/start', file: 'jquery-ui-1.8.18.custom.css')}" type="text/css">
    </head>
    <body>

	<g:javascript src="jquery-ui-1.8.18.custom.min.js" />
        
    	<script type="text/javascript">
    	    $(document).ready(function()
    	    {
    	      $("#chequeDate").datepicker({yearRange: "-5:+5",changeMonth: true,changeYear: true,
			dateFormat: 'dd-mm-yy'});
    	      $("#presentedOn").datepicker({yearRange: "-5:+5",changeMonth: true,changeYear: true,
			dateFormat: 'dd-mm-yy'});
			
    	    })
    	</script>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <!--<span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>-->
        </div>
        <div class="body">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${bouncedChequeInstance}">
            <div class="errors">
                <g:renderErrors bean="${bouncedChequeInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${bouncedChequeInstance?.id}" />
                <g:hiddenField name="version" value="${bouncedChequeInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="chequeNo"><g:message code="bouncedCheque.chequeNo.label" default="Cheque No" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: bouncedChequeInstance, field: 'chequeNo', 'errors')}">
                                    <g:textField name="chequeNo" maxlength="10" value="${bouncedChequeInstance?.chequeNo}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="chequeDate"><g:message code="bouncedCheque.chequeDate.label" default="Cheque Date" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: bouncedChequeInstance, field: 'chequeDate', 'errors')}">
                                    <!--<g:datePicker name="chequeDate" precision="day" value="${bouncedChequeInstance?.chequeDate}"  />-->
                                    <g:textField name="chequeDate" value="${bouncedChequeInstance?.chequeDate?.format('dd-MM-yyyy')}"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="bankName"><g:message code="bouncedCheque.bankName.label" default="Bank Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: bouncedChequeInstance, field: 'bankName', 'errors')}">
                                    <g:textField name="bankName" value="${bouncedChequeInstance?.bankName}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="branchName"><g:message code="bouncedCheque.branchName.label" default="Branch Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: bouncedChequeInstance, field: 'branchName', 'errors')}">
                                    <g:textField name="branchName" value="${bouncedChequeInstance?.branchName}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="issuedBy"><g:message code="bouncedCheque.issuedBy.label" default="Issued By" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: bouncedChequeInstance, field: 'issuedBy', 'errors')}">
                                    <g:textField name="issuedBy" value="${bouncedChequeInstance?.issuedBy}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="issuedTo"><g:message code="bouncedCheque.issuedTo.label" default="Issued To" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: bouncedChequeInstance, field: 'issuedTo', 'errors')}">
                                    <g:textField name="issuedTo" value="${bouncedChequeInstance?.issuedTo}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="presentedOn"><g:message code="bouncedCheque.presentedOn.label" default="Presented On" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: bouncedChequeInstance, field: 'presentedOn', 'errors')}">
                                    <!--<g:datePicker name="presentedOn" precision="day" value="${bouncedChequeInstance?.presentedOn}"  />-->
                                    <g:textField name="presentedOn" value="${bouncedChequeInstance?.presentedOn?.format('dd-MM-yyyy')}"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="comments"><g:message code="bouncedCheque.comments.label" default="Comments" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: bouncedChequeInstance, field: 'comments', 'errors')}">
                                    <g:textArea name="comments" value="${bouncedChequeInstance?.comments}" rows="5" cols="40"/>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="status"><g:message code="bouncedCheque.status.label" default="Status" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: bouncedChequeInstance, field: 'status', 'errors')}">
                                    <g:select name="status" from="${['OPEN','CLOSED','DELETED']}" value="${bouncedChequeInstance.status}"/>
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
    </body>
</html>
