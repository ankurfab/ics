
<%@ page import="ics.Trip" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="trip.show" default="Show Trip" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="trip.list" default="Trip List" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="trip.new" default="New Trip" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="trip.show" default="Show Trip" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:form>
                <g:hiddenField name="id" value="${tripInstance?.id}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="trip.id" default="Id" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: tripInstance, field: "id")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="trip.vehicle" default="Vehicle" />:</td>
                                
                                <td valign="top" class="value"><g:link controller="vehicle" action="show" id="${tripInstance?.vehicle?.id}">${tripInstance?.vehicle?.encodeAsHTML()}</g:link></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="trip.source" default="Source" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: tripInstance, field: "source")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="trip.destination" default="Destination" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: tripInstance, field: "destination")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="trip.departureTime" default="Departure Time" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${tripInstance?.departureTime}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="trip.arrivalTime" default="Arrival Time" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${tripInstance?.arrivalTime}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="trip.driverName" default="Driver Name" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: tripInstance, field: "driverName")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="trip.driverNumber" default="Driver Number" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: tripInstance, field: "driverNumber")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="trip.comments" default="Comments" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: tripInstance, field: "comments")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="trip.status" default="Status" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: tripInstance, field: "status")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="trip.creator" default="Creator" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: tripInstance, field: "creator")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="trip.dateCreated" default="Date Created" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${tripInstance?.dateCreated}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="trip.lastUpdated" default="Last Updated" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${tripInstance?.lastUpdated}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="trip.updator" default="Updator" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: tripInstance, field: "updator")}</td>
                                
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
