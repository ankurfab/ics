

<%@ page import="ics.IndividualRole" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'individualRole.label', default: 'IndividualRole')}" />
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
            <g:hasErrors bean="${individualRoleInstance}">
            <div class="errors">
                <g:renderErrors bean="${individualRoleInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${individualRoleInstance?.id}" />
                <g:hiddenField name="version" value="${individualRoleInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="individual"><g:message code="individualRole.individual.label" default="Individual" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: individualRoleInstance, field: 'individual', 'errors')}">
                                    ${individualRoleInstance?.individual}
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="role"><g:message code="individualRole.role.label" default="Role" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: individualRoleInstance, field: 'role', 'errors')}">
                                    ${individualRoleInstance?.role}
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="centre"><g:message code="individualRole.centre.label" default="Centre" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: individualRoleInstance, field: 'centre', 'errors')}">
                                    ${individualRoleInstance?.centre?.toString()}
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="department"><g:message code="individualRole.department.label" default="Department" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: individualRoleInstance, field: 'department', 'errors')}">
                                    ${individualRoleInstance?.department?.toString()}
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="status"><g:message code="individualRole.status.label" default="Status" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: individualRoleInstance, field: 'status', 'errors')}">
                                    <g:select name="status" from="${['INVALID','CEASED','DELETED']}"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="remarks"><g:message code="individualRole.remarks.label" default="Remarks" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: individualRoleInstance, field: 'remarks', 'errors')}">
                                    <g:textArea name="remarks" value="${individualRoleInstance?.remarks}"  rows="5" cols="40"/>
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}"  onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/></span>
                    <!--<span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>-->
                </div>
            </g:form>
        </div>
    </body>
</html>
