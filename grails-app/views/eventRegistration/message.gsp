
<%@ page import="ics.EventRegistration" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'eventRegistration.label', default: 'Registration For Opening of NVCC, Pune')}" />
        <title>${entityName}</title>
    </head>
    <body>
	<!--<div class="nav" role="navigation">
		<ul>
			<span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
		</ul>
	</div>-->
	<div class="body">
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
		<!--<h2 style="color:red">The management of ISKCON center in Pune is unable to provide for accommodation for guests registering henceforward since the capacity of all of the facilities available with us has exhausted. However, for the convenience of our guests, we are providing a list of hotels in Pune where the guests can try to find an accommodation. Please note that the details of these hotels have been picked up from a standard business directory and by publishing it on our website we are NOT approving them or their service or their rates or their business practices and policies. Therefore, we are NOT liable for any future unfavourable consequence faced by any of our guests with any of these hotels.</h2>
		<iframe width='1200' height='500' frameborder='0' src='https://docs.google.com/spreadsheet/pub?key=0Apz5QkEi1q0edEx2MEk3UzEwWWo1UWwzRWtSR29DckE&output=html&widget=true'></iframe>-->
        </div>
    </body>
</html>
