<%@ page import="ics.Sadhana" %>



<div class="fieldcontain ${hasErrors(bean: sadhanaInstance, field: 'devotee', 'error')} required">
	<label for="devotee">
		<g:message code="sadhana.devotee.label" default="Devotee" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="devotee.id" from="${ics.Individual.list()}" optionKey="id" value="${sadhanaInstance?.devotee?.id}"  />

</div>

<div class="fieldcontain ${hasErrors(bean: sadhanaInstance, field: 'day', 'error')} required">
	<label for="day">
		<g:message code="sadhana.day.label" default="Day" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="day" value="${sadhanaInstance?.day}"  />

</div>

<div class="fieldcontain ${hasErrors(bean: sadhanaInstance, field: 'attendedMangalAratik', 'error')} ">
	<label for="attendedMangalAratik">
		<g:message code="sadhana.attendedMangalAratik.label" default="Attended Mangal Aratik" />
		
	</label>
	<g:checkBox name="attendedMangalAratik" value="${sadhanaInstance?.attendedMangalAratik}" />

</div>

<div class="fieldcontain ${hasErrors(bean: sadhanaInstance, field: 'numRoundsBefore9', 'error')} ">
	<label for="numRoundsBefore9">
		<g:message code="sadhana.numRoundsBefore9.label" default="Num Rounds Before9" />
		
	</label>
	<g:textField name="numRoundsBefore9" value="${fieldValue(bean: sadhanaInstance, field: 'numRoundsBefore9')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: sadhanaInstance, field: 'numRoundsBetween9And12', 'error')} ">
	<label for="numRoundsBetween9And12">
		<g:message code="sadhana.numRoundsBetween9And12.label" default="Num Rounds Between9 And12" />
		
	</label>
	<g:textField name="numRoundsBetween9And12" value="${fieldValue(bean: sadhanaInstance, field: 'numRoundsBetween9And12')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: sadhanaInstance, field: 'numRoundsBetween12And6', 'error')} ">
	<label for="numRoundsBetween12And6">
		<g:message code="sadhana.numRoundsBetween12And6.label" default="Num Rounds Between12 And6" />
		
	</label>
	<g:textField name="numRoundsBetween12And6" value="${fieldValue(bean: sadhanaInstance, field: 'numRoundsBetween12And6')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: sadhanaInstance, field: 'numRoundsBetween6And9', 'error')} ">
	<label for="numRoundsBetween6And9">
		<g:message code="sadhana.numRoundsBetween6And9.label" default="Num Rounds Between6 And9" />
		
	</label>
	<g:textField name="numRoundsBetween6And9" value="${fieldValue(bean: sadhanaInstance, field: 'numRoundsBetween6And9')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: sadhanaInstance, field: 'numRoundsAfter9', 'error')} ">
	<label for="numRoundsAfter9">
		<g:message code="sadhana.numRoundsAfter9.label" default="Num Rounds After9" />
		
	</label>
	<g:textField name="numRoundsAfter9" value="${fieldValue(bean: sadhanaInstance, field: 'numRoundsAfter9')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: sadhanaInstance, field: 'minutesRead', 'error')} ">
	<label for="minutesRead">
		<g:message code="sadhana.minutesRead.label" default="Minutes Read" />
		
	</label>
	<g:textField name="minutesRead" value="${fieldValue(bean: sadhanaInstance, field: 'minutesRead')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: sadhanaInstance, field: 'minutesHeard', 'error')} ">
	<label for="minutesHeard">
		<g:message code="sadhana.minutesHeard.label" default="Minutes Heard" />
		
	</label>
	<g:textField name="minutesHeard" value="${fieldValue(bean: sadhanaInstance, field: 'minutesHeard')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: sadhanaInstance, field: 'minutesAssociated', 'error')} ">
	<label for="minutesAssociated">
		<g:message code="sadhana.minutesAssociated.label" default="Minutes Associated" />
		
	</label>
	<g:textField name="minutesAssociated" value="${fieldValue(bean: sadhanaInstance, field: 'minutesAssociated')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: sadhanaInstance, field: 'attendedSandhyaAratik', 'error')} ">
	<label for="attendedSandhyaAratik">
		<g:message code="sadhana.attendedSandhyaAratik.label" default="Attended Sandhya Aratik" />
		
	</label>
	<g:checkBox name="attendedSandhyaAratik" value="${sadhanaInstance?.attendedSandhyaAratik}" />

</div>

<div class="fieldcontain ${hasErrors(bean: sadhanaInstance, field: 'comments', 'error')} ">
	<label for="comments">
		<g:message code="sadhana.comments.label" default="Comments" />
		
	</label>
	<g:textField name="comments" value="${fieldValue(bean: sadhanaInstance, field: 'comments')}" />

</div>

