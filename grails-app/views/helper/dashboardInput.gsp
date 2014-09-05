
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

            
		<g:form action="dashboard" method="post">
                <div class="dialog">
                    <table border="0" cellspacing="0" cellpadding="0">
                        <tbody bgcolor="lavender">
			<tr class="prop">
                                <td valign="top" class="name">
                                    Year for Monthwise Collection
                                </td>
                                <td valign="top" class="value">
					<g:select name="yearsMonthwise" from="${yearsMonthwise}" value=""  />
				</td>
			</tr>

                        </tbody>
                    </table>
                </div>

                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="Next" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>