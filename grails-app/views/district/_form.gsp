<%@ page import="ics.District" %>



<div class="fieldcontain ${hasErrors(bean: districtInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="district.name.label" default="Name" />
		
	</label>
	<g:textField name="name" value="${fieldValue(bean: districtInstance, field: 'name')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: districtInstance, field: 'talukas', 'error')} ">
	<label for="talukas">
		<g:message code="district.talukas.label" default="Talukas" />
		
	</label>
	
<ul>
<g:each in="${districtInstance?.talukas}" var="talukaInstance">
    <li><g:link controller="taluka" action="show" id="${talukaInstance.id}">${talukaInstance?.encodeAsHTML()}</g:link></li>
</g:each>
</ul>
<g:link controller="taluka" params="['district.id': districtInstance?.id]" action="create"><g:message code="taluka.new" default="New Taluka" /></g:link>


</div>

