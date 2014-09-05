
<%@ page import="ics.CommsProvider" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="commsProvider.show" default="Show CommsProvider" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="commsProvider.list" default="CommsProvider List" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="commsProvider.new" default="New CommsProvider" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="commsProvider.show" default="Show CommsProvider" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:form>
                <g:hiddenField name="id" value="${commsProviderInstance?.id}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="commsProvider.id" default="Id" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: commsProviderInstance, field: "id")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="commsProvider.type" default="Type" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: commsProviderInstance, field: "type")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="commsProvider.uri" default="Uri" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: commsProviderInstance, field: "uri")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="commsProvider.user" default="User" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: commsProviderInstance, field: "user")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="commsProvider.pwd" default="Pwd" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: commsProviderInstance, field: "pwd")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="commsProvider.apikey" default="Apikey" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: commsProviderInstance, field: "apikey")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="commsProvider.host" default="Host" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: commsProviderInstance, field: "host")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="commsProvider.port" default="Port" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: commsProviderInstance, field: "port")}</td>
                                
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
