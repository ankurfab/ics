<%@ page import="ics.EventCriteria" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'eventCriteria.label', default: 'EventCriteria')}" />
        <title>Generated Slips for Print-out</title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
	<span class="menuButton"><g:link class="create" action="slips">Slips</g:link></span>
		<g:jasperReport jasper="donor_address_with_criteria" format="PDF" name="Slips" >
		<input type="hidden" name="individualId" value=${id} />
		</g:jasperReport>
	</div>
        <div class="body">
            <h1>${msg}</h1>
            <g:link action="register" params="${p}">
	         Click here to make an entry for these in the database.
	    </g:link>

        </div>
    </body>
</html>