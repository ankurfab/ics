<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Areawise Collections Report</title>        
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
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">Areawise Collections Report</a></span>
        </div> 

            <div class="list">
                           <!--<div id="ft">
	    	    	    	    		<a style="text-decoration:underline; color:black;" href="http://www.iskconpune.com">Rolewise Address Report</a>
	    	    	    	    		<br><br><b>Role: ${role}</b>
	    	    	    	</div>-->
 							<br>

 				<g:set var="sum" value="${0}" />			
                <table id="example">
                    <thead>
                        <tr>
                        	<th>Sr. No.</th>
                            	<th>Area</th>
                        	<th>Collection</th>
                        </tr>
                    </thead>
                    <tbody>
                    	<g:each in="${temp}" status="i" var="areaCollection">
				<tr class="none">
					<td><b>${i+1}</b></td>
					<td><b>${areaCollection}</b></td>
					<td><b>${collection_location[i]}</b></td>
					<g:set var="sum" value="${sum + collection_location[i]}" />
				</tr>
			</g:each>
                    </tbody>
                </table>
                <table>
                <tr>
                <td>
                <b>Total</b>
                </td>
                <td>
                <b>${sum}</b>
                </td>
                </tr>
                </table>                
            </div>

        </div>
    </body>
</html>