<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="100pc main1" />
    </head>
    <body>
        <div class="body">
            
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">ISKCON Representative Report</a></span>
        </div>
	<g:if test="${individualList?.size()>0}">

            <div class="list">
                <!--<div id="ft">
	    	    	    	
	    	    	    		<a style="text-decoration:underline; color:black;" href="http://www.iskconpune.com">ISKCON Representative Report</a>
	    	    	    		
	    	    	</div>-->
  
            	<table>
                	<tr>
                	<td>
                	<b>ISKCON Representative: <g:link controller="individual" action="show" id="${cultivator?.id}">${cultivator}</b></g:link>
                	</td>
                	</tr>
                </table>
                </div>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                            <th>IndividualId</th>
                            <th>Name</th>
                            <th>Address</th>
                            <th>Phone</th>
                            <th>EmailId</th>
                            <th>Donation(s)</th>
                            <th>Amount</th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${individualList}" status="i" var="individualInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                            <td><g:link controller="individual" action="show" id="${individualInstance?.id}">${individualInstance?.id}</g:link></td>
                            <td><b>${individualInstance}</b></td>
                            <td><b>${individualInstance?.address?.toString()}</b></td>
                            <td><b>${individualInstance?.voiceContact?.toString()}</b></td>
                            <td><b>${individualInstance?.emailContact?.toString()}</b></td>
                            <td><b>${donationMap[individualInstance?.id]}</b></td>
                            <td><b>${amountMap[individualInstance?.id]}</b></td>
                         </tr>
                    </g:each>
                         <tr>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td><b>Total</b></td>
                            <td><b>${sum}</b></td>
                         </tr>
                    </tbody>
                </table>
            </div>
	</g:if>


        </div>
    </body>
</html>