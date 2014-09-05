<html>
    <head>
        <title><g:layoutTitle default="ICS: ISKCON Communities System" /></title>
        <link rel="stylesheet" href="${resource(dir:'css',file:'layout.css')}" />
        <link rel="stylesheet" href="${resource(dir:'css',file:'main.css')}" />
        <link rel="stylesheet" href="${resource(dir:'css',file:'adminmenu.css')}" />
        <link rel="stylesheet" href="${resource(dir:'css',file:'screen.css')}" />
        <link rel="shortcut icon" href="${resource(dir:'images',file:'favicon.ico')}" type="image/x-icon" />
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
      
      
      
<!-- Commented to make date picker work; anyways these are already in the header
<g:javascript src='application.js' />
<g:javascript library='prototype' />
-->
<g:javascript src='prototype/scriptaculous.js?load=effects' />
<g:render template='/includes/ajaxLogin'/>
<g:render template='/includes/ajaxChangePassword'/>
<g:render template='/includes/ajaxResetPassword'/>
      <g:layoutBody />
    <g:render template="/common/footer" />
    </div>
  </div>
</div>     </body>


</html>