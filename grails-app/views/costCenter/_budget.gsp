<%@ page import="ics.CostCenter" %>

<table>
<thead>
	<th>${costCenterInstance?.name}</th>	
	<th>Q1</th>	
	<th>Q2</th>	
	<th>Q3</th>	
	<th>Q4</th>	
	<th>Annual</th>	
</thead>
	<tr>
		<td><b>Budget</b></td>
		<g:each var="qtr" in="${1..4}">
		<td>${ics.AttributeValue.findByAttribute(ics.Attribute.findWhere(domainClassName:'CostCenter',domainClassAttributeName:costCenterInstance?.id.toString(),category:year,type:'BUDGET',position:qtr))?.value}</td>
		</g:each>
	</tr>
	<tr>
		<td><b>Projected Income</b></td>
		<g:each var="qtr" in="${1..4}">
		<td>${ics.AttributeValue.findByAttribute(ics.Attribute.findWhere(domainClassName:'CostCenter',domainClassAttributeName:costCenterInstance?.id.toString(),category:year,type:'PROJECTED_INCOME',position:qtr))?.value}</td>
		</g:each>
	</tr>
	<tr>
		<td><b>Projected Expense</b></td>
		<g:each var="qtr" in="${1..4}">
		<td>${ics.AttributeValue.findByAttribute(ics.Attribute.findWhere(domainClassName:'CostCenter',domainClassAttributeName:costCenterInstance?.id.toString(),category:year,type:'PROJECTED_EXPENSE',position:qtr))?.value}</td>
		</g:each>
	</tr>
	<tr>
		<td><b>Actual Income</b></td>
		<g:each var="qtr" in="${1..4}">
		<td>${ics.AttributeValue.findByAttribute(ics.Attribute.findWhere(domainClassName:'CostCenter',domainClassAttributeName:costCenterInstance?.id.toString(),category:year,type:'INCOME',position:qtr))?.value}</td>
		</g:each>
	</tr>
	<tr>
		<td><b>Actual Expense</b></td>
		<g:each var="qtr" in="${1..4}">
		<td>${ics.AttributeValue.findByAttribute(ics.Attribute.findWhere(domainClassName:'CostCenter',domainClassAttributeName:costCenterInstance?.id.toString(),category:year,type:'EXPENSE',position:qtr))?.value}</td>
		</g:each>
	</tr>
</table>