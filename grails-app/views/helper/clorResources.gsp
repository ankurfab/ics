
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="Dashboard" />
        <title>Handy resources for counselors</title>
    </head>

    <body >

        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
	</div>
        <div class="body">
            <h1>Handy resources for counselors</h1>
            <g:if test="${flash.message}">
          	  <div class="message">${flash.message}</div>
            </g:if>

	<g:each in="${ics.Content.findAllWhere(department:ics.Department.findByName('TMC'))?.htmlContent}">
	    <div>
		<p>${it}</p><br>
	    </div>
	</g:each>

            
        </div>
    </body>
</html>