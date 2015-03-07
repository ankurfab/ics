
<%@ page import="ics.Assessment" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="assessment.create" default="Create Assessment" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="assessment.list" default="Assessment List" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="assessment.create" default="Create Assessment" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:hasErrors bean="${assessmentInstance}">
            <div class="errors">
                <g:renderErrors bean="${assessmentInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="name"><g:message code="assessment.name" default="Name" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: assessmentInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" value="${fieldValue(bean: assessmentInstance, field: 'name')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="status"><g:message code="assessment.status" default="Status" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: assessmentInstance, field: 'status', 'errors')}">
                                    <g:select name="status" from="${assessmentInstance.constraints.status.inList}" value="${assessmentInstance.status}" valueMessagePrefix="assessment.status"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="description"><g:message code="assessment.description" default="Description" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: assessmentInstance, field: 'description', 'errors')}">
                                    <g:textField name="description" value="${fieldValue(bean: assessmentInstance, field: 'description')}" />

                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="fees"><g:message code="assessment.fees" default="Fees" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: assessmentInstance, field: 'fees', 'errors')}">
                                    <g:textField name="fees" value="${fieldValue(bean: assessmentInstance, field: 'fees')}" />

                                </td>
                            </tr>
                        
                        
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="course"><g:message code="assessment.course" default="Course" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: assessmentInstance, field: 'course', 'errors')}">
                                    <g:select name="course.id" from="${ics.Course.list()}" optionKey="id" value="${assessmentInstance?.course?.id}" noSelection="['null': '']" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="department"><g:message code="assessment.department" default="Department" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: assessmentInstance, field: 'department', 'errors')}">
                                    <g:select name="department.id" from="${ics.Department.list([sort:'name'])}" optionKey="id" value="${assessmentInstance?.department?.id}" noSelection="['null': '']" />

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
