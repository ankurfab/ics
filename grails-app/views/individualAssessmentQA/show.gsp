
<%@ page import="ics.IndividualAssessmentQA" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="individualAssessmentQA.show" default="Show IndividualAssessmentQA" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="individualAssessmentQA.list" default="IndividualAssessmentQA List" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="individualAssessmentQA.new" default="New IndividualAssessmentQA" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="individualAssessmentQA.show" default="Show IndividualAssessmentQA" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:form>
                <g:hiddenField name="id" value="${individualAssessmentQAInstance?.id}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="individualAssessmentQA.id" default="Id" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: individualAssessmentQAInstance, field: "id")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="individualAssessmentQA.individualAssessment" default="Individual Assessment" />:</td>
                                
                                <td valign="top" class="value"><g:link controller="individualAssessment" action="show" id="${individualAssessmentQAInstance?.individualAssessment?.id}">${individualAssessmentQAInstance?.individualAssessment?.encodeAsHTML()}</g:link></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="individualAssessmentQA.question" default="Question" />:</td>
                                
                                <td valign="top" class="value"><g:link controller="question" action="show" id="${individualAssessmentQAInstance?.question?.id}">${individualAssessmentQAInstance?.question?.encodeAsHTML()}</g:link></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="individualAssessmentQA.selectedChoice1" default="Selected Choice1" />:</td>
                                
                                <td valign="top" class="value"><g:formatBoolean boolean="${individualAssessmentQAInstance?.selectedChoice1}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="individualAssessmentQA.selectedChoice2" default="Selected Choice2" />:</td>
                                
                                <td valign="top" class="value"><g:formatBoolean boolean="${individualAssessmentQAInstance?.selectedChoice2}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="individualAssessmentQA.selectedChoice3" default="Selected Choice3" />:</td>
                                
                                <td valign="top" class="value"><g:formatBoolean boolean="${individualAssessmentQAInstance?.selectedChoice3}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="individualAssessmentQA.selectedChoice4" default="Selected Choice4" />:</td>
                                
                                <td valign="top" class="value"><g:formatBoolean boolean="${individualAssessmentQAInstance?.selectedChoice4}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="individualAssessmentQA.correctAnswer" default="Correct Answer" />:</td>
                                
                                <td valign="top" class="value"><g:formatBoolean boolean="${individualAssessmentQAInstance?.correctAnswer}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="individualAssessmentQA.score" default="Score" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: individualAssessmentQAInstance, field: "score")}</td>
                                
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
