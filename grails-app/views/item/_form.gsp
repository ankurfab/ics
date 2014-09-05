<%@ page import="ics.Item" %>



<div class="fieldcontain ${hasErrors(bean: itemInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="item.name.label" default="Name" />
		
	</label>
	<g:textField name="name" value="${fieldValue(bean: itemInstance, field: 'name')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: itemInstance, field: 'otherNames', 'error')} ">
	<label for="otherNames">
		<g:message code="item.otherNames.label" default="Other Names" />
		
	</label>
	<g:textField name="otherNames" value="${fieldValue(bean: itemInstance, field: 'otherNames')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: itemInstance, field: 'category', 'error')} ">
	<label for="category">
		<g:message code="item.category.label" default="Category" />
		
	</label>
	<!--<g:textField name="category" value="${fieldValue(bean: itemInstance, field: 'category')}" />-->
	<g:select name="category" from="${['Vegetable', 'Grocery', 'Spices', 'Miscellaneous']}" value="${itemInstance?.category}" /> 	     		
</div>

<div class="fieldcontain ${hasErrors(bean: itemInstance, field: 'variety', 'error')} ">
	<label for="variety">
		<g:message code="item.variety.label" default="Variety" />
		
	</label>
	<g:textField name="variety" value="${fieldValue(bean: itemInstance, field: 'variety')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: itemInstance, field: 'brand', 'error')} ">
	<label for="brand">
		<g:message code="item.brand.label" default="Brand" />
		
	</label>
	<g:textField name="brand" value="${fieldValue(bean: itemInstance, field: 'brand')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: itemInstance, field: 'densityFactor', 'error')} required">
	<label for="densityFactor">
		<g:message code="item.densityFactor.label" default="Density Factor" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="densityFactor" value="${fieldValue(bean: itemInstance, field: 'densityFactor')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: itemInstance, field: 'comments', 'error')} ">
	<label for="comments">
		<g:message code="item.comments.label" default="Comments" />
		
	</label>
	<g:textField name="comments" value="${fieldValue(bean: itemInstance, field: 'comments')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: itemInstance, field: 'creator', 'error')} ">
	<label for="creator">
		<g:message code="item.creator.label" default="Creator" />
		
	</label>
	<g:textField name="creator" value="${fieldValue(bean: itemInstance, field: 'creator')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: itemInstance, field: 'updator', 'error')} ">
	<label for="updator">
		<g:message code="item.updator.label" default="Updator" />
		
	</label>
	<g:textField name="updator" value="${fieldValue(bean: itemInstance, field: 'updator')}" />

</div>

