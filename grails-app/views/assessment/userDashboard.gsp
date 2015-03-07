
<%@ page import="ics.Assessment" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="asmtUserLayout" />
	<link rel="stylesheet" href="${resource(dir:'css',file:'timeTo.css')}" />
    </head>
    <body>
       <g:javascript src="jquery.timeTo.min.js" /> 
    <div>
    	Welcome ${individual?.toString()} !
    </div>
    </body>
</html>
