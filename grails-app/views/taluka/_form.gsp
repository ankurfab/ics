<%@ page import="ics.Taluka" %>



<div class="fieldcontain ${hasErrors(bean: talukaInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="taluka.name.label" default="Name" />
		
	</label>
	<g:textField name="name" value="${fieldValue(bean: talukaInstance, field: 'name')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: talukaInstance, field: 'district', 'error')} required">
	<label for="district">
		<g:message code="taluka.district.label" default="District" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="district.id" from="${ics.District.list()}" optionKey="id" value="${talukaInstance?.district?.id}"  />

</div>

<div class="fieldcontain ${hasErrors(bean: talukaInstance, field: 'villages', 'error')} ">
	<label for="villages">
		<g:message code="taluka.villages.label" default="Villages" />
		
	</label>
	
<ul>
<g:each in="${talukaInstance?.villages}" var="villageInstance">
    <li><g:link controller="village" action="show" id="${villageInstance.id}">${villageInstance?.encodeAsHTML()}</g:link></li>
</g:each>
</ul>
<g:link controller="village" params="['taluka.id': talukaInstance?.id]" action="create"><g:message code="village.new" default="New Village" /></g:link>


</div>

