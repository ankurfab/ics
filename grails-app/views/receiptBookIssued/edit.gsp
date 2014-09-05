
<%@ page import="ics.ReceiptBookIssued" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'receiptBookIssued.label', default: 'ReceiptBookIssued')}" />
        <!--<title><g:message code="default.edit.label" args="[entityName]" /></title>-->
        <title><g:message code="Return ReceiptBookIssued" args="[entityName]" /></title>
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
        	$("#retrunDate").datepicker({yearRange: "-5:+5",changeMonth: true,changeYear: true,
			dateFormat: 'dd-mm-yy'});
            })
    	</script>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">Home</a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="Issue ReceiptBook" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="Return ReceiptBookIssued" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${receiptBookIssuedInstance}">
            <div class="errors">
                <g:renderErrors bean="${receiptBookIssuedInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${receiptBookIssuedInstance?.id}" />
                <g:hiddenField name="version" value="${receiptBookIssuedInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="receiptBook"><g:message code="receiptBookIssued.receiptBook.label" default="Receipt Book" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: receiptBookIssuedInstance, field: 'receiptBook', 'errors')}">
                                	<!--<g:hiddenField name="receiptBook.id" value="${receiptBookIssuedInstance?.receiptBook?.id}" />-->
                                    <label>${receiptBookIssuedInstance?.receiptBook?.toString()} </label>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="issuedTo"><g:message code="receiptBookIssued.issuedTo.label" default="Issued To" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: receiptBookIssuedInstance, field: 'issuedTo', 'errors')}">
                                    <label>${receiptBookIssuedInstance?.issuedTo?.toString()} </label>
                                </td>
                            </tr>

			<g:set var="crel" value="${ics.Relation.findByName('Councellee of')}" />
			<g:set var="counsellor" value="${ics.Relationship.findByIndividual1AndRelation(receiptBookIssuedInstance.issuedTo,crel)?.individual2}" />
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label>Councellor</label>
                                </td>
                                <td valign="top" class="value">
                                    <label>${counsellor} </label>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="issueDate"><g:message code="receiptBookIssued.issueDate.label" default="Issue Date" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: receiptBookIssuedInstance, field: 'issueDate', 'errors')}">
				    <g:formatDate format="dd-MM-yyyy" date="${receiptBookIssuedInstance?.issueDate}" />                                
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="returnDate"><g:message code="receiptBookIssued.returnDate.label" default="Return Date" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: receiptBookIssuedInstance, field: 'returnDate', 'errors')}">
                                    <!--<g:textField name="returnDate" value="${receiptBookIssuedInstance?.returnDate}"  />-->
                                    <label for="returnDate">${new Date().format('dd-MM-yyyy')}</label>
                                    <g:hiddenField name="returnDate" value="${new Date().format('dd-MM-yyyy')}"  />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="status"><g:message code="receiptBookIssued.status.label" default="Status" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: receiptBookIssuedInstance, field: 'status', 'errors')}">
                                    <g:select name="status" from="${['Submitted','Filled','Partly Filled','Blank','Lost','Damaged','Faulty']}" value="${receiptBookIssuedInstance?.status}"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="tempCash"><g:message code="receiptBookIssued.tempCash.label" default="Submitted Cash" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: receiptBookIssuedInstance, field: 'tempCash', 'errors')}">
                                    <g:textField name="tempCash" value="${receiptBookIssuedInstance?.tempCash}"/>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="tempCheque"><g:message code="receiptBookIssued.tempCheque.label" default="Submitted Cheque" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: receiptBookIssuedInstance, field: 'tempCheque', 'errors')}">
                                    <g:textField name="tempCheque" value="${receiptBookIssuedInstance?.tempCheque}"/>
                                </td>
                            </tr>



                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="comments"><g:message code="receiptBookIssued.comments.label" default="Comments" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: receiptBookIssuedInstance, field: 'comments', 'errors')}">
                                    <g:textArea name="comments" value="${receiptBookIssuedInstance?.comments}" rows="5" cols="40"/>
                                </td>
                            </tr>
                        
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    <!--<span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>-->
                </div>
            </g:form>
        </div>
    </body>
</html>
