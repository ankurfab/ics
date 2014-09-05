
<%@ page import="ics.IndividualRole" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'individualRole.label', default: 'IndividualRole')}" />
        <title>Search Individual By Role Result</title>
        <g:javascript library="jquery" />
		<link rel="stylesheet" href="${resource(dir: 'css/start', file: 'jquery-ui-1.8.18.custom.css')}" type="text/css">
		<link rel="stylesheet" href="${resource(dir: 'css/blue', file: 'style.css')}" type="text/css">
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
<g:javascript src="jquery.tablesorter.min.js" />
<g:javascript src="jquery-ui-1.8.18.custom.min.js" />
<script>
$(document).ready(function(){
   $("a").click(function(event){
   });
   $( "#datepicker" ).datepicker({yearRange: "-5:+5",changeMonth: true,changeYear: true,
			dateFormat: 'dd-mm-yy'});
  $("#myTable").tablesorter(); 
  		    $('#example').dataTable( {
  			"sDom": 'T<"clear">lfrtip',
  			"oTableTools": {
  			    "sSwfPath": "${resource(dir: 'swf', file: 'copy_csv_xls_pdf.swf')}"	
  			}
  		    } );

 });
 </script>
    
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
            <!--<span class="menuButton"><a class="list" href="${createLink(uri: '/searchIndividualByrole.gsp')}">SearchByRole</a></span>-->
            <span class="menuButton"><g:link class="create" controller="helper" action="searchIndividualByRole">SearchByRole</g:link></span>
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
                        
                            <!--<g:sortableColumn property="id" title="${message(code: 'individualRole.id.label', default: 'Id')}" />
                            
                            <g:sortableColumn property="individual" title="${message(code: 'individualRole.individual.label', default: 'Individual')}" />
                        
                            <g:sortableColumn property="role" title="${message(code: 'individualRole.role.label', default: 'Role')}" />
                        	
                            <g:sortableColumn property="status" title="${message(code: 'individualRole.status.label', default: 'Status')}" />
                        
                            <g:sortableColumn property="dateCreated" title="${message(code: 'individualRole.dateCreated.label', default: 'Date Created')}" />
                        
                            <g:sortableColumn property="creator" title="${message(code: 'individualRole.creator.label', default: 'Creator')}" />
                        -->
                        	<th>Id</th>
                        	<th>Individual</th>
                        	<th>Role</th>
                        	<th>Status</th>
                        	<th>Date Created</th>
                        	<th>Creator</th>
                           
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${individualRoleInstanceList}" status="i" var="individualRoleInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${individualRoleInstance.id}">${fieldValue(bean: individualRoleInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: individualRoleInstance, field: "individual")}</td>
                        
                            <td>${fieldValue(bean: individualRoleInstance, field: "role")}</td>
                        
                            <td>${fieldValue(bean: individualRoleInstance, field: "status")}</td>
                        
                            <td><g:formatDate format="dd-MM-yyyy" date="${individualRoleInstance.dateCreated}" /></td>
                        
                            <td>${fieldValue(bean: individualRoleInstance, field: "creator")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${individualRoleInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
