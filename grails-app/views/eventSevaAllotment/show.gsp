
<%@ page import="ics.EventSevaAllotment" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="eventSevaAllotment.show" default="Show EventSevaAllotment" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="eventSevaAllotment.list" default="EventSevaAllotment List" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="eventSevaAllotment.new" default="New EventSevaAllotment" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="eventSevaAllotment.show" default="Show EventSevaAllotment" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:form>
                <g:hiddenField name="id" value="${eventSevaAllotmentInstance?.id}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="eventSevaAllotment.id" default="Id" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: eventSevaAllotmentInstance, field: "id")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="eventSevaAllotment.dateCreated" default="Date Created" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${eventSevaAllotmentInstance?.dateCreated}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="eventSevaAllotment.creator" default="Creator" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: eventSevaAllotmentInstance, field: "creator")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="eventSevaAllotment.lastUpdated" default="Last Updated" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${eventSevaAllotmentInstance?.lastUpdated}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="eventSevaAllotment.updator" default="Updator" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: eventSevaAllotmentInstance, field: "updator")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="eventSevaAllotment.eventSeva" default="Event Seva" />:</td>
                                
                                <td valign="top" class="value"><g:link controller="eventSeva" action="show" id="${eventSevaAllotmentInstance?.eventSeva?.id}">${eventSevaAllotmentInstance?.eventSeva?.encodeAsHTML()}</g:link></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="eventSevaAllotment.person" default="Person" />:</td>
                                
                                <td valign="top" class="value"><g:link controller="person" action="show" id="${eventSevaAllotmentInstance?.person?.id}">${eventSevaAllotmentInstance?.person?.encodeAsHTML()}</g:link></td>
                                
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
