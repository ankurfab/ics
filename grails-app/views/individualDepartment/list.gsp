
<%@ page import="ics.IndividualDepartment" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="individualDepartment.list" default="IndividualDepartment List" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="individualDepartment.new" default="New IndividualDepartment" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="individualDepartment.list" default="IndividualDepartment List" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                   	    <g:sortableColumn property="id" title="Id" titleKey="individualDepartment.id" />
                        
                   	    <th><g:message code="individualDepartment.individual" default="Individual" /></th>
                   	    
                   	    <th><g:message code="individualDepartment.department" default="Department" /></th>
                   	    
                   	    <g:sortableColumn property="status" title="Status" titleKey="individualDepartment.status" />
                        
                   	    <g:sortableColumn property="salary" title="Salary" titleKey="individualDepartment.salary" />
                        
                   	    <g:sortableColumn property="comments" title="Comments" titleKey="individualDepartment.comments" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${individualDepartmentInstanceList}" status="i" var="individualDepartmentInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${individualDepartmentInstance.id}">${fieldValue(bean: individualDepartmentInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: individualDepartmentInstance, field: "individual")}</td>
                        
                            <td>${fieldValue(bean: individualDepartmentInstance, field: "department")}</td>
                        
                            <td>${fieldValue(bean: individualDepartmentInstance, field: "status")}</td>
                        
                            <td>${fieldValue(bean: individualDepartmentInstance, field: "salary")}</td>
                        
                            <td>${fieldValue(bean: individualDepartmentInstance, field: "comments")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${individualDepartmentInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
