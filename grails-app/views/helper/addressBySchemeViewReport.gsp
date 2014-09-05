<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Generated Report</title>
    </head>
    <body>
        <div class="nav">
		<g:jasperReport jasper="${reportName}" format="XLS,PDF" name="Report" >
		<input type="hidden" name="parameter1" value="${parameter1}" />
		</g:jasperReport>
	</div>
        <div class="body">
            <h1>${msg}</h1>
        </div>
    </body>
</html>