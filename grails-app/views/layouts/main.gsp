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
		<title><g:layoutTitle default="ICS: ISKCON Communities System"/></title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link rel="shortcut icon" href="${resource(dir: 'images', file: 'lotus.ico')}" type="image/x-icon">
		<link rel="apple-touch-icon" href="${resource(dir: 'images', file: 'apple-touch-icon.png')}">
		<link rel="apple-touch-icon" sizes="114x114" href="${resource(dir: 'images', file: 'apple-touch-icon-retina.png')}">
	        <link rel="stylesheet" href="${resource(dir:'css',file:'layout.css')}" />
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'main.css')}" type="text/css">
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'mobile.css')}" type="text/css">
	        <link rel="stylesheet" href="${resource(dir:'css',file:'adminmenu.css')}" />
	        <link rel="stylesheet" href="${resource(dir:'css',file:'screen.css')}" />
	        <link rel="stylesheet" href="${resource(dir: 'css', file: 'show_hide_div.css')}">
	        <link rel="stylesheet" href="${resource(dir: 'css', file: 'jquery.jgrowl.css')}">
	        <link rel="stylesheet" href="${resource(dir: 'css', file: 'jqeasypanel.css')}">
	        <link rel="stylesheet" href="${resource(dir: 'css', file: 'jqeasyslidepanel.css')}">
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'faary.css')}">	        
		<g:javascript library="jquery"/>
		<g:layoutHead/>
		<r:require modules="panel"/>
		<r:layoutResources />
	</head>
	<body onload=" pageRefresh()">

	<style>
	.ui-autocomplete-loading { background: white url('${resource(dir: 'images', file: 'spinner.gif')}') right center no-repeat; }
	.ui-autocomplete {
		max-height: 100px;
		overflow-y: auto;
		/* prevent horizontal scrollbar */
		overflow-x: hidden;
		/* add padding to account for vertical scrollbar */
		padding-right: 20px;
	}
	</style>

		<script type="text/javascript" charset="utf-8">
			function pageRefresh() {
				if(document.documentMode==9) {
				        if (location.href.indexOf('eventRegistration/create')!=-1 && location.href.indexOf('reload')==-1) {
						location.replace(location.href+'?reload');
					}
				}
			 }
			  
			


	       </script>	
	
		<div id="layout">
		  <div id="body_container">
		    <div id="body_container_inner">

		    <sec:ifNotLoggedIn>
		      
		      <div class="mainHeader">
		          <a href="http://iskcon.org/"><div class="headerLeft">&nbsp;</div></a>
			  <!--div class="headerCenter"><div class="spquote"><g:quote/></div></div-->
			  <a href="http://www.iskconpune.com/"><div class="headerRight">&nbsp;</div></a>
		      </div>
		      <div class="bodySeparator">
		          <div class="bodySeparator1">&nbsp;</div>
		          <div class="bodySeparator2">&nbsp;</div>
		      </div>
		    </sec:ifNotLoggedIn>
		    
			<g:render template="/common/menu"/>      
			<g:render template='/includes/ajaxLogin'/>
			<g:render template='/includes/ajaxChangePassword'/>
			<g:render template='/includes/ajaxResetPassword'/>

		      <g:layoutBody />


		    <g:render template="/common/footer" />
		    </div>
		  </div>
		</div>     
		<div id="spinner" class="spinner" style="display:none;"><g:message code="spinner.alt" default="Loading&hellip;"/></div>
		<g:javascript library="application"/>
        <r:layoutResources />
	</body>
</html>