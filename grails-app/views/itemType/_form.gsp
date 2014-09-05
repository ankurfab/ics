<%@ page import="ics.ItemType" %>



<div class="fieldcontain ${hasErrors(bean: itemTypeInstance, field: 'type', 'error')} ">
	<label for="type">
		<g:message code="itemType.type.label" default="Type" />
		
	</label>
	<g:textField name="type" value="${itemTypeInstance?.type}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: itemTypeInstance, field: 'creator', 'error')} ">
	<label for="creator">
		<g:message code="itemType.creator.label" default="Creator" />
		
	</label>
	<g:textField name="creator" value="${itemTypeInstance?.creator}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: itemTypeInstance, field: 'updator', 'error')} ">
	<label for="updator">
		<g:message code="itemType.updator.label" default="Updator" />
		
	</label>
	<g:textField name="updator" value="${itemTypeInstance?.updator}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: itemTypeInstance, field: 'categories', 'error')} ">
	<label for="categories">
		<g:message code="itemType.categories.label" default="Categories" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${itemTypeInstance?.categories?}" var="c">
    <li><g:link controller="itemCategory" action="show" id="${c.id}">${c?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="itemCategory" action="create" params="['itemType.id': itemTypeInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'itemCategory.label', default: 'ItemCategory')])}</g:link>
</li>
</ul>

</div>

