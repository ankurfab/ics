<html>
<head>
	<title><g:layoutTitle default="ICS: ISKCON Communities System" /></title>
	<link rel="stylesheet" href="${resource(dir:'css',file:'main.css')}" />
	<link rel="stylesheet" type="text/css" href="${resource(dir:'css',file:'3col-screen.css')}">
	<link rel="stylesheet" type="text/css" href="${resource(dir:'css',file:'reset-fonts-grids.css')}">
	<link rel="stylesheet" type="text/css" href="${resource(dir:'css',file:'base.css')}">
	<link rel="shortcut icon" href="${resource(dir:'images',file:'favicon.ico')}" type="image/x-icon" />
	<nav:resources/>
	<g:layoutHead />
</head>
<body>
<div id="doc3" class="yui-t7">
	<div id="hd">
		<!-- PUT MASTHEAD CODE HERE -->
		      <table>
			      <tr>
				      <td>
					      <img src="${resource(dir:'images',file:'iskcon-logo.png')}"/></a>
				      </td>
				      <td>
					      <!--<table>
						      <tr>
							      <td>
							      <g:quote/>
							      </td>
						      <tr>
							<table>-->
								<tr>
								      <sec:ifLoggedIn>
								      <sec:ifAnyGranted roles="ROLE_ADMIN,ROLE_NVCC_ADMIN,ROLE_DUMMY">
									<!--<td class="first"><a  href="${resource(dir: '')}">Home</a></td>-->
									  <td><g:link controller="individual" action="list">Individual</g:link></td>
									  <td><g:link controller="donation" action="list">Donation</g:link></td>
									  <td><g:link controller="giftIssued" action="list">Gift</g:link></td>
									  <!--<td><g:link controller="followup" action="list">Followup</g:link></td>-->
									  <td><g:link controller="searchable" action="index">Search</g:link></td>
									  <td><g:link controller="denomination" action="create">Denomination</g:link></td>
									  <td><a  href="${resource(dir:'',file:'reports.gsp')}">Reports</a></td>
									  <!--<td><a  href="${resource(dir:'',file:'advanced.gsp')}">Advanced</a></td>-->
								      </sec:ifAnyGranted>
								      <sec:ifAnyGranted roles="ROLE_DUMMY">
									  <td><g:link controller="followup" action="list">Followup</g:link></td>
								      </sec:ifAnyGranted>
								      <sec:ifAnyGranted roles="ROLE_ADMIN,ROLE_NVCC_ADMIN">
									  <td><a  href="${resource(dir:'',file:'advanced.gsp')}">Advanced</a></td>
								      </sec:ifAnyGranted>
								      <sec:ifAnyGranted roles="ROLE_USER">
									  <td><g:link controller="individual" action="folkMemberReport">FOLK Members</g:link></td>
									  <td><g:link controller="individual" action="folkMemberBirthMonthReport">Birthday Report</g:link></td>
									  <td><g:link controller="individual" action="folkMemberMAMonthReport">MarriageAnniversary Report</g:link></td>
									  <td><a  href="${resource(dir:'',file:'searchIndividual.gsp')}">Search Individual</a></td>
								      </sec:ifAnyGranted>
								      </sec:ifLoggedIn>
								</tr>
							</table>
						      </tr>
					      </table>
				      </td>
				      <td>
					      <!--<img src="${resource(dir:'images',file:'sp.png')}"/></a>-->
				      </td>
			      </tr>
		      </table>
	</div>
	<div id="bd">
		<div id="yui-main">
			<div class="yui-b">
				<!-- PUT MAIN COLUMN CODE HERE -->
				<div style='position: relative; margin-right: 20px; float: right; padding: 5px;'>
					      <sec:ifLoggedIn>
					      Hare Krishna -  <sec:username/> (<g:link controller='logout'><img src="${resource(dir:'images',file:'lock.png')}" alt="Logout" /></g:link>
					      <a href='#' onclick='showChangePassword(); return false;'><img src="${resource(dir:'images',file:'lock_edit.png')}"
					      alt="Change Password" /></a>

					      <sec:ifAnyGranted roles="ROLE_ADMIN,ROLE_NVCC_ADMIN">
					      <a href='#' onclick='showResetPassword(); return false;'>
					      <img src="${resource(dir:'images',file:'lock_break.png')}" alt="Reset Password" /></a>
					      </sec:ifAnyGranted>

					      )
					      </sec:ifLoggedIn>
					      <sec:ifNotLoggedIn>
					      <a href='#' onclick='showLogin(); return false;'>Login</a>
					      </sec:ifNotLoggedIn>
				</div>
				<g:javascript src='prototype/scriptaculous.js?load=effects' />
				<g:render template='/includes/ajaxLogin'/>
				<g:render template='/includes/ajaxChangePassword'/>
				<g:render template='/includes/ajaxResetPassword'/>
				<g:layoutBody />
			</div>
		</div>
		<div class="yui-b">
			<!-- PUT SECONDARY COLUMN CODE HERE -->
			
		</div>
	</div>
	<div id="ft">
		<!-- PUT FOOTER CODE HERE -->
		<a style="text-decoration:underline; color:black;" href="http://www.iskconpune.com">Hare Krishna Hare Krishna Krishna Krishna Hare Hare !
		   Hare Rama Hare Rama Rama Rama Hare Hare !!</a>
		<br>ICS v<g:meta name="app.version"/>
	</div>
</div>
</body>
</html>
