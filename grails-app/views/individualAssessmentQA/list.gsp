
<%@ page import="ics.IndividualAssessmentQA" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="individualAssessmentQA.list" default="IndividualAssessmentQA List" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="individualAssessmentQA.new" default="New IndividualAssessmentQA" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="individualAssessmentQA.list" default="IndividualAssessmentQA List" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                   	    <g:sortableColumn property="id" title="Id" titleKey="individualAssessmentQA.id" />
                        
                   	    <th><g:message code="individualAssessmentQA.individualAssessment" default="Individual Assessment" /></th>
                   	    
                   	    <th><g:message code="individualAssessmentQA.question" default="Question" /></th>
                   	    
                   	    <g:sortableColumn property="selectedChoice1" title="Selected Choice1" titleKey="individualAssessmentQA.selectedChoice1" />
                        
                   	    <g:sortableColumn property="selectedChoice2" title="Selected Choice2" titleKey="individualAssessmentQA.selectedChoice2" />
                        
                   	    <g:sortableColumn property="selectedChoice3" title="Selected Choice3" titleKey="individualAssessmentQA.selectedChoice3" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${individualAssessmentQAInstanceList}" status="i" var="individualAssessmentQAInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${individualAssessmentQAInstance.id}">${fieldValue(bean: individualAssessmentQAInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: individualAssessmentQAInstance, field: "individualAssessment")}</td>
                        
                            <td>${fieldValue(bean: individualAssessmentQAInstance, field: "question")}</td>
                        
                            <td><g:formatBoolean boolean="${individualAssessmentQAInstance.selectedChoice1}" /></td>
                        
                            <td><g:formatBoolean boolean="${individualAssessmentQAInstance.selectedChoice2}" /></td>
                        
                            <td><g:formatBoolean boolean="${individualAssessmentQAInstance.selectedChoice3}" /></td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${individualAssessmentQAInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
