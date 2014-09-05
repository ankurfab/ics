<%@ page import="ics.ItemCategory" %>



<div class="fieldcontain ${hasErrors(bean: itemCategoryInstance, field: 'category', 'error')} ">
	<label for="category">
		<g:message code="itemCategory.category.label" default="Category" />
		
	</label>
	<g:textField name="category" value="${itemCategoryInstance?.category}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: itemCategoryInstance, field: 'items', 'error')} ">
	<label for="items">
		<g:message code="itemCategory.items.label" default="Items" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${itemCategoryInstance?.items?}" var="i">
    <li><g:link controller="item" action="show" id="${i.id}">${i?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="item" action="create" params="['itemCategory.id': itemCategoryInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'item.label', default: 'Item')])}</g:link>
</li>
</ul>

</div>

<div class="fieldcontain ${hasErrors(bean: itemCategoryInstance, field: 'creator', 'error')} ">
	<label for="creator">
		<g:message code="itemCategory.creator.label" default="Creator" />
		
	</label>
	<g:textField name="creator" value="${itemCategoryInstance?.creator}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: itemCategoryInstance, field: 'updator', 'error')} ">
	<label for="updator">
		<g:message code="itemCategory.updator.label" default="Updator" />
		
	</label>
	<g:textField name="updator" value="${itemCategoryInstance?.updator}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: itemCategoryInstance, field: 'itemType', 'error')} required">
	<label for="itemType">
		<g:message code="itemCategory.itemType.label" default="Item Type" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="itemType" name="itemType.id" from="${ics.ItemType.list()}" optionKey="id" required="" value="${itemCategoryInstance?.itemType?.id}" class="many-to-one"/>
</div>

