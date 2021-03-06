

<%@ page import="ics.EventCriteria" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'eventCriteria.label', default: 'EventCriteria')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${eventCriteriaInstance}">
            <div class="errors">
                <g:renderErrors bean="${eventCriteriaInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${eventCriteriaInstance?.id}" />
                <g:hiddenField name="version" value="${eventCriteriaInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="name"><g:message code="eventCriteria.name.label" default="Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventCriteriaInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" value="${eventCriteriaInstance?.name}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="description"><g:message code="eventCriteria.description.label" default="Description" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventCriteriaInstance, field: 'description', 'errors')}">
                                    <g:textField name="description" value="${eventCriteriaInstance?.description}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="conditon1"><g:message code="eventCriteria.conditon1.label" default="Conditon1" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventCriteriaInstance, field: 'conditon1', 'errors')}">
                                    <g:textField name="conditon1" value="${eventCriteriaInstance?.conditon1}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="conditon2"><g:message code="eventCriteria.conditon2.label" default="Conditon2" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventCriteriaInstance, field: 'conditon2', 'errors')}">
                                    <g:textField name="conditon2" value="${eventCriteriaInstance?.conditon2}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="conditon3"><g:message code="eventCriteria.conditon3.label" default="Conditon3" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventCriteriaInstance, field: 'conditon3', 'errors')}">
                                    <g:textField name="conditon3" value="${eventCriteriaInstance?.conditon3}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="conditon4"><g:message code="eventCriteria.conditon4.label" default="Conditon4" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventCriteriaInstance, field: 'conditon4', 'errors')}">
                                    <g:textField name="conditon4" value="${eventCriteriaInstance?.conditon4}" />
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
