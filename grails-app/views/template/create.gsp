
<%@ page import="ics.Template" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="template.create" default="Create Template" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="template.list" default="Template List" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="template.create" default="Create Template" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:hasErrors bean="${templateInstance}">
            <div class="errors">
                <g:renderErrors bean="${templateInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="name"><g:message code="template.name" default="Name" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: templateInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" value="${fieldValue(bean: templateInstance, field: 'name')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="code"><g:message code="template.code" default="Code" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: templateInstance, field: 'code', 'errors')}">
                                    <g:textField name="code" value="${fieldValue(bean: templateInstance, field: 'code')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="body"><g:message code="template.body" default="Body" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: templateInstance, field: 'body', 'errors')}">
                                    <g:textArea name="body" rows="5" cols="40" value="${fieldValue(bean: templateInstance, field: 'body')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="category"><g:message code="template.category" default="Category" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: templateInstance, field: 'category', 'errors')}">
                                    <g:textField name="category" value="${fieldValue(bean: templateInstance, field: 'category')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="type"><g:message code="template.type" default="Type" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: templateInstance, field: 'type', 'errors')}">
                                    <g:textField name="type" value="${fieldValue(bean: templateInstance, field: 'type')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="department"><g:message code="template.department" default="Department" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: templateInstance, field: 'department', 'errors')}">
                                    <g:select name="department.id" from="${ics.Department.list()}" optionKey="id" value="${templateInstance?.department?.id}" noSelection="['null': '']" />

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
