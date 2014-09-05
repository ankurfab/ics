<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Rolewise Address Report</title>        
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
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">Rolewise Address Report</a></span>
        </div> 

            <div class="list">
                           <!--<div id="ft">
	    	    	    	    		<a style="text-decoration:underline; color:black;" href="http://www.iskconpune.com">Rolewise Address Report</a>
	    	    	    	    		<br><br><b>Role: ${role}</b>
	    	    	    	</div>-->
 							<br>
	            	<table>
	                	<tr>

	                	<td>
	                	<b>Addresses of ${role}(s)</b>
	                	</td>
	                	
	                	</tr>
                </table>
 							
                <table id="example">
                    <thead>
                        <tr>
                        	<th>Sr. No.</th>
                            <th>Name</th>
                        	<th>Address</th>
                        </tr>
                    </thead>
                    <tbody>
                    	<g:each in="${indv}" status="i" var="indvName">
				<tr class="none">
					<td><b>${i+1}</b></td>
					<td><b>${indvName}</b></td>
					<td><b>${addr[i]}</b></td>
				</tr>
			</g:each>
                    </tbody>
                </table>
            </div>

        </div>
    </body>
</html>