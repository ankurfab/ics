
<%@ page import="ics.Assessment" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="assessment.show" default="Show Assessment" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="assessment.list" default="Assessment List" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="assessment.new" default="New Assessment" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="generateQP" id="${assessmentInstance?.id}">GenerateQuestionPaper</g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="assessment.show" default="Show Assessment" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:form>
                <g:hiddenField name="id" value="${assessmentInstance?.id}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="assessment.id" default="Id" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: assessmentInstance, field: "id")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="assessment.name" default="Name" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: assessmentInstance, field: "name")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="assessment.status" default="Status" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: assessmentInstance, field: "status")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="assessment.description" default="Description" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: assessmentInstance, field: "description")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="assessment.fees" default="Fees" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: assessmentInstance, field: "fees")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="assessment.incharge" default="Incharge" />:</td>
                                
                                <td valign="top" class="value"><g:link controller="individual" action="show" id="${assessmentInstance?.incharge?.id}">${assessmentInstance?.incharge?.encodeAsHTML()}</g:link></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="assessment.course" default="Course" />:</td>
                                
                                <td valign="top" class="value"><g:link controller="course" action="show" id="${assessmentInstance?.course?.id}">${assessmentInstance?.course?.encodeAsHTML()}</g:link></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="assessment.department" default="Department" />:</td>
                                
                                <td valign="top" class="value"><g:link controller="department" action="show" id="${assessmentInstance?.department?.id}">${assessmentInstance?.department?.encodeAsHTML()}</g:link></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="assessment.questionPapers" default="Question Papers" />:</td>
                                
                                <td  valign="top" style="text-align: left;" class="value">
                                    <ul>
                                    <g:each in="${assessmentInstance?.questionPapers}" var="questionPaperInstance">
                                        <li><g:link controller="questionPaper" action="show" id="${questionPaperInstance.id}">${questionPaperInstance.encodeAsHTML()}</g:link></li>
                                    </g:each>
                                    </ul>
                                </td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="assessment.creator" default="Creator" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: assessmentInstance, field: "creator")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="assessment.dateCreated" default="Date Created" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${assessmentInstance?.dateCreated}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="assessment.lastUpdated" default="Last Updated" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${assessmentInstance?.lastUpdated}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="assessment.updator" default="Updator" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: assessmentInstance, field: "updator")}</td>
                                
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
