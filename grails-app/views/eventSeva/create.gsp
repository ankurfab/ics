
<%@ page import="ics.EventSeva" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="eventSeva.create" default="Create EventSeva" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="eventSeva.list" default="EventSeva List" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="eventSeva.create" default="Create EventSeva" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:hasErrors bean="${eventSevaInstance}">
            <div class="errors">
                <g:renderErrors bean="${eventSevaInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="comments"><g:message code="eventSeva.comments" default="Comments" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventSevaInstance, field: 'comments', 'errors')}">
                                    <g:textField name="comments" value="${fieldValue(bean: eventSevaInstance, field: 'comments')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="requiredFrom"><g:message code="eventSeva.requiredFrom" default="Required From" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventSevaInstance, field: 'requiredFrom', 'errors')}">
                                    <g:datePicker name="requiredFrom" value="${eventSevaInstance?.requiredFrom}" noSelection="['': '']" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="requiredTill"><g:message code="eventSeva.requiredTill" default="Required Till" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventSevaInstance, field: 'requiredTill', 'errors')}">
                                    <g:datePicker name="requiredTill" value="${eventSevaInstance?.requiredTill}" noSelection="['': '']" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="brahmachariAllotted"><g:message code="eventSeva.brahmachariAllotted" default="Brahmachari Allotted" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventSevaInstance, field: 'brahmachariAllotted', 'errors')}">
                                    <g:textField name="brahmachariAllotted" value="${fieldValue(bean: eventSevaInstance, field: 'brahmachariAllotted')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="brahmachariOpted"><g:message code="eventSeva.brahmachariOpted" default="Brahmachari Opted" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventSevaInstance, field: 'brahmachariOpted', 'errors')}">
                                    <g:textField name="brahmachariOpted" value="${fieldValue(bean: eventSevaInstance, field: 'brahmachariOpted')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="creator"><g:message code="eventSeva.creator" default="Creator" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventSevaInstance, field: 'creator', 'errors')}">
                                    <g:textField name="creator" value="${fieldValue(bean: eventSevaInstance, field: 'creator')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="dateCreated"><g:message code="eventSeva.dateCreated" default="Date Created" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventSevaInstance, field: 'dateCreated', 'errors')}">
                                    <g:datePicker name="dateCreated" value="${eventSevaInstance?.dateCreated}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="event"><g:message code="eventSeva.event" default="Event" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventSevaInstance, field: 'event', 'errors')}">
                                    <g:select name="event.id" from="${ics.Event.list()}" optionKey="id" value="${eventSevaInstance?.event?.id}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="inchargeContact"><g:message code="eventSeva.inchargeContact" default="Incharge Contact" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventSevaInstance, field: 'inchargeContact', 'errors')}">
                                    <g:textField name="inchargeContact" value="${fieldValue(bean: eventSevaInstance, field: 'inchargeContact')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="inchargeName"><g:message code="eventSeva.inchargeName" default="Incharge Name" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventSevaInstance, field: 'inchargeName', 'errors')}">
                                    <g:textField name="inchargeName" value="${fieldValue(bean: eventSevaInstance, field: 'inchargeName')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="lastUpdated"><g:message code="eventSeva.lastUpdated" default="Last Updated" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventSevaInstance, field: 'lastUpdated', 'errors')}">
                                    <g:datePicker name="lastUpdated" value="${eventSevaInstance?.lastUpdated}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="matajiAllotted"><g:message code="eventSeva.matajiAllotted" default="Mataji Allotted" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventSevaInstance, field: 'matajiAllotted', 'errors')}">
                                    <g:textField name="matajiAllotted" value="${fieldValue(bean: eventSevaInstance, field: 'matajiAllotted')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="matajiOpted"><g:message code="eventSeva.matajiOpted" default="Mataji Opted" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventSevaInstance, field: 'matajiOpted', 'errors')}">
                                    <g:textField name="matajiOpted" value="${fieldValue(bean: eventSevaInstance, field: 'matajiOpted')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="maxBrahmachariRequired"><g:message code="eventSeva.maxBrahmachariRequired" default="Max Brahmachari Required" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventSevaInstance, field: 'maxBrahmachariRequired', 'errors')}">
                                    <g:textField name="maxBrahmachariRequired" value="${fieldValue(bean: eventSevaInstance, field: 'maxBrahmachariRequired')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="maxMatajiRequired"><g:message code="eventSeva.maxMatajiRequired" default="Max Mataji Required" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventSevaInstance, field: 'maxMatajiRequired', 'errors')}">
                                    <g:textField name="maxMatajiRequired" value="${fieldValue(bean: eventSevaInstance, field: 'maxMatajiRequired')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="maxPrjiRequired"><g:message code="eventSeva.maxPrjiRequired" default="Max Prji Required" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventSevaInstance, field: 'maxPrjiRequired', 'errors')}">
                                    <g:textField name="maxPrjiRequired" value="${fieldValue(bean: eventSevaInstance, field: 'maxPrjiRequired')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="maxRequired"><g:message code="eventSeva.maxRequired" default="Max Required" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventSevaInstance, field: 'maxRequired', 'errors')}">
                                    <g:textField name="maxRequired" value="${fieldValue(bean: eventSevaInstance, field: 'maxRequired')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="prjiAllotted"><g:message code="eventSeva.prjiAllotted" default="Prji Allotted" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventSevaInstance, field: 'prjiAllotted', 'errors')}">
                                    <g:textField name="prjiAllotted" value="${fieldValue(bean: eventSevaInstance, field: 'prjiAllotted')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="prjiOpted"><g:message code="eventSeva.prjiOpted" default="Prji Opted" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventSevaInstance, field: 'prjiOpted', 'errors')}">
                                    <g:textField name="prjiOpted" value="${fieldValue(bean: eventSevaInstance, field: 'prjiOpted')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="seva"><g:message code="eventSeva.seva" default="Seva" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventSevaInstance, field: 'seva', 'errors')}">
                                    <g:select name="seva.id" from="${ics.Seva.list()}" optionKey="id" value="${eventSevaInstance?.seva?.id}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="totalAllotted"><g:message code="eventSeva.totalAllotted" default="Total Allotted" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventSevaInstance, field: 'totalAllotted', 'errors')}">
                                    <g:textField name="totalAllotted" value="${fieldValue(bean: eventSevaInstance, field: 'totalAllotted')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="totalOpted"><g:message code="eventSeva.totalOpted" default="Total Opted" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventSevaInstance, field: 'totalOpted', 'errors')}">
                                    <g:textField name="totalOpted" value="${fieldValue(bean: eventSevaInstance, field: 'totalOpted')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="updator"><g:message code="eventSeva.updator" default="Updator" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventSevaInstance, field: 'updator', 'errors')}">
                                    <g:textField name="updator" value="${fieldValue(bean: eventSevaInstance, field: 'updator')}" />

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
