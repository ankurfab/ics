<%@ page import="ics.Vehicle" %>



<div class="fieldcontain ${hasErrors(bean: vehicleInstance, field: 'regNum', 'error')} ">
	<label for="regNum">
		<g:message code="vehicle.regNum.label" default="Reg Num" />
		
	</label>
	<g:textField name="regNum" value="${fieldValue(bean: vehicleInstance, field: 'regNum')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: vehicleInstance, field: 'model', 'error')} ">
	<label for="model">
		<g:message code="vehicle.model.label" default="Model" />
		
	</label>
	<g:textField name="model" value="${fieldValue(bean: vehicleInstance, field: 'model')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: vehicleInstance, field: 'make', 'error')} ">
	<label for="make">
		<g:message code="vehicle.make.label" default="Make" />
		
	</label>
	<g:textField name="make" value="${fieldValue(bean: vehicleInstance, field: 'make')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: vehicleInstance, field: 'numCapacity', 'error')} required">
	<label for="numCapacity">
		<g:message code="vehicle.numCapacity.label" default="Num Capacity" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="numCapacity" value="${fieldValue(bean: vehicleInstance, field: 'numCapacity')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: vehicleInstance, field: 'comments', 'error')} ">
	<label for="comments">
		<g:message code="vehicle.comments.label" default="Comments" />
		
	</label>
	<g:textField name="comments" value="${fieldValue(bean: vehicleInstance, field: 'comments')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: vehicleInstance, field: 'status', 'error')} ">
	<label for="status">
		<g:message code="vehicle.status.label" default="Status" />
		
	</label>
	<g:textField name="status" value="${fieldValue(bean: vehicleInstance, field: 'status')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: vehicleInstance, field: 'availableFrom', 'error')} required">
	<label for="availableFrom">
		<g:message code="vehicle.availableFrom.label" default="Available From" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="availableFrom" value="${vehicleInstance?.availableFrom}"  />

</div>

<div class="fieldcontain ${hasErrors(bean: vehicleInstance, field: 'availableTill', 'error')} required">
	<label for="availableTill">
		<g:message code="vehicle.availableTill.label" default="Available Till" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="availableTill" value="${vehicleInstance?.availableTill}"  />

</div>

