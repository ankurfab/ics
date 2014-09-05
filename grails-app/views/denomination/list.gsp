
<%@ page import="ics.Denomination" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'denomination.label', default: 'Denomination')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
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
        $(document).ready(function()
        {
          $("#sColDate").datepicker({yearRange: "-1:+0",dateFormat: 'dd-mm-yy'});
          $("#sAckDate").datepicker({yearRange: "-1:+0",dateFormat: 'dd-mm-yy'});
        })		
    </script>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="list" controller="donation" action="showChequesDue">DueCheques</g:link></span>
	      <sec:ifAnyGranted roles="ROLE_NVCC_ADMIN">
            <span class="menuButton"><g:link class="create" action="merge">Merge</g:link></span>
	      </sec:ifAnyGranted>
        </div>
        <div class="body">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
	    <a href="javascript:toggleSearchParams()">Search Parameters </a>
	    
	    <div id='div-search' class="dialog" style="display: none">

		<g:form name="searchForm" action="search" >
               	<table>
                    <thead>
	                        <tr>
	                        <td>Receiver Name</td>
	                        <td><g:textField name="sColName" /></td>
				</tr>
	                        <tr>
	                        <td>Collection Date</td>
	                        <td><g:textField name="sColDate" /></td>
				</tr>
	                        <tr>
	                        <td>Ack Name</td>
	                        <td><g:textField name="sAckName" /></td>
				</tr>
	                        <tr>
	                        <td>Ack Date</td>
	                        <td><g:textField name="sAckDate" /></td>
				</tr>
	                        <tr>
	                        <tr>
	                        <td>Ack Ref</td>
	                        <td><g:textField name="sAckRef" /></td>
	                        </tr>
	                        <tr>
	                        <td>Comments</td>
	                        <td><g:textField name="sComments" /></td>
				</tr>
				<tr>
	                        <td>Status</td>
	                        <td><g:textField name="sStatus" /></td>
				</tr>
			</thead>
		</table>
                <div class="buttons">
                    <span class="button"><g:submitButton name="search" class="list" value="Search" /></span>
                </div>
                <br>
		</g:form>
            </div>

            <div class="list">
                <table width="80%"  id="example">
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${message(code: 'denomination.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="collectionDate" title="${message(code: 'denomination.collectionDate.label', default: 'Collection Date')}" />
                        
                            <th><g:message code="denomination.collectedBy.label" default="Received By" /></th>
                            
                            <th width="40%"> Denomination </th>
                            
                            <g:sortableColumn property="status" title="${message(code: 'denomination.status.label', default: 'Status')}" />
                            <g:sortableColumn property="ackBy" title="${message(code: 'denomination.ackBy.label', default: 'Ack By')}" />
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${denominationInstanceList}" status="i" var="denominationInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${denominationInstance.id}">${fieldValue(bean: denominationInstance, field: "id")}</g:link></td>
                        
                            <td><g:formatDate format="dd-MM-yyyy" date="${denominationInstance.collectionDate}" /></td>
                        
                            <td style="word-wrap: break-word" width="50%">${fieldValue(bean: denominationInstance, field: "collectedBy")}</td>
                            
                            <td>
                            <!--${denominationList}-->
								<table>
									<g:each in="${denominations[i]}" status="l" var="denominationsVar">
									
										<tr>
											<td>
												<g:if test="${denominationsVar.contains('Total')}">
													<b>${denominationsVar}<b>
												</g:if>
												<g:else>
													${denominationsVar}
												</g:else>
											</td>
											<!--<td>
												${denominationListVar}
											</td>-->
										</tr>
										
										
									</g:each>
								</table>
                            <!--${denominationInstance} -->
                            </td>
                        
                            <td> ${denominationInstance.status} </td>
                        
                            <td> ${denominationInstance.ackBy} </td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <g:if test="${!search}">
            <div class="paginateButtons">
                <g:paginate total="${denominationInstanceTotal}" />
            </div>
            </g:if>
        </div>
        <script language="javascript"> 
	    function toggleSearchParams() {
		var ele = document.getElementById("div-search");
		if (ele.style.display == "block") 
			{
				ele.style.display = "none";
			}
		else
			ele.style.display = "block";
	    } 
	</script>
    </body>
</html>
