<%@ page import="ics.AttributeValue" %>



<div class="fieldcontain ${hasErrors(bean: attributeValueInstance, field: 'attribute', 'error')} required">
	<label for="attribute">
		<g:message code="attributeValue.attribute.label" default="Attribute" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="attribute.id" from="${ics.Attribute.list()}" optionKey="id" value="${attributeValueInstance?.attribute?.id}"  />

</div>

<div class="fieldcontain ${hasErrors(bean: attributeValueInstance, field: 'creator', 'error')} ">
	<label for="creator">
		<g:message code="attributeValue.creator.label" default="Creator" />
		
	</label>
	<g:textField name="creator" value="${fieldValue(bean: attributeValueInstance, field: 'creator')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: attributeValueInstance, field: 'objectClassName', 'error')} ">
	<label for="objectClassName">
		<g:message code="attributeValue.objectClassName.label" default="Object Class Name" />
		
	</label>
	<g:textField name="objectClassName" value="${fieldValue(bean: attributeValueInstance, field: 'objectClassName')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: attributeValueInstance, field: 'objectId', 'error')} required">
	<label for="objectId">
		<g:message code="attributeValue.objectId.label" default="Object Id" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="objectId" value="${fieldValue(bean: attributeValueInstance, field: 'objectId')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: attributeValueInstance, field: 'updator', 'error')} ">
	<label for="updator">
		<g:message code="attributeValue.updator.label" default="Updator" />
		
	</label>
	<g:textField name="updator" value="${fieldValue(bean: attributeValueInstance, field: 'updator')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: attributeValueInstance, field: 'value', 'error')} ">
	<label for="value">
		<g:message code="attributeValue.value.label" default="Value" />
		
	</label>
	<g:textField name="value" value="${fieldValue(bean: attributeValueInstance, field: 'value')}" />

</div>

