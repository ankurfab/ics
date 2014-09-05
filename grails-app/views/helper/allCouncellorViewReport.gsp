<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>All Councellors Report</title>
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
			    <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">All Councellors Report</a></span>
        	</div><br>
	<g:if test="${cList?.size()>0}">

            <div id="demo">
                <table>
                        <tr class="none"}">
                            <td width="10%"><b>From ${fd?.format("dd-MM-yyyy")} To ${td?.format("dd-MM-yyyy")}</b></td>
                           
                        </tr>
                </table>
                <table id="example">
                    <thead>


                        <tr>
                        
                            <th>Councellor</th>
                            <th>Councellee Legal Name</th>
                            <th>Councellee Initiated Name</th>
                            
                            <th>Collection</th>
			    <th>Date</th>
			    
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${cList}" status="i" var="individualInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                            <td><b><g:link controller="individual" action="show" id="${individualInstance.councellor_id}">${individualInstance.councellor_name}</g:link></b></td>
                            <td><b><g:link controller="individual" action="show" id="${individualInstance.councellee_id}">${individualInstance.councellee_legal_name}</g:link></b></td>
                            <td><b><g:link controller="individual" action="show" id="${individualInstance.councellee_id}">${individualInstance.councellee_initiated_name}</g:link></b></td>

                            <td><b>${individualInstance.collection}</b></td>
			    <td><b>${individualInstance.submissionDate.format("dd-MM-yyyy")}</b></td>
			    
                        </tr>
                    </g:each>
                    </tbody>
                </table>
                
            </div>
	</g:if>


        </div>
    </body>
</html>