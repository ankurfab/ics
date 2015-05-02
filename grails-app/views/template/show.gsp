
<%@ page import="ics.Template" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="template.show" default="Show Template" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="template.list" default="Template List" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="template.new" default="New Template" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="template.show" default="Show Template" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:form>
                <g:hiddenField name="id" value="${templateInstance?.id}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="template.id" default="Id" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: templateInstance, field: "id")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="template.name" default="Name" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: templateInstance, field: "name")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="template.code" default="Code" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: templateInstance, field: "code")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="template.body" default="Body" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: templateInstance, field: "body")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="template.category" default="Category" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: templateInstance, field: "category")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="template.type" default="Type" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: templateInstance, field: "type")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="template.department" default="Department" />:</td>
                                
                                <td valign="top" class="value"><g:link controller="department" action="show" id="${templateInstance?.department?.id}">${templateInstance?.department?.encodeAsHTML()}</g:link></td>
                                
                            </tr>
                            
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'edit', 'default': 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'delete', 'default': 'Delete')}" onclick="return confirm('${message(code: 'delete.confirm', 'default': 'Are you sure?')}');" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
