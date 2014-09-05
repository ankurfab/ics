
<%@ page import="ics.IndividualRole" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'individualRole.label', default: 'IndividualRole')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" controller="helper" action="searchIndividualByRole">SearchByRole</g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
                <table>
                    <tbody>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individualRole.id.label" default="Id" /></td>
                            
                            <td valign="top" class="value"><g:formatNumber number="${individualRoleInstance?.id}" format="#" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individualRole.individual.label" default="Individual" /></td>
                            
                            <td valign="top" class="value"><g:link controller="individual" action="show" id="${individualRoleInstance?.individual?.id}">${individualRoleInstance?.individual?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individualRole.role.label" default="Role" /></td>
                            
                            <td valign="top" class="value"><g:link controller="role" action="show" id="${individualRoleInstance?.role?.id}">${individualRoleInstance?.role?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individualRole.centre.label" default="Centre" /></td>
                            
                            <td valign="top" class="value"><g:link controller="centre" action="show" id="${individualRoleInstance?.centre?.id}">${individualRoleInstance?.centre?.encodeAsHTML()}</g:link></td>
                            
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individualRole.department.label" default="Department" /></td>
                            
                            <td valign="top" class="value"><g:link controller="department" action="show" id="${individualRoleInstance?.department?.id}">${individualRoleInstance?.department?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individualRole.status.label" default="Status" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: individualRoleInstance, field: "status")}</td>
                            
                        </tr>
                        
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individualRole.remarks.label" default="Remarks" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: individualRoleInstance, field: "remarks")}</td>
                            
                        </tr>
                       
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individualRole.dateCreated.label" default="Date Created" /></td>
                            
                            <td valign="top" class="value"><g:formatDate format="dd-MM-yyyy hh:mm:ss a" date="${individualRoleInstance?.dateCreated}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individualRole.creator.label" default="Creator" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: individualRoleInstance, field: "creator")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individualRole.lastUpdated.label" default="Last Updated" /></td>
                            
                            <td valign="top" class="value"><g:formatDate format="dd-MM-yyyy hh:mm:ss a" date="${individualRoleInstance?.lastUpdated}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="individualRole.updator.label" default="Updator" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: individualRoleInstance, field: "updator")}</td>
                            
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${individualRoleInstance?.id}" />
                    <g:if test="${!individualRole?.status || individualRole?.status == 'VALID'}">
		         <span class="button"><g:actionSubmit class="edit" action="edit" value="Delete" /></span>
		    </g:if>
                </g:form>
            </div>
        </div>
    </body>
</html>
