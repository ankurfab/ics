
<%@ page import="ics.CostCenterGroup" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="costCenterGroup.show" default="Show CostCenterGroup" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="costCenterGroup.list" default="CostCenterGroup List" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="costCenterGroup.new" default="New CostCenterGroup" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="costCenterGroup.show" default="Show CostCenterGroup" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:form>
                <g:hiddenField name="id" value="${costCenterGroupInstance?.id}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="costCenterGroup.id" default="Id" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: costCenterGroupInstance, field: "id")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="costCenterGroup.name" default="Name" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: costCenterGroupInstance, field: "name")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="costCenterGroup.description" default="Description" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: costCenterGroupInstance, field: "description")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="costCenterGroup.owner" default="Owner" />:</td>
                                
                                <td valign="top" class="value"><g:link controller="individual" action="show" id="${costCenterGroupInstance?.owner?.id}">${costCenterGroupInstance?.owner?.encodeAsHTML()}</g:link></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="costCenterGroup.dateCreated" default="Date Created" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${costCenterGroupInstance?.dateCreated}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="costCenterGroup.creator" default="Creator" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: costCenterGroupInstance, field: "creator")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="costCenterGroup.lastUpdated" default="Last Updated" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${costCenterGroupInstance?.lastUpdated}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="costCenterGroup.updator" default="Updator" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: costCenterGroupInstance, field: "updator")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="costCenterGroup.costCenters" default="Cost Centers" />:</td>
                                
                                <td  valign="top" style="text-align: left;" class="value">
                                    <ul>
                                    <g:each in="${costCenterGroupInstance?.costCenters}" var="costCenterInstance">
                                        <li><g:link controller="costCenter" action="show" id="${costCenterInstance.id}">${costCenterInstance.encodeAsHTML()}</g:link></li>
                                    </g:each>
                                    </ul>
                                </td>
                                
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
