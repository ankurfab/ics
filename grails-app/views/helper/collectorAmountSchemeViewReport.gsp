<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="100pc main1" />
        
        
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">Collector_Amount_Scheme Report</a></span>
        </div> 

	<g:if test="${dList?.size()>0}">
            <div class="list">
            
            <!--<div id="ft">
	    		
	    		
	    		<a style="text-decoration:underline; color:black;" href="http://www.iskconpune.com">Search By Amount Report</a>
	    		
			</div>-->
	
	            	<table>
	            		<g:if test="${fromcriteria}">
	                	<tr>
	                	
	                	<td>
	                	<b>Amount ${fromcriteria} ${fromamount} ${tocriteria} ${toamount}</b>
	                	</td>
	                	
	                	</tr>
	                	</g:if>
	                	<g:if test="${scheme}">
	                	<tr>
	                	
	                	<td>
	                	<b>Scheme: ${scheme}</b> 
	                	</td>
	                	
	                	</tr>
	                	</g:if>
                </table>
                <table>
                    <thead>
                    
                    
                    
                        <tr>
                            <th>Sr.No.</th>
                            <th>Collector</th>
                            
                            	<th>Amount</th>
                            
                            <th>DonorName</th>
                           	<g:if test="${!fromcriteria}">
                            	<th>Scheme</th>
                            </g:if>
                            <!--<th>Amount</th>-->
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${dList}" status="i" var="dListItem">
                    
                        <!--<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">-->
                        <tr class="prop">
                        
                            <td style="word-wrap: break-word">${i+1}</td>
                        <!--${dList[i][0]}
                        ${dList[i][1]}
                        ${dList[i][2]}
                        ${dList[i][3]}-->
							<td style="word-wrap: break-word"><g:link controller="individual" action="show" id="${dList[i][2]}">${ics.Individual.findById(dList[i][2])}</g:link></td>
							<g:if test="${!fromcriteria}">
                            	<td style="word-wrap: break-word">${dList[i][1]}</td>
                            </g:if>
                            <g:else>
                            	<td style="word-wrap: break-word">${dList[i][4]}</td>
                            </g:else>
                            <td style="word-wrap: break-word"><g:link controller="individual" action="show" id="${dList[i][0]}">${ics.Individual.findById(dList[i][0])}</g:link></td>
                            <g:if test="${!fromcriteria}">
                            	<td style="word-wrap: break-word">${ics.Scheme.findById(dList[i][3])}</td>
                           	</g:if>
                            
                        </tr>
                       
                    </g:each>
						<tr>
						   <td></td>
						   <td>Total</td>
						   <td>${totalAmt}</td>
						   <td></td>
						   <g:if test="${!fromcriteria}">
							<td></td>
						   </g:if>
						   
                       </tr>                    
                    
                    </tbody>
                </table>
            </div>
	</g:if>


        </div>
    </body>
</html>