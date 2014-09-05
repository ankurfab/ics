<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Councellorwise Advance Donation Summary Report</title>
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
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">Councellorwise Advance Donation Summary Report</a></span>
        </div> 

            <div class="list">
                           <!--<div id="ft">
	    	    	    	    		
	    	    	    	    		<a style="text-decoration:underline; color:black;" href="http://www.iskconpune.com">Councellorwise Advance Donation Summary Report</a>
	    	    	    	    		
	    	    	    	</div>-->
	    	    	    	<br>
	    	    	    	<div>
	    	    	    		<b>Councellor: ${councellor}<b>
	    	    	    	</div>
 							<br>
                <table id="example">
                    <thead>
                        <tr>
                        
                            <th>Total Amount</th>
                        	<th>FD Amount</th>
                        </tr>
                    </thead>
                    <tbody>
                    
                        <tr>
                            <td align="center">${totalAmount}</td>
                            <td align="center">${totalFDAmount}</td>
                        </tr>
                    </tbody>
                </table>
            </div>


        </div>
    </body>
</html>