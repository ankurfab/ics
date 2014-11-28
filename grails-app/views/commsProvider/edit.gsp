
<%@ page import="ics.CommsProvider" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="commsProvider.edit" default="Edit CommsProvider" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="commsProvider.list" default="CommsProvider List" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="commsProvider.new" default="New CommsProvider" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="commsProvider.edit" default="Edit CommsProvider" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:hasErrors bean="${commsProviderInstance}">
            <div class="errors">
                <g:renderErrors bean="${commsProviderInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${commsProviderInstance?.id}" />
                <g:hiddenField name="version" value="${commsProviderInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="name"><g:message code="commsProvider.name" default="Name" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: commsProviderInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" value="${fieldValue(bean: commsProviderInstance, field: 'name')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="type"><g:message code="commsProvider.type" default="Type" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: commsProviderInstance, field: 'type', 'errors')}">
                                    <g:textField name="type" value="${fieldValue(bean: commsProviderInstance, field: 'type')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="baseUrl"><g:message code="commsProvider.baseUrl" default="Base Url" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: commsProviderInstance, field: 'baseUrl', 'errors')}">
                                    <g:textField name="baseUrl" value="${fieldValue(bean: commsProviderInstance, field: 'baseUrl')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="path"><g:message code="commsProvider.path" default="Path" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: commsProviderInstance, field: 'path', 'errors')}">
                                    <g:textField name="path" value="${fieldValue(bean: commsProviderInstance, field: 'path')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="query"><g:message code="commsProvider.query" default="Query" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: commsProviderInstance, field: 'query', 'errors')}">
                                    <g:textField name="query" value="${fieldValue(bean: commsProviderInstance, field: 'query')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="apikey"><g:message code="commsProvider.apikey" default="Apikey" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: commsProviderInstance, field: 'apikey', 'errors')}">
                                    <g:textField name="apikey" value="${fieldValue(bean: commsProviderInstance, field: 'apikey')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="uri"><g:message code="commsProvider.uri" default="Uri" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: commsProviderInstance, field: 'uri', 'errors')}">
                                    <g:textField name="uri" value="${fieldValue(bean: commsProviderInstance, field: 'uri')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="user"><g:message code="commsProvider.user" default="User" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: commsProviderInstance, field: 'user', 'errors')}">
                                    <g:textField name="user" value="${fieldValue(bean: commsProviderInstance, field: 'user')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="pwd"><g:message code="commsProvider.pwd" default="Pwd" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: commsProviderInstance, field: 'pwd', 'errors')}">
                                    <g:textField name="pwd" value="${fieldValue(bean: commsProviderInstance, field: 'pwd')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="host"><g:message code="commsProvider.host" default="Host" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: commsProviderInstance, field: 'host', 'errors')}">
                                    <g:textField name="host" value="${fieldValue(bean: commsProviderInstance, field: 'host')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="port"><g:message code="commsProvider.port" default="Port" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: commsProviderInstance, field: 'port', 'errors')}">
                                    <g:textField name="port" value="${fieldValue(bean: commsProviderInstance, field: 'port')}" />

                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'update', 'default': 'Update')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'delete', 'default': 'Delete')}" onclick="return confirm('${message(code: 'delete.confirm', 'default': 'Are you sure?')}');" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
