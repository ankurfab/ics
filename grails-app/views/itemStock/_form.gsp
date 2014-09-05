<%@ page import="ics.ItemStock" %>



<div class="fieldcontain ${hasErrors(bean: itemStockInstance, field: 'supplementedBy', 'error')} required">
	<label for="supplementedBy">
		<g:message code="itemStock.supplementedBy.label" default="Supplemented By" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="supplementedBy" name="supplementedBy.id" from="${ics.Person.list()}" optionKey="id" required="" value="${itemStockInstance?.supplementedBy?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: itemStockInstance, field: 'consumedBy', 'error')} required">
	<label for="consumedBy">
		<g:message code="itemStock.consumedBy.label" default="Consumed By" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="consumedBy" name="consumedBy.id" from="${ics.Person.list()}" optionKey="id" required="" value="${itemStockInstance?.consumedBy?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: itemStockInstance, field: 'auditedBy', 'error')} required">
	<label for="auditedBy">
		<g:message code="itemStock.auditedBy.label" default="Audited By" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="auditedBy" name="auditedBy.id" from="${ics.Person.list()}" optionKey="id" required="" value="${itemStockInstance?.auditedBy?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: itemStockInstance, field: 'itemCounts', 'error')} ">
	<label for="itemCounts">
		<g:message code="itemStock.itemCounts.label" default="Item Counts" />
		
	</label>
	<g:select name="itemCounts" from="${ics.ItemCount.list()}" multiple="multiple" optionKey="id" size="5" value="${itemStockInstance?.itemCounts*.id}" class="many-to-many"/>
</div>

<div class="fieldcontain ${hasErrors(bean: itemStockInstance, field: 'creator', 'error')} ">
	<label for="creator">
		<g:message code="itemStock.creator.label" default="Creator" />
		
	</label>
	<g:textField name="creator" value="${itemStockInstance?.creator}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: itemStockInstance, field: 'updator', 'error')} ">
	<label for="updator">
		<g:message code="itemStock.updator.label" default="Updator" />
		
	</label>
	<g:textField name="updator" value="${itemStockInstance?.updator}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: itemStockInstance, field: 'department', 'error')} required">
	<label for="department">
		<g:message code="itemStock.department.label" default="Department" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="department" name="department.id" from="${ics.Department.list()}" optionKey="id" required="" value="${itemStockInstance?.department?.id}" class="many-to-one"/>
</div>

