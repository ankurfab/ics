<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Datewise Councellor Councellee Report</title>
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
			    <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">Councellor Councelle Report</a></span>
        	</div><br>
	<g:if test="${individualList?.size()>0}">
            <div id="demo">
     
  
            	<table>
                	<tr>
                	<td>
                	<b>CouncellorName: <g:link controller="individual" action="show" id="${councellorId}">${councellorName}</b></g:link>
                	</td>
                	</tr>
                	<tr>
                	<td>
                	<b>Between Dates: ${fd.format("dd-MM-yy")} and ${td.format("dd-MM-yy")}</b>
                	</td>
                	</tr>
                	
                </table>
                </div>
            <div id="demo">
                <table id="example">
                    <thead>


                        <tr>
                        
                            <th>Id</th>
                            <th>Name</th>
                            <th>IndividualContribution</th>
                            <th>Collection</th>
                            <th>Address</th>
                            <th>Phone</th>
                            <th>EmailId</th>

                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${individualList}" status="i" var="individualInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                            <td><g:link controller="individual" action="show" id="${individualInstance.id}">${fieldValue(bean: individualInstance, field: "id")}</g:link></td>
                            <td><b>${individualInstance.toString()}</b></td>
                            <td><b>${amountMap[individualInstance.id]}</b></td>
                            <td><b>${collectorMap[individualInstance.id]=='Yes'?'':'Not a Collector'}${collectionMap[individualInstance.id]}</b></td>
                            <td><b>${individualInstance.address?.toString()}</b></td>
                            <td><b>${individualInstance.voiceContact?.toString()}</b></td>
                            <td><b>${individualInstance.emailContact?.toString()}</b></td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
                <table>
                	
                	<tr>
				<td width="20%"><b>Total Individual Contribution</b></td>
				<td width="80%"><b>${totalIndividualAmt}</b></td>
                	</tr>
  
                            <td width="20%"><b>Total Collection</b></td>
                            <td width="80%"><b>${totalCollectionAmt}</b></td>

		</table>
                
            </div>
	</g:if>


        </div>
    </body>
</html>