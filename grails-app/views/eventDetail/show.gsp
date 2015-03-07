
<%@ page import="ics.EventDetail" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="eventDetail.show" default="Show EventDetail" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="eventDetail.list" default="EventDetail List" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="eventDetail.new" default="New EventDetail" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="eventDetail.show" default="Show EventDetail" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:form>
                <g:hiddenField name="id" value="${eventDetailInstance?.id}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="eventDetail.id" default="Id" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: eventDetailInstance, field: "id")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="eventDetail.event" default="Event" />:</td>
                                
                                <td valign="top" class="value"><g:link controller="event" action="show" id="${eventDetailInstance?.event?.id}">${eventDetailInstance?.event?.encodeAsHTML()}</g:link></td>
                                
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="eventDetail.category" default="Category" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: eventDetailInstance, field: "category")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="eventDetail.type" default="Type" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: eventDetailInstance, field: "type")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="eventDetail.details" default="Details" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: eventDetailInstance, field: "details")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="eventDetail.creator" default="Creator" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: eventDetailInstance, field: "creator")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="eventDetail.dateCreated" default="Date Created" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${eventDetailInstance?.dateCreated}" /></td>
                                
                            </tr>
                            
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="eventDetail.lastUpdated" default="Last Updated" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${eventDetailInstance?.lastUpdated}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="eventDetail.updator" default="Updator" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: eventDetailInstance, field: "updator")}</td>
                                
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
