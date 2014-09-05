
<%@ page import="ics.RelationshipGroup" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'relationshipGroup.label', default: 'RelationshipGroup')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
	<r:require module="jqui" />
    </head>
    <body>
	<script>
	$(function() {
		$( "#ind" ).autocomplete({
			source: "${createLink(controller:'individual',action:'allIndividualsAsJSON_JQ')}",
			minLength: 3,
			  select: function(event, ui) { // event handler when user selects a company from the list.
			   $("#linkedid").val(ui.item.id); // update the hidden field.
			  }
		});
	});
	</script>

        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">Home</a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${relationshipGroupInstance}">
            <div class="errors">
                <g:renderErrors bean="${relationshipGroupInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="groupName"><g:message code="relationshipGroup.groupName.label" default="Group Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: relationshipGroupInstance, field: 'groupName', 'errors')}">
                                    <g:textField name="groupName" value="${relationshipGroupInstance?.groupName}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="linkedIndividual">Linked Individual</label>*
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: icsUserInstance, field: 'linkedIndividual', 'errors')}">
                                    <g:hiddenField name="linkedid" value=""/>
                                    <input id="ind" size="40" />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="comments"><g:message code="relationshipGroup.comments.label" default="Comments" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: relationshipGroupInstance, field: 'comments', 'errors')}">
                                    <g:textField name="comments" value="${relationshipGroupInstance?.comments}" />
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
