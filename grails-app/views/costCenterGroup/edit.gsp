
<%@ page import="ics.CostCenterGroup" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="costCenterGroup.edit" default="Edit CostCenterGroup" /></title>
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
            <span class="menuButton"><g:link class="list" action="list"><g:message code="costCenterGroup.list" default="CostCenterGroup List" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="costCenterGroup.new" default="New CostCenterGroup" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="costCenterGroup.edit" default="Edit CostCenterGroup" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:hasErrors bean="${costCenterGroupInstance}">
            <div class="errors">
                <g:renderErrors bean="${costCenterGroupInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${costCenterGroupInstance?.id}" />
                <g:hiddenField name="version" value="${costCenterGroupInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="name"><g:message code="costCenterGroup.name" default="Name" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: costCenterGroupInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" value="${fieldValue(bean: costCenterGroupInstance, field: 'name')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="description"><g:message code="costCenterGroup.description" default="Description" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: costCenterGroupInstance, field: 'description', 'errors')}">
                                    <g:textField name="description" value="${fieldValue(bean: costCenterGroupInstance, field: 'description')}" />

                                </td>
                            </tr>
                        
                             <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="currentowner">CurrentOwner</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: costCenterGroupInstance, field: 'owner', 'errors')}">
                                    ${fieldValue(bean: costCenterGroupInstance, field: 'owner')}
                                </td>
                            </tr>

                           <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="newowner">New Owner</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: costCenterGroupInstance, field: 'owner', 'errors')}">
                                    <g:hiddenField name="owner.id" value="${costCenterGroupInstance?.owner?.id}"/>
                                    <input id="ind" size="40" />
                                </td>
                            </tr>
                        
                                                
                           <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="newowner1">New Owner1</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: costCenterGroupInstance, field: 'owner1', 'errors')}">
                                    <g:hiddenField name="owner1.id" value="${costCenterGroupInstance?.owner1?.id}"/>
                                    <input id="ind1" size="40" />
                                </td>
                            </tr>

                           <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="newowner2">New Owner2</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: costCenterGroupInstance, field: 'owner2', 'errors')}">
                                    <g:hiddenField name="owner2.id" value="${costCenterGroupInstance?.owner2?.id}"/>
                                    <input id="ind2" size="40" />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="updator"><g:message code="costCenterGroup.updator" default="Updator" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: costCenterGroupInstance, field: 'updator', 'errors')}">
                                    <g:textField name="updator" value="${fieldValue(bean: costCenterGroupInstance, field: 'updator')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="costCenters"><g:message code="costCenterGroup.costCenters" default="Cost Centers" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: costCenterGroupInstance, field: 'costCenters', 'errors')}">
                                    
<ul>
<g:each in="${costCenterGroupInstance?.costCenters}" var="costCenterInstance">
    <li><g:link controller="costCenter" action="show" id="${costCenterInstance.id}">${costCenterInstance?.encodeAsHTML()}</g:link></li>
</g:each>
</ul>
<g:link controller="costCenter" params="['costCenterGroup.id': costCenterGroupInstance?.id]" action="create"><g:message code="costCenter.new" default="New CostCenter" /></g:link>


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
