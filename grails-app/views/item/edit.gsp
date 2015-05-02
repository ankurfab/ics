
<%@ page import="ics.Item" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="item.edit" default="Edit Item" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="item.list" default="Item List" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="item.new" default="New Item" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="item.edit" default="Edit Item" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:hasErrors bean="${itemInstance}">
            <div class="errors">
                <g:renderErrors bean="${itemInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post"  enctype="multipart/form-data">
                <g:hiddenField name="id" value="${itemInstance?.id}" />
                <g:hiddenField name="version" value="${itemInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="name"><g:message code="item.name" default="Name" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: itemInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" value="${fieldValue(bean: itemInstance, field: 'name')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="otherNames"><g:message code="item.otherNames" default="Other Names" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: itemInstance, field: 'otherNames', 'errors')}">
                                    <g:textField name="otherNames" value="${fieldValue(bean: itemInstance, field: 'otherNames')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="category"><g:message code="item.category" default="Category" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: itemInstance, field: 'category', 'errors')}">
                                    <g:textField name="category" value="${fieldValue(bean: itemInstance, field: 'category')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="subcategory"><g:message code="item.subcategory" default="SubCategory" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: itemInstance, field: 'subcategory', 'errors')}">
                                    <g:textField name="subcategory" value="${fieldValue(bean: itemInstance, field: 'subcategory')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="variety"><g:message code="item.variety" default="Variety" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: itemInstance, field: 'variety', 'errors')}">
                                    <g:textField name="variety" value="${fieldValue(bean: itemInstance, field: 'variety')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="brand"><g:message code="item.brand" default="Brand" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: itemInstance, field: 'brand', 'errors')}">
                                    <g:textField name="brand" value="${fieldValue(bean: itemInstance, field: 'brand')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="densityFactor"><g:message code="item.densityFactor" default="Density Factor" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: itemInstance, field: 'densityFactor', 'errors')}">
                                    <g:textField name="densityFactor" value="${fieldValue(bean: itemInstance, field: 'densityFactor')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">Rate:</td>
                                
                                <td><g:textField name="rate" value="${fieldValue(bean: itemInstance, field: 'rate')}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name">TaxRate:</td>
                                
                                <td><g:textField name="taxRate" value="${fieldValue(bean: itemInstance, field: 'taxRate')}" /></td>
                                
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="nunitSize"><g:message code="item.nunitSize" default="Normalized Unit Size" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: itemInstance, field: 'nunitSize', 'errors')}">
                                    <g:textField name="nunitSize" value="${fieldValue(bean: itemInstance, field: 'nunitSize')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="nunit"><g:message code="item.nunit" default="Normalized Unit" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: itemInstance, field: 'nunit', 'errors')}">
                                    <g:select name="nunit" from="${ics.Unit?.values()}" value="${fieldValue(bean: itemInstance, field: 'nunit')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="comments">Description:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: itemInstance, field: 'comments', 'errors')}">
                                    <g:textArea name="comments" value="${fieldValue(bean: itemInstance, field: 'comments')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">Image1:</td>
                                
                                <td valign="top" class="value">
                                <img class="avatar" src="${createLink(controller:'item', action:'item_image', id:itemInstance?.id, params:['seq':1])}" />
                                <input type="file" name="image1" id="image1" /></td>
                                
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">Image2:</td>
                                
                                <td valign="top" class="value">
				<img class="avatar" src="${createLink(controller:'item', action:'item_image', id:itemInstance?.id, params:['seq':2])}" />                                
                                <input type="file" name="image2" id="image2" /></td>
                                
                            </tr>

                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'update', 'default': 'Update')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'delete', 'default': 'Delete')}" onclick="return confirm('${message(code: 'delete.confirm', 'default': 'Are you sure?')}');" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
