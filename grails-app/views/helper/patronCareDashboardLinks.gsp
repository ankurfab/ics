
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="Dashboard" />
        <title>Dashboard</title>
    </head>

    <body >

        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
	</div>
        <div class="body">
            <h1>Dashboard</h1>
            <g:if test="${flash.message}">
          	  <div class="message">${flash.message}</div>
            </g:if>

            
		
                <div class="dialog">
                    <table border="0" cellspacing="0" cellpadding="0">
                        <tbody bgcolor="lavender">
			<tr class="prop">
				<td valign="top" class="name">
				    <g:link controller="helper" action="patronCareDashboardYearwise" params="['patronCareSevaks': params.patronCareSevaks, 'patronCareSevaksIds': params.patronCareSevaks.id]">Yearwise Collection Chart</g:link>
				</td>

			</tr>
			
			<tr class="prop">
                                <td valign="top" class="name">
                                    <g:link controller="helper" action="patronCareDashboardMonthwiseInput" params="['patronCareSevaks': params.patronCareSevaks, 'patronCareSevaksIds': params.patronCareSevaks.id]">Monthwise Collection Chart</g:link>
                                </td>

			</tr>
			<tr class="prop">
                                <td valign="top" class="name">
                                    <g:link controller="helper" action="patronCareDashboardSchemewise" params="['patronCareSevaks': params.patronCareSevaks, 'patronCareSevaksIds': params.patronCareSevaks.id]">Schemewise Collection Chart</g:link>
                                </td>

			</tr>	
			<!--<tr class="prop">
                                <td valign="top" class="name">
                                    <g:link controller="helper" action="showGraphs">Test Chart</g:link>
                                </td>

			</tr>				-->
                        </tbody>
                    </table>
                </div>

        </div>
    </body>
</html>