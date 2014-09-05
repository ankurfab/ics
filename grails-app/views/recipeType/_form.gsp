<%@ page import="ics.RecipeType" %>



<div class="fieldcontain ${hasErrors(bean: recipeTypeInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="recipeType.name.label" default="Name" />
		
	</label>
	<g:textField name="name" value="${recipeTypeInstance?.name}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: recipeTypeInstance, field: 'creator', 'error')} ">
	<label for="creator">
		<g:message code="recipeType.creator.label" default="Creator" />
		
	</label>
	<g:textField name="creator" value="${recipeTypeInstance?.creator}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: recipeTypeInstance, field: 'updator', 'error')} ">
	<label for="updator">
		<g:message code="recipeType.updator.label" default="Updator" />
		
	</label>
	<g:textField name="updator" value="${recipeTypeInstance?.updator}"/>
</div>

