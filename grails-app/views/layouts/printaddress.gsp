<html>
<head>
	<title><g:layoutTitle default="ICS: ISKCON Communities System" /></title>
	<link rel="stylesheet" href="${resource(dir:'css',file:'printaddress.css')}" />
	<link rel="stylesheet" type="text/css" href="${resource(dir:'css',file:'3col-screen.css')}">
	<link rel="stylesheet" type="text/css" href="${resource(dir:'css',file:'reset-fonts-grids.css')}">
	<link rel="stylesheet" type="text/css" href="${resource(dir:'css',file:'base.css')}">
	<link rel="shortcut icon" href="${resource(dir:'images',file:'favicon.ico')}" type="image/x-icon" />
	<g:javascript library="application" />
	<g:javascript library='jquery' />
	<nav:resources/>
	<g:layoutHead />
        <r:layoutResources />
</head>
<body>
<div id="doc3" class="yui-t7">
	<div id="hd">
		<!-- PUT MASTHEAD CODE HERE -->
	</div>
	<div id="bd">
		<div id="yui-main">
			<div class="yui-b">
				<!-- PUT MAIN COLUMN CODE HERE -->
				<div style='position: relative; margin-right: 20px; float: right; padding: 5px;'>
					      <sec:ifNotLoggedIn>
					      <a href='#' onclick='showLogin(); return false;'>Login</a>
					      </sec:ifNotLoggedIn>
				</div>
			</div>
		</div>
		<div class="yui-b">
			<!-- PUT SECONDARY COLUMN CODE HERE -->
			
		</div>
	</div>
	<div id="ft" align="left">
		<!-- PUT FOOTER CODE HERE -->
		<a href="http://www.iskconpune.com"><font size="1">Hare Krishna Hare Krishna Krishna Krishna Hare Hare !
		   Hare Rama Hare Rama Rama Rama Hare Hare !!</font></a>
		<br><font size="1">ICS v<g:meta name="app.version"/></font>
	</div>
</div>
<g:layoutBody />
        <r:layoutResources />
</body>
</html>
