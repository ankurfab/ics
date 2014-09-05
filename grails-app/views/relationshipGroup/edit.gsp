
<%@ page import="ics.RelationshipGroup" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'relationshipGroup.label', default: 'RelationshipGroup')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
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
            <g:hasErrors bean="${relationshipGroupInstance}">
            <div class="errors">
                <g:renderErrors bean="${relationshipGroupInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${relationshipGroupInstance?.id}" />
                <g:hiddenField name="version" value="${relationshipGroupInstance?.version}" />
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
                                  <label for="comments"><g:message code="relationshipGroup.comments.label" default="Comments" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: relationshipGroupInstance, field: 'comments', 'errors')}">
                                    <g:textField name="comments" value="${relationshipGroupInstance?.comments}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="relationships"><g:message code="relationshipGroup.relationships.label" default="Relationships" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: relationshipGroupInstance, field: 'relationships', 'errors')}">
                                    
<ul>
<g:each in="${relationshipGroupInstance?.relationships?}" var="r">
    <li><g:link controller="relationship" action="show" id="${r.id}">${r?.encodeAsHTML()}</g:link></li>
</g:each>
</ul>
<g:link controller="relationship" action="create" params="['relationshipGroup.id': relationshipGroupInstance?.id,'individual2.id': relationshipGroupInstance?.refid]">${message(code: 'default.add.label', args: [message(code: 'relationship.label', default: 'Relationship')])}</g:link>

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
