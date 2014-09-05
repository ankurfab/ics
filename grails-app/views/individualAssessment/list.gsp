
<%@ page import="ics.IndividualAssessment" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="individualAssessment.list" default="IndividualAssessment List" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="individualAssessment.new" default="New IndividualAssessment" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="individualAssessment.list" default="IndividualAssessment List" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                   	    <g:sortableColumn property="id" title="Id" titleKey="individualAssessment.id" />
                        
                   	    <g:sortableColumn property="assessmentCode" title="Assessment Code" titleKey="individualAssessment.assessmentCode" />
                        
                   	    <th><g:message code="individualAssessment.individual" default="Individual" /></th>
                   	    
                   	    <th><g:message code="individualAssessment.assessment" default="Assessment" /></th>
                   	    
                   	    <th><g:message code="individualAssessment.questionPaper" default="Question Paper" /></th>
                   	    
                   	    <g:sortableColumn property="assessmentDate" title="Assessment Date" titleKey="individualAssessment.assessmentDate" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${individualAssessmentInstanceList}" status="i" var="individualAssessmentInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${individualAssessmentInstance.id}">${fieldValue(bean: individualAssessmentInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: individualAssessmentInstance, field: "assessmentCode")}</td>
                        
                            <td>${fieldValue(bean: individualAssessmentInstance, field: "individual")}</td>
                        
                            <td>${fieldValue(bean: individualAssessmentInstance, field: "assessment")}</td>
                        
                            <td>${fieldValue(bean: individualAssessmentInstance, field: "questionPaper")}</td>
                        
                            <td><g:formatDate date="${individualAssessmentInstance.assessmentDate}" /></td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${individualAssessmentInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
