
<%@ page import="ics.AccommodationAllotment" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="accommodationAllotment.show" default="Show AccommodationAllotment" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="accommodationAllotment.list" default="AccommodationAllotment List" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="accommodationAllotment.new" default="New AccommodationAllotment" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="accommodationAllotment.show" default="Show AccommodationAllotment" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:form>
                <g:hiddenField name="id" value="${accommodationAllotmentInstance?.id}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="accommodationAllotment.id" default="Id" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: accommodationAllotmentInstance, field: "id")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="accommodationAllotment.regCode" default="Reg Code" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: accommodationAllotmentInstance, field: "regCode")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="accommodationAllotment.eventAccomodation" default="Event Accomodation" />:</td>
                                
                                <td valign="top" class="value"><g:link controller="eventAccomodation" action="show" id="${accommodationAllotmentInstance?.eventAccomodation?.id}">${accommodationAllotmentInstance?.eventAccomodation?.encodeAsHTML()}</g:link></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="accommodationAllotment.numberofPrabhujisAllotted" default="Numberof Prabhujis Allotted" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: accommodationAllotmentInstance, field: "numberofPrabhujisAllotted")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="accommodationAllotment.numberofMatajisAllotted" default="Numberof Matajis Allotted" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: accommodationAllotmentInstance, field: "numberofMatajisAllotted")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="accommodationAllotment.numberofChildrenAllotted" default="Numberof Children Allotted" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: accommodationAllotmentInstance, field: "numberofChildrenAllotted")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="accommodationAllotment.dateCreated" default="Date Created" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${accommodationAllotmentInstance?.dateCreated}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="accommodationAllotment.creator" default="Creator" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: accommodationAllotmentInstance, field: "creator")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="accommodationAllotment.lastUpdated" default="Last Updated" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${accommodationAllotmentInstance?.lastUpdated}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="accommodationAllotment.updator" default="Updator" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: accommodationAllotmentInstance, field: "updator")}</td>
                                
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
