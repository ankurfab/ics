
<%@ page import="ics.IndividualAssessmentQA" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="individualAssessmentQA.create" default="Create IndividualAssessmentQA" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="individualAssessmentQA.list" default="IndividualAssessmentQA List" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="individualAssessmentQA.create" default="Create IndividualAssessmentQA" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:hasErrors bean="${individualAssessmentQAInstance}">
            <div class="errors">
                <g:renderErrors bean="${individualAssessmentQAInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="individualAssessment"><g:message code="individualAssessmentQA.individualAssessment" default="Individual Assessment" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: individualAssessmentQAInstance, field: 'individualAssessment', 'errors')}">
                                    <g:select name="individualAssessment.id" from="${ics.IndividualAssessment.list()}" optionKey="id" value="${individualAssessmentQAInstance?.individualAssessment?.id}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="question"><g:message code="individualAssessmentQA.question" default="Question" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: individualAssessmentQAInstance, field: 'question', 'errors')}">
                                    <g:select name="question.id" from="${ics.Question.list()}" optionKey="id" value="${individualAssessmentQAInstance?.question?.id}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="selectedChoice1"><g:message code="individualAssessmentQA.selectedChoice1" default="Selected Choice1" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: individualAssessmentQAInstance, field: 'selectedChoice1', 'errors')}">
                                    <g:checkBox name="selectedChoice1" value="${individualAssessmentQAInstance?.selectedChoice1}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="selectedChoice2"><g:message code="individualAssessmentQA.selectedChoice2" default="Selected Choice2" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: individualAssessmentQAInstance, field: 'selectedChoice2', 'errors')}">
                                    <g:checkBox name="selectedChoice2" value="${individualAssessmentQAInstance?.selectedChoice2}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="selectedChoice3"><g:message code="individualAssessmentQA.selectedChoice3" default="Selected Choice3" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: individualAssessmentQAInstance, field: 'selectedChoice3', 'errors')}">
                                    <g:checkBox name="selectedChoice3" value="${individualAssessmentQAInstance?.selectedChoice3}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="selectedChoice4"><g:message code="individualAssessmentQA.selectedChoice4" default="Selected Choice4" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: individualAssessmentQAInstance, field: 'selectedChoice4', 'errors')}">
                                    <g:checkBox name="selectedChoice4" value="${individualAssessmentQAInstance?.selectedChoice4}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="correctAnswer"><g:message code="individualAssessmentQA.correctAnswer" default="Correct Answer" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: individualAssessmentQAInstance, field: 'correctAnswer', 'errors')}">
                                    <g:checkBox name="correctAnswer" value="${individualAssessmentQAInstance?.correctAnswer}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="score"><g:message code="individualAssessmentQA.score" default="Score" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: individualAssessmentQAInstance, field: 'score', 'errors')}">
                                    <g:textField name="score" value="${fieldValue(bean: individualAssessmentQAInstance, field: 'score')}" />

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
