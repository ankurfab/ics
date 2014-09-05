
<%@ page import="ics.CostCategory" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="costCategory.edit" default="Edit CostCategory" /></title>
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
	});
	</script>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="costCategory.list" default="CostCategory List" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="costCategory.new" default="New CostCategory" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="costCategory.edit" default="Edit CostCategory" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:hasErrors bean="${costCategoryInstance}">
            <div class="errors">
                <g:renderErrors bean="${costCategoryInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${costCategoryInstance?.id}" />
                <g:hiddenField name="version" value="${costCategoryInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="name"><g:message code="costCategory.name" default="Name" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: costCategoryInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" value="${fieldValue(bean: costCategoryInstance, field: 'name')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="alias"><g:message code="costCategory.alias" default="Alias" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: costCategoryInstance, field: 'alias', 'errors')}">
                                    <g:textField name="alias" value="${fieldValue(bean: costCategoryInstance, field: 'alias')}" />

                                </td>
                            </tr>

                             <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="currentowner">CurrentOwner</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: costCategoryInstance, field: 'owner', 'errors')}">
                                    ${fieldValue(bean: costCategoryInstance, field: 'owner')}
                                </td>
                            </tr>

                           <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="newowner">New Owner</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: costCategoryInstance, field: 'owner', 'errors')}">
                                    <g:hiddenField name="owner.id" value="${costCategoryInstance?.owner?.id}"/>
                                    <input id="ind" size="40" />
                                </td>
                            </tr>

                                                
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="costCenters"><g:message code="costCategory.costCenters" default="Cost Centers" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: costCategoryInstance, field: 'costCenters', 'errors')}">
                                    
<ul>
<g:each in="${costCategoryInstance?.costCenters}" var="costCenterInstance">
    <li><g:link controller="costCenter" action="show" id="${costCenterInstance.id}">${costCenterInstance?.encodeAsHTML()}</g:link></li>
</g:each>
</ul>
<g:link controller="costCenter" params="['costCategory.id': costCategoryInstance?.id]" action="create"><g:message code="costCenter.new" default="New CostCenter" /></g:link>


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
