
<%@ page import="ics.Flags" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'flags.label', default: 'Flags')}" />
        <title>Under Verification List</title>
	<link rel="stylesheet" href="${resource(dir: 'css/tablesort-theme', file: 'style.css')}" type="text/css" media="print, projection, screen"/>
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
		    $('#listTable').dataTable( {
			"sDom": 'T<"clear">lfrtip',
			"oTableTools": {
			    "sSwfPath": "${resource(dir: 'swf', file: 'copy_csv_xls_pdf.swf')}"
			}
		    } );
		} );

	</script>                
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
        </div>
        <div class="body">
            <h1>Under Verification List</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table id="listTable">
                    <thead>
                        <tr>
                        
                        <th>Individual</th>
                        <th>TelephoneVerified?</th>
                        <th>TelePhone</th>
                        <th>EmailVerified?</th>
                        <th>Email</th>
                        <th>AddressVerified?</th>
                        <th>Address</th>
                        <th>Comments</th>
                        <th>LastUpdated</th>
                        
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${flagsInstanceList}" status="i" var="flagsInstance">
                    	<g:set var="ind" value="${ics.Individual.get(flagsInstance?.individualid)}" />
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${flagsInstance.id}">${ind}</g:link></td>

                            <td><g:formatBoolean boolean="${flagsInstance.telephoneNo}" /></td>
                            
                            <td>${ind?.voiceContact?.toString()}</td>
                        
                            <td><g:formatBoolean boolean="${flagsInstance.email}" /></td>
                        
                            <td>${ind?.emailContact?.toString()}</td>
                        
                            <td><g:formatBoolean boolean="${flagsInstance.address}" /></td>
                            
                            <td>${ind?.address?.toString()}</td>
                        
                            <td>${flagsInstance.comments}</td>
                        
                            <td><g:formatDate date="${flagsInstance.lastUpdated}" /></td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
        </div>
    </body>
</html>
