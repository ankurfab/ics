<%@ page import="ics.CostCenterGroup" %>
<div class="allbody"> 
<g:hiddenField name="id" value="${costCenterGroupInstance?.id}" />
<g:hiddenField name="version" value="${costCenterGroupInstance?.version}" />

<fieldset class="form">
<div class="fieldcontain ${hasErrors(bean: costCenterInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="costCenter.name.label" default="Name" />
		
	</label>
	<g:textField name="name" value="${costCenterInstance?.name}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: costCenterInstance, field: 'alias', 'error')} ">
	<label for="alias">
		<g:message code="costCenter.alias.label" default="Alias" />
		
	</label>
	<g:textField name="alias" value="${costCenterInstance?.alias}"/>
</div>

</fieldset>

</div>