<%@ page import="ics.MenuChart" %>



<div class="fieldcontain ${hasErrors(bean: menuChartInstance, field: 'menu', 'error')} ">
	<label for="menu">
		<g:message code="menuChart.menu.label" default="Menu" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${menuChartInstance?.menu?}" var="m">
    <li><g:link controller="menu" action="show" id="${m.id}">${m?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="menu" action="create" params="['menuChart.id': menuChartInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'menu.label', default: 'Menu')])}</g:link>
</li>
</ul>

</div>

<div class="fieldcontain ${hasErrors(bean: menuChartInstance, field: 'creator', 'error')} ">
	<label for="creator">
		<g:message code="menuChart.creator.label" default="Creator" />
		
	</label>
	<g:textField name="creator" value="${menuChartInstance?.creator}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: menuChartInstance, field: 'updator', 'error')} ">
	<label for="updator">
		<g:message code="menuChart.updator.label" default="Updator" />
		
	</label>
	<g:textField name="updator" value="${menuChartInstance?.updator}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: menuChartInstance, field: 'chartName', 'error')} ">
	<label for="chartName">
		<g:message code="menuChart.chartName.label" default="Chart Name" />
		
	</label>
	<g:textField name="chartName" value="${menuChartInstance?.chartName}"/>
</div>

