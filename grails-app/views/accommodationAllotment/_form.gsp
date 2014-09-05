<%@ page import="ics.AccommodationAllotment" %>



<div class="fieldcontain ${hasErrors(bean: accommodationAllotmentInstance, field: 'regCode', 'error')} required">
	<label for="regCode">
		<g:message code="accommodationAllotment.regCode.label" default="Reg Code" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="regCode" value="${fieldValue(bean: accommodationAllotmentInstance, field: 'regCode')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: accommodationAllotmentInstance, field: 'eventAccomodation', 'error')} required">
	<label for="eventAccomodation">
		<g:message code="accommodationAllotment.eventAccomodation.label" default="Event Accomodation" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="eventAccomodation.id" from="${ics.EventAccomodation.list()}" optionKey="id" value="${accommodationAllotmentInstance?.eventAccomodation?.id}"  />

</div>

<div class="fieldcontain ${hasErrors(bean: accommodationAllotmentInstance, field: 'numberofPrabhujisAllotted', 'error')} required">
	<label for="numberofPrabhujisAllotted">
		<g:message code="accommodationAllotment.numberofPrabhujisAllotted.label" default="Numberof Prabhujis Allotted" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="numberofPrabhujisAllotted" value="${fieldValue(bean: accommodationAllotmentInstance, field: 'numberofPrabhujisAllotted')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: accommodationAllotmentInstance, field: 'numberofMatajisAllotted', 'error')} required">
	<label for="numberofMatajisAllotted">
		<g:message code="accommodationAllotment.numberofMatajisAllotted.label" default="Numberof Matajis Allotted" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="numberofMatajisAllotted" value="${fieldValue(bean: accommodationAllotmentInstance, field: 'numberofMatajisAllotted')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: accommodationAllotmentInstance, field: 'numberofChildrenAllotted', 'error')} required">
	<label for="numberofChildrenAllotted">
		<g:message code="accommodationAllotment.numberofChildrenAllotted.label" default="Numberof Children Allotted" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="numberofChildrenAllotted" value="${fieldValue(bean: accommodationAllotmentInstance, field: 'numberofChildrenAllotted')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: accommodationAllotmentInstance, field: 'creator', 'error')} ">
	<label for="creator">
		<g:message code="accommodationAllotment.creator.label" default="Creator" />
		
	</label>
	<g:textField name="creator" value="${fieldValue(bean: accommodationAllotmentInstance, field: 'creator')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: accommodationAllotmentInstance, field: 'updator', 'error')} ">
	<label for="updator">
		<g:message code="accommodationAllotment.updator.label" default="Updator" />
		
	</label>
	<g:textField name="updator" value="${fieldValue(bean: accommodationAllotmentInstance, field: 'updator')}" />

</div>

