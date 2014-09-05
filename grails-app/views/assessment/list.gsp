
<%@ page import="ics.Assessment" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="assessment.list" default="Assessment List" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="assessment.new" default="New Assessment" /></g:link></span>
            <span class="menuButton"><g:link class="list" controller="question" action="list"><g:message code="question.list" default="Question List" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="assessment.list" default="Assessment List" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                   	    <g:sortableColumn property="id" title="Id" titleKey="assessment.id" />
                        
                   	    <g:sortableColumn property="name" title="Name" titleKey="assessment.name" />
                        
                   	    <g:sortableColumn property="status" title="Status" titleKey="assessment.status" />
                        
                   	    <g:sortableColumn property="description" title="Description" titleKey="assessment.description" />
                        
                   	    <th><g:message code="assessment.incharge" default="Incharge" /></th>
                   	    
                   	    <th><g:message code="assessment.course" default="Course" /></th>
                   	    
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${assessmentInstanceList}" status="i" var="assessmentInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${assessmentInstance.id}">${fieldValue(bean: assessmentInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: assessmentInstance, field: "name")}</td>
                        
                            <td>${fieldValue(bean: assessmentInstance, field: "status")}</td>
                        
                            <td>${fieldValue(bean: assessmentInstance, field: "description")}</td>
                        
                            <td>${fieldValue(bean: assessmentInstance, field: "incharge")}</td>
                        
                            <td>${fieldValue(bean: assessmentInstance, field: "course")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${assessmentInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
