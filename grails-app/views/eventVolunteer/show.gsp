
<%@ page import="ics.EventVolunteer" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="eventVolunteer.show" default="Show EventVolunteer" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="eventVolunteer.list" default="EventVolunteer List" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="eventVolunteer.new" default="New EventVolunteer" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="eventVolunteer.show" default="Show EventVolunteer" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:form>
                <g:hiddenField name="id" value="${eventVolunteerInstance?.id}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="eventVolunteer.id" default="Id" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: eventVolunteerInstance, field: "id")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="eventVolunteer.event" default="Event" />:</td>
                                
                                <td valign="top" class="value"><g:link controller="event" action="show" id="${eventVolunteerInstance?.event?.id}">${eventVolunteerInstance?.event?.encodeAsHTML()}</g:link></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="eventVolunteer.department" default="Department" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: eventVolunteerInstance, field: "department")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="eventVolunteer.seva" default="Seva" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: eventVolunteerInstance, field: "seva")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="eventVolunteer.requiredFrom" default="Required From" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${eventVolunteerInstance?.requiredFrom}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="eventVolunteer.requiredTill" default="Required Till" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${eventVolunteerInstance?.requiredTill}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="eventVolunteer.numPrjiRequired" default="Num Prji Required" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: eventVolunteerInstance, field: "numPrjiRequired")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="eventVolunteer.numMatajiRequired" default="Num Mataji Required" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: eventVolunteerInstance, field: "numMatajiRequired")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="eventVolunteer.numPrjiAllotted" default="Num Prji Allotted" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: eventVolunteerInstance, field: "numPrjiAllotted")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="eventVolunteer.numMatajiAllotted" default="Num Mataji Allotted" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: eventVolunteerInstance, field: "numMatajiAllotted")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="eventVolunteer.comments" default="Comments" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: eventVolunteerInstance, field: "comments")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="eventVolunteer.updator" default="Updator" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: eventVolunteerInstance, field: "updator")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="eventVolunteer.lastUpdated" default="Last Updated" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${eventVolunteerInstance?.lastUpdated}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="eventVolunteer.creator" default="Creator" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: eventVolunteerInstance, field: "creator")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="eventVolunteer.dateCreated" default="Date Created" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${eventVolunteerInstance?.dateCreated}" /></td>
                                
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
