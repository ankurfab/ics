<%@ page import="ics.ItemCount" %>



<div class="fieldcontain ${hasErrors(bean: itemCountInstance, field: 'item', 'error')} required">
	<label for="item">
		<g:message code="itemCount.item.label" default="Item" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="item" name="item.id" from="${ics.Item.list()}" optionKey="id" required="" value="${itemCountInstance?.item?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: itemCountInstance, field: 'qty', 'error')} required">
	<label for="qty">
		<g:message code="itemCount.qty.label" default="Qty" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="qty" required="" value="${fieldValue(bean: itemCountInstance, field: 'qty')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: itemCountInstance, field: 'unit', 'error')} required">
	<label for="unit">
		<g:message code="itemCount.unit.label" default="Unit" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="unit" from="${ics.Unit?.values()}" keys="${ics.Unit.values()*.name()}" required="" value="${itemCountInstance?.unit?.name()}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: itemCountInstance, field: 'rate', 'error')} required">
	<label for="rate">
		<g:message code="itemCount.rate.label" default="Rate" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="rate" required="" value="${fieldValue(bean: itemCountInstance, field: 'rate')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: itemCountInstance, field: 'nqty', 'error')} required">
	<label for="nqty">
		<g:message code="itemCount.nqty.label" default="Nqty" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="nqty" required="" value="${fieldValue(bean: itemCountInstance, field: 'nqty')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: itemCountInstance, field: 'nunit', 'error')} required">
	<label for="nunit">
		<g:message code="itemCount.nunit.label" default="Nunit" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="nunit" from="${ics.Unit?.values()}" keys="${ics.Unit.values()*.name()}" required="" value="${itemCountInstance?.nunit?.name()}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: itemCountInstance, field: 'nrate', 'error')} required">
	<label for="nrate">
		<g:message code="itemCount.nrate.label" default="Nrate" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="nrate" required="" value="${fieldValue(bean: itemCountInstance, field: 'nrate')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: itemCountInstance, field: 'creator', 'error')} ">
	<label for="creator">
		<g:message code="itemCount.creator.label" default="Creator" />
		
	</label>
	<g:textField name="creator" value="${itemCountInstance?.creator}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: itemCountInstance, field: 'updator', 'error')} ">
	<label for="updator">
		<g:message code="itemCount.updator.label" default="Updator" />
		
	</label>
	<g:textField name="updator" value="${itemCountInstance?.updator}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: itemCountInstance, field: 'instruction', 'error')} required">
	<label for="instruction">
		<g:message code="itemCount.instruction.label" default="Instruction" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="instruction" name="instruction.id" from="${ics.Instruction.list()}" optionKey="id" required="" value="${itemCountInstance?.instruction?.id}" class="many-to-one"/>
</div>

