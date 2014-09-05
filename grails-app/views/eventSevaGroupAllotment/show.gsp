
<%@ page import="ics.EventSevaGroupAllotment" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="eventSevaGroupAllotment.show" default="Show EventSevaGroupAllotment" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="eventSevaGroupAllotment.list" default="EventSevaGroupAllotment List" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="eventSevaGroupAllotment.new" default="New EventSevaGroupAllotment" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="eventSevaGroupAllotment.show" default="Show EventSevaGroupAllotment" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:form>
                <g:hiddenField name="id" value="${eventSevaGroupAllotmentInstance?.id}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="eventSevaGroupAllotment.id" default="Id" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: eventSevaGroupAllotmentInstance, field: "id")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="eventSevaGroupAllotment.dateCreated" default="Date Created" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${eventSevaGroupAllotmentInstance?.dateCreated}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="eventSevaGroupAllotment.creator" default="Creator" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: eventSevaGroupAllotmentInstance, field: "creator")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="eventSevaGroupAllotment.lastUpdated" default="Last Updated" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${eventSevaGroupAllotmentInstance?.lastUpdated}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="eventSevaGroupAllotment.updator" default="Updator" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: eventSevaGroupAllotmentInstance, field: "updator")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="eventSevaGroupAllotment.eventSeva" default="Event Seva" />:</td>
                                
                                <td valign="top" class="value"><g:link controller="eventSeva" action="show" id="${eventSevaGroupAllotmentInstance?.eventSeva?.id}">${eventSevaGroupAllotmentInstance?.eventSeva?.encodeAsHTML()}</g:link></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="eventSevaGroupAllotment.eventRegistration" default="Event Registration" />:</td>
                                
                                <td valign="top" class="value"><g:link controller="eventRegistration" action="show" id="${eventSevaGroupAllotmentInstance?.eventRegistration?.id}">${eventSevaGroupAllotmentInstance?.eventRegistration?.encodeAsHTML()}</g:link></td>
                                
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
