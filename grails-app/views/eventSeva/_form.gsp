<%@ page import="ics.EventSeva" %>



<div class="fieldcontain ${hasErrors(bean: eventSevaInstance, field: 'comments', 'error')} ">
	<label for="comments">
		<g:message code="eventSeva.comments.label" default="Comments" />
		
	</label>
	<g:textField name="comments" value="${fieldValue(bean: eventSevaInstance, field: 'comments')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: eventSevaInstance, field: 'requiredFrom', 'error')} ">
	<label for="requiredFrom">
		<g:message code="eventSeva.requiredFrom.label" default="Required From" />
		
	</label>
	<g:datePicker name="requiredFrom" value="${eventSevaInstance?.requiredFrom}" noSelection="['': '']" />

</div>

<div class="fieldcontain ${hasErrors(bean: eventSevaInstance, field: 'requiredTill', 'error')} ">
	<label for="requiredTill">
		<g:message code="eventSeva.requiredTill.label" default="Required Till" />
		
	</label>
	<g:datePicker name="requiredTill" value="${eventSevaInstance?.requiredTill}" noSelection="['': '']" />

</div>

<div class="fieldcontain ${hasErrors(bean: eventSevaInstance, field: 'brahmachariAllotted', 'error')} required">
	<label for="brahmachariAllotted">
		<g:message code="eventSeva.brahmachariAllotted.label" default="Brahmachari Allotted" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="brahmachariAllotted" value="${fieldValue(bean: eventSevaInstance, field: 'brahmachariAllotted')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: eventSevaInstance, field: 'brahmachariOpted', 'error')} required">
	<label for="brahmachariOpted">
		<g:message code="eventSeva.brahmachariOpted.label" default="Brahmachari Opted" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="brahmachariOpted" value="${fieldValue(bean: eventSevaInstance, field: 'brahmachariOpted')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: eventSevaInstance, field: 'creator', 'error')} ">
	<label for="creator">
		<g:message code="eventSeva.creator.label" default="Creator" />
		
	</label>
	<g:textField name="creator" value="${fieldValue(bean: eventSevaInstance, field: 'creator')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: eventSevaInstance, field: 'event', 'error')} required">
	<label for="event">
		<g:message code="eventSeva.event.label" default="Event" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="event.id" from="${ics.Event.list()}" optionKey="id" value="${eventSevaInstance?.event?.id}"  />

</div>

<div class="fieldcontain ${hasErrors(bean: eventSevaInstance, field: 'inchargeContact', 'error')} ">
	<label for="inchargeContact">
		<g:message code="eventSeva.inchargeContact.label" default="Incharge Contact" />
		
	</label>
	<g:textField name="inchargeContact" value="${fieldValue(bean: eventSevaInstance, field: 'inchargeContact')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: eventSevaInstance, field: 'inchargeName', 'error')} ">
	<label for="inchargeName">
		<g:message code="eventSeva.inchargeName.label" default="Incharge Name" />
		
	</label>
	<g:textField name="inchargeName" value="${fieldValue(bean: eventSevaInstance, field: 'inchargeName')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: eventSevaInstance, field: 'matajiAllotted', 'error')} required">
	<label for="matajiAllotted">
		<g:message code="eventSeva.matajiAllotted.label" default="Mataji Allotted" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="matajiAllotted" value="${fieldValue(bean: eventSevaInstance, field: 'matajiAllotted')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: eventSevaInstance, field: 'matajiOpted', 'error')} required">
	<label for="matajiOpted">
		<g:message code="eventSeva.matajiOpted.label" default="Mataji Opted" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="matajiOpted" value="${fieldValue(bean: eventSevaInstance, field: 'matajiOpted')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: eventSevaInstance, field: 'maxBrahmachariRequired', 'error')} required">
	<label for="maxBrahmachariRequired">
		<g:message code="eventSeva.maxBrahmachariRequired.label" default="Max Brahmachari Required" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="maxBrahmachariRequired" value="${fieldValue(bean: eventSevaInstance, field: 'maxBrahmachariRequired')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: eventSevaInstance, field: 'maxMatajiRequired', 'error')} required">
	<label for="maxMatajiRequired">
		<g:message code="eventSeva.maxMatajiRequired.label" default="Max Mataji Required" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="maxMatajiRequired" value="${fieldValue(bean: eventSevaInstance, field: 'maxMatajiRequired')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: eventSevaInstance, field: 'maxPrjiRequired', 'error')} required">
	<label for="maxPrjiRequired">
		<g:message code="eventSeva.maxPrjiRequired.label" default="Max Prji Required" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="maxPrjiRequired" value="${fieldValue(bean: eventSevaInstance, field: 'maxPrjiRequired')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: eventSevaInstance, field: 'maxRequired', 'error')} required">
	<label for="maxRequired">
		<g:message code="eventSeva.maxRequired.label" default="Max Required" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="maxRequired" value="${fieldValue(bean: eventSevaInstance, field: 'maxRequired')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: eventSevaInstance, field: 'prjiAllotted', 'error')} required">
	<label for="prjiAllotted">
		<g:message code="eventSeva.prjiAllotted.label" default="Prji Allotted" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="prjiAllotted" value="${fieldValue(bean: eventSevaInstance, field: 'prjiAllotted')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: eventSevaInstance, field: 'prjiOpted', 'error')} required">
	<label for="prjiOpted">
		<g:message code="eventSeva.prjiOpted.label" default="Prji Opted" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="prjiOpted" value="${fieldValue(bean: eventSevaInstance, field: 'prjiOpted')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: eventSevaInstance, field: 'seva', 'error')} required">
	<label for="seva">
		<g:message code="eventSeva.seva.label" default="Seva" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="seva.id" from="${ics.Seva.list()}" optionKey="id" value="${eventSevaInstance?.seva?.id}"  />

</div>

<div class="fieldcontain ${hasErrors(bean: eventSevaInstance, field: 'totalAllotted', 'error')} required">
	<label for="totalAllotted">
		<g:message code="eventSeva.totalAllotted.label" default="Total Allotted" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="totalAllotted" value="${fieldValue(bean: eventSevaInstance, field: 'totalAllotted')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: eventSevaInstance, field: 'totalOpted', 'error')} required">
	<label for="totalOpted">
		<g:message code="eventSeva.totalOpted.label" default="Total Opted" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="totalOpted" value="${fieldValue(bean: eventSevaInstance, field: 'totalOpted')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: eventSevaInstance, field: 'updator', 'error')} ">
	<label for="updator">
		<g:message code="eventSeva.updator.label" default="Updator" />
		
	</label>
	<g:textField name="updator" value="${fieldValue(bean: eventSevaInstance, field: 'updator')}" />

</div>

