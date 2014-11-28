
<%@ page import="ics.Village" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="village.list" default="Village List" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="village.new" default="New Village" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="village.list" default="Village List" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                   	    <g:sortableColumn property="id" title="Id" titleKey="village.id" />
                        
                   	    <g:sortableColumn property="name" title="Name" titleKey="village.name" />
                        
                   	    <th><g:message code="village.taluka" default="Taluka" /></th>
                   	    
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${villageInstanceList}" status="i" var="villageInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${villageInstance.id}">${fieldValue(bean: villageInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: villageInstance, field: "name")}</td>
                        
                            <td>${fieldValue(bean: villageInstance, field: "taluka")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${villageInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
