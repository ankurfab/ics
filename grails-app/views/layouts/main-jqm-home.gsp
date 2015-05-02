<!DOCTYPE html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <title><g:layoutTitle default="Grails"/></title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="shortcut icon" href="${resource(dir: 'images', file: 'favicon.ico')}" type="image/x-icon">
        <link rel="apple-touch-icon" href="${resource(dir: 'images', file: 'apple-touch-icon.png')}">
        <link rel="apple-touch-icon" sizes="114x114" href="${resource(dir: 'images', file: 'apple-touch-icon-retina.png')}">
        <link rel="stylesheet" href="${resource(dir: 'css', file: 'main.css')}" type="text/css">
        <link rel="stylesheet" href="${resource(dir: 'css', file: 'mobile.css')}" type="text/css">
        <link rel="stylesheet" href="${resource(dir: 'css', file: 'style.css')}" type="text/css">
    <g:javascript library="jquery"/>
    <g:layoutHead/>
    <r:require module="jqui"/>
    <r:require module="jqmobile" />
    <r:require module="ajaxform"/>
    <r:layoutResources />
</head>



<body>
    <div id="grailsLogo" role="banner"><a href="http://grails.org"><img src="${resource(dir: 'images', file: 'grails_logo.png')}" alt="Grails"/></a></div>
<g:layoutBody/>
<div class="footer" role="contentinfo"></div>
<div id="spinner" class="spinner" style="display:none;"><g:message code="spinner.alt" default="Loading&hellip;"/></div>
<g:javascript library="application"/>
<r:layoutResources />

<div data-role="page" id="home" >
    <div data-role="header">

        <div class="box"> <img src="css/images/home/krushna.png" height="190px" width="100%"/></div>
    </div> <!header div close -->      
    
   <!- Buttons on the main page -->
    <div data-role="main" class="ui-content">

        <div data-role="navbar" data-theme="b">
            <ul>
                <li><a href="#registerPopup" data-rel="popup"  data-transition="flow" data-icon="user">Register</a></li>
                <li><a href="#" data-rel="popup" data-transition="flow" data-icon="star">Events</a></li>
                <li><a href="#loginPopup" data-rel="popup" data-icon="user" data-transition="flow">Login </a></li>
            </ul>
        </div>

        <!- Login user-->

        <div data-role="popup" id="loginPopup" class="ui-content" data-close-btn="right"  data-dismissible="false" data-theme="a" data-overlay-theme="a">
            <a href="#" data-rel="back" data-role="button" data-theme="b" data-icon="delete" data-iconpos="notext" class="ui-btn-right">Close</a>
            <g:form name="loginForm" controller="individual" action="login" method="POST"> 

                <h3>Please Log In</h3>

                <label class="ui-hidden-accessible" for="un">Username:</label>          
                <input id="username" name="username" value="" type="text" placeholder="username" required>

                <label class="ui-hidden-accessible" for="pw">Password:</label>      
                <input id="password" name="password" value="" type="password" placeholder="password" required>

                <button class="ui-btn ui-corner-all ui-shadow ui-btn-a ui-btn-icon-left ui-icon-check" type="submit">Log In</button>    
                <button  id="logincancelbutton" class="ui-btn ui-corner-all ui-shadow ui-btn-a ui-btn-icon-left ui-icon-delete" data-rel="back" type="reset">Cancel</button>
        
            </g:form>
        </div>

        <!--Register user -->

        <div data-role="popup" id="registerPopup"  class="ui-content" style=" width="480"; height="320";"" data-close-btn="right" data-rel="back" data-theme="a"  data-dismissible="false" data-overlay-theme="b">
         <a href="#" data-rel="back" data-role="button" data-theme="b" data-icon="delete" data-iconpos="notext" class="ui-btn-right">Close</a>
        <g:form name="registerForm" controller="individual" action="register" method="POST"> 
            <h3>User Registration</h3>
            <input id="username" name="name" value="" type="text" placeholder="name" required>
              
            <input id="mobile" name="mobile" value="" type="text" placeholder="Mobile No" required>
            <input id="email" name="email" value="" type="email" placeholder="mail id" required>
            <input id="comments" name="comments" value="" type="text" placeholder="commets" required>
            <button class="ui-btn ui-corner-all ui-shadow ui-btn-a ui-btn-icon-left ui-icon-check" id="registerubmitbutton" type="submit">Submit</button>    
            <button  id="registercancelbutton" class="ui-btn ui-corner-all ui-shadow ui-btn-a ui-btn-icon-left ui-icon-delete" data-rel="back" type="reset">Cancel</button>
        </g:form>
        </div>
        <!-- page footer-->
        <div data-role="footer" data-theme="b">
            <h1>Always chant "Hare Krishna Hare Krishna Krishna Krishna Hare Hare ! Hare Rama Hare Rama Rama Rama Hare Hare !!" and be happy.</br> 
                Served by konsoftech.in To help us to serve you better, please contact us !!</h1>
        </div>
    </div><!--page  div  close -->  

    <script>
        $(document).on('pagebeforeshow', '#home', function() {
            $(document).on('click', '#logincancelbutton', function() {
                setTimeout(function() {
                    $("#loginPopup").popup("close");
                }, 1);
            });

            //to clear data so url not appers again
            if ($(this).is("[data-rel='back']")) {
                window.history.back();
                return false;
            }

            //login form event
            $('#loginForm').submit(function()
            {

                var url = "${createLink(controller:'individual',action:'login')}";

                // gather the form data
                var data = $(this).serialize();
                // post data
                $.post(url, data, function(returnData)
                {

                  
                    if (!returnData.success)
                    {
                       
                      
                        return false;
                    }

                })
                return true; // stops browser from doing default submit process
            });

        });

        $("#dialogPage").on("popupafterclose", function(event, ui) {
            // Do something here, it requires SOlution 1 to trigger popup close

        });
    </script>

</body>


</html>


