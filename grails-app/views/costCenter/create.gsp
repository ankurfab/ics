
<%@ page import="ics.CostCenter" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="costCenter.create" default="Create CostCenter" /></title>
	<r:require module="jqui" />
    </head>
    <body>
	<script>
	$(function() {
		$( "#ind" ).autocomplete({
			source: "${createLink(controller:'individual',action:'allIndividualsAsJSON_JQ')}",//todo take care of data from other departments
			minLength: 3,
			  select: function(event, ui) { // event handler when user selects a company from the list.
			   $(document.getElementById('owner.id')).val(ui.item.id); // update the hidden field.
			  }
		});
		$( "#ind1" ).autocomplete({
			source: "${createLink(controller:'individual',action:'allIndividualsAsJSON_JQ')}",//todo take care of data from other departments
			minLength: 3,
			  select: function(event, ui) { // event handler when user selects a company from the list.
			   $(document.getElementById('owner1.id')).val(ui.item.id); // update the hidden field.
			  }
		});
		$( "#ind2" ).autocomplete({
			source: "${createLink(controller:'individual',action:'allIndividualsAsJSON_JQ')}",//todo take care of data from other departments
			minLength: 3,
			  select: function(event, ui) { // event handler when user selects a company from the list.
			   $(document.getElementById('owner2.id')).val(ui.item.id); // update the hidden field.
			  }
		});
	});
	</script>
         <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="costCenter.list" default="CostCenter List" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="costCenter.create" default="Create CostCenter" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:hasErrors bean="${costCenterInstance}">
            <div class="errors">
                <g:renderErrors bean="${costCenterInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="name"><g:message code="costCenter.name" default="Name" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: costCenterInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" value="${fieldValue(bean: costCenterInstance, field: 'name')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="alias"><g:message code="costCenter.alias" default="Alias" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: costCenterInstance, field: 'alias', 'errors')}">
                                    <g:textField name="alias" value="${fieldValue(bean: costCenterInstance, field: 'alias')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="isProfitCenter"><g:message code="costCenter.isProfitCenter" default="Is Profit Center" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: costCenterInstance, field: 'isProfitCenter', 'errors')}">
					Yes<g:radio name="isProfitCenter" value="true" checked="${costCenterInstance?.isProfitCenter?'checked':''}"/>
					No<g:radio name="isProfitCenter" value="false" checked="${costCenterInstance?.isProfitCenter?'':'checked'}"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="isServiceCenter"><g:message code="costCenter.isServiceCenter" default="Is Service Center" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: costCenterInstance, field: 'isServiceCenter', 'errors')}">
					Yes<g:radio name="isServiceCenter" value="true" checked="${costCenterInstance?.isServiceCenter?'checked':''}"/>
					No<g:radio name="isServiceCenter" value="false" checked="${costCenterInstance?.isServiceCenter?'':'checked'}"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="budget"><g:message code="costCenter.budget" default="Budget" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: costCenterInstance, field: 'budget', 'errors')}">
                                    <g:textField name="budget" value="${fieldValue(bean: costCenterInstance, field: 'budget')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="capitalBudget"><g:message code="costCenter.capitalBudget" default="Capital Budget" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: costCenterInstance, field: 'capitalBudget', 'errors')}">
                                    <g:textField name="capitalBudget" value="${fieldValue(bean: costCenterInstance, field: 'capitalBudget')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="owner">Owner</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: costCenterInstance, field: 'owner', 'errors')}">
                                    <g:hiddenField name="owner.id" value=""/>
                                    <input id="ind" size="40" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="owner1">Owner1</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: costCenterInstance, field: 'owner1', 'errors')}">
                                    <g:hiddenField name="owner1.id" value=""/>
                                    <input id="ind1" size="40" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="owner2">Owner2</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: costCenterInstance, field: 'owner2', 'errors')}">
                                    <g:hiddenField name="owner2.id" value=""/>
                                    <input id="ind2" size="40" />
                                </td>
                            </tr>
                        

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="costCategory"><g:message code="costCenter.costCategory" default="Cost Category" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: costCenterInstance, field: 'costCategory', 'errors')}">
                                    <g:select name="costCategory.id" from="${ics.CostCategory.list([sort:'name'])}" optionKey="id" value="${costCenterInstance?.costCategory?.id}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="costCenterGroup"><g:message code="costCenter.costCenterGroup" default="Cost Center Group" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: costCenterInstance, field: 'costCenterGroup', 'errors')}">
                                    <g:select name="costCenterGroup.id" from="${ics.CostCenterGroup.list([sort:'name'])}" optionKey="id" value="${costCenterInstance?.costCenterGroup?.id}"  noSelection="['':'-Choose Cost Center Group-']"/>

                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'create', 'default': 'Create')}" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
