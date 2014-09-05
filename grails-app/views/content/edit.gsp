
<%@ page import="ics.Content" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="content.edit" default="Edit Content" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="content.list" default="Content List" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="content.new" default="New Content" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="content.edit" default="Edit Content" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:hasErrors bean="${contentInstance}">
            <div class="errors">
                <g:renderErrors bean="${contentInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${contentInstance?.id}" />
                <g:hiddenField name="version" value="${contentInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="name"><g:message code="content.name" default="Name" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: contentInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" value="${fieldValue(bean: contentInstance, field: 'name')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="description"><g:message code="content.description" default="Description" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: contentInstance, field: 'description', 'errors')}">
                                    <g:textField name="description" value="${fieldValue(bean: contentInstance, field: 'description')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="htmlContent"><g:message code="content.htmlContent" default="Html Content" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: contentInstance, field: 'htmlContent', 'errors')}">
                                    <g:textArea name="htmlContent" value="${fieldValue(bean: contentInstance, field: 'htmlContent')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="category"><g:message code="content.category" default="Category" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: contentInstance, field: 'category', 'errors')}">
                                    <g:select name="category" from="${contentInstance.constraints.category.inList}" value="${contentInstance.category}" valueMessagePrefix="content.category"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="type"><g:message code="content.type" default="Type" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: contentInstance, field: 'type', 'errors')}">
                                    <g:textField name="type" value="${fieldValue(bean: contentInstance, field: 'type')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="language"><g:message code="content.language" default="Language" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: contentInstance, field: 'language', 'errors')}">
                                    <g:select name="language" from="${contentInstance.constraints.language.inList}" value="${contentInstance.language}" valueMessagePrefix="content.language"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="status"><g:message code="content.status" default="Status" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: contentInstance, field: 'status', 'errors')}">
                                    <g:select name="status" from="${contentInstance.constraints.status.inList}" value="${contentInstance.status}" valueMessagePrefix="content.status"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="department"><g:message code="content.department" default="Department" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: contentInstance, field: 'department', 'errors')}">
                                    <g:select name="department.id" from="${ics.Department.list()}" optionKey="id" value="${contentInstance?.department?.id}" noSelection="['null': '']" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="course"><g:message code="content.course" default="Course" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: contentInstance, field: 'course', 'errors')}">
                                    <g:select name="course.id" from="${ics.Course.list()}" optionKey="id" value="${contentInstance?.course?.id}" noSelection="['null': '']" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="assessment"><g:message code="content.assessment" default="Assessment" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: contentInstance, field: 'assessment', 'errors')}">
                                    <g:select name="assessment.id" from="${ics.Assessment.list()}" optionKey="id" value="${contentInstance?.assessment?.id}" noSelection="['null': '']" />

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
