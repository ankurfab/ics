
<%@ page import="ics.DepartmentCP" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="departmentCP.list" default="DepartmentCP List" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="departmentCP.new" default="New DepartmentCP" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="departmentCP.list" default="DepartmentCP List" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                   	    <g:sortableColumn property="id" title="Id" titleKey="departmentCP.id" />
                        
                   	    <g:sortableColumn property="sender" title="Sender" titleKey="departmentCP.sender" />
                        
                   	    <th><g:message code="departmentCP.cp" default="Cp" /></th>
                   	    
                   	    <th><g:message code="departmentCP.department" default="Department" /></th>
                   	    
                   	    <g:sortableColumn property="count" title="Count" titleKey="departmentCP.count" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${departmentCPInstanceList}" status="i" var="departmentCPInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${departmentCPInstance.id}">${fieldValue(bean: departmentCPInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: departmentCPInstance, field: "sender")}</td>
                        
                            <td>${fieldValue(bean: departmentCPInstance, field: "cp")}</td>
                        
                            <td>${fieldValue(bean: departmentCPInstance, field: "department")}</td>
                        
                            <td>${fieldValue(bean: departmentCPInstance, field: "count")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${departmentCPInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
