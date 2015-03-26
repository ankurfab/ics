
<%@ page import="ics.CostCenterGroup" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="costCenterGroup.create" default="Create CostCenterGroup" /></title>
  	<r:require module="jqui" />
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="costCenterGroup.list" default="CostCenterGroup List" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="costCenterGroup.create" default="Create CostCenterGroup" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:hasErrors bean="${costCenterGroupInstance}">
            <div class="errors">
                <g:renderErrors bean="${costCenterGroupInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
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
                                    <label for="owner"><g:message code="costCenterGroup.owner" default="Owner" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: costCenterGroupInstance, field: 'owner', 'errors')}">
				    <g:hiddenField name="owner.id" value=""/>
				    <input id="ind" size="40" />
                                </td>
                            </tr>
                                                
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="creator"><g:message code="costCenterGroup.creator" default="Creator" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: costCenterGroupInstance, field: 'creator', 'errors')}">
                                    <g:textField name="creator" value="${fieldValue(bean: costCenterGroupInstance, field: 'creator')}" />

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
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'create', 'default': 'Create')}" /></span>
                </div>
            </g:form>
        </div>

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


    </body>
</html>