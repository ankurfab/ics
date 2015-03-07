<%@ page import="grails.plugins.springsecurity.SpringSecurityService" %>
<% def springSecurityService %>
<!doctype html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8">
		<title><g:layoutTitle default="${ia?.eventRegistration?.event?.title?:'GITA Premiere League'}"/></title>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="shortcut icon" href="${resource(dir: 'images', file: 'lotus.ico')}" type="image/x-icon">
		<link rel="apple-touch-icon" href="${resource(dir: 'images', file: 'apple-touch-icon.png')}">
		<link rel="apple-touch-icon" sizes="114x114" href="${resource(dir: 'images', file: 'apple-touch-icon-retina.png')}">
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'mobile.css')}" type="text/css">
		<g:javascript library="jquery"/>
		<g:layoutHead/>
		<r:require module="jqmobile" />
		<r:layoutResources />
	</head>
	<body>
		<div data-role="page" id="exampage">

		<div data-role="header" style="overflow:hidden;">
		
		<h1>${(ia?.questionPaper?'':'MOCK ')+(ia?.eventRegistration?.event?.title?:'GITA Premiere League')}</h1>
		    <a id="qNumText" href="#popupInstructions" data-rel="popup" data-transition="flip" data-icon="" class="ui-btn-left">Instructions</a>
		    <div id="timeText" class="ui-btn-right"></div>
		</div><!-- /header -->

		  <div data-role="main" class="ui-content">
			<g:layoutBody/>
		  </div>

		  <div data-role="footer">
		    <h1>Knowledge..Culture..Devotion</h1>
		    <a href="${createLink(controller:'assessment',action:'userDashboard')}" data-transition="flip" data-icon="home" class="ui-btn-left">Home</a>
		    <a href="${createLink(controller:'logout')}" data-transition="fade" data-icon="gear" data-ajax="false" class="ui-btn-right">Logout</a>
		  </div><!-- /footer -->
		</div> 
		<r:layoutResources />
	</body>
</html>