
<%@ page import="ics.Sadhana" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="sadhana.show" default="Show Sadhana" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="sadhana.list" default="Sadhana List" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="sadhana.new" default="New Sadhana" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="sadhana.show" default="Show Sadhana" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:form>
                <g:hiddenField name="id" value="${sadhanaInstance?.id}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="sadhana.id" default="Id" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: sadhanaInstance, field: "id")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="sadhana.devotee" default="Devotee" />:</td>
                                
                                <td valign="top" class="value"><g:link controller="individual" action="show" id="${sadhanaInstance?.devotee?.id}">${sadhanaInstance?.devotee?.encodeAsHTML()}</g:link></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="sadhana.day" default="Day" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${sadhanaInstance?.day}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="sadhana.attendedMangalAratik" default="Attended Mangal Aratik" />:</td>
                                
                                <td valign="top" class="value"><g:formatBoolean boolean="${sadhanaInstance?.attendedMangalAratik}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="sadhana.numRoundsBefore9" default="Num Rounds Before9" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: sadhanaInstance, field: "numRoundsBefore9")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="sadhana.numRoundsBetween9And12" default="Num Rounds Between9 And12" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: sadhanaInstance, field: "numRoundsBetween9And12")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="sadhana.numRoundsBetween12And6" default="Num Rounds Between12 And6" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: sadhanaInstance, field: "numRoundsBetween12And6")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="sadhana.numRoundsBetween6And9" default="Num Rounds Between6 And9" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: sadhanaInstance, field: "numRoundsBetween6And9")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="sadhana.numRoundsAfter9" default="Num Rounds After9" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: sadhanaInstance, field: "numRoundsAfter9")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="sadhana.minutesRead" default="Minutes Read" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: sadhanaInstance, field: "minutesRead")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="sadhana.minutesHeard" default="Minutes Heard" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: sadhanaInstance, field: "minutesHeard")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="sadhana.minutesAssociated" default="Minutes Associated" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: sadhanaInstance, field: "minutesAssociated")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="sadhana.attendedSandhyaAratik" default="Attended Sandhya Aratik" />:</td>
                                
                                <td valign="top" class="value"><g:formatBoolean boolean="${sadhanaInstance?.attendedSandhyaAratik}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="sadhana.comments" default="Comments" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: sadhanaInstance, field: "comments")}</td>
                                
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
