<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Family Donations Report</title>        
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
 				<span class="menuButton"><a class="home" href="${createLink(uri: '/')}">Family Donations Report</a></span>
			</div>
    
        <div class="body">
            <div class="list">
   
 		<br>
                <table id="example">
                    <thead>
                        <tr>
                            <th>Id</th>
                            <th>Legal Name</th>
                            <th>Initiated Name</th>
                            <th>Family</th>
			    <th>Individual Donation</th>
			    <th>Family Donation</th>
                            
                        </tr>
                    </thead>
                    <tbody>
                    	<g:each in="${amtFam}" status="i" var="individualInstance">
			<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                            <td><g:link controller="individual" action="show" id="${individualInstance?.donorid}"><g:formatNumber number="${individualInstance?.donorid}" format="#" /></g:link></td>
                        
                            <td>${ics.Individual.get(individualInstance?.donorid)?.legalName}</td>
                            <td>${ics.Individual.get(individualInstance?.donorid)?.initiatedName}</td>							
                            <td>
                            	<g:each in="${ics.Individual.get(individualInstance?.donorid)?.relative2?}" var="r">
				<g:if test="${r?.relationshipGroup?.groupName != 'dummy'}">
				    <li><g:link controller="relationship" action="show" id="${r.id}">${r?.encodeAsHTML()}</g:link></li>
				</g:if>
				</g:each>
				<g:each in="${ics.Individual.get(individualInstance?.donorid)?.relative1?}" var="r">
					<g:if test="${r?.relationshipGroup?.groupName != 'dummy'}">
					    <li><g:link controller="relationship" action="show" id="${r.id}">${(r?.relation?.toString() +" -> " + r?.individual2)?.encodeAsHTML()}</g:link></li>
					</g:if>
				</g:each>			
			    </td>
			    <td>${individualInstance.amount}</td>
			    
			    <td>${individualInstance.famount}</td>								

                        </tr>
			</g:each>
                    </tbody>
                </table>
            </div>

        </div>
        
    </body>
    
</html>