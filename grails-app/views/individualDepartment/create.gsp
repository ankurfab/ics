
<%@ page import="ics.IndividualDepartment" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="individualDepartment.create" default="Create IndividualDepartment" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="individualDepartment.list" default="IndividualDepartment List" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="individualDepartment.create" default="Create IndividualDepartment" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:hasErrors bean="${individualDepartmentInstance}">
            <div class="errors">
                <g:renderErrors bean="${individualDepartmentInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="individual"><g:message code="individualDepartment.individual" default="Individual" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: individualDepartmentInstance, field: 'individual', 'errors')}">
                                    <g:select name="individual.id" from="${ics.Individual.list()}" optionKey="id" value="${individualDepartmentInstance?.individual?.id}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="department"><g:message code="individualDepartment.department" default="Department" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: individualDepartmentInstance, field: 'department', 'errors')}">
                                    <g:select name="department.id" from="${ics.Department.list()}" optionKey="id" value="${individualDepartmentInstance?.department?.id}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="status"><g:message code="individualDepartment.status" default="Status" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: individualDepartmentInstance, field: 'status', 'errors')}">
                                    <g:textField name="status" value="${fieldValue(bean: individualDepartmentInstance, field: 'status')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="salary"><g:message code="individualDepartment.salary" default="Salary" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: individualDepartmentInstance, field: 'salary', 'errors')}">
                                    <g:textField name="salary" value="${fieldValue(bean: individualDepartmentInstance, field: 'salary')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="comments"><g:message code="individualDepartment.comments" default="Comments" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: individualDepartmentInstance, field: 'comments', 'errors')}">
                                    <g:textField name="comments" value="${fieldValue(bean: individualDepartmentInstance, field: 'comments')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="since"><g:message code="individualDepartment.since" default="Since" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: individualDepartmentInstance, field: 'since', 'errors')}">
                                    <g:datePicker name="since" value="${individualDepartmentInstance?.since}" noSelection="['': '']" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="till"><g:message code="individualDepartment.till" default="Till" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: individualDepartmentInstance, field: 'till', 'errors')}">
                                    <g:datePicker name="till" value="${individualDepartmentInstance?.till}" noSelection="['': '']" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="creator"><g:message code="individualDepartment.creator" default="Creator" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: individualDepartmentInstance, field: 'creator', 'errors')}">
                                    <g:textField name="creator" value="${fieldValue(bean: individualDepartmentInstance, field: 'creator')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="dateCreated"><g:message code="individualDepartment.dateCreated" default="Date Created" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: individualDepartmentInstance, field: 'dateCreated', 'errors')}">
                                    <g:datePicker name="dateCreated" value="${individualDepartmentInstance?.dateCreated}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="lastUpdated"><g:message code="individualDepartment.lastUpdated" default="Last Updated" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: individualDepartmentInstance, field: 'lastUpdated', 'errors')}">
                                    <g:datePicker name="lastUpdated" value="${individualDepartmentInstance?.lastUpdated}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="updator"><g:message code="individualDepartment.updator" default="Updator" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: individualDepartmentInstance, field: 'updator', 'errors')}">
                                    <g:textField name="updator" value="${fieldValue(bean: individualDepartmentInstance, field: 'updator')}" />

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
