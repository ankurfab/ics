
<%@ page import="ics.Attribute" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="attribute.show" default="Show Attribute" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="attribute.list" default="Attribute List" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="attribute.new" default="New Attribute" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="attribute.show" default="Show Attribute" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:form>
                <g:hiddenField name="id" value="${attributeInstance?.id}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="attribute.id" default="Id" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: attributeInstance, field: "id")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="attribute.name" default="Name" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: attributeInstance, field: "name")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="attribute.type" default="Type" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: attributeInstance, field: "type")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="attribute.category" default="Category" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: attributeInstance, field: "category")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="attribute.department" default="Department" />:</td>
                                
                                <td valign="top" class="value"><g:link controller="department" action="show" id="${attributeInstance?.department?.id}">${attributeInstance?.department?.encodeAsHTML()}</g:link></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="attribute.centre" default="Centre" />:</td>
                                
                                <td valign="top" class="value"><g:link controller="centre" action="show" id="${attributeInstance?.centre?.id}">${attributeInstance?.centre?.encodeAsHTML()}</g:link></td>
                                
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
