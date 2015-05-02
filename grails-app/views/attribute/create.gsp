
<%@ page import="ics.Attribute" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="attribute.create" default="Create Attribute" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="attribute.list" default="Attribute List" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="attribute.create" default="Create Attribute" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:hasErrors bean="${attributeInstance}">
            <div class="errors">
                <g:renderErrors bean="${attributeInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="name"><g:message code="attribute.name" default="Name" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: attributeInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" value="${fieldValue(bean: attributeInstance, field: 'name')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="type"><g:message code="attribute.type" default="Type" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: attributeInstance, field: 'type', 'errors')}">
                                    <g:textField name="type" value="${fieldValue(bean: attributeInstance, field: 'type')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="category"><g:message code="attribute.category" default="Category" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: attributeInstance, field: 'category', 'errors')}">
                                    <g:textField name="category" value="${fieldValue(bean: attributeInstance, field: 'category')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="department"><g:message code="attribute.department" default="Department" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: attributeInstance, field: 'department', 'errors')}">
                                    <g:select name="department.id" from="${ics.Department.list()}" optionKey="id" value="${attributeInstance?.department?.id}" noSelection="['null': '']" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="centre"><g:message code="attribute.centre" default="Centre" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: attributeInstance, field: 'centre', 'errors')}">
                                    <g:select name="centre.id" from="${ics.Centre.list()}" optionKey="id" value="${attributeInstance?.centre?.id}" noSelection="['null': '']" />

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
