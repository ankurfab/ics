
<%@ page import="ics.ReceiptBookIssued" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'receiptBookIssued.label', default: 'ReceiptBookIssued')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
	<gui:resources components="['autoComplete']"/>
	<style>
	.yui-skin-sam .yui-ac-content {
	  width: 350px !important;
	</style>
        
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
    
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">Home</a></span>
        </div>
        <div class="body">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>

		

            <br>
            <div class="list">
                <table id="example">
                    <thead>
                        <tr>
                        
                            
                            <g:sortableColumn property="id" title="${message(code: 'receiptBookIssued.id.label', default: 'Id')}" />
                        	
                            <th><g:message code="receiptBookIssued.receiptBook.label" default="Receipt Book" /></th>
                   	    
                            <th><g:message code="receiptBookIssued.issuedTo.label" default="Issued To" /></th>
                            
                            <th>Councellor</th>
                   	    
                            <g:sortableColumn property="issueDate" title="${message(code: 'receiptBookIssued.issueDate.label', default: 'Issue Date')}" />
                        
                            <g:sortableColumn property="returnDate" title="${message(code: 'receiptBookIssued.returnDate.label', default: 'Return Date')}" />
                            
                            <g:sortableColumn property="status" title="${message(code: 'receiptBookIssued.status.label', default: 'Status')}" />
                        
                            <g:sortableColumn property="comments" title="${message(code: 'receiptBookIssued.comments.label', default: 'Comments')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${patronCareReceiptBooks}" status="i" var="receiptBookIssuedInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                            
                            <td><g:link controller="receiptBookIssued" action="show" id="${receiptBookIssuedInstance.id}">${fieldValue(bean: receiptBookIssuedInstance, field: "id")}</g:link></td>
                            
                            <td>${fieldValue(bean: receiptBookIssuedInstance, field: "receiptBook")}</td>
                        
                            <td>${fieldValue(bean: receiptBookIssuedInstance, field: "issuedTo")}</td>
                            
				<g:set var="crel" value="${ics.Relation.findByName('Councellee of')}" />
				<g:set var="counsellor" value="${ics.Relationship.findByIndividual1AndRelation(receiptBookIssuedInstance.issuedTo,crel)?.individual2}" />
                            
                            <td>${counsellor}</td>
                        
                            <td><g:formatDate format="dd-MM-yyyy" date="${receiptBookIssuedInstance.issueDate}" /></td>
                        
                            <td><g:formatDate format="dd-MM-yyyy" date="${receiptBookIssuedInstance.returnDate}" /></td>
                            
                            <td>${fieldValue(bean: receiptBookIssuedInstance, field: "status")}</td>
                        
                            <td>${fieldValue(bean: receiptBookIssuedInstance, field: "comments")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>

        </div>
    </body>
</html>
