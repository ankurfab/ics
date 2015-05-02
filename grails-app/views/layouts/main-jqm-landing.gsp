<!DOCTYPE html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <title><g:layoutTitle default="ICS"/></title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="shortcut icon" href="${resource(dir: 'images', file: 'lotus.ico')}" type="image/x-icon">
        <link rel="apple-touch-icon" href="${resource(dir: 'images', file: 'apple-touch-icon.png')}">
        <link rel="apple-touch-icon" sizes="114x114" href="${resource(dir: 'images', file: 'apple-touch-icon-retina.png')}">
        <link rel="stylesheet" href="${resource(dir: 'css', file: 'main.css')}" type="text/css">
        <link rel="stylesheet" href="${resource(dir: 'css', file: 'mobile.css')}" type="text/css">
    <g:javascript library="jquery"/>
    <r:require module="jqmobile" />
    <r:require module="jqmDatePicker" />
<style>
/* Custom indentations are needed because the length of custom labels differs from
   the length of the standard labels */
.custom-label-flipswitch.ui-flipswitch .ui-btn.ui-flipswitch-on {
    text-indent: -3.4em;
}
.custom-label-flipswitch.ui-flipswitch .ui-flipswitch-off {
    text-indent: 0.5em;
}
</style>

    <g:layoutHead/>

    <r:layoutResources />


    <div data-role="page" id="landingpage">       
        <!--top panel to include on page -->
        <div data-position="fixed" data-role="header" > 
        <h1>ICS: Expense Management Module</h1>           
             <div data-type="horizontal" class="ui-btn-left"> 
                <a href="${createLink(controller:'project',action: 'index')}" id="emshome"  data-role="button" data-icon="bars" data-iconpos="notext"  data-ajax="false" title="EMS" >EMS</a>
            </div>          
             <div data-type="horizontal" class="ui-btn-right"> 
                Hare Krishna! ${session.individualname} (<sec:username/>)
                <a href="${createLink(uri: '/')}" id="home"  data-role="button" data-icon="home" data-iconpos="notext" title="Home" data-ajax="false" >Home</a>
                <a href="${createLink(controller:'individual',action: 'self')}"  id="profile" data-role="button" data-icon="user"  data-iconpos="notext" data-history="false" data-ajax="false"  title="Profile">Profile</a>
                <a href="${createLink(controller:'logout',action: 'index')}" id="logout"  data-role="button" data-icon="lock" data-ajax="false" data-iconpos="notext" title="Logout">Logout</a>
            </div>          
         </div> 
       
      
        <div align="center" data-role="content" id="contentConfirmation" name="contentConfirmation">  
         <g:layoutBody/>
         </div>

        <div data-role="footer" data-position="fixed">
            <h1>Always chant "Hare Krishna Hare Krishna Krishna Krishna Hare Hare ! Hare Rama Hare Rama Rama Rama Hare Hare !!" and be happy. <br> 
            Served by konsoftech.in To help us to serve you better, please contact us !!</h1>
         </div>
          </div><!--page  div  close -->
    <r:layoutResources />
    <script>
    </script>
</body>
</html>