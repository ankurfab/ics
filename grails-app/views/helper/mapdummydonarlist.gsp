<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Map Dummy Donar</title>
    </head>
    <body>
        <div class="body">
            <h1>Dummy Donars</h1>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                            <th> DummyDonar </th>
                            <th> MappedDonar </th>
                            
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${retList}" status="i" var="donar">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td> ${donar[0]} </td>
                        
                            <td> <g:link controller="individual" action="show" id="${donar[1]?.id}">${donar[1]}</g:link></td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
       </div>
    </body>
</html>