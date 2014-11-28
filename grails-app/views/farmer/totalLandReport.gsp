<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Total Land Report</title>
    </head>
    <body>
        <div class="body">
            <h1>Total Land Report</h1>

		<g:set var="sum" value="${0}" />
                <table id="report">
                    <thead>
                        <tr>
                        
                            <th>FirstName</th>
                            <th>MiddleName</th>
                            <th>LastName</th>
                            <th>Village</th>
                            <th>Taluka</th>
                            <th>District</th>
                            <th>ShareHolder</th>
                            <th>ShareCertificateNo</th>
                            <th>TotalLand</th>
                            <th>MobileNo</th>

                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${ics.Farmer.listOrderByFirstName()}" status="i" var="farmer">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                           
                            <td><b>${farmer.firstName?:''}</b></td>
                            <td><b>${farmer.middleName?:''}</b></td>
                            <td><b>${farmer.lastName?:''}</b></td>
                            <td><b>${farmer.village?:''}</b></td>
                            <td><b>${farmer.taluka?:''}</b></td>
                            <td><b>${farmer.district?:''}</b></td>
                            <td><b>${farmer.shareHolder?'Yes':'No'}</b></td>
                            <td><b>${farmer.shareCertificateNo?:''}</b></td>
                            <td><b>${farmer.areaOfTotalLand}</b></td>
                            <td><b>${farmer.mobileNo}</b></td>
                            
                            	<g:set var="sum" value="${sum + farmer.areaOfTotalLand}" />
                            
                         </tr>
                    </g:each>

                    </tbody>
                </table>
                <table>
                <tr>
                <td>
                <b>Total Land across all farmers</b>
                </td>
                <td>
                <b>${sum}</b>
                </td>
                </tr>
                </table>

        </div>
    </body>
</html>