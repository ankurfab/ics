
<%@ page import="ics.CostCenter" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="costCenter.edit" default="Edit CostCenter" /></title>
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
            <span class="menuButton"><g:link class="create" action="create"><g:message code="costCenter.new" default="New CostCenter" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="costCenter.edit" default="Edit CostCenter" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:hasErrors bean="${costCenterInstance}">
            <div class="errors">
                <g:renderErrors bean="${costCenterInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${costCenterInstance?.id}" />
                <g:hiddenField name="version" value="${costCenterInstance?.version}" />
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
                                    <g:select name="costCenterGroup.id" from="${ics.CostCenterGroup.list([sort:'name'])}" optionKey="id" value="${costCenterInstance?.costCenterGroup?.id}"   noSelection="['':'-Choose Cost Center Group-']"/>

                                </td>
                            </tr>

                             <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="currentowner">CurrentOwner</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: costCenterInstance, field: 'owner', 'errors')}">
                                    ${fieldValue(bean: costCenterInstance, field: 'owner')}
                                </td>
                            </tr>

                           <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="newowner">New Owner</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: costCenterInstance, field: 'owner', 'errors')}">
                                    <g:hiddenField name="owner.id" value="${costCenterInstance?.owner?.id}"/>
                                    <input id="ind" size="40" />
                                </td>
                            </tr>

                             <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="currentowner1">CurrentOwner1</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: costCenterInstance, field: 'owner1', 'errors')}">
                                    ${fieldValue(bean: costCenterInstance, field: 'owner1')}
                                </td>
                            </tr>

                           <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="newowner1">New Owner1</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: costCenterInstance, field: 'owner1', 'errors')}">
                                    <g:hiddenField name="owner1.id" value="${costCenterInstance?.owner1?.id}"/>
                                    <input id="ind1" size="40" />
                                </td>
                            </tr>

                             <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="currentowner2">CurrentOwner2</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: costCenterInstance, field: 'owner2', 'errors')}">
                                    ${fieldValue(bean: costCenterInstance, field: 'owner2')}
                                </td>
                            </tr>

                           <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="newowner2">New Owner2</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: costCenterInstance, field: 'owner2', 'errors')}">
                                    <g:hiddenField name="owner2.id" value="${costCenterInstance?.owner2?.id}"/>
                                    <input id="ind2" size="40" />
                                </td>
                            </tr>

                                                
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'update', 'default': 'Update')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'delete', 'default': 'Delete')}" onclick="return confirm('${message(code: 'delete.confirm', 'default': 'Are you sure?')}');" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
