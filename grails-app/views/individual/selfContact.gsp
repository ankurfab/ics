<%@ page import="ics.Individual" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<title>Contact Details</title>
	</head>
	<body>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
			</ul>
		</div>
		<div id="create-individual" class="content scaffold-create" role="main">
			<h1>Update Contact Details</h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:form action="selfContactUpdate" >
				<fieldset class="form">
					Phone: <g:textField name="phone" value="${phone}" size="50"/>
					Email: <g:textField name="email" value="${email}" size="50"/>
				</fieldset>
				<fieldset class="buttons">
					<g:submitButton name="create" class="save" value="Update" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
