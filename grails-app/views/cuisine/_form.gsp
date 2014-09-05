<%@ page import="ics.Cuisine" %>



<div class="fieldcontain ${hasErrors(bean: cuisineInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="cuisine.name.label" default="Name" />
		
	</label>
	<g:textField name="name" value="${cuisineInstance?.name}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: cuisineInstance, field: 'recipe', 'error')} ">
	<label for="recipe">
		<g:message code="cuisine.recipe.label" default="Recipe" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${cuisineInstance?.recipe?}" var="r">
    <li><g:link controller="recipe" action="show" id="${r.id}">${r?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="recipe" action="create" params="['cuisine.id': cuisineInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'recipe.label', default: 'Recipe')])}</g:link>
</li>
</ul>

</div>

<div class="fieldcontain ${hasErrors(bean: cuisineInstance, field: 'creator', 'error')} ">
	<label for="creator">
		<g:message code="cuisine.creator.label" default="Creator" />
		
	</label>
	<g:textField name="creator" value="${cuisineInstance?.creator}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: cuisineInstance, field: 'updator', 'error')} ">
	<label for="updator">
		<g:message code="cuisine.updator.label" default="Updator" />
		
	</label>
	<g:textField name="updator" value="${cuisineInstance?.updator}"/>
</div>

