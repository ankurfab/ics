
<%@ page import="ics.IndividualCourse" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'individualCourse.label', default: 'IndividualCourse')}" />
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

		<div id="list-individualCourse" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table id="example">
				<thead>
					<tr>
					
						<th><g:message code="individualCourse.individual.label" default="Individual" /></th>
					
						<th><g:message code="individualCourse.course.label" default="Course" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${individualCourseInstanceList}" status="i" var="individualCourseInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${individualCourseInstance.id}">${fieldValue(bean: individualCourseInstance, field: "individual")}</g:link></td>
					
						<td>${fieldValue(bean: individualCourseInstance, field: "course")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
		</div>
	</body>
</html>
