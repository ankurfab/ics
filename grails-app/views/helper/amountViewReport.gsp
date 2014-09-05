<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Search By Amount Report</title>
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
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">Search By Amount Report</a></span>
        </div> 

	<g:if test="${individualList?.size()>0}">
            <div class="list">
            
            <!--<div id="ft">
	    		
	    		
	    		<a style="text-decoration:underline; color:black;" href="http://www.iskconpune.com">Search By Amount Report</a>
	    		
			</div>-->
	
	            	<table>
	                	<tr>

	                	<td>
	                	<b>Amount ${fromcriteria} ${fromamount} ${tocriteria} ${toamount}</b>
	                	</td>
	                	
	                	</tr>
                	<tr>
                	<td>
                	<b>Between Dates: ${fd.format("dd-MM-yy")} and ${td.format("dd-MM-yy")}</b>
                	</td>
                	</tr>
                </table>
                <table id="example">
                    <thead>
                    
                    
                    
                        <tr>
                        
                            <th>Id</th>
                            <th>DonorName</th>
                            <th>Amount</th>
                            <th>SubmissionDate</th>
                            <th>Category</th>
                            <th>Address</th>
                            <th>Phone</th>
                            <th>EmailId</th>
                            <th>CollectorName</th>

                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${individualList}" status="i" var="individualInstance">
                        <!--<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">-->
                        <tr class="prop">
                        
                            <td style="word-wrap: break-word"><g:link controller="individual" action="show" id="${individualInstance.id}">${fieldValue(bean: individualInstance, field: "id")}</g:link></td>
                        
                            <td style="word-wrap: break-word"><g:link controller="individual" action="show" id="${individualInstance.id}">${individualInstance.toString()}</g:link></td>
                            <td style="word-wrap: break-word"><b>${amountList[i]}</b></td>
                            <td style="word-wrap: break-word"><b>${dateList[i]?.format("dd-MM-yyyy")}</b></td>
                            <td style="word-wrap: break-word"><b>${individualInstance.category}</b></td>
                            <td style="word-wrap: break-word"><b>${individualInstance.address?.toString()}</b></td>
                            <td style="word-wrap: break-word"><b>${individualInstance.voiceContact?.toString()}</b></td>
                            <td style="word-wrap: break-word"><b>${individualInstance.emailContact?.toString()}</b></td>
                            <td style="word-wrap: break-word"><g:link controller="individual" action="show" id="${collectorList[i]}">${ics.Individual.findById(collectorList[i])}</g:link></td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
	</g:if>


        </div>
    </body>
</html>