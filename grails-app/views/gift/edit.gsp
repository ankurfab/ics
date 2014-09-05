
<%@ page import="ics.Gift" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'gift.label', default: 'Gift')}" />
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
        	$("#effectiveFrom").datepicker({yearRange: "-5:+5",changeMonth: true,changeYear: true,
			dateFormat: 'dd-mm-yy'});
        	$("#effectiveTill").datepicker({yearRange: "-5:+5",changeMonth: true,changeYear: true,
			dateFormat: 'dd-mm-yy'});
          	
            })
    	</script>

        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">Home</a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${giftInstance}">
            <div class="errors">
                <g:renderErrors bean="${giftInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${giftInstance?.id}" />
                <g:hiddenField name="version" value="${giftInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="name"><g:message code="gift.name.label" default="Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: giftInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" value="${giftInstance?.name}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="worth"><g:message code="gift.worth.label" default="Worth" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: giftInstance, field: 'worth', 'errors')}">
                                    <g:textField name="worth" value="${fieldValue(bean: giftInstance, field: 'worth')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="cost"><g:message code="gift.cost.label" default="Cost" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: giftInstance, field: 'cost', 'errors')}">
                                    <g:textField name="cost" value="${fieldValue(bean: giftInstance, field: 'cost')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="qtyInStock"><g:message code="gift.qtyInStock.label" default="Qty In Stock" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: giftInstance, field: 'qtyInStock', 'errors')}">
                                    <g:textField name="qtyInStock" value="${fieldValue(bean: giftInstance, field: 'qtyInStock')}" />
                                </td>
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="department"><g:message code="gift.department.label" default="Department" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: giftInstance, field: 'department', 'errors')}">
                                    <g:select name="department.id" from="${ics.Department.list()}" optionKey="id" value="${giftInstance?.department?.id}" />
                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="effectiveFrom"><g:message code="giftInstance.effectiveFrom" default="Effective From" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: giftInstance, field: 'effectiveFrom', 'errors')}">
                                     <g:textField name="effectiveFrom" value="${giftInstance?.effectiveFrom?.format('dd-MM-yyyy')}"/>                                      

                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="effectiveTill"><g:message code="giftInstance.effectiveTill" default="Effective Till" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: giftInstance, field: 'effectiveTill', 'errors')}">
                                     <g:textField name="effectiveTill" value="${giftInstance?.effectiveTill?.format('dd-MM-yyyy')}"/>                                      

                                </td>
                            </tr>

                            <!--<tr class="prop">
                                <td valign="top" class="name">
                                  <label for="giftIssued"><g:message code="gift.giftIssued.label" default="Gift Issued" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: giftInstance, field: 'giftIssued', 'errors')}">
                                    
<ul>
<g:each in="${giftInstance?.giftIssued?}" var="g">
    <li><g:link controller="giftIssued" action="show" id="${g.id}">${g?.encodeAsHTML()}</g:link></li>
</g:each>
</ul>


                                </td>
                            </tr>-->
                        
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
