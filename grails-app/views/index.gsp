<!doctype html>
<html>
    <head>
        <title></title>
	<meta name="layout" content="mainWithPanels" />
    </head>
    <body>
   	
	<sec:ifNotLoggedIn>
	<div class="body">
		<table>
			<tr>
				<td>
					<a href="${createLink(controller:'login',action:'index')}"><img src="${resource(dir:'images',file:'login_icon.jpg')}"
					  alt="LOGIN"
					  width="200" height="250" border="0" /></a>
				</td>
				<td>
					<img src="${resource(dir:'images',file:'centre.jpg')}"
					  width="775" height="250" border="0" />
				</td>
				<td>
					<a href="${createLink(controller:'EventRegistration',action:'index',params:"[eventName:'RVTO']")}"><img src="${resource(dir:'images',file:'register-now.jpg')}"
					  alt="REGISTER"
					  width="200" height="250" border="0" /></a>
				</td>
			</tr>
		</table>
	</div>

      </sec:ifNotLoggedIn>
      <sec:ifLoggedIn>
	<sec:ifAnyGranted roles="ROLE_MB_ADMIN,ROLE_MB_SEC,ROLE_MB_MEMBER">
		<g:javascript>
		window.location.href = "${createLink(controller:'mb',action:'index')}";
		</g:javascript>
	</sec:ifAnyGranted>
	<sec:ifAnyGranted roles="ROLE_COUNSELLOR">
		<g:javascript>
		//window.location.href = "${createLink(controller:'helper',action:'clorDashboard')}";
		window.location.href = "${createLink(controller:'individual',action:'cleelist')}";
		</g:javascript>
	</sec:ifAnyGranted>
	<sec:ifAnyGranted roles="ROLE_ASMT_USER">
		<g:javascript>
		window.location.href = "${createLink(controller:'assessment',action:'userDashboard')}";
		</g:javascript>
	</sec:ifAnyGranted>
	<sec:ifAnyGranted roles="ROLE_ASMT_USERUV">
		<g:javascript>
		window.location.href = "${createLink(controller:'assessment',action:'verify')}";
		</g:javascript>
	</sec:ifAnyGranted>
	<sec:ifAnyGranted roles="ROLE_CC_OWNER,ROLE_CG_OWNER">
		<g:javascript>
		window.location.href = "${createLink(controller:'project',action:'index')}";
		</g:javascript>
	</sec:ifAnyGranted>
	<sec:ifNotGranted roles="ROLE_COUNSELLOR,ROLE_ASMT_USER,ROLE_ASMT_USERUV,ROLE_CC_OWNER,ROLE_CG_OWNER">
		<!--<img src="${resource(dir:'images',file:'main.jpg')}" width="1250" height="500"/>-->
		<div>
			<h1>Welcome to ICS! Please select the relevant activity from the top menu bar!!</h1>
		</div>
	</sec:ifNotGranted>
      </sec:ifLoggedIn>
    </body>
</html>