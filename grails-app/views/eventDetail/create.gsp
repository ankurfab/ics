
<%@ page import="ics.EventDetail" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="eventDetail.create" default="Create EventDetail" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="eventDetail.list" default="EventDetail List" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="eventDetail.create" default="Create EventDetail" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:hasErrors bean="${eventDetailInstance}">
            <div class="errors">
                <g:renderErrors bean="${eventDetailInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="event"><g:message code="eventDetail.event" default="Event" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventDetailInstance, field: 'event', 'errors')}">
                                    <g:select name="event.id" from="${ics.Event.list()}" optionKey="id" value="${eventDetailInstance?.event?.id}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="category"><g:message code="eventDetail.category" default="Category" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventDetailInstance, field: 'category', 'errors')}">
                                    <g:textField name="category" value="${fieldValue(bean: eventDetailInstance, field: 'category')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="type"><g:message code="eventDetail.type" default="Type" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventDetailInstance, field: 'type', 'errors')}">
                                    <g:textField name="type" value="${fieldValue(bean: eventDetailInstance, field: 'type')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="details"><g:message code="eventDetail.details" default="Details" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventDetailInstance, field: 'details', 'errors')}">
                                    <g:textArea name="details" rows="5" cols="40" value="${fieldValue(bean: eventDetailInstance, field: 'details')}" />

                                </td>
                            </tr>
                                                
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'create', 'default': 'Create')}" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
