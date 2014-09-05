
<%@ page import="ics.EventSevaGroupAllotment" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="eventSevaGroupAllotment.edit" default="Edit EventSevaGroupAllotment" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="eventSevaGroupAllotment.list" default="EventSevaGroupAllotment List" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="eventSevaGroupAllotment.new" default="New EventSevaGroupAllotment" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="eventSevaGroupAllotment.edit" default="Edit EventSevaGroupAllotment" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:hasErrors bean="${eventSevaGroupAllotmentInstance}">
            <div class="errors">
                <g:renderErrors bean="${eventSevaGroupAllotmentInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${eventSevaGroupAllotmentInstance?.id}" />
                <g:hiddenField name="version" value="${eventSevaGroupAllotmentInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="dateCreated"><g:message code="eventSevaGroupAllotment.dateCreated" default="Date Created" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventSevaGroupAllotmentInstance, field: 'dateCreated', 'errors')}">
                                    <g:datePicker name="dateCreated" value="${eventSevaGroupAllotmentInstance?.dateCreated}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="creator"><g:message code="eventSevaGroupAllotment.creator" default="Creator" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventSevaGroupAllotmentInstance, field: 'creator', 'errors')}">
                                    <g:textField name="creator" value="${fieldValue(bean: eventSevaGroupAllotmentInstance, field: 'creator')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="lastUpdated"><g:message code="eventSevaGroupAllotment.lastUpdated" default="Last Updated" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventSevaGroupAllotmentInstance, field: 'lastUpdated', 'errors')}">
                                    <g:datePicker name="lastUpdated" value="${eventSevaGroupAllotmentInstance?.lastUpdated}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="updator"><g:message code="eventSevaGroupAllotment.updator" default="Updator" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventSevaGroupAllotmentInstance, field: 'updator', 'errors')}">
                                    <g:textField name="updator" value="${fieldValue(bean: eventSevaGroupAllotmentInstance, field: 'updator')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="eventSeva"><g:message code="eventSevaGroupAllotment.eventSeva" default="Event Seva" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventSevaGroupAllotmentInstance, field: 'eventSeva', 'errors')}">
                                    <g:select name="eventSeva.id" from="${ics.EventSeva.list()}" optionKey="id" value="${eventSevaGroupAllotmentInstance?.eventSeva?.id}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="eventRegistration"><g:message code="eventSevaGroupAllotment.eventRegistration" default="Event Registration" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventSevaGroupAllotmentInstance, field: 'eventRegistration', 'errors')}">
                                    <g:select name="eventRegistration.id" from="${ics.EventRegistration.list()}" optionKey="id" value="${eventSevaGroupAllotmentInstance?.eventRegistration?.id}"  />

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
