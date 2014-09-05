
<%@ page import="ics.Vehicle" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="vehicle.create" default="Create Vehicle" /></title>
	<r:require module="dateTimePicker" />
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list" controller="Trip">Trip List</g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="vehicle.create" default="Create Vehicle" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:hasErrors bean="${vehicleInstance}">
            <div class="errors">
                <g:renderErrors bean="${vehicleInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
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
                                    <label for="availableFrom"><g:message code="vehicle.availableFrom" default="Available From" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: vehicleInstance, field: 'availableFrom', 'errors')}">
                                    <g:textField name="availableFrom" value="${vehicleInstance?.availableFrom?.format('dd-MM-yyyy hh:mm a')}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="availableTill"><g:message code="vehicle.availableTill" default="Available Till" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: vehicleInstance, field: 'availableTill', 'errors')}">
                                    <g:textField name="availableTill" value="${vehicleInstance?.availableTill?.format('dd-MM-yyyy hh:mm a')}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="comments"><g:message code="vehicle.comments" default="Comments" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: vehicleInstance, field: 'comments', 'errors')}">
                                    <g:textArea rows="5" cols="50" name="comments" value="${fieldValue(bean: vehicleInstance, field: 'comments')}" />

                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'create', 'default': 'Create')}" /></span>
                </div>
            </g:form>
        </div>

		<script type="text/javascript">
		  $(document).ready(function () {

			$('#availableFrom').datetimepicker({dateFormat:'dd-mm-yy'});
			$('#availableTill').datetimepicker({dateFormat:'dd-mm-yy'});
			
			});
			
		</script>

    </body>
</html>
