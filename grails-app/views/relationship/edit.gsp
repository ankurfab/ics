
<%@ page import="ics.Relationship" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'relationship.label', default: 'Relationship')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">Home</a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <!--<span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>-->
        </div>
        <div class="body">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${relationshipInstance}">
            <div class="errors">
                <g:renderErrors bean="${relationshipInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${relationshipInstance?.id}" />
                <g:hiddenField name="version" value="${relationshipInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="relationshipGroup"><g:message code="relationship.relationshipGroup.label" default="Relationship Group" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: relationshipInstance, field: 'relationshipGroup', 'errors')}">
                                    ${relationshipInstance?.relationshipGroup}
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="individual1"><g:message code="relationship.individual1.label" default="Individual1" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: relationshipInstance, field: 'individual1', 'errors')}">
                                    ${relationshipInstance?.individual1}
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="relation"><g:message code="relationship.relation.label" default="Relation" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: relationshipInstance, field: 'relation', 'errors')}">
                                    
                                    ${relationshipInstance?.relation}
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="individual2"><g:message code="relationship.individual2.label" default="Individual2" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: relationshipInstance, field: 'individual2', 'errors')}">
                                    ${relationshipInstance?.individual2}
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="status"><g:message code="relationship.status.label" default="Status" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: relationshipInstance, field: 'status', 'errors')}">
                                    <g:select name="status" from="${['ACTIVE','INACTIVE','DELETED']}"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="comment"><g:message code="relationship.comment.label" default="Comment" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: relationshipInstance, field: 'comment', 'errors')}">
                                    <g:textArea name="comment" value="${relationshipInstance?.comment}" rows="5" cols="40"/>
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
