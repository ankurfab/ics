
<%@ page import="ics.IndividualAssessment" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="individualAssessment.edit" default="Edit IndividualAssessment" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="individualAssessment.list" default="IndividualAssessment List" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="individualAssessment.new" default="New IndividualAssessment" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="individualAssessment.edit" default="Edit IndividualAssessment" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:hasErrors bean="${individualAssessmentInstance}">
            <div class="errors">
                <g:renderErrors bean="${individualAssessmentInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${individualAssessmentInstance?.id}" />
                <g:hiddenField name="version" value="${individualAssessmentInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="assessmentCode"><g:message code="individualAssessment.assessmentCode" default="Assessment Code" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: individualAssessmentInstance, field: 'assessmentCode', 'errors')}">
                                    <g:textField name="assessmentCode" value="${fieldValue(bean: individualAssessmentInstance, field: 'assessmentCode')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="individual"><g:message code="individualAssessment.individual" default="Individual" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: individualAssessmentInstance, field: 'individual', 'errors')}">
                                    <g:select name="individual.id" from="${ics.Individual.list()}" optionKey="id" value="${individualAssessmentInstance?.individual?.id}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="assessment"><g:message code="individualAssessment.assessment" default="Assessment" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: individualAssessmentInstance, field: 'assessment', 'errors')}">
                                    <g:select name="assessment.id" from="${ics.Assessment.list()}" optionKey="id" value="${individualAssessmentInstance?.assessment?.id}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="questionPaper"><g:message code="individualAssessment.questionPaper" default="Question Paper" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: individualAssessmentInstance, field: 'questionPaper', 'errors')}">
                                    <g:select name="questionPaper.id" from="${ics.QuestionPaper.list()}" optionKey="id" value="${individualAssessmentInstance?.questionPaper?.id}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="assessmentDate"><g:message code="individualAssessment.assessmentDate" default="Assessment Date" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: individualAssessmentInstance, field: 'assessmentDate', 'errors')}">
                                    <g:datePicker name="assessmentDate" value="${individualAssessmentInstance?.assessmentDate}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="status"><g:message code="individualAssessment.status" default="Status" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: individualAssessmentInstance, field: 'status', 'errors')}">
                                    <g:select name="status" from="${individualAssessmentInstance.constraints.status.inList}" value="${individualAssessmentInstance.status}" valueMessagePrefix="individualAssessment.status"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="comments"><g:message code="individualAssessment.comments" default="Comments" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: individualAssessmentInstance, field: 'comments', 'errors')}">
                                    <g:textField name="comments" value="${fieldValue(bean: individualAssessmentInstance, field: 'comments')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="score"><g:message code="individualAssessment.score" default="Score" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: individualAssessmentInstance, field: 'score', 'errors')}">
                                    <g:textField name="score" value="${fieldValue(bean: individualAssessmentInstance, field: 'score')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="timeTaken"><g:message code="individualAssessment.timeTaken" default="Time Taken" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: individualAssessmentInstance, field: 'timeTaken', 'errors')}">
                                    <g:textField name="timeTaken" value="${fieldValue(bean: individualAssessmentInstance, field: 'timeTaken')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="certificateIssued"><g:message code="individualAssessment.certificateIssued" default="Certificate Issued" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: individualAssessmentInstance, field: 'certificateIssued', 'errors')}">
                                    <g:checkBox name="certificateIssued" value="${individualAssessmentInstance?.certificateIssued}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="answers"><g:message code="individualAssessment.answers" default="Answers" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: individualAssessmentInstance, field: 'answers', 'errors')}">
                                    
<ul>
<g:each in="${individualAssessmentInstance?.answers}" var="individualAssessmentQAInstance">
    <li><g:link controller="individualAssessmentQA" action="show" id="${individualAssessmentQAInstance.id}">${individualAssessmentQAInstance?.encodeAsHTML()}</g:link></li>
</g:each>
</ul>
<g:link controller="individualAssessmentQA" params="['individualAssessment.id': individualAssessmentInstance?.id]" action="create"><g:message code="individualAssessmentQA.new" default="New IndividualAssessmentQA" /></g:link>


                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="creator"><g:message code="individualAssessment.creator" default="Creator" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: individualAssessmentInstance, field: 'creator', 'errors')}">
                                    <g:textField name="creator" value="${fieldValue(bean: individualAssessmentInstance, field: 'creator')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="dateCreated"><g:message code="individualAssessment.dateCreated" default="Date Created" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: individualAssessmentInstance, field: 'dateCreated', 'errors')}">
                                    <g:datePicker name="dateCreated" value="${individualAssessmentInstance?.dateCreated}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="lastUpdated"><g:message code="individualAssessment.lastUpdated" default="Last Updated" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: individualAssessmentInstance, field: 'lastUpdated', 'errors')}">
                                    <g:datePicker name="lastUpdated" value="${individualAssessmentInstance?.lastUpdated}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="updator"><g:message code="individualAssessment.updator" default="Updator" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: individualAssessmentInstance, field: 'updator', 'errors')}">
                                    <g:textField name="updator" value="${fieldValue(bean: individualAssessmentInstance, field: 'updator')}" />

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
