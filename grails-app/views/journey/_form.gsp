<%@ page import="ics.Journey" %>



<div class="fieldcontain ${hasErrors(bean: journeyInstance, field: 'arrival', 'error')} ">
	<label for="arrival">
		<g:message code="journey.arrival.label" default="Arrival" />
		
	</label>
	<g:checkBox name="arrival" value="${journeyInstance?.arrival}" />
</div>

<div class="fieldcontain ${hasErrors(bean: journeyInstance, field: 'creator', 'error')} ">
	<label for="creator">
		<g:message code="journey.creator.label" default="Creator" />
		
	</label>
	<g:textField name="creator" value="${journeyInstance?.creator}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: journeyInstance, field: 'eventRegistration', 'error')} required">
	<label for="eventRegistration">
		<g:message code="journey.eventRegistration.label" default="Event Registration" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="eventRegistration" name="eventRegistration.id" from="${ics.EventRegistration.list()}" optionKey="id" required="" value="${journeyInstance?.eventRegistration?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: journeyInstance, field: 'location', 'error')} ">
	<label for="location">
		<g:message code="journey.location.label" default="Location" />
		
	</label>
	<g:textField name="location" value="${journeyInstance?.location}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: journeyInstance, field: 'mode', 'error')} ">
	<label for="mode">
		<g:message code="journey.mode.label" default="Mode" />
		
	</label>
	<g:textField name="mode" value="${journeyInstance?.mode}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: journeyInstance, field: 'modeComments', 'error')} ">
	<label for="modeComments">
		<g:message code="journey.modeComments.label" default="Mode Comments" />
		
	</label>
	<g:textField name="modeComments" value="${journeyInstance?.modeComments}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: journeyInstance, field: 'modeDateTime', 'error')} required">
	<label for="modeDateTime">
		<g:message code="journey.modeDateTime.label" default="Mode Date Time" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="modeDateTime" precision="day"  value="${journeyInstance?.modeDateTime}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: journeyInstance, field: 'modeDetail', 'error')} ">
	<label for="modeDetail">
		<g:message code="journey.modeDetail.label" default="Mode Detail" />
		
	</label>
	<g:textField name="modeDetail" value="${journeyInstance?.modeDetail}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: journeyInstance, field: 'numChildGuest', 'error')} required">
	<label for="numChildGuest">
		<g:message code="journey.numChildGuest.label" default="Num Child Guest" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="numChildGuest" required="" value="${fieldValue(bean: journeyInstance, field: 'numChildGuest')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: journeyInstance, field: 'numChildPrasadam', 'error')} required">
	<label for="numChildPrasadam">
		<g:message code="journey.numChildPrasadam.label" default="Num Child Prasadam" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="numChildPrasadam" required="" value="${fieldValue(bean: journeyInstance, field: 'numChildPrasadam')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: journeyInstance, field: 'numMatajiGuest', 'error')} required">
	<label for="numMatajiGuest">
		<g:message code="journey.numMatajiGuest.label" default="Num Mataji Guest" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="numMatajiGuest" required="" value="${fieldValue(bean: journeyInstance, field: 'numMatajiGuest')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: journeyInstance, field: 'numMatajiPrasadam', 'error')} required">
	<label for="numMatajiPrasadam">
		<g:message code="journey.numMatajiPrasadam.label" default="Num Mataji Prasadam" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="numMatajiPrasadam" required="" value="${fieldValue(bean: journeyInstance, field: 'numMatajiPrasadam')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: journeyInstance, field: 'numPrjiGuest', 'error')} required">
	<label for="numPrjiGuest">
		<g:message code="journey.numPrjiGuest.label" default="Num Prji Guest" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="numPrjiGuest" required="" value="${fieldValue(bean: journeyInstance, field: 'numPrjiGuest')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: journeyInstance, field: 'numPrjiPrasadam', 'error')} required">
	<label for="numPrjiPrasadam">
		<g:message code="journey.numPrjiPrasadam.label" default="Num Prji Prasadam" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="numPrjiPrasadam" required="" value="${fieldValue(bean: journeyInstance, field: 'numPrjiPrasadam')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: journeyInstance, field: 'updator', 'error')} ">
	<label for="updator">
		<g:message code="journey.updator.label" default="Updator" />
		
	</label>
	<g:textField name="updator" value="${journeyInstance?.updator}"/>
</div>

