<%@ page import="ics.Village" %>



<div class="fieldcontain ${hasErrors(bean: villageInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="village.name.label" default="Name" />
		
	</label>
	<g:textField name="name" value="${fieldValue(bean: villageInstance, field: 'name')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: villageInstance, field: 'taluka', 'error')} required">
	<label for="taluka">
		<g:message code="village.taluka.label" default="Taluka" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="taluka.id" from="${ics.Taluka.list()}" optionKey="id" value="${villageInstance?.taluka?.id}"  />

</div>

