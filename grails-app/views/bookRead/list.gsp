
<%@ page import="ics.BookRead" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'bookRead.label', default: 'BookRead')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
		<link rel="stylesheet" href="${resource(dir: 'css/datatable', file: 'demo_page.css')}" type="text/css" media="print, projection, screen"/>
		<link rel="stylesheet" href="${resource(dir: 'css/datatable', file: 'demo_table.css')}" type="text/css" media="print, projection, screen"/>
		<link rel="stylesheet" href="${resource(dir: 'css/datatable', file: 'TableTools.css')}" type="text/css" media="print, projection, screen"/>
	</head>
	<body>
		<g:javascript src="datatable/jquery.dataTables.min.js" />    
		<g:javascript src="datatable/ZeroClipboard.js" />    
		<g:javascript src="datatable/TableTools.min.js" />    

			<script type="text/javascript" charset="utf-8">
			$(document).ready( function () {
			    $('#example').dataTable( {
				"sDom": 'T<"clear">lfrtip',
				"oTableTools": {
				    "sSwfPath": "${resource(dir: 'swf', file: 'copy_csv_xls_pdf.swf')}"
				}
			    } );
			} );

		</script>

		<div id="list-bookRead" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table id="example">
				<thead>
					<tr>
					
						<th><g:message code="bookRead.individual.label" default="Individual" /></th>
					
						<th><g:message code="bookRead.book.label" default="Book" /></th>
										
					</tr>
				</thead>
				<tbody>
				<g:each in="${bookReadInstanceList}" status="i" var="bookReadInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${bookReadInstance.id}">${fieldValue(bean: bookReadInstance, field: "individual")}</g:link></td>
					
						<td>${fieldValue(bean: bookReadInstance, field: "book")}</td>
										
					</tr>
				</g:each>
				</tbody>
			</table>
		</div>
	</body>
</html>
