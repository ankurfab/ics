
<%@ page import="ics.Education" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="education.list" default="Education List" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="education.new" default="New Education" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="education.list" default="Education List" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                   	    <g:sortableColumn property="id" title="Id" titleKey="education.id" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${educationInstanceList}" status="i" var="educationInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${educationInstance.id}">${fieldValue(bean: educationInstance, field: "id")}</g:link></td>
                        <td>${fieldValue(bean: educationInstance, field: "name")}</td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${educationInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
