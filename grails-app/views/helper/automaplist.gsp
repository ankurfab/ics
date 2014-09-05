<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>AutoMapped Dummy Donations</title>
    </head>
    <body>
        <div class="body">
            <h1>Dummy Donations</h1>
            <g:form method="post">
            <g:hiddenField name="donationIdList" value="${donationIdList}" />
            <div class="list">
                <table>
                    <thead>
                        <tr>
                            <th> Donar </th>
                            <th> MappedDonar </th>
                            
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${donationList}" status="i" var="donation">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td> <g:link controller="donation" action="show" id="${donation?.id}">${donation?.comments} </g:link></td>
                        
                            <td> <g:link controller="individual" action="show" id="${donation?.donatedBy?.id}">${donation?.donatedBy}</g:link></td>

                            <td> <g:checkBox name="myCheckbox" value="${donation?.id}" /> </td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
			<div class="buttons">
				<span class="button"><g:actionSubmit class="save" action="automap" value="Automap" /></span>
				
			</div>
            
       </div>
       </g:form>
    </body>
</html>