<!doctype html>
<html lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<title><g:layoutTitle default="ICS: ISKCON Communities System"/></title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link rel="shortcut icon" href="${resource(dir: 'images', file: 'lotus.ico')}" type="image/x-icon">
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'bootstrap-theme.css')}" type="text/css">
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'sticky-footer-navbar.css')}" type="text/css">
		<g:javascript src="jquery-2.1.3.min.js" />
		<g:layoutHead/>
		<r:require modules="bootstrap"/>
		<r:layoutResources />
	</head>
	<body>
		<g:render template="/common/headerBootstrap" />

		<!-- Begin page content -->
		<div class="container">
			<g:layoutBody />
		</div>
    
		<g:render template="/common/footerBootstrap" />
		
		<g:javascript library="application"/>
		<r:layoutResources />
	</body>
</html>