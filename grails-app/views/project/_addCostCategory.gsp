<%@ page import="ics.CostCategory" %>
<div class="allbody">

<g:hiddenField name="id" value="${costCategoryInstance?.id}" />
<g:hiddenField name="version" value="${costCategoryInstance?.version}" />
<fieldset class="form">

<div class="fieldcontain ${hasErrors(bean: costCategoryInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="costCategory.name.label" default="Name" />
		
	</label>
	<g:textField name="name" value="${costCategoryInstance?.name}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: costCategoryInstance, field: 'alias', 'error')} ">
	<label for="alias">
		<g:message code="costCategory.alias.label" default="Alias" />
		
	</label>
	<g:textField name="alias" value="${costCategoryInstance?.alias}"/>
</div>

</fieldset>

</div>

   
