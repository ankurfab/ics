
<%@ page import="ics.IndividualAssessment" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="individualAssessment.show" default="Show IndividualAssessment" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="individualAssessment.list" default="IndividualAssessment List" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="individualAssessment.new" default="New IndividualAssessment" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="individualAssessment.show" default="Show IndividualAssessment" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:form>
                <g:hiddenField name="id" value="${individualAssessmentInstance?.id}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="individualAssessment.id" default="Id" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: individualAssessmentInstance, field: "id")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="individualAssessment.assessmentCode" default="Assessment Code" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: individualAssessmentInstance, field: "assessmentCode")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="individualAssessment.individual" default="Individual" />:</td>
                                
                                <td valign="top" class="value"><g:link controller="individual" action="show" id="${individualAssessmentInstance?.individual?.id}">${individualAssessmentInstance?.individual?.encodeAsHTML()}</g:link></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="individualAssessment.assessment" default="Assessment" />:</td>
                                
                                <td valign="top" class="value"><g:link controller="assessment" action="show" id="${individualAssessmentInstance?.assessment?.id}">${individualAssessmentInstance?.assessment?.encodeAsHTML()}</g:link></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="individualAssessment.questionPaper" default="Question Paper" />:</td>
                                
                                <td valign="top" class="value"><g:link controller="questionPaper" action="show" id="${individualAssessmentInstance?.questionPaper?.id}">${individualAssessmentInstance?.questionPaper?.encodeAsHTML()}</g:link></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="individualAssessment.assessmentDate" default="Assessment Date" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${individualAssessmentInstance?.assessmentDate}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="individualAssessment.status" default="Status" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: individualAssessmentInstance, field: "status")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="individualAssessment.comments" default="Comments" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: individualAssessmentInstance, field: "comments")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="individualAssessment.score" default="Score" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: individualAssessmentInstance, field: "score")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="individualAssessment.timeTaken" default="Time Taken" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: individualAssessmentInstance, field: "timeTaken")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="individualAssessment.certificateIssued" default="Certificate Issued" />:</td>
                                
                                <td valign="top" class="value"><g:formatBoolean boolean="${individualAssessmentInstance?.certificateIssued}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="individualAssessment.answers" default="Answers" />:</td>
                                
                                <td  valign="top" style="text-align: left;" class="value">
                                    <ul>
                                    <g:each in="${individualAssessmentInstance?.answers}" var="individualAssessmentQAInstance">
                                        <li><g:link controller="individualAssessmentQA" action="show" id="${individualAssessmentQAInstance.id}">${individualAssessmentQAInstance.encodeAsHTML()}</g:link></li>
                                    </g:each>
                                    </ul>
                                </td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="individualAssessment.creator" default="Creator" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: individualAssessmentInstance, field: "creator")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="individualAssessment.dateCreated" default="Date Created" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${individualAssessmentInstance?.dateCreated}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="individualAssessment.lastUpdated" default="Last Updated" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${individualAssessmentInstance?.lastUpdated}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="individualAssessment.updator" default="Updator" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: individualAssessmentInstance, field: "updator")}</td>
                                
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
