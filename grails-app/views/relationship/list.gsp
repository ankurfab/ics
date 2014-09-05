
<%@ page import="ics.Relationship" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'relationship.label', default: 'Relationship')}" />
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
            <!--<span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>-->
        </div>
        <div class="body">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>

		<g:form name="searchForm" action="search" >
               	<table>
                    <thead>
                    	
	                        <tr>
	                        <td>Relationship Group</td>
	                        <td><g:textField name="sRelationshipGroup" /></td>
				</tr>
	                        <tr>
	                        <td>Individual1</td>
	                        <td><g:textField name="sIndividual1" /></td>
				</tr>
	                        <td>Relation</td>
	                        <td><g:textField name="sRelation" /></td>
				</tr>
	                        <tr>
	                        <td>Individual2</td>
	                        <td><g:textField name="sIndividual2" /></td>
				</tr>
	                        <tr>
	                        <td>Status</td>
	                        <td><g:textField name="sStatus" /></td>
				</tr>
				
	                        <tr>
	                        <td>Comments</td>
	                        <td><g:textField name="sComments" /></td>
				</tr>
			</thead>
		</table>
                <div class="buttons">
                    <span class="button"><g:submitButton name="search" class="list" value="Search" /></span>
                </div>
		</g:form>

            <div class="list">
                <table id="example">
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${message(code: 'relationship.id.label', default: 'Id')}" />
                        
                            <th><g:message code="relationship.relationshipGroup.label" default="Relationship Group" /></th>
                   	    
                            <th><g:message code="relationship.individual1.label" default="Individual1" /></th>
                   	    
                            <th><g:message code="relationship.relation.label" default="Relation" /></th>
                   	    
                            <th><g:message code="relationship.individual2.label" default="Individual2" /></th>
                            
                            <th><g:message code="relationship.status.label" default="Status" /></th>
                   	    
                            <g:sortableColumn property="comment" title="${message(code: 'relationship.comment.label', default: 'Comment')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${relationshipInstanceList}" status="i" var="relationshipInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${relationshipInstance.id}">${fieldValue(bean: relationshipInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: relationshipInstance, field: "relationshipGroup")}</td>
                        
                            <td>${fieldValue(bean: relationshipInstance, field: "individual1")}</td>
                        
                            <td>${fieldValue(bean: relationshipInstance, field: "relation")}</td>
                        
                            <td>${fieldValue(bean: relationshipInstance, field: "individual2")}</td>
                            
                            <td>${fieldValue(bean: relationshipInstance, field: "status")}</td>
                        
                            <td>${fieldValue(bean: relationshipInstance, field: "comment")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${relationshipInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
