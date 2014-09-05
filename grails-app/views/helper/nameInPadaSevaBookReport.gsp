<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Name in Padaseva Book Report</title>        
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
 				<span class="menuButton"><a class="home" href="${createLink(uri: '/')}">Name in Padaseva Book Report</a></span>
			</div>
    
        <div class="body">
            <div class="list">
   
 							<br>
                <table id="example">
                    <thead>
                        <tr>
                        	<th>Sr.No.</th>
                            <th>Donor Name</th>
                        	<th>Name In Pada Seva Book</th>
                        </tr>
                    </thead>
                    <tbody>
                    	<g:each in="${nameInPadaSevaBookList}" status="i" var="pdbName">
							<tr class="none">
								<td><b>${i+1}</b></td>
								<td><b>${pdbName[0]}</b></td>
								<td><b>${pdbName[1]}</b></td>
							</tr>
						</g:each>
                    </tbody>
                </table>
            </div>

        </div>
        
    </body>
    
</html>