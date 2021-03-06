
<%@ page import="ics.Role" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'role.label', default: 'Role')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">Home</a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
	    <span class="menuButton"><g:link class="create" controller="role" action="pairs" id="${roleInstance?.id}">Pairs</g:link></span>
	    <span class="menuButton"><g:link class="create" controller="helper" action="message" params="[entityName: 'Role',ids: roleInstance?.id, via:'SMS',depid:ics.Department.findByName('TMC')?.id]">Send SMS Message</g:link></span>
	    <span class="menuButton"><g:link class="create" controller="helper" action="message" params="[entity: 'Role',id: roleInstance?.id, via:'EMAIL']">Send Email Message</g:link></span>
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
                            <td valign="top" class="name"><g:message code="role.id.label" default="Id" /></td>
                            
                            <td valign="top" class="value"><g:formatNumber number="${roleInstance?.id}" format="#" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="role.name.label" default="Name" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: roleInstance, field: "name")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="role.description.label" default="Description" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: roleInstance, field: "description")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="role.category.label" default="Category" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: roleInstance, field: "category")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="role.authority.label" default="Authority" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: roleInstance, field: "authority")}</td>
                            
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name">Individuals</td>
                            
                            <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                <g:each in="${roleInstance.individualRoles}" var="i">
                                    <li><g:link controller="individual" action="show" id="${i?.individual?.id}">${i?.individual}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                            
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="role.dateCreated.label" default="Date Created" /></td>
                            
                            <td valign="top" class="value"><g:formatDate format="dd-MM-yyyy hh:mm:ss a" date="${roleInstance?.dateCreated}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="role.creator.label" default="Creator" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: roleInstance, field: "creator")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="role.lastUpdated.label" default="Last Updated" /></td>
                            
                            <td valign="top" class="value"><g:formatDate format="dd-MM-yyyy hh:mm:ss a" date="${roleInstance?.lastUpdated}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="role.updator.label" default="Updator" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: roleInstance, field: "updator")}</td>
                            
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${roleInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
