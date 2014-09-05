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
			  
			
			$(document).ready(function(){

				$(".show_hide").show();
				$(".slidingDiv").hide();

			    $('.show_hide').click(function(){
			    $(".slidingDiv").slideToggle();
			    });

			});


	       </script>	
	
		<script>
		 $(document).ready(function() {
		      <sec:ifAnyGranted roles="ROLE_PATRONCARE,ROLE_PATRONCARE_USER">
				$('#triggerl1').text("B: "+${session.BdayTodayCount?:"''"});
				$('#triggerl2').text("M: "+${session.MannivTodayCount?:"''"});
				$('#triggerr1').text("BT: "+${session.BdayTomorrowCount?:"''"});
				$('#triggerr2').text("MT: "+${session.MannivTomorrowCount?:"''"});

			/*$.getJSON("${g.createLink(controller:'helper',action:'bdaysTodayCount')}", function(data) {
				$('#triggerl1').text("B: "+data.count);
			    });	
			$.getJSON("${g.createLink(controller:'helper',action:'mannivsTodayCount')}", function(data) {
				$('#triggerl2').text("M: "+data.count);
			    });	
			$.getJSON("${g.createLink(controller:'helper',action:'bdaysTomorrowCount')}", function(data) {
				$('#triggerr1').text("BT: "+data.count);
			    });	
			$.getJSON("${g.createLink(controller:'helper',action:'mannivsTomorrowCount')}", function(data) {
				$('#triggerr2').text("MT: "+data.count);
			    });	
			$.getJSON("${g.createLink(controller:'helper',action:'pendingItems')}", function(data) {
				$('#pendingItemsMenu').text("PENDING ITEMS ("+data.count+")");
			    });	*/
		      </sec:ifAnyGranted>
			    
		   var refreshId = setInterval(function() {
		      <sec:ifAnyGranted roles="ROLE_PATRONCARE,ROLE_PATRONCARE_USER,ROLE_NVCC_ADMIN,ROLE_BACKOFFICE">
		      $("#responsecontainer").load("${g.createLink(controller:'helper',action:'notificationsSummary')}");
		      </sec:ifAnyGranted>
		      
		      /*<sec:ifAnyGranted roles="ROLE_COUNSELLOR">
		      $("#responsecontainer").load("${g.createLink(controller:'helper',action:'clornotificationsSummary')}");
		      </sec:ifAnyGranted>*/

		      <sec:ifAnyGranted roles="ROLE_PATRONCARE,ROLE_PATRONCARE_USER,ROLE_NVCC_ADMIN,ROLE_BACKOFFICE">
			$.getJSON("${g.createLink(controller:'helper',action:'bcnotify')}", function(data) {
			    if(data.count>0)
			    	{
			    	$.jGrowl(data.text ,{ header: 'BouncedCheque' ,life: 600000});
			    	}
			    	$('#trigger1').text(data.count);
			    });
			</sec:ifAnyGranted>
		      <sec:ifAnyGranted roles="ROLE_NVCC_ADMIN">
			$.getJSON("${g.createLink(controller:'helper',action:'cultivatorConflict')}", function(data) {
			    if(data.count>0)
			    	{
			    	$.jGrowl(data.text ,{ header: 'CultivatorConflict' ,life: 600000});
			    	}
			    	$('#trigger2').text(data.count);
			    });
			</sec:ifAnyGranted>
			<sec:ifAnyGranted roles="ROLE_PATRONCARE,ROLE_PATRONCARE_USER">
			$.getJSON("${g.createLink(controller:'helper',action:'lifePatronCardArrivalNotification')}", function(data) {
			    if(data.count>0)
			    	{
			    	$.jGrowl(data.text ,{ header: 'LifePatronCardArrival' ,life: 600000});
			    	}
			    	$('#trigger3').text(data.count);
			    });
			
			</sec:ifAnyGranted>
		   }, 300000);

		      <sec:ifAnyGranted roles="ROLE_PATRONCARE,ROLE_PATRONCARE_USER,ROLE_NVCC_ADMIN,ROLE_BACKOFFICE">
		   $.ajaxSetup({ cache: false });
		    $('#jqeasypanel').jqEasyPanel({
			position: 'bottom',            // panel position 'top' or 'bottom'
			height: '500px',             // set the height of the panel
			speed: 'normal',            // 'slow', 'normal', 'fast', or number in milliseconds
			moveContainer: true,        // whether to slide your page container along with the panel. this allows your page content to always be visible.
			container: '#body_container',    // your page container id or class
			openBtn: '.open',           // open button id or class inside 'jqeasytrigger' div
			closeBtn: '.close',         // close button id or class inside 'jqeasytrigger' div
			openLink: '.openpanel',     // open button id or class for text links to open panel
			closeLink: '.closepanel',   // close button id or class for text links to close panel
			keepOpenCheck: '#keepopen', // sets cookie value to show panel on load on all pages
			showTrigger: true,          // turn trigger tab button on/off
			showOnLoad: false           // ALWAYS open panel on page load. Ignores cookie value!		    
		    });
	
			$('#panell1').slidePanel({
				triggerName: '#triggerl1',
				position: 'fixed',
				triggerTopPos: '40px',
				panelTopPos: '40px',
				ajax: true,
				ajaxSource: '${g.createLink(controller:'helper',action:'panel',params:["id":"l1"])}'
			});

			$('#panell2').slidePanel({
				triggerName: '#triggerl2',
				position: 'fixed',
				triggerTopPos: '200px',
				panelTopPos: '200px',
				ajax: true,
				ajaxSource: '${g.createLink(controller:'helper',action:'panel',params:["id":"l2"])}'
			});


			$('#panelr1').slidePanel({
				triggerName: '#triggerr1',
				position: 'fixed',
				triggerTopPos: '40px',
				panelTopPos: '40px',
				ajax: true,
				ajaxSource: '${g.createLink(controller:'helper',action:'panel',params:["id":"r1"])}'
			});

			$('#panelr2').slidePanel({
				triggerName: '#triggerr2',
				position: 'fixed',
				triggerTopPos: '200px',
				panelTopPos: '200px',
				ajax: true,
				ajaxSource: '${g.createLink(controller:'helper',action:'panel',params:["id":"r2"])}'
			});



		</sec:ifAnyGranted>

		});
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

				
		<sec:ifAnyGranted roles="ROLE_PATRONCARE,ROLE_PATRONCARE_USER,ROLE_NVCCADMIN,ROLE_BACKOFFICE">
		<div id="jqeasypanel" style="height:auto">
		    <!-- panel content here -->
		    <div id="jqeasypaneloptions">
			<p><label for="keepopen">Keep panel open?</label> <input name="keepopen" id="keepopen" type="checkbox" value="" /></p>
			<div id="responsecontainer">
			
			</div>
		    </div>
		</div>
		<div id="jqeasytrigger">
		    <a href="#" class="open">open</a>
		    <a href="#" class="close">close</a>
		</div>

		<a href="#" id="triggerl1" class="trigger left"></a>
		<div id="panell1" class="panel left">
		    <p>Chant Hare Krishna and Be Happy!</p>
		</div>

		<a href="#" id="triggerl2" class="trigger left"></a>
		<div id="panell2" class="panel left">
		    <p>Chant Hare Krishna and Be Happy!</p>
		</div>

		<a href="#" id="triggerr1" class="trigger right"></a>
		<div id="panelr1" class="panel right">
		    <p>Chant Hare Krishna and Be Happy!</p>
		</div>

		<a href="#" id="triggerr2" class="trigger right"></a>
		<div id="panelr2" class="panel right">
		    <p>Chant Hare Krishna and Be Happy!</p>
		</div>


		</sec:ifAnyGranted>

        <r:layoutResources />
	</body>
</html>