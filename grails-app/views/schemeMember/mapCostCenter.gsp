<html>
    <head>
        <title>MapCostCenter</title>
		<meta name="layout" content="main" />
		
	
    </head>
    <body>
    

	<div id="body">

		<div>
		Upload Mapping for Cost Centers : <br />
		    <g:uploadForm controller="SchemeMember" action="uploadCostCenterMapping">
			<input type="file" name="myFile" />
			<input type="submit" value="Map"/>
		    </g:uploadForm>
		</div>

	</div>
	
    </body>
</html>