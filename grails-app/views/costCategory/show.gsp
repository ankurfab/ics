
<%@ page import="ics.CostCategory" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="costCategory.show" default="Show CostCategory" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="costCategory.list" default="CostCategory List" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="costCategory.new" default="New CostCategory" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="costCategory.show" default="Show CostCategory" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:form>
                <g:hiddenField name="id" value="${costCategoryInstance?.id}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="costCategory.id" default="Id" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: costCategoryInstance, field: "id")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="costCategory.name" default="Name" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: costCategoryInstance, field: "name")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="costCategory.alias" default="Alias" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: costCategoryInstance, field: "alias")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="costCategory.owner" default="Owner" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: costCategoryInstance, field: "owner")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="costCategory.dateCreated" default="Date Created" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${costCategoryInstance?.dateCreated}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="costCategory.creator" default="Creator" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: costCategoryInstance, field: "creator")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="costCategory.lastUpdated" default="Last Updated" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${costCategoryInstance?.lastUpdated}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="costCategory.updator" default="Updator" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: costCategoryInstance, field: "updator")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="costCategory.costCenters" default="Cost Centers" />:</td>
                                
                                <td  valign="top" style="text-align: left;" class="value">
                                    <ul>
                                    <g:each in="${ics.CostCenter.findAllByCostCategoryAndStatusIsNull(costCategoryInstance,[sort:'name'])}" var="costCenterInstance">
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
