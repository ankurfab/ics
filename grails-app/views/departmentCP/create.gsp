
<%@ page import="ics.DepartmentCP" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="departmentCP.create" default="Create DepartmentCP" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="departmentCP.list" default="DepartmentCP List" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="departmentCP.create" default="Create DepartmentCP" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:hasErrors bean="${departmentCPInstance}">
            <div class="errors">
                <g:renderErrors bean="${departmentCPInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="sender"><g:message code="departmentCP.sender" default="Sender" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: departmentCPInstance, field: 'sender', 'errors')}">
                                    <g:textField name="sender" value="${fieldValue(bean: departmentCPInstance, field: 'sender')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="cp"><g:message code="departmentCP.cp" default="Cp" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: departmentCPInstance, field: 'cp', 'errors')}">
                                    <g:select name="cp.id" from="${ics.CommsProvider.list()}" optionKey="id" value="${departmentCPInstance?.cp?.id}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="department"><g:message code="departmentCP.department" default="Department" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: departmentCPInstance, field: 'department', 'errors')}">
                                    <g:select name="department.id" from="${ics.Department.list()}" optionKey="id" value="${departmentCPInstance?.department?.id}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="count"><g:message code="departmentCP.count" default="Count" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: departmentCPInstance, field: 'count', 'errors')}">
                                    <g:textField name="count" value="${fieldValue(bean: departmentCPInstance, field: 'count')}" />

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
