
<%@ page import="ics.Question" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="question.show" default="Show Question" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="question.list" default="Question List" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="question.new" default="New Question" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="question.show" default="Show Question" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:form>
                <g:hiddenField name="id" value="${questionInstance?.id}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="question.id" default="Id" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: questionInstance, field: "id")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="question.questionText" default="Question Text" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: questionInstance, field: "questionText")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="question.choice1" default="Choice1" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: questionInstance, field: "choice1")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="question.choice2" default="Choice2" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: questionInstance, field: "choice2")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="question.choice3" default="Choice3" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: questionInstance, field: "choice3")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="question.choice4" default="Choice4" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: questionInstance, field: "choice4")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="question.isChoice1Correct" default="Is Choice1 Correct" />:</td>
                                
                                <td valign="top" class="value"><g:formatBoolean boolean="${questionInstance?.isChoice1Correct}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="question.isChoice2Correct" default="Is Choice2 Correct" />:</td>
                                
                                <td valign="top" class="value"><g:formatBoolean boolean="${questionInstance?.isChoice2Correct}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="question.isChoice3Correct" default="Is Choice3 Correct" />:</td>
                                
                                <td valign="top" class="value"><g:formatBoolean boolean="${questionInstance?.isChoice3Correct}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="question.isChoice4Correct" default="Is Choice4 Correct" />:</td>
                                
                                <td valign="top" class="value"><g:formatBoolean boolean="${questionInstance?.isChoice4Correct}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="question.marks" default="Marks" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: questionInstance, field: "marks")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="question.hint" default="Hint" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: questionInstance, field: "hint")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="question.info" default="Info" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: questionInstance, field: "info")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="question.status" default="Status" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: questionInstance, field: "status")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="question.type" default="Type" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: questionInstance, field: "type")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="question.level" default="Level" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: questionInstance, field: "level")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="language">Language:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: questionInstance, field: 'language', 'errors')}">
                                    ${questionInstance.language?:'ENGLISH'}
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="question.category" default="Category" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: questionInstance, field: "category")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="question.course" default="Course" />:</td>
                                
                                <td valign="top" class="value"><g:link controller="course" action="show" id="${questionInstance?.course?.id}">${questionInstance?.course?.encodeAsHTML()}</g:link></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="question.creator" default="Creator" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: questionInstance, field: "creator")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="question.dateCreated" default="Date Created" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${questionInstance?.dateCreated}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="question.lastUpdated" default="Last Updated" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${questionInstance?.lastUpdated}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="question.tags" default="Tags" />:</td>
                                
                                <td  valign="top" style="text-align: left;" class="value">
                                    <ul>
                                    <g:each in="${questionInstance?.tags}" var="tagInstance">
                                        <li><g:link controller="tag" action="show" id="${tagInstance.id}">${tagInstance.encodeAsHTML()}</g:link></li>
                                    </g:each>
                                    </ul>
                                </td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="question.updator" default="Updator" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: questionInstance, field: "updator")}</td>
                                
                            </tr>
                            
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'edit', 'default': 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'delete', 'default': 'Delete')}" onclick="return confirm('${message(code: 'delete.confirm', 'default': 'Are you sure?')}');" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
