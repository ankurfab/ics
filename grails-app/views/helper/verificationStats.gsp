<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Contact Data Correction and Verification Report</title>
    </head>
    <body>
        <div class="body">
        <g:link action="verificationStats"><h1>Contact data verification status</h1></g:link>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <h2>Summary</h2>
            <div class="dialog">
                <table>
                    <tbody>
                    <thead>
                        <tr>
                        
                            <th>Status</th>
                            <th>Count</th>
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${stats}" status="i" var="s">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td>${s.formstatus}</td>
                        
                            <td>
                            <g:link controller="individual" action="list" params="['status':s.formstatus]">${s.c}</g:link>
                            
                            </td>
                        </tr>
                    </g:each>
                    </tbody>
                    </tbody>
                </table>
            </div>
            
            <h2>Details</h2>
            <div class="dialog">
                <table>
                    <tbody>
                    <thead>
                        <tr>
                            <th>Individual</th>
                            <th>Status</th>
                            <th>Count</th>
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${detstats}" status="j" var="d">
                        <tr class="${(j % 2) == 0 ? 'odd' : 'even'}">
                        <g:set var="ind" value="${ics.Individual.findByLoginid(d.updator)}" />
                        
                            <td>${ind}</td>

                            <td>
                            <g:if test="${d.formstatus == 'UNDER VERIFICATION'}">
                            	<g:link controller="helper" action="clearPending" params="['updator':d?.updator]" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" >${d.formstatus}</g:link>
                            </g:if>
                            <g:else>
                            	${d.formstatus}
                            </g:else>
                            </td>
                        
                            <td>
                            <g:link controller="individual" action="list" params="['status':d.formstatus,'updator':d?.updator]">${d.c}</g:link>
                            
                            </td>
                        </tr>
                    </g:each>
                    </tbody>
                    </tbody>
                </table>
            </div>

        </div>
    </body>
</html>