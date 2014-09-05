<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Followup Report</title>
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
        <div class="body">
            
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">Followup Report</a></span>
        </div> 

	<g:if test="${followupList?.size()>0}">
	
            <div class="list">
            
            	<table>
                	<tr>
                	<td>
                	<b>Followup By: <g:link controller="individual" action="show" id="${followupBy?.id}">${followupBy}</b></g:link>
                	</td>
                	</tr>
                </table>
                </div>
            <div class="list">
                <table id="example">
                    <thead>
                        <tr>
                        
                            <th>FollowupId</th>
                            <th>Followup With</th>
                            <th>StartDate</th>
                            <th>Category</th>
                            <th>Description</th>
                            <th>Comments</th>
                            <th>Status</th>
                            <th>Reference</th>
                            
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${followupList}" status="i" var="followupInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                            <td  style="word-wrap: break-word"><g:link controller="followup" action="show" id="${followupInstance?.id}">${followupInstance?.id}</g:link></td>
                            <td  style="word-wrap: break-word"><g:link controller="individual" action="show" id="${followupInstance?.followupWith?.id}">${followupInstance?.followupWith}</g:link></td>
                            <td  style="word-wrap: break-word"><b>${followupInstance?.startDate.format('dd-MM-yyyy')}</b></td>
                            <td  style="word-wrap: break-word"><b>${followupInstance?.category}</b></td>
                            <td  style="word-wrap: break-word"><b>${followupInstance?.description}</b></td>
                            <td  style="word-wrap: break-word"><b>${followupInstance?.comments}</b></td>
                            <td  style="word-wrap: break-word"><b>${followupInstance?.status}</b></td>
                            <td  style="word-wrap: break-word"><b>${followupInstance?.ref}</b></td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
	</g:if>


        </div>
    </body>
</html>