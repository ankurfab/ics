
<%@ page import="ics.PaymentMode" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'paymentMode.label', default: 'PaymentMode')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
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
                            <td valign="top" class="name"><g:message code="paymentMode.id.label" default="Id" /></td>
                            
                            <td valign="top" class="value"><g:formatNumber number="${paymentModeInstance?.id}" format="#" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="paymentMode.name.label" default="Name" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: paymentModeInstance, field: "name")}</td>
                            
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="paymentMode.dateCreated.label" default="Date Created" /></td>
                            
                            <td valign="top" class="value"><g:formatDate format="dd-MM-yyyy hh:mm:ss a" date="${paymentModeInstance?.dateCreated}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="paymentMode.creator.label" default="Creator" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: paymentModeInstance, field: "creator")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="paymentMode.lastUpdated.label" default="Last Updated" /></td>
                            
                            <td valign="top" class="value"><g:formatDate format="dd-MM-yyyy hh:mm:ss a" date="${paymentModeInstance?.lastUpdated}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="paymentMode.updator.label" default="Updator" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: paymentModeInstance, field: "updator")}</td>
                            
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${paymentModeInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
