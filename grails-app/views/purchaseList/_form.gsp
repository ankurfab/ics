<%@ page import="ics.PurchaseList" %>



<div class="fieldcontain ${hasErrors(bean: purchaseListInstance, field: 'purchaseListDate', 'error')} required">
	<label for="purchaseListDate">
		<g:message code="purchaseList.purchaseListDate.label" default="Purchase List Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="purchaseListDate" value="${purchaseListInstance?.purchaseListDate}"  />

</div>

<div class="fieldcontain ${hasErrors(bean: purchaseListInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="purchaseList.name.label" default="Name" />
		
	</label>
	<g:textField name="name" value="${fieldValue(bean: purchaseListInstance, field: 'name')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: purchaseListInstance, field: 'preparedBy', 'error')} required">
	<label for="preparedBy">
		<g:message code="purchaseList.preparedBy.label" default="Prepared By" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="preparedBy.id" from="${ics.Individual.list()}" optionKey="id" value="${purchaseListInstance?.preparedBy?.id}"  />

</div>

<div class="fieldcontain ${hasErrors(bean: purchaseListInstance, field: 'preparationComments', 'error')} ">
	<label for="preparationComments">
		<g:message code="purchaseList.preparationComments.label" default="Preparation Comments" />
		
	</label>
	<g:textField name="preparationComments" value="${fieldValue(bean: purchaseListInstance, field: 'preparationComments')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: purchaseListInstance, field: 'status', 'error')} ">
	<label for="status">
		<g:message code="purchaseList.status.label" default="Status" />
		
	</label>
	<g:textField name="status" value="${fieldValue(bean: purchaseListInstance, field: 'status')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: purchaseListInstance, field: 'department', 'error')} ">
	<label for="department">
		<g:message code="purchaseList.department.label" default="Department" />
		
	</label>
	<g:select name="department.id" from="${ics.Department.list()}" optionKey="id" value="${purchaseListInstance?.department?.id}" noSelection="['null': '']" />

</div>

<div class="fieldcontain ${hasErrors(bean: purchaseListInstance, field: 'purchaseDateDate', 'error')} ">
	<label for="purchaseDateDate">
		<g:message code="purchaseList.purchaseDateDate.label" default="Purchase Date Date" />
		
	</label>
	<g:datePicker name="purchaseDateDate" value="${purchaseListInstance?.purchaseDateDate}" noSelection="['': '']" />

</div>

<div class="fieldcontain ${hasErrors(bean: purchaseListInstance, field: 'purchasedBy', 'error')} ">
	<label for="purchasedBy">
		<g:message code="purchaseList.purchasedBy.label" default="Purchased By" />
		
	</label>
	<g:select name="purchasedBy.id" from="${ics.Individual.list()}" optionKey="id" value="${purchaseListInstance?.purchasedBy?.id}" noSelection="['null': '']" />

</div>

<div class="fieldcontain ${hasErrors(bean: purchaseListInstance, field: 'purchasedFrom', 'error')} ">
	<label for="purchasedFrom">
		<g:message code="purchaseList.purchasedFrom.label" default="Purchased From" />
		
	</label>
	<g:select name="purchasedFrom.id" from="${ics.Individual.list()}" optionKey="id" value="${purchaseListInstance?.purchasedFrom?.id}" noSelection="['null': '']" />

</div>

<div class="fieldcontain ${hasErrors(bean: purchaseListInstance, field: 'purchaseComments', 'error')} ">
	<label for="purchaseComments">
		<g:message code="purchaseList.purchaseComments.label" default="Purchase Comments" />
		
	</label>
	<g:textField name="purchaseComments" value="${fieldValue(bean: purchaseListInstance, field: 'purchaseComments')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: purchaseListInstance, field: 'estimateDate', 'error')} ">
	<label for="estimateDate">
		<g:message code="purchaseList.estimateDate.label" default="Estimate Date" />
		
	</label>
	<g:datePicker name="estimateDate" value="${purchaseListInstance?.estimateDate}" noSelection="['': '']" />

</div>

<div class="fieldcontain ${hasErrors(bean: purchaseListInstance, field: 'estimatedAmount', 'error')} ">
	<label for="estimatedAmount">
		<g:message code="purchaseList.estimatedAmount.label" default="Estimated Amount" />
		
	</label>
	<g:textField name="estimatedAmount" value="${fieldValue(bean: purchaseListInstance, field: 'estimatedAmount')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: purchaseListInstance, field: 'estimateReference', 'error')} ">
	<label for="estimateReference">
		<g:message code="purchaseList.estimateReference.label" default="Estimate Reference" />
		
	</label>
	<g:textField name="estimateReference" value="${fieldValue(bean: purchaseListInstance, field: 'estimateReference')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: purchaseListInstance, field: 'estimateComments', 'error')} ">
	<label for="estimateComments">
		<g:message code="purchaseList.estimateComments.label" default="Estimate Comments" />
		
	</label>
	<g:textField name="estimateComments" value="${fieldValue(bean: purchaseListInstance, field: 'estimateComments')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: purchaseListInstance, field: 'estimateStatus', 'error')} ">
	<label for="estimateStatus">
		<g:message code="purchaseList.estimateStatus.label" default="Estimate Status" />
		
	</label>
	<g:textField name="estimateStatus" value="${fieldValue(bean: purchaseListInstance, field: 'estimateStatus')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: purchaseListInstance, field: 'billDate', 'error')} ">
	<label for="billDate">
		<g:message code="purchaseList.billDate.label" default="Bill Date" />
		
	</label>
	<g:datePicker name="billDate" value="${purchaseListInstance?.billDate}" noSelection="['': '']" />

</div>

<div class="fieldcontain ${hasErrors(bean: purchaseListInstance, field: 'billAmount', 'error')} ">
	<label for="billAmount">
		<g:message code="purchaseList.billAmount.label" default="Bill Amount" />
		
	</label>
	<g:textField name="billAmount" value="${fieldValue(bean: purchaseListInstance, field: 'billAmount')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: purchaseListInstance, field: 'billReference', 'error')} ">
	<label for="billReference">
		<g:message code="purchaseList.billReference.label" default="Bill Reference" />
		
	</label>
	<g:textField name="billReference" value="${fieldValue(bean: purchaseListInstance, field: 'billReference')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: purchaseListInstance, field: 'billComments', 'error')} ">
	<label for="billComments">
		<g:message code="purchaseList.billComments.label" default="Bill Comments" />
		
	</label>
	<g:textField name="billComments" value="${fieldValue(bean: purchaseListInstance, field: 'billComments')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: purchaseListInstance, field: 'billStatus', 'error')} ">
	<label for="billStatus">
		<g:message code="purchaseList.billStatus.label" default="Bill Status" />
		
	</label>
	<g:textField name="billStatus" value="${fieldValue(bean: purchaseListInstance, field: 'billStatus')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: purchaseListInstance, field: 'paymentDate', 'error')} ">
	<label for="paymentDate">
		<g:message code="purchaseList.paymentDate.label" default="Payment Date" />
		
	</label>
	<g:datePicker name="paymentDate" value="${purchaseListInstance?.paymentDate}" noSelection="['': '']" />

</div>

<div class="fieldcontain ${hasErrors(bean: purchaseListInstance, field: 'paidAmount', 'error')} ">
	<label for="paidAmount">
		<g:message code="purchaseList.paidAmount.label" default="Paid Amount" />
		
	</label>
	<g:textField name="paidAmount" value="${fieldValue(bean: purchaseListInstance, field: 'paidAmount')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: purchaseListInstance, field: 'paymentReference', 'error')} ">
	<label for="paymentReference">
		<g:message code="purchaseList.paymentReference.label" default="Payment Reference" />
		
	</label>
	<g:textField name="paymentReference" value="${fieldValue(bean: purchaseListInstance, field: 'paymentReference')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: purchaseListInstance, field: 'paymentComments', 'error')} ">
	<label for="paymentComments">
		<g:message code="purchaseList.paymentComments.label" default="Payment Comments" />
		
	</label>
	<g:textField name="paymentComments" value="${fieldValue(bean: purchaseListInstance, field: 'paymentComments')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: purchaseListInstance, field: 'paymentMode', 'error')} ">
	<label for="paymentMode">
		<g:message code="purchaseList.paymentMode.label" default="Payment Mode" />
		
	</label>
	<g:textField name="paymentMode" value="${fieldValue(bean: purchaseListInstance, field: 'paymentMode')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: purchaseListInstance, field: 'paymentStatus', 'error')} ">
	<label for="paymentStatus">
		<g:message code="purchaseList.paymentStatus.label" default="Payment Status" />
		
	</label>
	<g:textField name="paymentStatus" value="${fieldValue(bean: purchaseListInstance, field: 'paymentStatus')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: purchaseListInstance, field: 'requiredItems', 'error')} ">
	<label for="requiredItems">
		<g:message code="purchaseList.requiredItems.label" default="Required Items" />
		
	</label>
	<g:select name="requiredItems"
from="${ics.PurchaseItem.list()}"
size="5" multiple="yes" optionKey="id"
value="${purchaseListInstance?.requiredItems}" />


</div>

<div class="fieldcontain ${hasErrors(bean: purchaseListInstance, field: 'purchasedItems', 'error')} ">
	<label for="purchasedItems">
		<g:message code="purchaseList.purchasedItems.label" default="Purchased Items" />
		
	</label>
	<g:select name="purchasedItems"
from="${ics.PurchaseItem.list()}"
size="5" multiple="yes" optionKey="id"
value="${purchaseListInstance?.purchasedItems}" />


</div>

<div class="fieldcontain ${hasErrors(bean: purchaseListInstance, field: 'creator', 'error')} ">
	<label for="creator">
		<g:message code="purchaseList.creator.label" default="Creator" />
		
	</label>
	<g:textField name="creator" value="${fieldValue(bean: purchaseListInstance, field: 'creator')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: purchaseListInstance, field: 'updator', 'error')} ">
	<label for="updator">
		<g:message code="purchaseList.updator.label" default="Updator" />
		
	</label>
	<g:textField name="updator" value="${fieldValue(bean: purchaseListInstance, field: 'updator')}" />

</div>

