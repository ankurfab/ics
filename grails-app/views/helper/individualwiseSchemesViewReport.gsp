<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Individualwise Schemes Report</title>
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
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">Individualwise Schemes Report</a></span>
        </div>     
        <div class="body">
            


	<g:if test="${schemeMemberList?.size()>0}">
	<g:set var="sum" value="${0}" />
            <div class="list">
                           <!--<div id="ft">
	    	    	    	    		
	    	    	    	    		<a style="text-decoration:underline; color:black;" href="http://www.iskconpune.com">Individualwise Schemes Report</a>
	    	    	    	    		
	    	    	    	</div>-->
 				<br><b>Individual: ${member}</b><br><br>
                <table id="example">
                    <thead>
                        <tr>
                        
                            <th>Sr.No.</th>
                            <th>Scheme</th>


                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${schemeMemberList}" status="i" var="schemeMemberInstance">
                        <tr>
                            <td><b>${i+1}</b></td>
                            <td><b>${schemeMemberInstance?.scheme}</b></td>

                        </tr>
                    </g:each>

                    </tbody>
                </table>
            </div>
	</g:if>


        </div>
    </body>
</html>