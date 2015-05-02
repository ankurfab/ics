
<%@ page import="ics.Crop" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="crop.edit" default="Edit Crop" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="crop.list" default="Crop List" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="crop.new" default="New Crop" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="crop.edit" default="Edit Crop" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:hasErrors bean="${cropInstance}">
            <div class="errors">
                <g:renderErrors bean="${cropInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${cropInstance?.id}" />
                <g:hiddenField name="version" value="${cropInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="farmers"><g:message code="crop.farmers" default="Farmers" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: cropInstance, field: 'farmers', 'errors')}">
                                    
<ul>
<g:each in="${cropInstance?.farmers}" var="farmerCropInstance">
    <li><g:link controller="farmerCrop" action="show" id="${farmerCropInstance.id}">${farmerCropInstance?.encodeAsHTML()}</g:link></li>
</g:each>
</ul>
<g:link controller="farmerCrop" params="['crop.id': cropInstance?.id]" action="create"><g:message code="farmerCrop.new" default="New FarmerCrop" /></g:link>


                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="name"><g:message code="crop.name" default="Name" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: cropInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" value="${fieldValue(bean: cropInstance, field: 'name')}" />

                                </td>
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
