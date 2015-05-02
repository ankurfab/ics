
<%@ page import="ics.EventRegistration" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Registration message</title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
        </div>
	<div class="body">
            <h2 style="color:red">${flash.message}</h2>
            <g:submitButton name="close" value="Close" onclick="closeMe();"/>
        </div>

<script>
function closeMe()
{
    window.opener = self;
    window.close();
}
</script>

    </body>
</html>
