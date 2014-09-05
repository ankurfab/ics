<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Generated Report</title>
    </head>
    <body>
        <div class="nav">
		<g:jasperReport jasper="${reportName}" format="XLS,PDF" name="Report" >
		<input type="hidden" name="param1" value=${param1} />
		<input type="hidden" name="param2" value=${param2} />
		<input type="hidden" name="param3" value=${param3} />
		<input type="hidden" name="param4" value=${param4} />
		<input type="hidden" name="param5" value=${param5} />
		</g:jasperReport>
	</div>
        <div class="body">
            <h1>${msg}</h1>
        </div>
    </body>
</html>