
<%@ page import="ics.Vehicle" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="vehicle.edit" default="Edit Vehicle" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="vehicle.list" default="Vehicle List" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="vehicle.new" default="New Vehicle" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="vehicle.edit" default="Edit Vehicle" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:hasErrors bean="${vehicleInstance}">
            <div class="errors">
                <g:renderErrors bean="${vehicleInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${vehicleInstance?.id}" />
                <g:hiddenField name="version" value="${vehicleInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="regNum"><g:message code="vehicle.regNum" default="Reg Num" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: vehicleInstance, field: 'regNum', 'errors')}">
                                    <g:textField name="regNum" value="${fieldValue(bean: vehicleInstance, field: 'regNum')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="model"><g:message code="vehicle.model" default="Model" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: vehicleInstance, field: 'model', 'errors')}">
                                    <g:textField name="model" value="${fieldValue(bean: vehicleInstance, field: 'model')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="make"><g:message code="vehicle.make" default="Make" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: vehicleInstance, field: 'make', 'errors')}">
                                    <g:textField name="make" value="${fieldValue(bean: vehicleInstance, field: 'make')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="numCapacity"><g:message code="vehicle.numCapacity" default="Num Capacity" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: vehicleInstance, field: 'numCapacity', 'errors')}">
                                    <g:textField name="numCapacity" value="${fieldValue(bean: vehicleInstance, field: 'numCapacity')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="comments"><g:message code="vehicle.comments" default="Comments" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: vehicleInstance, field: 'comments', 'errors')}">
                                    <g:textField name="comments" value="${fieldValue(bean: vehicleInstance, field: 'comments')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="status"><g:message code="vehicle.status" default="Status" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: vehicleInstance, field: 'status', 'errors')}">
                                    <g:textField name="status" value="${fieldValue(bean: vehicleInstance, field: 'status')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="availableFrom"><g:message code="vehicle.availableFrom" default="Available From" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: vehicleInstance, field: 'availableFrom', 'errors')}">
                                    <g:datePicker name="availableFrom" value="${vehicleInstance?.availableFrom}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="availableTill"><g:message code="vehicle.availableTill" default="Available Till" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: vehicleInstance, field: 'availableTill', 'errors')}">
                                    <g:datePicker name="availableTill" value="${vehicleInstance?.availableTill}"  />

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
