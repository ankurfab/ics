
<%@ page import="ics.EventVolunteer" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="eventVolunteer.edit" default="Edit EventVolunteer" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="eventVolunteer.list" default="EventVolunteer List" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="eventVolunteer.new" default="New EventVolunteer" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="eventVolunteer.edit" default="Edit EventVolunteer" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:hasErrors bean="${eventVolunteerInstance}">
            <div class="errors">
                <g:renderErrors bean="${eventVolunteerInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${eventVolunteerInstance?.id}" />
                <g:hiddenField name="version" value="${eventVolunteerInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="event"><g:message code="eventVolunteer.event" default="Event" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventVolunteerInstance, field: 'event', 'errors')}">
                                    <g:select name="event.id" from="${ics.Event.list()}" optionKey="id" value="${eventVolunteerInstance?.event?.id}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="department"><g:message code="eventVolunteer.department" default="Department" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventVolunteerInstance, field: 'department', 'errors')}">
                                    <g:textField name="department" value="${fieldValue(bean: eventVolunteerInstance, field: 'department')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="seva"><g:message code="eventVolunteer.seva" default="Seva" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventVolunteerInstance, field: 'seva', 'errors')}">
                                    <g:textField name="seva" value="${fieldValue(bean: eventVolunteerInstance, field: 'seva')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="requiredFrom"><g:message code="eventVolunteer.requiredFrom" default="Required From" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventVolunteerInstance, field: 'requiredFrom', 'errors')}">
                                    <g:datePicker name="requiredFrom" value="${eventVolunteerInstance?.requiredFrom}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="requiredTill"><g:message code="eventVolunteer.requiredTill" default="Required Till" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventVolunteerInstance, field: 'requiredTill', 'errors')}">
                                    <g:datePicker name="requiredTill" value="${eventVolunteerInstance?.requiredTill}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="numPrjiRequired"><g:message code="eventVolunteer.numPrjiRequired" default="Num Prji Required" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventVolunteerInstance, field: 'numPrjiRequired', 'errors')}">
                                    <g:textField name="numPrjiRequired" value="${fieldValue(bean: eventVolunteerInstance, field: 'numPrjiRequired')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="numMatajiRequired"><g:message code="eventVolunteer.numMatajiRequired" default="Num Mataji Required" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventVolunteerInstance, field: 'numMatajiRequired', 'errors')}">
                                    <g:textField name="numMatajiRequired" value="${fieldValue(bean: eventVolunteerInstance, field: 'numMatajiRequired')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="numPrjiAllotted"><g:message code="eventVolunteer.numPrjiAllotted" default="Num Prji Allotted" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventVolunteerInstance, field: 'numPrjiAllotted', 'errors')}">
                                    <g:textField name="numPrjiAllotted" value="${fieldValue(bean: eventVolunteerInstance, field: 'numPrjiAllotted')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="numMatajiAllotted"><g:message code="eventVolunteer.numMatajiAllotted" default="Num Mataji Allotted" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventVolunteerInstance, field: 'numMatajiAllotted', 'errors')}">
                                    <g:textField name="numMatajiAllotted" value="${fieldValue(bean: eventVolunteerInstance, field: 'numMatajiAllotted')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="comments"><g:message code="eventVolunteer.comments" default="Comments" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventVolunteerInstance, field: 'comments', 'errors')}">
                                    <g:textArea rows="3" cols="20" name="comments" value="${fieldValue(bean: eventVolunteerInstance, field: 'comments')}" />

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
