
<%@ page import="ics.Event" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'event.label', default: 'Event')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list">Event Calendar</g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" controller="menuOrder" action="create" params="['eid':eventInstance?.id]">Place Menu Order</g:link></span>
            <span class="menuButton"><g:link class="create" controller="EventRegistration" action="list" params="['eid':eventInstance?.id]">EventRegistration</g:link></span>
            <span class="menuButton"><g:link class="create" controller="EventAccommodation" action="list" params="['eid':eventInstance?.id]">EventAccommodation</g:link></span>
            <span class="menuButton"><g:link class="create" controller="Trip" action="list" params="['eid':eventInstance?.id]">EventTransportation</g:link></span>
            <span class="menuButton"><g:link class="create" controller="eventPrasadam" action="list" params="['eid':eventInstance?.id]">EventPrasadam</g:link></span>
            <span class="menuButton"><g:link class="create" controller="eventSeva" action="list" params="['eid':eventInstance?.id]">EventService</g:link></span>
            <span class="menuButton"><g:link class="create" controller="helper" action="eventDashboard" params="['eid':eventInstance?.id]">EventDashboard</g:link></span>
            <span class="menuButton"><g:link class="create" controller="icsUser" action="list" params="['eid':eventInstance?.id]">EventUsers</g:link></span>
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
                            <td valign="top" class="name"><g:message code="event.id.label" default="Id" /></td>
                            
                            <td valign="top" class="value"><g:formatNumber number="${eventInstance?.id}" format="#" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="event.category.label" default="Category" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: eventInstance, field: "category")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="event.title.label" default="Title" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: eventInstance, field: "title")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="event.startDate.label" default="Start Date" /></td>
                            
                            <td valign="top" class="value"><g:formatDate format="dd-MM-yyyy  hh:mm:ss a" date="${eventInstance?.startDate}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="event.endDate.label" default="End Date" /></td>
                            
                            <td valign="top" class="value"><g:formatDate format="dd-MM-yyyy  hh:mm:ss a" date="${eventInstance?.endDate}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="event.venue.label" default="Venue" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: eventInstance, field: "venue")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="event.contactPerson.label" default="Contact Person" /></td>
                            
                            <td valign="top" class="value"><g:link controller="individual" action="show" id="${eventInstance?.contactPerson?.id}">${eventInstance?.contactPerson?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="event.description.label" default="Description" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: eventInstance, field: "description")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="event.department.label" default="Department" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: eventInstance, field: "department")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="event.comments.label" default="Comments" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: eventInstance, field: "comments")}</td>
                            
                        </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="regstartDate"><g:message code="event.regstartDate.label" default="Registration Start Date" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventInstance, field: 'regstartDate', 'errors')}">
					<g:formatDate format="dd-MM-yyyy hh:mm:ss a" date="${eventInstance?.regstartDate}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="regendDate"><g:message code="event.regendDate.label" default="Registration End Date" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventInstance, field: 'regendDate', 'errors')}">
					<g:formatDate format="dd-MM-yyyy hh:mm:ss a" date="${eventInstance?.regendDate}" />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="registrationMode"><g:message code="event.registrationMode.label" default="Registration Mode" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventInstance, field: 'registrationMode', 'errors')}">
					${eventInstance?.registrationMode}
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="status"><g:message code="event.status.label" default="Status" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventInstance, field: 'status', 'errors')}">
					${eventInstance?.status}
                                </td>
                            </tr>

                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="event.participants.label" default="Participants" /></td>
                            
                            <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                <g:each in="${eventInstance.participants}" var="p">
                                    <li><g:link controller="eventParticipant" action="show" id="${p.id}">${p?.encodeAsHTML()}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                            
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="event.dateCreated.label" default="Date Created" /></td>
                            
                            <td valign="top" class="value"><g:formatDate format="dd-MM-yyyy hh:mm:ss a" date="${eventInstance?.dateCreated}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="event.creator.label" default="Creator" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: eventInstance, field: "creator")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="event.lastUpdated.label" default="Last Updated" /></td>
                            
                            <td valign="top" class="value"><g:formatDate format="dd-MM-yyyy hh:mm:ss a" date="${eventInstance?.lastUpdated}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="event.updator.label" default="Updator" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: eventInstance, field: "updator")}</td>
                            
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${eventInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
