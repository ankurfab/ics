
<%@ page import="ics.EventSeva" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="eventSeva.show" default="Show EventSeva" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="eventSeva.list" default="EventSeva List" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="eventSeva.new" default="New EventSeva" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="eventSeva.show" default="Show EventSeva" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:form>
                <g:hiddenField name="id" value="${eventSevaInstance?.id}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="eventSeva.id" default="Id" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: eventSevaInstance, field: "id")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="eventSeva.comments" default="Comments" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: eventSevaInstance, field: "comments")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="eventSeva.requiredFrom" default="Required From" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${eventSevaInstance?.requiredFrom}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="eventSeva.requiredTill" default="Required Till" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${eventSevaInstance?.requiredTill}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="eventSeva.brahmachariAllotted" default="Brahmachari Allotted" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: eventSevaInstance, field: "brahmachariAllotted")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="eventSeva.brahmachariOpted" default="Brahmachari Opted" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: eventSevaInstance, field: "brahmachariOpted")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="eventSeva.creator" default="Creator" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: eventSevaInstance, field: "creator")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="eventSeva.dateCreated" default="Date Created" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${eventSevaInstance?.dateCreated}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="eventSeva.event" default="Event" />:</td>
                                
                                <td valign="top" class="value"><g:link controller="event" action="show" id="${eventSevaInstance?.event?.id}">${eventSevaInstance?.event?.encodeAsHTML()}</g:link></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="eventSeva.inchargeContact" default="Incharge Contact" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: eventSevaInstance, field: "inchargeContact")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="eventSeva.inchargeName" default="Incharge Name" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: eventSevaInstance, field: "inchargeName")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="eventSeva.lastUpdated" default="Last Updated" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${eventSevaInstance?.lastUpdated}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="eventSeva.matajiAllotted" default="Mataji Allotted" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: eventSevaInstance, field: "matajiAllotted")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="eventSeva.matajiOpted" default="Mataji Opted" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: eventSevaInstance, field: "matajiOpted")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="eventSeva.maxBrahmachariRequired" default="Max Brahmachari Required" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: eventSevaInstance, field: "maxBrahmachariRequired")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="eventSeva.maxMatajiRequired" default="Max Mataji Required" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: eventSevaInstance, field: "maxMatajiRequired")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="eventSeva.maxPrjiRequired" default="Max Prji Required" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: eventSevaInstance, field: "maxPrjiRequired")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="eventSeva.maxRequired" default="Max Required" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: eventSevaInstance, field: "maxRequired")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="eventSeva.prjiAllotted" default="Prji Allotted" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: eventSevaInstance, field: "prjiAllotted")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="eventSeva.prjiOpted" default="Prji Opted" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: eventSevaInstance, field: "prjiOpted")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="eventSeva.seva" default="Seva" />:</td>
                                
                                <td valign="top" class="value"><g:link controller="seva" action="show" id="${eventSevaInstance?.seva?.id}">${eventSevaInstance?.seva?.encodeAsHTML()}</g:link></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="eventSeva.totalAllotted" default="Total Allotted" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: eventSevaInstance, field: "totalAllotted")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="eventSeva.totalOpted" default="Total Opted" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: eventSevaInstance, field: "totalOpted")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="eventSeva.updator" default="Updator" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: eventSevaInstance, field: "updator")}</td>
                                
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
