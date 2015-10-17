<!-- Marriage Board Based Roles Start-->
<li class="dropdown">
  <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">MarriageBoard <span class="caret"></span></a>
  <ul class="dropdown-menu" role="menu">
      <sec:ifAnyGranted roles="ROLE_MB_ADMIN,ROLE_MB_SEC,ROLE_MB_MEMBER">
		<li><g:link controller="mb" action="dashboard">Mb Dashboard</g:link></li>
		<li><g:link class="list" action="manage" controller="mb">Mb Profile Management</g:link></li>
      </sec:ifAnyGranted> 
      <sec:ifAnyGranted roles="ROLE_MB_ADMIN,ROLE_MB_SEC">
		<li><g:link controller="mb" action="report">Mb Report</g:link></li>
      </sec:ifAnyGranted> 
      <sec:ifAnyGranted roles="ROLE_MB_ADMIN">
		<li><g:link class="list" action="manageBoard" controller="mb">Mb Management</g:link></li>
      </sec:ifAnyGranted> 
      <sec:ifAnyGranted roles="ROLE_MB_CANDIDATE">
		<li><g:link controller="mb" action="editProfile">Profile</g:link></li>
		<li><g:link controller="mb" action="prospects">Prospects</g:link></li>
      </sec:ifAnyGranted> 
      <sec:ifAnyGranted roles="ROLE_MB_ADMIN,ROLE_MB_SEC,ROLE_MB_MEMBER,ROLE_MB_CANDIDATE">
		<li><g:link controller="mb" action="activityStream">Activity Stream</g:link></li>
      </sec:ifAnyGranted> 
  </ul>
</li>
<!-- Marriage Board Roles End-->

<!-- Atithi Based Roles Start-->
<sec:ifAnyGranted roles="ROLE_ATITHI_ADMIN,ROLE_ATITHI_USER">
<li class="dropdown">
  <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">GuestReception <span class="caret"></span></a>
  <ul class="dropdown-menu" role="menu">
	<sec:ifAnyGranted roles="ROLE_ATITHI_ADMIN,ROLE_ATITHI_USER">
	<li><g:link controller="person" action="list">Visitors</g:link></li>
	</sec:ifAnyGranted>
	<sec:ifAnyGranted roles="ROLE_ATITHI_ADMIN">
	<li><g:link controller="topic" action="list">Subscription Management</g:link></li>
	<li><g:link controller="person" action="dashboard">Dashboard</g:link></li>
	</sec:ifAnyGranted>
  </ul>
</li>
</sec:ifAnyGranted>
<!-- Atithi Based Roles End-->
