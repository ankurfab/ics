<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Birthday Report</title>
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
		<span class="menuButton"><a class="home" href="${createLink(uri: '/')}">Birthday Report</a></span>
	    </div>
    
        <div class="body">
            <!--<div class="list">-->
   		<div id="demo">
 		<br>
                <table id="example">
                    <thead>
                        <tr>
                            <th>Legal Name</th>
                            <th>Initiated Name</th>
                            <th>Birthdate</th>
                            <th>Address</th>
                            <th>Phone</th>
                            <th>Email</th>
                        </tr>
                    </thead>
                    <tbody>
                    	<g:each in="${birthdayList}" status="i" var="bDay">
				<tr class="none">
					<td><b><g:link controller = "individual" action="show" id="${bDay?.id}">${bDay?.legalName}</g:link></b></td>
					<td><b>${bDay?.initiatedName}</b></td>
					<td><b>${bDay?.dob?.format('dd-MM-yyyy')}</b></td>
					<td><b>${bDay?.address}</b></td>
					<td><b>${bDay?.voiceContact}</b></td>
					<td><b>${bDay?.emailContact}</b></td>
				</tr>
			</g:each>
                    </tbody>
                </table>
            </div>

        </div>
    </body>
</html>