<%@ page import="ics.Recipe" %>
<%@ page import="ics.RecipeVersion" %>

<table>

<tr><td>

<div class="fieldcontain ${hasErrors(bean: recipeInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="recipe.name.label" default="Name*" />		
	</label>
	<br/><g:textField name="name" value="${recipeInstance?.name}"/>
</div>

</td><td>

<!--<div class="fieldcontain ${hasErrors(bean: recipeInstance, field: 'category', 'error')} ">
	<label for="category">
		<g:message code="recipe.category.label" default="Category*" />		
	</label>
	<g:textField name="category" value="${recipeInstance?.category}"/>
</div>-->

<div class="fieldcontain ${hasErrors(bean: recipeInstance, field: 'category', 'error')} ">
	<label for="category">
		<g:message code="recipe.category.label" default="Category" />		
	</label>
	
	<g:if test="${list == recipeInstance?.category?.toList()}">
		<br/><g:select name="category" from="${ics.Category.list()}" multiple="true" optionKey="id" size="5" value="${recipeInstance?.category*.id}" class="many-to-many"/> 	     
	</g:if>
	<g:else>		
	        <br/><g:select name="category" from="${recipeInstance?.category?.toList() +  ics.Category.list()}" multiple="true" optionKey="id" size="${recipeInstance?.category?.id.size()}" value="${recipeInstance?.category*.id}" class="many-to-many"/> 	
	</g:else>	
</div>

</td> <td>

<div class="fieldcontain ${hasErrors(bean: recipeInstance, field: 'cuisine', 'error')} ">
	<label for="cuisine">
		<g:message code="recipe.cuisine.label" default="Cuisine" />
		
	</label>
        <g:hiddenField name="cuisineid" value=""/>
	`<br/><g:textField id="cuisineACBox" name="cuisine" value="${recipeInstance?.cuisine}"/>
</div>

</td><td>

<div class="fieldcontain ${hasErrors(bean: recipeInstance, field: 'rating', 'error')} required">
	<label for="rating">
		<g:message code="recipe.rating.label" default="Rating" />
		<!--<span class="required-indicator">*</span>-->
	</label>
	<g:if test="${list == recipeInstance?.rating}">
		<br/><g:select name="rating" from="${ics.Rating?.values()}" keys="${ics.Rating.values()*.name()}" required="" value="${recipeInstance?.rating}"/>
	</g:if>
	<g:else>
		<br/><g:select name="rating" from="${recipeInstance?.rating}" keys="${ics.Rating.values()*.name()}" required="" value="${recipeInstance?.rating}"/>
	</g:else>

</div>

</td></tr>

<tr><td>

<div class="fieldcontain ${hasErrors(bean: recipeVersionInstance, field: 'chef', 'error')} required">
	<label for="chef">
		<g:message code="recipeVersion.chef.label" default="Chef" />
		<!--<span class="required-indicator">*</span>-->
	</label>
	<g:if test="${list == recipeInstance?.defaultRecipe?.chef}">
		<br/><g:select id="chef" name="chef.id" from="${ics.Individual.list()}" optionKey="id" required="" value="${recipeVersionInstance?.chef?.id}" class="many-to-one"/>
	</g:if>
	<g:else>
		<br/><g:select id="chef" name="chef.id" from="${recipeInstance?.defaultRecipe?.chef}" optionKey="id" required="" value="${recipeVersionInstance?.chef?.id}" class="many-to-one"/>
	</g:else>
	
	
</div>

</td><td>

<div class="fieldcontain ${hasErrors(bean: recipeVersionInstance, field: 'recipeStatus', 'error')} required">
	<label for="recipeStatus">
		<g:message code="recipeVersion.recipeStatus.label" default="RecipeStatus" />
		<!--<span class="required-indicator">*</span>-->
	</label>
<g:if test="${list == recipeInstance?.defaultRecipe?.recipeStatus}">
		<br/><g:select name="recipeStatus" from="${ics.RecipeStatus?.values()}" keys="${ics.RecipeStatus.values()*.name()}" required="" value="${recipeInstance?.defaultRecipe?.recipeStatus}"/>
	</g:if>
	<g:else>
		<br/><g:select name="recipeStatus" from="${recipeInstance?.defaultRecipe?.recipeStatus}" keys="${ics.RecipeStatus.values()*.name()}" required="" value="${recipeInstance?.defaultRecipe?.recipeStatus}"/>
	</g:else>
	
</div>

</td><td>

<div class="fieldcontain ${hasErrors(bean: recipeInstance, field: 'spicy', 'error')} ">
	<label for="spicy">
		<g:message code="recipe.spicy.label" default="Spicy" />
		
	</label>
	<br/><g:textField name="spicy" value="${recipeInstance?.spicy}"/>
</div>

</td><td>

<div class="fieldcontain ${hasErrors(bean: recipeInstance, field: 'healthy', 'error')} ">
	<label for="healthy">
		<g:message code="recipe.healthy.label" default="Healthy" />
		
	</label>
	<br/><g:textField name="healthy" value="${recipeInstance?.healthy}"/>
</div>

</td></tr>

<tr><td>

<div class="fieldcontain ${hasErrors(bean: recipeInstance, field: 'economical', 'error')} ">
	<label for="economical">
		<g:message code="recipe.economical.label" default="Economical" />
		
	</label>
	<br/><g:textField name="economical" value="${recipeInstance?.economical}"/>
</div>

</td><td>

<div class="fieldcontain ${hasErrors(bean: recipeInstance, field: 'preprationtime', 'error')} ">
	<label for="preprationtime">
		<g:message code="recipe.preprationtime.label" default="Preprationtime" />
		
	</label>
	<br/><g:textField name="preprationtime" value="${recipeInstance?.preprationtime}"/>
</div>

</td><td>

<div class="fieldcontain ${hasErrors(bean: recipeInstance, field: 'shelflife', 'error')} ">
	<label for="shelflife">
		<g:message code="recipe.shelflife.label" default="Shelflife" />
		
	</label>
	<br/><g:textField name="shelflife" value="${recipeInstance?.shelflife}"/>
</div>

</td><td>

<div class="fieldcontain ${hasErrors(bean: recipeInstance, field: 'feedback', 'error')} ">
	<label for="feedback">
		<g:message code="recipe.feedback.label" default="Feedback" />
		
	</label>
	<br/><g:textField name="feedback" value="${recipeInstance?.feedback}"/>
</div>

</td></tr>
</table>

<br/><br/>

<table>

<tr>

<td>

<div class="fieldcontain ${hasErrors(bean: recipeVersionInstance, field: 'yield1', 'error')} ">
	<label for="yield1">
		<g:message code="recipeVersion.yield1.label" default="Yield1" />		
	</label>
	<!--OBSERVE THIS LINE YOU HAVE USED RECIPEINSTANCE INTEAD OF RECIPE VERSION
	    CHECK HOW TO DISPLAY THAT PARTICULAR RECIPE VERSION INSTANCE 
	    EVEN ONE BELOW THE OHTER IN LOOP-->
	<br/><g:textField name="yield1" value="${recipeInstance?.defaultRecipe?.yield1}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: recipeVersionInstance, field: 'yieldUnit1', 'error')}">
	<label for="yieldUnit1">
		<g:message code="recipeVersion.yieldUnit1.label" default="Unit1" />
	</label>
	<br/><g:select name="unit1" from="${ics.Unit?.values()}" value="${recipeInstance?.defaultRecipe?.yieldUnit1}"/>	
</div>

</td>


<td>

<div class="fieldcontain ${hasErrors(bean: recipeVersionInstance, field: 'yield2', 'error')} ">
	<label for="yield2">
		<g:message code="recipeVersion.yield2.label" default="Yield2" />		
	</label>
	<br/><g:textField name="yield2" value="${recipeInstance?.defaultRecipe?.yield2}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: recipeVersionInstance, field: 'yieldUnit2', 'error')}">
	<label for="yieldUnit2">
		<g:message code="recipeVersion.yieldUnit2.label" default="Unit2" />
	</label>
	<br/><g:select name="unit2" from="${ics.Unit?.values()}" value="${recipeInstance?.defaultRecipe?.yieldUnit2}"/>	
</div>

</td>


<td>

<div class="fieldcontain ${hasErrors(bean: recipeVersionInstance, field: 'yield3', 'error')} ">
	<label for="yield3">
		<g:message code="recipeVersion.yield3.label" default="Yield3" />		
	</label>
	<br/><g:textField name="yield3" value="${recipeInstance?.defaultRecipe?.yield3}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: recipeVersionInstance, field: 'yieldUnit3', 'error')}">
	<label for="yieldUnit3">
		<g:message code="recipeVersion.yieldUnit3.label" default="Unit3" />
	</label>
	<br/><g:select name="unit3" from="${ics.Unit?.values()}" value="${recipeInstance?.defaultRecipe?.yieldUnit3}"/>	
</div>

</td>

<tr>

</table>


	<script>
	$(function() {
		$( "#cuisineACBox" ).autocomplete({
			source: "${createLink(controller:'recipe',action:'cuisineList_JQ')}",
			minLength: 1,
			  select: function(event, ui) { // event handler when user selects a company from the list.
			   $("#cuisineid").val(ui.item); // update the hidden field.
			  }
		});
	});
	</script>
