<%@ page import="ics.RecipeVersion" %>



<div class="fieldcontain ${hasErrors(bean: recipeVersionInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="recipeVersion.name.label" default="Name" />
		
	</label>
	<g:textField name="name" value="${recipeVersionInstance?.name}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: recipeVersionInstance, field: 'rating', 'error')} ">
	<label for="rating">
		<g:message code="recipeVersion.rating.label" default="Rating" />
		
	</label>
	<g:select name="rating" from="${ics.Rating?.values()}" keys="${ics.Rating.values()*.name()}" value="${recipeVersionInstance?.rating?.name()}" noSelection="['': '']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: recipeVersionInstance, field: 'feedback', 'error')} ">
	<label for="feedback">
		<g:message code="recipeVersion.feedback.label" default="Feedback" />
		
	</label>
	<g:textField name="feedback" value="${recipeVersionInstance?.feedback}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: recipeVersionInstance, field: 'chef', 'error')} required">
	<label for="chef">
		<g:message code="recipeVersion.chef.label" default="Chef" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="chef" name="chef.id" from="${ics.Person.list()}" optionKey="id" required="" value="${recipeVersionInstance?.chef?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: recipeVersionInstance, field: 'recipeStatus', 'error')} required">
	<label for="recipeStatus">
		<g:message code="recipeVersion.recipeStatus.label" default="Recipe Status" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="recipeStatus" from="${ics.RecipeStatus?.values()}" keys="${ics.RecipeStatus.values()*.name()}" required="" value="${recipeVersionInstance?.recipeStatus?.name()}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: recipeVersionInstance, field: 'serves', 'error')} ">
	<label for="serves">
		<g:message code="recipeVersion.serves.label" default="Serves" />
		
	</label>
	<g:select name="serves" from="${ics.PersonCount.list()}" multiple="multiple" optionKey="id" size="5" value="${recipeVersionInstance?.serves*.id}" class="many-to-many"/>
</div>

<div class="fieldcontain ${hasErrors(bean: recipeVersionInstance, field: 'yield', 'error')} ">
	<label for="yield">
		<g:message code="recipeVersion.yield.label" default="Yield" />
		
	</label>
	
</div>

<div class="fieldcontain ${hasErrors(bean: recipeVersionInstance, field: 'yieldUnit', 'error')} ">
	<label for="yieldUnit">
		<g:message code="recipeVersion.yieldUnit.label" default="Yield Unit" />
		
	</label>
	
</div>

<div class="fieldcontain ${hasErrors(bean: recipeVersionInstance, field: 'comments', 'error')} ">
	<label for="comments">
		<g:message code="recipeVersion.comments.label" default="Comments" />
		
	</label>
	<g:textField name="comments" value="${recipeVersionInstance?.comments}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: recipeVersionInstance, field: 'creator', 'error')} ">
	<label for="creator">
		<g:message code="recipeVersion.creator.label" default="Creator" />
		
	</label>
	<g:textField name="creator" value="${recipeVersionInstance?.creator}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: recipeVersionInstance, field: 'updator', 'error')} ">
	<label for="updator">
		<g:message code="recipeVersion.updator.label" default="Updator" />
		
	</label>
	<g:textField name="updator" value="${recipeVersionInstance?.updator}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: recipeVersionInstance, field: 'instructionGroup', 'error')} ">
	<label for="instructionGroup">
		<g:message code="recipeVersion.instructionGroup.label" default="Instruction Group" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${recipeVersionInstance?.instructionGroup?}" var="i">
    <li><g:link controller="instructionGroup" action="show" id="${i.id}">${i?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="instructionGroup" action="create" params="['recipeVersion.id': recipeVersionInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'instructionGroup.label', default: 'InstructionGroup')])}</g:link>
</li>
</ul>

</div>

<div class="fieldcontain ${hasErrors(bean: recipeVersionInstance, field: 'recipe', 'error')} required">
	<label for="recipe">
		<g:message code="recipeVersion.recipe.label" default="Recipe" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="recipe" name="recipe.id" from="${ics.Recipe.list()}" optionKey="id" required="" value="${recipeVersionInstance?.recipe?.id}" class="many-to-one"/>
</div>

