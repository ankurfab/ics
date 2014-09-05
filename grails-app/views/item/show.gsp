
<%@ page import="ics.Item" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="item.show" default="Show Item" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="item.list" default="Item List" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="item.new" default="New Item" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="item.show" default="Show Item" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:form>
                <g:hiddenField name="id" value="${itemInstance?.id}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="item.id" default="Id" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: itemInstance, field: "id")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="item.name" default="Name" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: itemInstance, field: "name")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="item.otherNames" default="Other Names" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: itemInstance, field: "otherNames")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="item.category" default="Category" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: itemInstance, field: "category")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="item.subcategory" default="SubCategory" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: itemInstance, field: "subcategory")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="item.variety" default="Variety" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: itemInstance, field: "variety")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="item.brand" default="Brand" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: itemInstance, field: "brand")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="item.densityFactor" default="Density Factor" />:</td>
                                
                                <td valign="top" class="value"><g:formatNumber number="${itemInstance?.densityFactor}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="nunitSize"><g:message code="item.nunitSize" default="Normalized Unit Size" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: itemInstance, field: 'nunitSize', 'errors')}">
                                    ${fieldValue(bean: itemInstance, field: 'nunitSize')}

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="nunit"><g:message code="item.nunit" default="Normalized Unit" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: itemInstance, field: 'nunit', 'errors')}">
                                    ${fieldValue(bean: itemInstance, field: 'nunit')}

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">Description:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: itemInstance, field: "comments")}</td>
                                
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">Image1:</td>
                                
                                <td valign="top" class="value"><img class="avatar" src="${createLink(controller:'item', action:'item_image', id:itemInstance?.id, params:['seq':1])}" /></td>
                                
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">Image2:</td>
                                
                                <td valign="top" class="value"><img class="avatar" src="${createLink(controller:'item', action:'item_image', id:itemInstance?.id, params:['seq':2])}" /></td>
                                
                            </tr>

                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="item.creator" default="Creator" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: itemInstance, field: "creator")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="item.dateCreated" default="Date Created" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${itemInstance?.dateCreated}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="item.updator" default="Updator" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: itemInstance, field: "updator")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="item.lastUpdated" default="Last Updated" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${itemInstance?.lastUpdated}" /></td>
                                
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
