<nav class="navbar navbar-default navbar-fixed-top">
  <div class="container-fluid">
    <!-- Brand and toggle get grouped for better mobile display -->
    <div class="navbar-header">
      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <!-- @TODO: Brand image can be obtained dynamically from the db -->
      <a class="navbar-brand" href="${createLink(controller:'mb',action:'index')}"><img alt="ICS-MB" src="${resource(dir: 'images', file: 'icsmb_logo.png')}"></a>
    </div>

    <!-- Collect the nav links, forms, and other content for toggling -->
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
      <ul class="nav navbar-nav">
      	<g:render template="/common/menuBootstrap" />
      </ul>
      <ul class="nav navbar-nav navbar-right">
        <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Hare Krishna -  ${ics.Individual.findByLoginid(sec.loggedInUserInfo(field:"username"))} (<sec:username/>) <span class="caret"></span></a>
          <ul class="dropdown-menu" role="menu">
            <li><a href='<g:createLink controller="individual" action="selfContact" />'><img src="${resource(dir:'images',file:'profile.png')}"
				    alt="Profile" title="Profile" />Profile</a></li>
            <li class="divider"></li>
	    <sec:ifAnyGranted roles="ROLE_ADMIN">
            <li>
	    <a href='#' onclick='showResetPassword(); return false;'>
	    <img src="${resource(dir:'images',file:'lock_break.png')}" alt="Reset Password" title="Reset Password" />ResetPassword</a>
            </li>
	    </sec:ifAnyGranted>

            <li><a href='#' onclick='showChangePassword(); return false;'><img src="${resource(dir:'images',file:'lock_edit.png')}"
				    alt="Change Password" title="Change Password" />ChangePassword</a></li>
            <li>
		    <sec:ifAnyGranted roles="ROLE_MB_ADMIN,ROLE_MB_SEC,ROLE_MB_MEMBER,ROLE_MB_CANDIDATE">
			<g:link controller='logout' params="['logoutUri': '/mb']"><img src="${resource(dir:'images',file:'lock.png')}" alt="Logout" title="Logout"/>Logout</g:link>
		    </sec:ifAnyGranted>
		    <sec:ifNotGranted roles="ROLE_MB_ADMIN,ROLE_MB_SEC,ROLE_MB_MEMBER,ROLE_MB_CANDIDATE">
			<g:link controller='logout'><img src="${resource(dir:'images',file:'lock.png')}" alt="Logout" title="Logout"/>Logout</g:link>
		    </sec:ifNotGranted>            
            </li>
          </ul>
        </li>
      </ul>
    </div><!-- /.navbar-collapse -->
  </div><!-- /.container-fluid -->
</nav>