
<%@ page import="ics.Question" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="question.list" default="Question List" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="question.new" default="New Question" /></g:link></span>
            <span class="menuButton"><g:link class="list" controller="Assessment" action="exportQB">Export</g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="question.list" default="Question List" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                   	    <g:sortableColumn property="id" title="Id" titleKey="question.id" />
                        
                   	    <g:sortableColumn property="questionText" title="Question Text" titleKey="question.questionText" />
                        
                   	    <g:sortableColumn property="choice1" title="Choice1" titleKey="question.choice1" />
                        
                   	    <g:sortableColumn property="choice2" title="Choice2" titleKey="question.choice2" />
                        
                   	    <g:sortableColumn property="choice3" title="Choice3" titleKey="question.choice3" />
                        
                   	    <g:sortableColumn property="choice4" title="Choice4" titleKey="question.choice4" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${questionInstanceList}" status="i" var="questionInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${questionInstance.id}">${fieldValue(bean: questionInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: questionInstance, field: "questionText")}</td>
                        
                            <td>${fieldValue(bean: questionInstance, field: "choice1")}</td>
                        
                            <td>${fieldValue(bean: questionInstance, field: "choice2")}</td>
                        
                            <td>${fieldValue(bean: questionInstance, field: "choice3")}</td>
                        
                            <td>${fieldValue(bean: questionInstance, field: "choice4")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${questionInstanceTotal}" />
            </div>

	<div>
	Upload questions in bulk: <br />
	    <g:uploadForm controller="Assessment" action="importQB">
		<input type="file" name="myFile" />
		<input type="submit" value="Upload"/>
	    </g:uploadForm>
	</div>            

        </div>
    </body>
</html>
