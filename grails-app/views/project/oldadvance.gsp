
<%@ page import="ics.Project" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Upload old advances</title>
    </head>
    <body>
	<div>
	Upload Old Advances: <br />
	    <g:uploadForm controller="Project" action="uploadOldAdvances">
		<input type="file" name="myFile" />
		<input type="submit" value="Upload"/>
	    </g:uploadForm>
	</div>
    </body>
</html>
