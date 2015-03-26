<%@ page import="ics.CostCenterGroup" %>



<div class="fieldcontain ${hasErrors(bean: costCenterGroupInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="costCenterGroup.name.label" default="Name" />
		
	</label>
	<g:textField name="name" value="${fieldValue(bean: costCenterGroupInstance, field: 'name')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: costCenterGroupInstance, field: 'description', 'error')} ">
	<label for="description">
		<g:message code="costCenterGroup.description.label" default="Description" />
		
	</label>
	<g:textField name="description" value="${fieldValue(bean: costCenterGroupInstance, field: 'description')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: costCenterGroupInstance, field: 'owner', 'error')} ">
	<label for="owner">
		<g:message code="costCenterGroup.owner.label" default="Owner" />
		
	</label>
	<g:select name="owner.id" from="${ics.Individual.list()}" optionKey="id" value="${costCenterGroupInstance?.owner?.id}" noSelection="['null': '']" />

</div>

<div class="fieldcontain ${hasErrors(bean: costCenterGroupInstance, field: 'creator', 'error')} ">
	<label for="creator">
		<g:message code="costCenterGroup.creator.label" default="Creator" />
		
	</label>
	<g:textField name="creator" value="${fieldValue(bean: costCenterGroupInstance, field: 'creator')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: costCenterGroupInstance, field: 'updator', 'error')} ">
	<label for="updator">
		<g:message code="costCenterGroup.updator.label" default="Updator" />
		
	</label>
	<g:textField name="updator" value="${fieldValue(bean: costCenterGroupInstance, field: 'updator')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: costCenterGroupInstance, field: 'costCenters', 'error')} ">
	<label for="costCenters">
		<g:message code="costCenterGroup.costCenters.label" default="Cost Centers" />
		
	</label>
	
<ul>
<g:each in="${costCenterGroupInstance?.costCenters}" var="costCenterInstance">
    <li><g:link controller="costCenter" action="show" id="${costCenterInstance.id}">${costCenterInstance?.encodeAsHTML()}</g:link></li>
</g:each>
</ul>
<g:link controller="costCenter" params="['costCenterGroup.id': costCenterGroupInstance?.id]" action="create"><g:message code="costCenter.new" default="New CostCenter" /></g:link>


</div>

