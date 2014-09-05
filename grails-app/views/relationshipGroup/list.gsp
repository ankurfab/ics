
<%@ page import="ics.RelationshipGroup" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'relationshipGroup.label', default: 'RelationshipGroup')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
        <gui:resources components="['autoComplete']"/>
	<link rel="stylesheet" href="${resource(dir: 'css/datatable', file: 'demo_page.css')}" type="text/css" media="print, projection, screen"/>
	<link rel="stylesheet" href="${resource(dir: 'css/datatable', file: 'demo_table.css')}" type="text/css" media="print, projection, screen"/>
	<link rel="stylesheet" href="${resource(dir: 'css/datatable', file: 'TableTools.css')}" type="text/css" media="print, projection, screen"/>
	<link rel="stylesheet" href="${resource(dir: 'css/start', file: 'jquery-ui-1.8.18.custom.css')}" type="text/css">
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

    <g:javascript src="jquery-ui-1.8.18.custom.min.js" />
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">Home</a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table id="example">
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${message(code: 'relationshipGroup.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="groupName" title="${message(code: 'relationshipGroup.groupName.label', default: 'Group Name')}" />
                        
                            <g:sortableColumn property="comments" title="${message(code: 'relationshipGroup.comments.label', default: 'Comments')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${relationshipGroupInstanceList}" status="i" var="relationshipGroupInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${relationshipGroupInstance.id}">${fieldValue(bean: relationshipGroupInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: relationshipGroupInstance, field: "groupName")}</td>
                        
                            <td>${fieldValue(bean: relationshipGroupInstance, field: "comments")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${relationshipGroupInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
