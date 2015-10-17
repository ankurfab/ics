
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
	<r:require module="jqui" />
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
            <span class="menuButton"><g:link class="create" action="create"><g:message code="Issue ReceiptBook" /></g:link></span>
            <span class="menuButton"><g:link class="list" action="status">ReceiptBookStatus</g:link></span>
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
	                        <td width="15%">Batch Id</td>
	                        <td width="85%"><g:textField name="sBatchId" /></td>
				</tr>
                    	
	                        <tr>
	                        <td width="15%">Receipt Book Series</td>
	                        <td width="85%"><g:textField name="sBookSeries" /></td>
				</tr>
                    	
	                        <tr>
	                        <td width="15%">Book Number</td>
	                        <td width="85%"><g:textField name="sBookNumber" /></td>
				</tr>
				
	                        <tr>
	                        <td width="15%">Collector</td>
	                        <td width="85%">
				    <div style="width: 200px">
					<gui:autoComplete
					    id="acCollector"
					    width="200px"
					    controller="individual"
					    action="findCollectorsAsJSON"
					    useShadow="true"
					    queryDelay="0.5" minQueryLength='3'
				    />
				    </div>
	                        
	                        </td>
				</tr>
	                        
	                        <tr>
	                        <td width="15%">Comments</td>
	                        <td width="85%"><g:textField name="sComments" /></td>
				</tr>
			</thead>
		</table>
                <div class="buttons">
                    <span class="button"><g:submitButton name="search" class="list" value="Search" /></span>
                </div>
		</g:form>
		<input class="menuButton" type="BUTTON" id="dlBtn" value="Download" />

            <br>
            <div class="list">
                <table id="example">
                    <thead>
                        <tr>
                        
                            <th></th>
                            
                            <th><g:message code="receiptBookIssued.batchId.label" default="Batch Id" /></th>
                            
                            <g:sortableColumn property="id" title="${message(code: 'receiptBookIssued.id.label', default: 'Id')}" />
                        	
                            <th><g:message code="receiptBookIssued.receiptBook.label" default="Receipt Book" /></th>
                   	    
                            <th><g:message code="receiptBookIssued.issuedTo.label" default="Issued To" /></th>
                            
                            <th>Councellor</th>
                   	    
                            <g:sortableColumn property="issueDate" title="${message(code: 'receiptBookIssued.issueDate.label', default: 'Issue Date')}" />
                        
                            <g:sortableColumn property="returnDate" title="${message(code: 'receiptBookIssued.returnDate.label', default: 'Return Date')}" />
                            
                            <g:sortableColumn property="status" title="${message(code: 'receiptBookIssued.status.label', default: 'Status')}" />
                        
                            <g:sortableColumn property="tempCash" title="${message(code: 'receiptBookIssued.tempCash.label', default: 'Cash')}" />

                            <g:sortableColumn property="tempCheque" title="${message(code: 'receiptBookIssued.tempCheque.label', default: 'Cheque')}" />

                            <g:sortableColumn property="comments" title="${message(code: 'receiptBookIssued.comments.label', default: 'Comments')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${receiptBookIssuedInstanceList}" status="i" var="receiptBookIssuedInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <!--<td align="center">${fieldValue(bean: receiptBookIssuedInstance, field: "batchId")}</td>-->
                            
                            <td><g:link action="issueacknowledgement" id="${receiptBookIssuedInstance.batchId}">Ack</g:link></td>
                            
                            <td><g:link action="editCollectors" id="${receiptBookIssuedInstance.batchId}">${fieldValue(bean: receiptBookIssuedInstance, field: "batchId")}</g:link></td>
                            
                            <td><g:link action="show" id="${receiptBookIssuedInstance.id}">${fieldValue(bean: receiptBookIssuedInstance, field: "id")}</g:link></td>
                            
                            <td>
                            <g:if test="${receiptBookIssuedInstance?.status=='Issued'}">
                            	<g:link controller="receiptBookIssued" action="edit" id="${receiptBookIssuedInstance?.id}">${fieldValue(bean: receiptBookIssuedInstance, field: "receiptBook")}</g:link>
                            </g:if>
                            <g:else>
                            	${fieldValue(bean: receiptBookIssuedInstance, field: "receiptBook")}
                            </g:else>
                            </td>
                        
                            <td>${fieldValue(bean: receiptBookIssuedInstance, field: "issuedTo")}</td>
                            
				<g:set var="crel" value="${ics.Relation.findByName('Councellee of')}" />
				<g:set var="counsellor" value="${ics.Relationship.findByIndividual1AndRelation(receiptBookIssuedInstance.issuedTo,crel)?.individual2}" />
                            
                            <td>${counsellor}</td>
                        
                            <td><g:formatDate format="dd-MM-yyyy" date="${receiptBookIssuedInstance.issueDate}" /></td>
                        
                            <td><g:formatDate format="dd-MM-yyyy" date="${receiptBookIssuedInstance.returnDate}" /></td>
                            
                            <td>${fieldValue(bean: receiptBookIssuedInstance, field: "status")}</td>
                        
                            <td>${fieldValue(bean: receiptBookIssuedInstance, field: "tempCash")}</td>
                        
                            <td>${fieldValue(bean: receiptBookIssuedInstance, field: "tempCheque")}</td>
                        
                            <td>${fieldValue(bean: receiptBookIssuedInstance, field: "comments")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <!--<div class="paginateButtons">
                <g:paginate total="${receiptBookIssuedInstanceTotal}" />
            </div>-->
        </div>
        
<script>
  $(document).ready(function () {
	$( "#dlBtn" )
		.button()
		.click(function() {
			var url = "${createLink(action:'downloadRBIssuedData')}"
			var win = window.open(url, '_blank');
			if(win){
			    //Browser has allowed it to be opened
			    win.focus();
			}else{
			    //Broswer has blocked it
			    alert('Please allow popups for this site');
			}			
		});
  });

</script>

    </body>
</html>
