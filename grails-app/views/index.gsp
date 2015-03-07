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
	<sec:ifAnyGranted roles="ROLE_COUNSELLOR">
		<g:javascript>
		window.location.href = "${createLink(controller:'helper',action:'clorDashboard')}";
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
	<sec:ifAnyGranted roles="ROLE_CC_OWNER,ROLE_CCAT_OWNER,ROLE_FINANCE,ROLE_ACC_USER">
		<g:javascript>
		window.location.href = "${createLink(controller:'project',action:'index')}";
		</g:javascript>
	</sec:ifAnyGranted>
	<sec:ifNotGranted roles="ROLE_COUNSELLOR,ROLE_ASMT_USER,ROLE_ASMT_USERUV">
		<img src="${resource(dir:'images',file:'main.jpg')}" width="1250" height="500"/>
	</sec:ifNotGranted>
      </sec:ifLoggedIn>
    </body>
</html>