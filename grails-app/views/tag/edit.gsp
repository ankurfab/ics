
<%@ page import="ics.Tag" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="tag.edit" default="Edit Tag" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="tag.list" default="Tag List" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="tag.new" default="New Tag" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="tag.edit" default="Edit Tag" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:hasErrors bean="${tagInstance}">
            <div class="errors">
                <g:renderErrors bean="${tagInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${tagInstance?.id}" />
                <g:hiddenField name="version" value="${tagInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="name"><g:message code="tag.name" default="Name" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: tagInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" value="${fieldValue(bean: tagInstance, field: 'name')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="category"><g:message code="tag.category" default="Category" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: tagInstance, field: 'category', 'errors')}">
                                    <g:textField name="category" value="${fieldValue(bean: tagInstance, field: 'category')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="department"><g:message code="tag.department" default="Department" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: tagInstance, field: 'department', 'errors')}">
                                    <g:select name="department.id" from="${ics.Department.list()}" optionKey="id" value="${tagInstance?.department?.id}" noSelection="['null': '']" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="creator"><g:message code="tag.creator" default="Creator" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: tagInstance, field: 'creator', 'errors')}">
                                    <g:textField name="creator" value="${fieldValue(bean: tagInstance, field: 'creator')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="dateCreated"><g:message code="tag.dateCreated" default="Date Created" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: tagInstance, field: 'dateCreated', 'errors')}">
                                    <g:datePicker name="dateCreated" value="${tagInstance?.dateCreated}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="lastUpdated"><g:message code="tag.lastUpdated" default="Last Updated" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: tagInstance, field: 'lastUpdated', 'errors')}">
                                    <g:datePicker name="lastUpdated" value="${tagInstance?.lastUpdated}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="updator"><g:message code="tag.updator" default="Updator" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: tagInstance, field: 'updator', 'errors')}">
                                    <g:textField name="updator" value="${fieldValue(bean: tagInstance, field: 'updator')}" />

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
