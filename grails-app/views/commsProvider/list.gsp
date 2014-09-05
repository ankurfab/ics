
<%@ page import="ics.CommsProvider" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="commsProvider.list" default="CommsProvider List" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="commsProvider.new" default="New CommsProvider" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="commsProvider.list" default="CommsProvider List" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                   	    <g:sortableColumn property="id" title="Id" titleKey="commsProvider.id" />
                        
                   	    <g:sortableColumn property="type" title="Type" titleKey="commsProvider.type" />
                        
                   	    <g:sortableColumn property="uri" title="Uri" titleKey="commsProvider.uri" />
                        
                   	    <g:sortableColumn property="user" title="User" titleKey="commsProvider.user" />
                        
                   	    <g:sortableColumn property="pwd" title="Pwd" titleKey="commsProvider.pwd" />
                        
                   	    <g:sortableColumn property="apikey" title="Apikey" titleKey="commsProvider.apikey" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${commsProviderInstanceList}" status="i" var="commsProviderInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${commsProviderInstance.id}">${fieldValue(bean: commsProviderInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: commsProviderInstance, field: "type")}</td>
                        
                            <td>${fieldValue(bean: commsProviderInstance, field: "uri")}</td>
                        
                            <td>${fieldValue(bean: commsProviderInstance, field: "user")}</td>
                        
                            <td>${fieldValue(bean: commsProviderInstance, field: "pwd")}</td>
                        
                            <td>${fieldValue(bean: commsProviderInstance, field: "apikey")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${commsProviderInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
