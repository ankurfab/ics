
<%@ page import="ics.Question" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="question.edit" default="Edit Question" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="question.list" default="Question List" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="question.new" default="New Question" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="question.edit" default="Edit Question" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:hasErrors bean="${questionInstance}">
            <div class="errors">
                <g:renderErrors bean="${questionInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${questionInstance?.id}" />
                <g:hiddenField name="version" value="${questionInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="questionText"><g:message code="question.questionText" default="Question Text" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: questionInstance, field: 'questionText', 'errors')}">
                                    <g:textArea name="questionText" rows="5" cols="40" value="${fieldValue(bean: questionInstance, field: 'questionText')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="choice1"><g:message code="question.choice1" default="Choice1" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: questionInstance, field: 'choice1', 'errors')}">
                                    <g:textArea name="choice1" rows="5" cols="40" value="${fieldValue(bean: questionInstance, field: 'choice1')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="choice2"><g:message code="question.choice2" default="Choice2" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: questionInstance, field: 'choice2', 'errors')}">
                                    <g:textArea name="choice2" rows="5" cols="40" value="${fieldValue(bean: questionInstance, field: 'choice2')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="choice3"><g:message code="question.choice3" default="Choice3" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: questionInstance, field: 'choice3', 'errors')}">
                                    <g:textArea name="choice3" rows="5" cols="40" value="${fieldValue(bean: questionInstance, field: 'choice3')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="choice4"><g:message code="question.choice4" default="Choice4" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: questionInstance, field: 'choice4', 'errors')}">
                                    <g:textArea name="choice4" rows="5" cols="40" value="${fieldValue(bean: questionInstance, field: 'choice4')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="isChoice1Correct"><g:message code="question.isChoice1Correct" default="Is Choice1 Correct" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: questionInstance, field: 'isChoice1Correct', 'errors')}">
                                    <g:checkBox name="isChoice1Correct" value="${questionInstance?.isChoice1Correct}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="isChoice2Correct"><g:message code="question.isChoice2Correct" default="Is Choice2 Correct" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: questionInstance, field: 'isChoice2Correct', 'errors')}">
                                    <g:checkBox name="isChoice2Correct" value="${questionInstance?.isChoice2Correct}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="isChoice3Correct"><g:message code="question.isChoice3Correct" default="Is Choice3 Correct" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: questionInstance, field: 'isChoice3Correct', 'errors')}">
                                    <g:checkBox name="isChoice3Correct" value="${questionInstance?.isChoice3Correct}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="isChoice4Correct"><g:message code="question.isChoice4Correct" default="Is Choice4 Correct" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: questionInstance, field: 'isChoice4Correct', 'errors')}">
                                    <g:checkBox name="isChoice4Correct" value="${questionInstance?.isChoice4Correct}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="marks"><g:message code="question.marks" default="Marks" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: questionInstance, field: 'marks', 'errors')}">
                                    <g:textField name="marks" value="${fieldValue(bean: questionInstance, field: 'marks')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="hint"><g:message code="question.hint" default="Hint" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: questionInstance, field: 'hint', 'errors')}">
                                    <g:textArea name="hint" rows="5" cols="40" value="${fieldValue(bean: questionInstance, field: 'hint')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="info"><g:message code="question.info" default="Info" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: questionInstance, field: 'info', 'errors')}">
                                    <g:textArea name="info" rows="5" cols="40" value="${fieldValue(bean: questionInstance, field: 'info')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="status"><g:message code="question.status" default="Status" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: questionInstance, field: 'status', 'errors')}">
                                    <g:select name="status" from="${questionInstance.constraints.status.inList}" value="${questionInstance.status}" valueMessagePrefix="question.status"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="type"><g:message code="question.type" default="Type" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: questionInstance, field: 'type', 'errors')}">
                                    <g:select name="type" from="${questionInstance.constraints.type.inList}" value="${questionInstance.type}" valueMessagePrefix="question.type"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="level"><g:message code="question.level" default="Level" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: questionInstance, field: 'level', 'errors')}">
                                    <g:select name="level" from="${questionInstance.constraints.level.inList}" value="${questionInstance.level}" valueMessagePrefix="question.level"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="language">Language:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: questionInstance, field: 'language', 'errors')}">
                                    <g:select name="language" from="${['ENGLISH','HINDI','MARATHI']}" value="${questionInstance.language?:'ENGLISH'}" />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="category"><g:message code="question.category" default="Category" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: questionInstance, field: 'category', 'errors')}">
                                    <g:textField name="category" value="${fieldValue(bean: questionInstance, field: 'category')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="course"><g:message code="question.course" default="Course" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: questionInstance, field: 'course', 'errors')}">
                                    <g:select name="course.id" from="${ics.Course.list()}" optionKey="id" value="${questionInstance?.course?.id}" noSelection="['null': '']" />

                                </td>
                            </tr>
                        
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="tags"><g:message code="question.tags" default="Tags" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: questionInstance, field: 'tags', 'errors')}">
                                    <g:select name="tags"
from="${ics.Tag.list()}"
size="5" multiple="yes" optionKey="id"
value="${questionInstance?.tags}" />


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
