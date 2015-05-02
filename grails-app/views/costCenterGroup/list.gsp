
<%@ page import="ics.CostCenterGroup" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="costCenterGroup.list" default="CostCenterGroup List" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="costCenterGroup.new" default="New CostCenterGroup" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="costCenterGroup.list" default="CostCenterGroup List" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                   	    <g:sortableColumn property="id" title="Id" titleKey="costCenterGroup.id" />
                        
                   	    <g:sortableColumn property="name" title="Name" titleKey="costCenterGroup.name" />
                        
                   	    <g:sortableColumn property="description" title="Description" titleKey="costCenterGroup.description" />
                        
                   	    <th><g:message code="costCenterGroup.owner" default="Owner" /></th>
                   	    
                   	    <th><g:message code="costCenterGroup.owner1" default="Owner1" /></th>
                   	    
                   	    <th><g:message code="costCenterGroup.owner2" default="Owner2" /></th>
                   	    
                   	    <g:sortableColumn property="dateCreated" title="Date Created" titleKey="costCenterGroup.dateCreated" />
                        
                   	    <g:sortableColumn property="creator" title="Creator" titleKey="costCenterGroup.creator" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${costCenterGroupInstanceList}" status="i" var="costCenterGroupInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${costCenterGroupInstance.id}">${fieldValue(bean: costCenterGroupInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: costCenterGroupInstance, field: "name")}</td>
                        
                            <td>${fieldValue(bean: costCenterGroupInstance, field: "description")}</td>
                        
                            <td>${fieldValue(bean: costCenterGroupInstance, field: "owner")}</td>
                        
                            <td>${fieldValue(bean: costCenterGroupInstance, field: "owner1")}</td>
                        
                            <td>${fieldValue(bean: costCenterGroupInstance, field: "owner2")}</td>
                        
                            <td><g:formatDate date="${costCenterGroupInstance.dateCreated}" /></td>
                        
                            <td>${fieldValue(bean: costCenterGroupInstance, field: "creator")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${costCenterGroupInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
