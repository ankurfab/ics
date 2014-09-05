<%@ page import="ics.Trip" %>



<div class="fieldcontain ${hasErrors(bean: tripInstance, field: 'vehicle', 'error')} required">
	<label for="vehicle">
		<g:message code="trip.vehicle.label" default="Vehicle" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="vehicle.id" from="${ics.Vehicle.list()}" optionKey="id" value="${tripInstance?.vehicle?.id}"  />

</div>

<div class="fieldcontain ${hasErrors(bean: tripInstance, field: 'source', 'error')} ">
	<label for="source">
		<g:message code="trip.source.label" default="Source" />
		
	</label>
	<g:textField name="source" value="${fieldValue(bean: tripInstance, field: 'source')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: tripInstance, field: 'destination', 'error')} ">
	<label for="destination">
		<g:message code="trip.destination.label" default="Destination" />
		
	</label>
	<g:textField name="destination" value="${fieldValue(bean: tripInstance, field: 'destination')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: tripInstance, field: 'departureTime', 'error')} required">
	<label for="departureTime">
		<g:message code="trip.departureTime.label" default="Departure Time" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="departureTime" value="${tripInstance?.departureTime}"  />

</div>

<div class="fieldcontain ${hasErrors(bean: tripInstance, field: 'arrivalTime', 'error')} ">
	<label for="arrivalTime">
		<g:message code="trip.arrivalTime.label" default="Arrival Time" />
		
	</label>
	<g:datePicker name="arrivalTime" value="${tripInstance?.arrivalTime}" noSelection="['': '']" />

</div>

<div class="fieldcontain ${hasErrors(bean: tripInstance, field: 'driverName', 'error')} ">
	<label for="driverName">
		<g:message code="trip.driverName.label" default="Driver Name" />
		
	</label>
	<g:textField name="driverName" value="${fieldValue(bean: tripInstance, field: 'driverName')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: tripInstance, field: 'driverNumber', 'error')} ">
	<label for="driverNumber">
		<g:message code="trip.driverNumber.label" default="Driver Number" />
		
	</label>
	<g:textField name="driverNumber" value="${fieldValue(bean: tripInstance, field: 'driverNumber')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: tripInstance, field: 'comments', 'error')} ">
	<label for="comments">
		<g:message code="trip.comments.label" default="Comments" />
		
	</label>
	<g:textField name="comments" value="${fieldValue(bean: tripInstance, field: 'comments')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: tripInstance, field: 'status', 'error')} ">
	<label for="status">
		<g:message code="trip.status.label" default="Status" />
		
	</label>
	<g:textField name="status" value="${fieldValue(bean: tripInstance, field: 'status')}" />

</div>

