
<%@ page import="ics.AccommodationAllotment" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="accommodationAllotment.create" default="Create AccommodationAllotment" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="accommodationAllotment.list" default="AccommodationAllotment List" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="accommodationAllotment.create" default="Create AccommodationAllotment" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:hasErrors bean="${accommodationAllotmentInstance}">
            <div class="errors">
                <g:renderErrors bean="${accommodationAllotmentInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="regCode"><g:message code="accommodationAllotment.regCode" default="Reg Code" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: accommodationAllotmentInstance, field: 'regCode', 'errors')}">
                                    <g:textField name="regCode" value="${fieldValue(bean: accommodationAllotmentInstance, field: 'regCode')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="eventAccomodation"><g:message code="accommodationAllotment.eventAccomodation" default="Event Accomodation" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: accommodationAllotmentInstance, field: 'eventAccomodation', 'errors')}">
                                    <g:select name="eventAccomodation.id" from="${ics.EventAccomodation.list()}" optionKey="id" value="${accommodationAllotmentInstance?.eventAccomodation?.id}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="numberofPrabhujisAllotted"><g:message code="accommodationAllotment.numberofPrabhujisAllotted" default="Numberof Prabhujis Allotted" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: accommodationAllotmentInstance, field: 'numberofPrabhujisAllotted', 'errors')}">
                                    <g:textField name="numberofPrabhujisAllotted" value="${fieldValue(bean: accommodationAllotmentInstance, field: 'numberofPrabhujisAllotted')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="numberofMatajisAllotted"><g:message code="accommodationAllotment.numberofMatajisAllotted" default="Numberof Matajis Allotted" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: accommodationAllotmentInstance, field: 'numberofMatajisAllotted', 'errors')}">
                                    <g:textField name="numberofMatajisAllotted" value="${fieldValue(bean: accommodationAllotmentInstance, field: 'numberofMatajisAllotted')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="numberofChildrenAllotted"><g:message code="accommodationAllotment.numberofChildrenAllotted" default="Numberof Children Allotted" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: accommodationAllotmentInstance, field: 'numberofChildrenAllotted', 'errors')}">
                                    <g:textField name="numberofChildrenAllotted" value="${fieldValue(bean: accommodationAllotmentInstance, field: 'numberofChildrenAllotted')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="dateCreated"><g:message code="accommodationAllotment.dateCreated" default="Date Created" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: accommodationAllotmentInstance, field: 'dateCreated', 'errors')}">
                                    <g:datePicker name="dateCreated" value="${accommodationAllotmentInstance?.dateCreated}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="creator"><g:message code="accommodationAllotment.creator" default="Creator" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: accommodationAllotmentInstance, field: 'creator', 'errors')}">
                                    <g:textField name="creator" value="${fieldValue(bean: accommodationAllotmentInstance, field: 'creator')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="lastUpdated"><g:message code="accommodationAllotment.lastUpdated" default="Last Updated" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: accommodationAllotmentInstance, field: 'lastUpdated', 'errors')}">
                                    <g:datePicker name="lastUpdated" value="${accommodationAllotmentInstance?.lastUpdated}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="updator"><g:message code="accommodationAllotment.updator" default="Updator" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: accommodationAllotmentInstance, field: 'updator', 'errors')}">
                                    <g:textField name="updator" value="${fieldValue(bean: accommodationAllotmentInstance, field: 'updator')}" />

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
