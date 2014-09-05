<!doctype html>

<%@ page import="grails.util.Environment" %> 

<html>
	<head>
		<title>Grails Runtime Exception</title>
		<meta name="layout" content="main">
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'errors.css')}" type="text/css">
	</head>
	<body>
		<g:if test="${Environment.current == Environment.PRODUCTION}">
		    ${response.sendError(500)}
		</g:if>
		<g:else> 
			<g:renderException exception="${exception}" />
		</g:else>
	</body>
</html>