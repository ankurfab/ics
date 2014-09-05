<html>
    <head>
        <title><g:layoutTitle default="ICS: ISKCON Communities System" /></title>
        <link rel="stylesheet" href="${resource(dir:'css',file:'layout.css')}" />
        <link rel="stylesheet" href="${resource(dir:'css',file:'main.css')}" />
        <link rel="stylesheet" href="${resource(dir:'css',file:'adminmenu.css')}" />
        <link rel="stylesheet" href="${resource(dir:'css',file:'screen.css')}" />
        <link rel="shortcut icon" href="${resource(dir:'images',file:'favicon.ico')}" type="image/x-icon" />
        <g:javascript library="application" />
	<g:javascript library='jquery' />
	<nav:resources/>
          <g:layoutHead />
  </head>
    <body>
        <div id="spinner" class="spinner" style="display:none;">
            <img src="${resource(dir:'images',file:'spinner.gif')}" alt="Spinner" />
        </div>
<div id="layout">



  <div id="body_container">
    <div id="body_container_inner">
      <div id="menu">
        <ul>
      <sec:ifLoggedIn>
      <sec:ifAnyGranted roles="ROLE_PATRONCARE,ROLE_PATRONCARE_USER">
          <li><a  href="${resource(dir:'',file:'reports.gsp')}">Reports</a></li>
      </sec:ifAnyGranted>
      
      <sec:ifAnyGranted roles="ROLE_ADMIN,ROLE_NVCC_ADMIN,ROLE_DUMMY">
	<!--<li class="first"><a  href="${resource(dir: '')}">Home</a></li>-->
          <li><g:link controller="individual" action="list">Individual</g:link></li>
          <li><g:link controller="donation" action="list">Donation</g:link></li>
          <li><g:link controller="giftIssued" action="list">Gift</g:link></li>
          <!--<li><g:link controller="followup" action="list">Followup</g:link></li>-->
          <li><g:link controller="searchable" action="index">Search</g:link></li>
          <li><g:link controller="denomination" action="create">Denomination</g:link></li>
          <li><a href="${resource(dir:'',file:'reports.gsp')}">Reports</a></li>
          <!--<li><a  href="${resource(dir:'',file:'advanced.gsp')}">Advanced</a></li>-->
      </sec:ifAnyGranted>
      <sec:ifAnyGranted roles="ROLE_ADMIN,ROLE_NVCC_ADMIN">
          <li><a  href="${resource(dir:'',file:'advanced.gsp')}">Advanced</a></li>
      </sec:ifAnyGranted>
      <sec:ifAnyGranted roles="ROLE_USER">
          <li><g:link controller="individual" action="folkMemberReport">FOLK Members</g:link></li>
          <li><g:link controller="individual" action="folkMemberBirthMonthReport">Birthday Report</g:link></li>
          <li><g:link controller="individual" action="folkMemberMAMonthReport">MarriageAnniversary Report</g:link></li>
          <li><a  href="${resource(dir:'',file:'searchIndividual.gsp')}">Search Individual</a></li>
      </sec:ifAnyGranted>
      </sec:ifLoggedIn>
        </ul>
      </div>
      <div id="spquote" class="find_more">
      <p><g:quote/>
      </div>
      <span id='loginLink' style='position: relative; margin-right: 20px; float: right'>
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
</span>
<g:render template='/includes/ajaxLogin'/>
<g:render template='/includes/ajaxChangePassword'/>
<g:render template='/includes/ajaxResetPassword'/>
      <g:layoutBody />
    <g:render template="/common/footer" />
    </div>
  </div>
</div>     </body>

</html>