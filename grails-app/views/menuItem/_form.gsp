<%@ page import="ics.MenuItem" %>



<div class="fieldcontain ${hasErrors(bean: menuItemInstance, field: 'recipe', 'error')} required">
	<label for="recipe">
		<g:message code="menuItem.recipe.label" default="Recipe" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="recipe" name="recipe.id" from="${ics.RecipeVersion.list()}" optionKey="id" required="" value="${menuItemInstance?.recipe?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: menuItemInstance, field: 'oqty', 'error')} required">
	<label for="oqty">
		<g:message code="menuItem.oqty.label" default="Oqty" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="oqty" required="" value="${fieldValue(bean: menuItemInstance, field: 'oqty')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: menuItemInstance, field: 'ounit', 'error')} required">
	<label for="ounit">
		<g:message code="menuItem.ounit.label" default="Ounit" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="ounit" from="${ics.Unit?.values()}" keys="${ics.Unit.values()*.name()}" required="" value="${menuItemInstance?.ounit?.name()}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: menuItemInstance, field: 'yqty', 'error')} required">
	<label for="yqty">
		<g:message code="menuItem.yqty.label" default="Yqty" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="yqty" required="" value="${fieldValue(bean: menuItemInstance, field: 'yqty')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: menuItemInstance, field: 'yunit', 'error')} required">
	<label for="yunit">
		<g:message code="menuItem.yunit.label" default="Yunit" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="yunit" from="${ics.Unit?.values()}" keys="${ics.Unit.values()*.name()}" required="" value="${menuItemInstance?.yunit?.name()}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: menuItemInstance, field: 'sqty', 'error')} required">
	<label for="sqty">
		<g:message code="menuItem.sqty.label" default="Sqty" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="sqty" required="" value="${fieldValue(bean: menuItemInstance, field: 'sqty')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: menuItemInstance, field: 'sunit', 'error')} required">
	<label for="sunit">
		<g:message code="menuItem.sunit.label" default="Sunit" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="sunit" from="${ics.Unit?.values()}" keys="${ics.Unit.values()*.name()}" required="" value="${menuItemInstance?.sunit?.name()}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: menuItemInstance, field: 'creator', 'error')} ">
	<label for="creator">
		<g:message code="menuItem.creator.label" default="Creator" />
		
	</label>
	<g:textField name="creator" value="${menuItemInstance?.creator}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: menuItemInstance, field: 'updator', 'error')} ">
	<label for="updator">
		<g:message code="menuItem.updator.label" default="Updator" />
		
	</label>
	<g:textField name="updator" value="${menuItemInstance?.updator}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: menuItemInstance, field: 'menu', 'error')} required">
	<label for="menu">
		<g:message code="menuItem.menu.label" default="Menu" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="menu" name="menu.id" from="${ics.Menu.list()}" optionKey="id" required="" value="${menuItemInstance?.menu?.id}" class="many-to-one"/>
</div>

