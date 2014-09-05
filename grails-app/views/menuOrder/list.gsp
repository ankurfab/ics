
<%@ page import="ics.MenuOrder" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'menuOrder.label', default: 'MenuOrder')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
		<r:require module="grid" />
	</head>
	<body>

	<table id="43rowed3"></table> <div id="p43rowed3"></div> <br />

<script  type="text/javascript">
		  $(document).ready(function () {

		jQuery("#43rowed3").jqGrid({
			url:'server.php?q=2', datatype: "json",
			colNames:['Inv No','Date', 'Client', 'Amount','Tax','Total','Notes'],
			colModel:[
				{name:'id',index:'id', width:55}, {name:'invdate',index:'invdate', width:90, editable:true}, {name:'name',index:'name', width:100,editable:true}, {name:'amount',index:'amount', width:80, align:"right",editable:true}, {name:'tax',index:'tax', width:80, align:"right",editable:true}, {name:'total',index:'total', width:80,align:"right",editable:true}, {name:'note',index:'note', width:150, sortable:false,editable:true} ], rowNum:10, rowList:[10,20,30], pager: '#p43rowed3', sortname: 'id', viewrecords: true, sortorder: "desc", editurl: "server.php", caption: "Using navigator" });
		jQuery("#43rowed3").jqGrid('navGrid',"#p43rowed3",{edit:false,add:false,del:false});
		jQuery("#43rowed3").jqGrid('inlineNav',"#p43rowed3");

		});

</script>
		<a href="#list-menuOrder" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-menuOrder" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="orderDate" title="${message(code: 'menuOrder.orderDate.label', default: 'Order Date')}" />
					
						<th><g:message code="menuOrder.requestedBy.label" default="Requested By" /></th>
					
						<th><g:message code="menuOrder.acceptedBy.label" default="Accepted By" /></th>
					
						<th><g:message code="menuOrder.menuChart.label" default="Menu Chart" /></th>
					
						<g:sortableColumn property="estimatedOrderValue" title="${message(code: 'menuOrder.estimatedOrderValue.label', default: 'Estimated Order Value')}" />
					
						<g:sortableColumn property="actualOrderValue" title="${message(code: 'menuOrder.actualOrderValue.label', default: 'Actual Order Value')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${menuOrderInstanceList}" status="i" var="menuOrderInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${menuOrderInstance.id}">${fieldValue(bean: menuOrderInstance, field: "orderDate")}</g:link></td>
					
						<td>${fieldValue(bean: menuOrderInstance, field: "requestedBy")}</td>
					
						<td>${fieldValue(bean: menuOrderInstance, field: "acceptedBy")}</td>
					
						<td>${fieldValue(bean: menuOrderInstance, field: "menuChart")}</td>
					
						<td>${fieldValue(bean: menuOrderInstance, field: "estimatedOrderValue")}</td>
					
						<td>${fieldValue(bean: menuOrderInstance, field: "actualOrderValue")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${menuOrderInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
