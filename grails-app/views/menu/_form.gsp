<%@ page import="ics.Menu" %>



<div class="fieldcontain ${hasErrors(bean: menuInstance, field: 'meal', 'error')} required">
	<label for="meal">
		<g:message code="menu.meal.label" default="Meal" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="meal" from="${ics.Meal?.values()}" keys="${ics.Meal.values()*.name()}" required="" value="${menuInstance?.meal?.name()}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: menuInstance, field: 'mealDate', 'error')} required">
	<label for="mealDate">
		<g:message code="menu.mealDate.label" default="Meal Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="mealDate" precision="day"  value="${menuInstance?.mealDate}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: menuInstance, field: 'menuItems', 'error')} ">
	<label for="menuItems">
		<g:message code="menu.menuItems.label" default="Menu Items" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${menuInstance?.menuItems?}" var="m">
    <li><g:link controller="menuItem" action="show" id="${m.id}">${m?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="menuItem" action="create" params="['menu.id': menuInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'menuItem.label', default: 'MenuItem')])}</g:link>
</li>
</ul>

</div>

<div class="fieldcontain ${hasErrors(bean: menuInstance, field: 'orderedPersonCounts', 'error')} ">
	<label for="orderedPersonCounts">
		<g:message code="menu.orderedPersonCounts.label" default="Ordered Person Counts" />
		
	</label>
	<g:select name="orderedPersonCounts" from="${ics.PersonCount.list()}" multiple="multiple" optionKey="id" size="5" value="${menuInstance?.orderedPersonCounts*.id}" class="many-to-many"/>
</div>

<div class="fieldcontain ${hasErrors(bean: menuInstance, field: 'actualPersonCounts', 'error')} ">
	<label for="actualPersonCounts">
		<g:message code="menu.actualPersonCounts.label" default="Actual Person Counts" />
		
	</label>
	<g:select name="actualPersonCounts" from="${ics.PersonCount.list()}" multiple="multiple" optionKey="id" size="5" value="${menuInstance?.actualPersonCounts*.id}" class="many-to-many"/>
</div>

<div class="fieldcontain ${hasErrors(bean: menuInstance, field: 'totalCost', 'error')} required">
	<label for="totalCost">
		<g:message code="menu.totalCost.label" default="Total Cost" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="totalCost" required="" value="${fieldValue(bean: menuInstance, field: 'totalCost')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: menuInstance, field: 'mealCost', 'error')} required">
	<label for="mealCost">
		<g:message code="menu.mealCost.label" default="Meal Cost" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="mealCost" required="" value="${fieldValue(bean: menuInstance, field: 'mealCost')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: menuInstance, field: 'creator', 'error')} ">
	<label for="creator">
		<g:message code="menu.creator.label" default="Creator" />
		
	</label>
	<g:textField name="creator" value="${menuInstance?.creator}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: menuInstance, field: 'updator', 'error')} ">
	<label for="updator">
		<g:message code="menu.updator.label" default="Updator" />
		
	</label>
	<g:textField name="updator" value="${menuInstance?.updator}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: menuInstance, field: 'actualYield', 'error')} ">
	<label for="actualYield">
		<g:message code="menu.actualYield.label" default="Actual Yield" />
		
	</label>
	
</div>

<div class="fieldcontain ${hasErrors(bean: menuInstance, field: 'menuChart', 'error')} required">
	<label for="menuChart">
		<g:message code="menu.menuChart.label" default="Menu Chart" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="menuChart" name="menuChart.id" from="${ics.MenuChart.list()}" optionKey="id" required="" value="${menuInstance?.menuChart?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: menuInstance, field: 'orderedYield', 'error')} ">
	<label for="orderedYield">
		<g:message code="menu.orderedYield.label" default="Ordered Yield" />
		
	</label>
	
</div>

<div class="fieldcontain ${hasErrors(bean: menuInstance, field: 'yieldUnit', 'error')} ">
	<label for="yieldUnit">
		<g:message code="menu.yieldUnit.label" default="Yield Unit" />
		
	</label>
	
</div>

