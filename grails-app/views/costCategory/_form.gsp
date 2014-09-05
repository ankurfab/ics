<%@ page import="ics.CostCategory" %>



<div class="fieldcontain ${hasErrors(bean: costCategoryInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="costCategory.name.label" default="Name" />
		
	</label>
	<g:textField name="name" value="${fieldValue(bean: costCategoryInstance, field: 'name')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: costCategoryInstance, field: 'alias', 'error')} ">
	<label for="alias">
		<g:message code="costCategory.alias.label" default="Alias" />
		
	</label>
	<g:textField name="alias" value="${fieldValue(bean: costCategoryInstance, field: 'alias')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: costCategoryInstance, field: 'creator', 'error')} ">
	<label for="creator">
		<g:message code="costCategory.creator.label" default="Creator" />
		
	</label>
	<g:textField name="creator" value="${fieldValue(bean: costCategoryInstance, field: 'creator')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: costCategoryInstance, field: 'updator', 'error')} ">
	<label for="updator">
		<g:message code="costCategory.updator.label" default="Updator" />
		
	</label>
	<g:textField name="updator" value="${fieldValue(bean: costCategoryInstance, field: 'updator')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: costCategoryInstance, field: 'costCenters', 'error')} ">
	<label for="costCenters">
		<g:message code="costCategory.costCenters.label" default="Cost Centers" />
		
	</label>
	
<ul>
<g:each in="${costCategoryInstance?.costCenters}" var="costCenterInstance">
    <li><g:link controller="costCenter" action="show" id="${costCenterInstance.id}">${costCenterInstance?.encodeAsHTML()}</g:link></li>
</g:each>
</ul>
<g:link controller="costCenter" params="['costCategory.id': costCategoryInstance?.id]" action="create"><g:message code="costCenter.new" default="New CostCenter" /></g:link>


</div>

