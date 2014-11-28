
<%@ page import="ics.Sadhana" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="sadhana.list" default="Sadhana List" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="sadhana.new" default="New Sadhana" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="sadhana.list" default="Sadhana List" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                   	    <g:sortableColumn property="id" title="Id" titleKey="sadhana.id" />
                        
                   	    <th><g:message code="sadhana.devotee" default="Devotee" /></th>
                   	    
                   	    <g:sortableColumn property="day" title="Day" titleKey="sadhana.day" />
                        
                   	    <g:sortableColumn property="attendedMangalAratik" title="Attended Mangal Aratik" titleKey="sadhana.attendedMangalAratik" />
                        
                   	    <g:sortableColumn property="numRoundsBefore9" title="Num Rounds Before9" titleKey="sadhana.numRoundsBefore9" />
                        
                   	    <g:sortableColumn property="numRoundsBetween9And12" title="Num Rounds Between9 And12" titleKey="sadhana.numRoundsBetween9And12" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${sadhanaInstanceList}" status="i" var="sadhanaInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${sadhanaInstance.id}">${fieldValue(bean: sadhanaInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: sadhanaInstance, field: "devotee")}</td>
                        
                            <td><g:formatDate date="${sadhanaInstance.day}" /></td>
                        
                            <td><g:formatBoolean boolean="${sadhanaInstance.attendedMangalAratik}" /></td>
                        
                            <td>${fieldValue(bean: sadhanaInstance, field: "numRoundsBefore9")}</td>
                        
                            <td>${fieldValue(bean: sadhanaInstance, field: "numRoundsBetween9And12")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${sadhanaInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
