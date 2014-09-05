
<%@ page import="ics.Commitment" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="commitment.list" default="Commitment List" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="commitment.new" default="New Commitment" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="commitment.list" default="Commitment List" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                   	    <g:sortableColumn property="id" title="Id" titleKey="commitment.id" />
                        
                   	    <g:sortableColumn property="donatedAmount" title="Donated Amount" titleKey="commitment.donatedAmount" />
                        
                   	    <g:sortableColumn property="collectedAmount" title="Collected Amount" titleKey="commitment.collectedAmount" />
                        
                   	    <g:sortableColumn property="commitmentOn" title="Commitment On" titleKey="commitment.commitmentOn" />
                        
                   	    <g:sortableColumn property="commitmentTill" title="Commitment Till" titleKey="commitment.commitmentTill" />
                        
                   	    <th><g:message code="commitment.scheme" default="Scheme" /></th>
                   	    
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${commitmentInstanceList}" status="i" var="commitmentInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${commitmentInstance.id}">${fieldValue(bean: commitmentInstance, field: "id")}</g:link></td>
                        
                            <td><g:formatNumber number="${commitmentInstance.donatedAmount}" /></td>
                        
                            <td><g:formatNumber number="${commitmentInstance.collectedAmount}" /></td>
                        
                            <td><g:formatDate date="${commitmentInstance.commitmentOn}" /></td>
                        
                            <td><g:formatDate date="${commitmentInstance.commitmentTill}" /></td>
                        
                            <td>${fieldValue(bean: commitmentInstance, field: "scheme")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${commitmentInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
