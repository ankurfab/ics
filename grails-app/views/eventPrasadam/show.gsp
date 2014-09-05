
<%@ page import="ics.EventPrasadam" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="eventPrasadam.show" default="Show EventPrasadam" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="eventPrasadam.list" default="EventPrasadam List" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="eventPrasadam.new" default="New EventPrasadam" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="eventPrasadam.show" default="Show EventPrasadam" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:form>
                <g:hiddenField name="id" value="${eventPrasadamInstance?.id}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="eventPrasadam.id" default="Id" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: eventPrasadamInstance, field: "id")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="eventPrasadam.event" default="Event" />:</td>
                                
                                <td valign="top" class="value"><g:link controller="event" action="show" id="${eventPrasadamInstance?.event?.id}">${eventPrasadamInstance?.event?.encodeAsHTML()}</g:link></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="eventPrasadam.meal" default="Meal" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: eventPrasadamInstance, field: "meal")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="eventPrasadam.mealDate" default="Meal Date" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${eventPrasadamInstance?.mealDate}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="eventPrasadam.numPrji" default="Num Prji" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: eventPrasadamInstance, field: "numPrji")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="eventPrasadam.numMataji" default="Num Mataji" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: eventPrasadamInstance, field: "numMataji")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="eventPrasadam.numChildren" default="Num Children" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: eventPrasadamInstance, field: "numChildren")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="eventPrasadam.comments" default="Comments" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: eventPrasadamInstance, field: "comments")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="eventPrasadam.updator" default="Updator" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: eventPrasadamInstance, field: "updator")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="eventPrasadam.lastUpdated" default="Last Updated" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${eventPrasadamInstance?.lastUpdated}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="eventPrasadam.creator" default="Creator" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: eventPrasadamInstance, field: "creator")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="eventPrasadam.dateCreated" default="Date Created" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${eventPrasadamInstance?.dateCreated}" /></td>
                                
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
