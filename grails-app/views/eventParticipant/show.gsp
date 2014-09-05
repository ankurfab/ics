
<%@ page import="ics.EventParticipant" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'eventParticipant.label', default: 'EventParticipant')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">Home</a></span>
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
                            <td valign="top" class="name"><g:message code="eventParticipant.id.label" default="Id" /></td>
                            
                            <td valign="top" class="value"><g:formatNumber number="${eventParticipantInstance?.id}" format="#" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="eventParticipant.event.label" default="Event" /></td>
                            
                            <td valign="top" class="value"><g:link controller="event" action="show" id="${eventParticipantInstance?.event?.id}">${eventParticipantInstance?.event?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="eventParticipant.individual.label" default="Individual" /></td>
                            
                            <td valign="top" class="value"><g:link controller="individual" action="show" id="${eventParticipantInstance?.individual?.id}">${eventParticipantInstance?.individual?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="eventParticipant.regCode.label" default="RegCode" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: eventParticipantInstance, field: "regCode")}</td>
                            
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="eventParticipant.attended.label" default="Attended" /></td>
                            
                            <td valign="top" class="value"><g:formatBoolean boolean="${eventParticipantInstance?.attended}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="eventParticipant.invited.label" default="Invited" /></td>
                            
                            <td valign="top" class="value"><g:formatBoolean boolean="${eventParticipantInstance?.invited}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="eventParticipant.confirmed.label" default="Confirmed" /></td>
                            
                            <td valign="top" class="value"><g:formatBoolean boolean="${eventParticipantInstance?.confirmed}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="eventParticipant.comments.label" default="Comments" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: eventParticipantInstance, field: "comments")}</td>
                            
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="eventParticipant.dateCreated.label" default="Date Created" /></td>
                            
                            <td valign="top" class="value"><g:formatDate format="dd-MM-yyyy hh:mm:ss a" date="${eventParticipantInstance?.dateCreated}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="eventParticipant.creator.label" default="Creator" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: eventParticipantInstance, field: "creator")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="eventParticipant.lastUpdated.label" default="Last Updated" /></td>
                            
                            <td valign="top" class="value"><g:formatDate format="dd-MM-yyyy hh:mm:ss a" date="${eventParticipantInstance?.lastUpdated}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="eventParticipant.updator.label" default="Updator" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: eventParticipantInstance, field: "updator")}</td>
                            
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${eventParticipantInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
