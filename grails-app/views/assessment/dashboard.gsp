
<%@ page import="ics.Assessment" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Dashboard for ${event}</title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
        </div>
        <div class="body">
            <h1>Dashboard for ${event}</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <h2>Registrations</h2>
            <table>
            	<thead>
            		<th>Language</th>
            		<th>VerificationStatus</th>
            		<th>Number</th>
            	</thead>
            	<tbody>
            		<g:each var="result" in="${stats.numRegistrations}">
            		<tr>
				<td>${result[0]}</td>
				<td>${result[1]}</td>
				<td>${result[2]}</td>
            		</tr>
            		</g:each>
            	</tbody>
            </table>
            <h2>ExamTakers</h2>
            <table>
            	<thead>
            		<th>Language</th>
            		<th>Number</th>
            	</thead>
            	<tbody>
            		<g:each var="result" in="${stats.examTakers}">
            		<tr>
				<td>${result[0]}</td>
				<td>${result[1]}</td>
            		</tr>
            		</g:each>
            	</tbody>
            </table>
        </div>
    </body>
</html>
