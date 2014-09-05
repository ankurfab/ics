
<%@ page import="ics.Individual" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'individual.label', default: 'Individual')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" controller="relationship" action="create">New Relationship</g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${message(code: 'individual.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="legalName" title="Name" />
                            <!--<g:sortableColumn property="status" title="Status" />
                            <g:sortableColumn property="isDonor" title="Donor" />                            
                            <g:sortableColumn property="isWellWisher" title="WellWisher" />
                            <g:sortableColumn property="isLifeMember" title="LifeMember" />-->
                            <g:sortableColumn property="dob" title="DoB" />
                            <g:sortableColumn property="marriageAnniversary" title="DoM" />
                        
                            <th>Address</th>
                            <th>Email</th>
                            <th>Phone</th>

                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${individualInstanceList}" status="i" var="individualInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${individualInstance.id}">${fieldValue(bean: individualInstance, field: "id")}</g:link></td>
                        
                            <td>${individualInstance.toString()}</td>
                        
                            <!--<td>${fieldValue(bean: individualInstance, field: "status")}</td>
                        	<td><g:formatBoolean boolean="${individualInstance.isDonor}" /></td>
                            <td><g:formatBoolean boolean="${individualInstance.isWellWisher}" /></td>
                            <td><g:formatBoolean boolean="${individualInstance.isLifeMember}" /></td>-->
                            <td><g:formatDate format="dd-MM-yyyy" date="${individualInstance.dob}" /></td>
                            <td><g:formatDate format="dd-MM-yyyy" date="${individualInstance.marriageAnniversary}" /></td>
                            <td>${individualInstance.address?.toString()}</td>
                            <td>${individualInstance.emailContact?.toString()}</td>
                            <td>${individualInstance.voiceContact?.toString()}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${individualInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
