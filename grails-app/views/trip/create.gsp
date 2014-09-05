
<%@ page import="ics.Trip" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="trip.create" default="Create Trip" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="trip.list" default="Trip List" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="trip.create" default="Create Trip" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:hasErrors bean="${tripInstance}">
            <div class="errors">
                <g:renderErrors bean="${tripInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="vehicle"><g:message code="trip.vehicle" default="Vehicle" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: tripInstance, field: 'vehicle', 'errors')}">
                                    <g:select name="vehicle.id" from="${ics.Vehicle.list()}" optionKey="id" value="${tripInstance?.vehicle?.id}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="source"><g:message code="trip.source" default="Source" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: tripInstance, field: 'source', 'errors')}">
                                    <g:textField name="source" value="${fieldValue(bean: tripInstance, field: 'source')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="destination"><g:message code="trip.destination" default="Destination" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: tripInstance, field: 'destination', 'errors')}">
                                    <g:textField name="destination" value="${fieldValue(bean: tripInstance, field: 'destination')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="departureTime"><g:message code="trip.departureTime" default="Departure Time" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: tripInstance, field: 'departureTime', 'errors')}">
                                    <g:datePicker name="departureTime" value="${tripInstance?.departureTime}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="arrivalTime"><g:message code="trip.arrivalTime" default="Arrival Time" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: tripInstance, field: 'arrivalTime', 'errors')}">
                                    <g:datePicker name="arrivalTime" value="${tripInstance?.arrivalTime}" noSelection="['': '']" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="driverName"><g:message code="trip.driverName" default="Driver Name" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: tripInstance, field: 'driverName', 'errors')}">
                                    <g:textField name="driverName" value="${fieldValue(bean: tripInstance, field: 'driverName')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="driverNumber"><g:message code="trip.driverNumber" default="Driver Number" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: tripInstance, field: 'driverNumber', 'errors')}">
                                    <g:textField name="driverNumber" value="${fieldValue(bean: tripInstance, field: 'driverNumber')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="comments"><g:message code="trip.comments" default="Comments" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: tripInstance, field: 'comments', 'errors')}">
                                    <g:textField name="comments" value="${fieldValue(bean: tripInstance, field: 'comments')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="status"><g:message code="trip.status" default="Status" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: tripInstance, field: 'status', 'errors')}">
                                    <g:textField name="status" value="${fieldValue(bean: tripInstance, field: 'status')}" />

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
