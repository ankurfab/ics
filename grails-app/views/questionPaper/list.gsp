
<%@ page import="ics.QuestionPaper" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="questionPaper.list" default="QuestionPaper List" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="questionPaper.new" default="New QuestionPaper" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="questionPaper.list" default="QuestionPaper List" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                   	    <g:sortableColumn property="id" title="Id" titleKey="questionPaper.id" />
                        
                   	    <g:sortableColumn property="name" title="Name" titleKey="questionPaper.name" />
                        
                   	    <g:sortableColumn property="description" title="Description" titleKey="questionPaper.description" />
                        
                   	    <g:sortableColumn property="status" title="Status" titleKey="questionPaper.status" />
                        
                   	    <g:sortableColumn property="randomize" title="Randomize" titleKey="questionPaper.randomize" />
                        
                   	    <g:sortableColumn property="totalMarks" title="Total Marks" titleKey="questionPaper.totalMarks" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${questionPaperInstanceList}" status="i" var="questionPaperInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${questionPaperInstance.id}">${fieldValue(bean: questionPaperInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: questionPaperInstance, field: "name")}</td>
                        
                            <td>${fieldValue(bean: questionPaperInstance, field: "description")}</td>
                        
                            <td>${fieldValue(bean: questionPaperInstance, field: "status")}</td>
                        
                            <td><g:formatBoolean boolean="${questionPaperInstance.randomize}" /></td>
                        
                            <td>${fieldValue(bean: questionPaperInstance, field: "totalMarks")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${questionPaperInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
