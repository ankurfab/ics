<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>All Collections Report</title>
	<link rel="stylesheet" href="${resource(dir: 'css/datatable', file: 'demo_page.css')}" type="text/css" media="print, projection, screen"/>
	<link rel="stylesheet" href="${resource(dir: 'css/datatable', file: 'demo_table.css')}" type="text/css" media="print, projection, screen"/>
	<link rel="stylesheet" href="${resource(dir: 'css/datatable', file: 'TableTools.css')}" type="text/css" media="print, projection, screen"/>
    </head>
    <body>
    	
        <div class="body">
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
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">All Collections Report</a></span>
        </div> 

	<g:set var="sum" value="${0}" />
            <div class="list">
                <table>
                        <tr class="none"}">
                            <td width="10%"><b>From ${fd?.format("dd-MM-yyyy")} To ${td?.format("dd-MM-yyyy")}</b></td>
                           
                        </tr>
                </table>

                <table id="example">
                    <thead>
                        <tr>
                        
                            <th>Collector Legal Name</th>
                            <th>Collector Initiated Name</th>
                            <th>Collector Contact</th>
                            <th>Collection Amount</th>
                            

                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${collectionsResult}" status="i" var="collectionsResultInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                            
                            <td  style="word-wrap: break-word"><g:link controller="individual" action="show" id="${collectionsResultInstance?.collected_by_id}">${collectionsResultInstance?.legal_name}</g:link></td>
                            <td  style="word-wrap: break-word"><g:link controller="individual" action="show" id="${collectionsResultInstance?.collected_by_id}">${collectionsResultInstance?.initiated_name}</g:link></td>
                            <td  style="word-wrap: break-word">${collectionsResultInstance?.number}</td>
                            <td  style="word-wrap: break-word"><b>${collectionsResultInstance?.amt}</b></td>
                           
                            <g:set var="sum" value="${sum + collectionsResultInstance?.amt}" />
                        </tr>
                    </g:each>
                    </tbody>
                </table>
                <table>
                        <tr class="none"}">
                            <td width="10%"><b>Total</b></td>
                            <td width="90%"><b>${sum}</b></td>
                        </tr>
                </table>
            </div>
        </div>
    </body>
</html>