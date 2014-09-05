
<%@ page import="ics.Menu" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'menu.label', default: 'Menu')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-menu" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-menu" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list menu">
			
				<g:if test="${menuInstance?.meal}">
				<li class="fieldcontain">
					<span id="meal-label" class="property-label"><g:message code="menu.meal.label" default="Meal" /></span>
					
						<span class="property-value" aria-labelledby="meal-label"><g:fieldValue bean="${menuInstance}" field="meal"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${menuInstance?.mealDate}">
				<li class="fieldcontain">
					<span id="mealDate-label" class="property-label"><g:message code="menu.mealDate.label" default="Meal Date" /></span>
					
						<span class="property-value" aria-labelledby="mealDate-label"><g:formatDate date="${menuInstance?.mealDate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${menuInstance?.menuItems}">
				<li class="fieldcontain">
					<span id="menuItems-label" class="property-label"><g:message code="menu.menuItems.label" default="Menu Items" /></span>
					
						<g:each in="${menuInstance.menuItems}" var="m">
						<span class="property-value" aria-labelledby="menuItems-label"><g:link controller="menuItem" action="show" id="${m.id}">${m?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${menuInstance?.orderedPersonCounts}">
				<li class="fieldcontain">
					<span id="orderedPersonCounts-label" class="property-label"><g:message code="menu.orderedPersonCounts.label" default="Ordered Person Counts" /></span>
					
						<g:each in="${menuInstance.orderedPersonCounts}" var="o">
						<span class="property-value" aria-labelledby="orderedPersonCounts-label"><g:link controller="personCount" action="show" id="${o.id}">${o?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${menuInstance?.actualPersonCounts}">
				<li class="fieldcontain">
					<span id="actualPersonCounts-label" class="property-label"><g:message code="menu.actualPersonCounts.label" default="Actual Person Counts" /></span>
					
						<g:each in="${menuInstance.actualPersonCounts}" var="a">
						<span class="property-value" aria-labelledby="actualPersonCounts-label"><g:link controller="personCount" action="show" id="${a.id}">${a?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${menuInstance?.totalCost}">
				<li class="fieldcontain">
					<span id="totalCost-label" class="property-label"><g:message code="menu.totalCost.label" default="Total Cost" /></span>
					
						<span class="property-value" aria-labelledby="totalCost-label"><g:fieldValue bean="${menuInstance}" field="totalCost"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${menuInstance?.mealCost}">
				<li class="fieldcontain">
					<span id="mealCost-label" class="property-label"><g:message code="menu.mealCost.label" default="Meal Cost" /></span>
					
						<span class="property-value" aria-labelledby="mealCost-label"><g:fieldValue bean="${menuInstance}" field="mealCost"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${menuInstance?.creator}">
				<li class="fieldcontain">
					<span id="creator-label" class="property-label"><g:message code="menu.creator.label" default="Creator" /></span>
					
						<span class="property-value" aria-labelledby="creator-label"><g:fieldValue bean="${menuInstance}" field="creator"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${menuInstance?.dateCreated}">
				<li class="fieldcontain">
					<span id="dateCreated-label" class="property-label"><g:message code="menu.dateCreated.label" default="Date Created" /></span>
					
						<span class="property-value" aria-labelledby="dateCreated-label"><g:formatDate date="${menuInstance?.dateCreated}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${menuInstance?.updator}">
				<li class="fieldcontain">
					<span id="updator-label" class="property-label"><g:message code="menu.updator.label" default="Updator" /></span>
					
						<span class="property-value" aria-labelledby="updator-label"><g:fieldValue bean="${menuInstance}" field="updator"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${menuInstance?.lastUpdated}">
				<li class="fieldcontain">
					<span id="lastUpdated-label" class="property-label"><g:message code="menu.lastUpdated.label" default="Last Updated" /></span>
					
						<span class="property-value" aria-labelledby="lastUpdated-label"><g:formatDate date="${menuInstance?.lastUpdated}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${menuInstance?.actualYield}">
				<li class="fieldcontain">
					<span id="actualYield-label" class="property-label"><g:message code="menu.actualYield.label" default="Actual Yield" /></span>
					
						<span class="property-value" aria-labelledby="actualYield-label"><g:fieldValue bean="${menuInstance}" field="actualYield"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${menuInstance?.menuChart}">
				<li class="fieldcontain">
					<span id="menuChart-label" class="property-label"><g:message code="menu.menuChart.label" default="Menu Chart" /></span>
					
						<span class="property-value" aria-labelledby="menuChart-label"><g:link controller="menuChart" action="show" id="${menuInstance?.menuChart?.id}">${menuInstance?.menuChart?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${menuInstance?.orderedYield}">
				<li class="fieldcontain">
					<span id="orderedYield-label" class="property-label"><g:message code="menu.orderedYield.label" default="Ordered Yield" /></span>
					
						<span class="property-value" aria-labelledby="orderedYield-label"><g:fieldValue bean="${menuInstance}" field="orderedYield"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${menuInstance?.yieldUnit}">
				<li class="fieldcontain">
					<span id="yieldUnit-label" class="property-label"><g:message code="menu.yieldUnit.label" default="Yield Unit" /></span>
					
						<span class="property-value" aria-labelledby="yieldUnit-label"><g:fieldValue bean="${menuInstance}" field="yieldUnit"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${menuInstance?.id}" />
					<g:link class="edit" action="edit" id="${menuInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
