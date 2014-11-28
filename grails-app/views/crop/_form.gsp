<%@ page import="ics.Crop" %>



<div class="fieldcontain ${hasErrors(bean: cropInstance, field: 'farmers', 'error')} ">
	<label for="farmers">
		<g:message code="crop.farmers.label" default="Farmers" />
		
	</label>
	
<ul>
<g:each in="${cropInstance?.farmers}" var="farmerCropInstance">
    <li><g:link controller="farmerCrop" action="show" id="${farmerCropInstance.id}">${farmerCropInstance?.encodeAsHTML()}</g:link></li>
</g:each>
</ul>
<g:link controller="farmerCrop" params="['crop.id': cropInstance?.id]" action="create"><g:message code="farmerCrop.new" default="New FarmerCrop" /></g:link>


</div>

<div class="fieldcontain ${hasErrors(bean: cropInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="crop.name.label" default="Name" />
		
	</label>
	<g:textField name="name" value="${fieldValue(bean: cropInstance, field: 'name')}" />

</div>

