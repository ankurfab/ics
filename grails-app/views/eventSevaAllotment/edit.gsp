
<%@ page import="ics.EventSevaAllotment" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="eventSevaAllotment.edit" default="Edit EventSevaAllotment" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="eventSevaAllotment.list" default="EventSevaAllotment List" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="eventSevaAllotment.new" default="New EventSevaAllotment" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="eventSevaAllotment.edit" default="Edit EventSevaAllotment" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:hasErrors bean="${eventSevaAllotmentInstance}">
            <div class="errors">
                <g:renderErrors bean="${eventSevaAllotmentInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${eventSevaAllotmentInstance?.id}" />
                <g:hiddenField name="version" value="${eventSevaAllotmentInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="dateCreated"><g:message code="eventSevaAllotment.dateCreated" default="Date Created" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventSevaAllotmentInstance, field: 'dateCreated', 'errors')}">
                                    <g:datePicker name="dateCreated" value="${eventSevaAllotmentInstance?.dateCreated}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="creator"><g:message code="eventSevaAllotment.creator" default="Creator" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventSevaAllotmentInstance, field: 'creator', 'errors')}">
                                    <g:textField name="creator" value="${fieldValue(bean: eventSevaAllotmentInstance, field: 'creator')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="lastUpdated"><g:message code="eventSevaAllotment.lastUpdated" default="Last Updated" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventSevaAllotmentInstance, field: 'lastUpdated', 'errors')}">
                                    <g:datePicker name="lastUpdated" value="${eventSevaAllotmentInstance?.lastUpdated}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="updator"><g:message code="eventSevaAllotment.updator" default="Updator" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventSevaAllotmentInstance, field: 'updator', 'errors')}">
                                    <g:textField name="updator" value="${fieldValue(bean: eventSevaAllotmentInstance, field: 'updator')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="eventSeva"><g:message code="eventSevaAllotment.eventSeva" default="Event Seva" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventSevaAllotmentInstance, field: 'eventSeva', 'errors')}">
                                    <g:select name="eventSeva.id" from="${ics.EventSeva.list()}" optionKey="id" value="${eventSevaAllotmentInstance?.eventSeva?.id}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="person"><g:message code="eventSevaAllotment.person" default="Person" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventSevaAllotmentInstance, field: 'person', 'errors')}">
                                    <g:select name="person.id" from="${ics.Person.list()}" optionKey="id" value="${eventSevaAllotmentInstance?.person?.id}"  />

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
