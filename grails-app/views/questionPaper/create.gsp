
<%@ page import="ics.QuestionPaper" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="questionPaper.create" default="Create QuestionPaper" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="questionPaper.list" default="QuestionPaper List" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="questionPaper.create" default="Create QuestionPaper" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:hasErrors bean="${questionPaperInstance}">
            <div class="errors">
                <g:renderErrors bean="${questionPaperInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="name"><g:message code="questionPaper.name" default="Name" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: questionPaperInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" value="${fieldValue(bean: questionPaperInstance, field: 'name')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="description"><g:message code="questionPaper.description" default="Description" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: questionPaperInstance, field: 'description', 'errors')}">
                                    <g:textField name="description" value="${fieldValue(bean: questionPaperInstance, field: 'description')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="status"><g:message code="questionPaper.status" default="Status" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: questionPaperInstance, field: 'status', 'errors')}">
                                    <g:select name="status" from="${questionPaperInstance.constraints.status.inList}" value="${questionPaperInstance.status}" valueMessagePrefix="questionPaper.status"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="randomize"><g:message code="questionPaper.randomize" default="Randomize" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: questionPaperInstance, field: 'randomize', 'errors')}">
                                    <g:checkBox name="randomize" value="${questionPaperInstance?.randomize}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="totalMarks"><g:message code="questionPaper.totalMarks" default="Total Marks" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: questionPaperInstance, field: 'totalMarks', 'errors')}">
                                    <g:textField name="totalMarks" value="${fieldValue(bean: questionPaperInstance, field: 'totalMarks')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="timeLimit"><g:message code="questionPaper.timeLimit" default="Time Limit" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: questionPaperInstance, field: 'timeLimit', 'errors')}">
                                    <g:textField name="timeLimit" value="${fieldValue(bean: questionPaperInstance, field: 'timeLimit')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="course"><g:message code="questionPaper.course" default="Course" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: questionPaperInstance, field: 'course', 'errors')}">
                                    <g:select name="course.id" from="${ics.Course.list()}" optionKey="id" value="${questionPaperInstance?.course?.id}" noSelection="['null': '']" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="department"><g:message code="questionPaper.department" default="Department" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: questionPaperInstance, field: 'department', 'errors')}">
                                    <g:select name="department.id" from="${ics.Department.list()}" optionKey="id" value="${questionPaperInstance?.department?.id}" noSelection="['null': '']" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="assessment"><g:message code="questionPaper.assessment" default="Assessment" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: questionPaperInstance, field: 'assessment', 'errors')}">
                                    <g:select name="assessment.id" from="${ics.Assessment.list()}" optionKey="id" value="${questionPaperInstance?.assessment?.id}"  />

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
