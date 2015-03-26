
<%@ page import="ics.Role" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="plain" />
        <g:set var="roleInstance" value="${Role.get(id)}" />
        <title>Sheet</title>
    </head>
    <body>
    	<g:render template="/common/sheet" model="['results':results]" />
    </body>
</html>
