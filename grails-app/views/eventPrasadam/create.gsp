
<%@ page import="ics.EventPrasadam" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="eventPrasadam.create" default="Create EventPrasadam" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="eventPrasadam.list" default="EventPrasadam List" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="eventPrasadam.create" default="Create EventPrasadam" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:hasErrors bean="${eventPrasadamInstance}">
            <div class="errors">
                <g:renderErrors bean="${eventPrasadamInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="event"><g:message code="eventPrasadam.event" default="Event" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventPrasadamInstance, field: 'event', 'errors')}">
                                    <g:select name="event.id" from="${ics.Event.list()}" optionKey="id" value="${eventPrasadamInstance?.event?.id}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="meal"><g:message code="eventPrasadam.meal" default="Meal" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventPrasadamInstance, field: 'meal', 'errors')}">
                                    <g:textField name="meal" value="${fieldValue(bean: eventPrasadamInstance, field: 'meal')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="mealDate"><g:message code="eventPrasadam.mealDate" default="Meal Date" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventPrasadamInstance, field: 'mealDate', 'errors')}">
                                    <g:datePicker name="mealDate" value="${eventPrasadamInstance?.mealDate}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="numPrji"><g:message code="eventPrasadam.numPrji" default="Num Prji" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventPrasadamInstance, field: 'numPrji', 'errors')}">
                                    <g:textField name="numPrji" value="${fieldValue(bean: eventPrasadamInstance, field: 'numPrji')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="numMataji"><g:message code="eventPrasadam.numMataji" default="Num Mataji" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventPrasadamInstance, field: 'numMataji', 'errors')}">
                                    <g:textField name="numMataji" value="${fieldValue(bean: eventPrasadamInstance, field: 'numMataji')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="numChildren"><g:message code="eventPrasadam.numChildren" default="Num Children" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventPrasadamInstance, field: 'numChildren', 'errors')}">
                                    <g:textField name="numChildren" value="${fieldValue(bean: eventPrasadamInstance, field: 'numChildren')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="comments"><g:message code="eventPrasadam.comments" default="Comments" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventPrasadamInstance, field: 'comments', 'errors')}">
                                    <g:textField name="comments" value="${fieldValue(bean: eventPrasadamInstance, field: 'comments')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="updator"><g:message code="eventPrasadam.updator" default="Updator" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventPrasadamInstance, field: 'updator', 'errors')}">
                                    <g:textField name="updator" value="${fieldValue(bean: eventPrasadamInstance, field: 'updator')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="lastUpdated"><g:message code="eventPrasadam.lastUpdated" default="Last Updated" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventPrasadamInstance, field: 'lastUpdated', 'errors')}">
                                    <g:datePicker name="lastUpdated" value="${eventPrasadamInstance?.lastUpdated}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="creator"><g:message code="eventPrasadam.creator" default="Creator" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventPrasadamInstance, field: 'creator', 'errors')}">
                                    <g:textField name="creator" value="${fieldValue(bean: eventPrasadamInstance, field: 'creator')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="dateCreated"><g:message code="eventPrasadam.dateCreated" default="Date Created" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventPrasadamInstance, field: 'dateCreated', 'errors')}">
                                    <g:datePicker name="dateCreated" value="${eventPrasadamInstance?.dateCreated}"  />

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
