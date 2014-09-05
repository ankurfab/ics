<%@ page import="ics.MenuOrder" %>



<div class="fieldcontain ${hasErrors(bean: menuOrderInstance, field: 'orderDate', 'error')} required">
	<label for="orderDate">
		<g:message code="menuOrder.orderDate.label" default="Order Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="orderDate" precision="day"  value="${menuOrderInstance?.orderDate}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: menuOrderInstance, field: 'requestedBy', 'error')} required">
	<label for="requestedBy">
		<g:message code="menuOrder.requestedBy.label" default="Requested By" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="requestedBy" name="requestedBy.id" from="${ics.Person.list()}" optionKey="id" required="" value="${menuOrderInstance?.requestedBy?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: menuOrderInstance, field: 'acceptedBy', 'error')} required">
	<label for="acceptedBy">
		<g:message code="menuOrder.acceptedBy.label" default="Accepted By" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="acceptedBy" name="acceptedBy.id" from="${ics.Person.list()}" optionKey="id" required="" value="${menuOrderInstance?.acceptedBy?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: menuOrderInstance, field: 'menuChart', 'error')} required">
	<label for="menuChart">
		<g:message code="menuOrder.menuChart.label" default="Menu Chart" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="menuChart" name="menuChart.id" from="${ics.MenuChart.list()}" optionKey="id" required="" value="${menuOrderInstance?.menuChart?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: menuOrderInstance, field: 'estimatedOrderValue', 'error')} required">
	<label for="estimatedOrderValue">
		<g:message code="menuOrder.estimatedOrderValue.label" default="Estimated Order Value" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="estimatedOrderValue" required="" value="${fieldValue(bean: menuOrderInstance, field: 'estimatedOrderValue')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: menuOrderInstance, field: 'actualOrderValue', 'error')} required">
	<label for="actualOrderValue">
		<g:message code="menuOrder.actualOrderValue.label" default="Actual Order Value" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="actualOrderValue" required="" value="${fieldValue(bean: menuOrderInstance, field: 'actualOrderValue')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: menuOrderInstance, field: 'invoicedOrderValue', 'error')} required">
	<label for="invoicedOrderValue">
		<g:message code="menuOrder.invoicedOrderValue.label" default="Invoiced Order Value" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="invoicedOrderValue" required="" value="${fieldValue(bean: menuOrderInstance, field: 'invoicedOrderValue')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: menuOrderInstance, field: 'advance', 'error')} required">
	<label for="advance">
		<g:message code="menuOrder.advance.label" default="Advance" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="advance" required="" value="${fieldValue(bean: menuOrderInstance, field: 'advance')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: menuOrderInstance, field: 'invoiceRef', 'error')} ">
	<label for="invoiceRef">
		<g:message code="menuOrder.invoiceRef.label" default="Invoice Ref" />
		
	</label>
	<g:textField name="invoiceRef" value="${menuOrderInstance?.invoiceRef}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: menuOrderInstance, field: 'invoiceDate', 'error')} required">
	<label for="invoiceDate">
		<g:message code="menuOrder.invoiceDate.label" default="Invoice Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="invoiceDate" precision="day"  value="${menuOrderInstance?.invoiceDate}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: menuOrderInstance, field: 'settled', 'error')} ">
	<label for="settled">
		<g:message code="menuOrder.settled.label" default="Settled" />
		
	</label>
	<g:checkBox name="settled" value="${menuOrderInstance?.settled}" />
</div>

<div class="fieldcontain ${hasErrors(bean: menuOrderInstance, field: 'creator', 'error')} ">
	<label for="creator">
		<g:message code="menuOrder.creator.label" default="Creator" />
		
	</label>
	<g:textField name="creator" value="${menuOrderInstance?.creator}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: menuOrderInstance, field: 'updator', 'error')} ">
	<label for="updator">
		<g:message code="menuOrder.updator.label" default="Updator" />
		
	</label>
	<g:textField name="updator" value="${menuOrderInstance?.updator}"/>
</div>

