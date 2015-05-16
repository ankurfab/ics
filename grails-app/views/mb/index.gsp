<%@ page import="ics.Mb" %>
<!DOCTYPE html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>ICS : Marriage Board</title>
    <r:require module="mbHome"/>
    <r:layoutResources />
</head>
<body>
<r:img id="bg" dir="images" file="1.jpg" hidden="hidden"/>
<nav class="navbar navbar-inverse navbar-no-bg" role="navigation">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#top-navbar-1">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <div class="navbar-brand"></div>
        </div>
        <h3 class="site-head hidden-xs hidden-sm">ISKCON Community Services : Marriage Board</h3>
        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse" id="top-navbar-1">
            <ul class="nav navbar-nav navbar-right">
                <li>
                    <a href="#">Tutorials</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- Top content -->
<div class="top-content">
    <div class="inner-bg">
        <div class="container">
            <div class="row">
                <div class="col-sm-7 text">
                    <h1><strong>Hare Krishna</strong></h1>
                    <div class="description">
                        <p>
                            Committed to Finding you the perfect Krishna Counscious Life partner to assist you in your Service to their Lordships.
                        </p>
                    </div>
                    <div class="top-big-link">
                        <a id="switchFormsBtn" class="btn btn-link-1" href="javascript:void(0)" onclick="switchForms()">Login as MB user</a>
                    </div>
                </div>

                <div class="col-sm-5 form-box">
                    <div class="form-top">
                    <g:if test="${textMsg}">
                        <p style="text-align: center"><strong>${textMsg}</strong></p>
                    </div>
                    </g:if>
                    <g:else>
                        <div class="form-top-left">
                            <h3><strong>Register Now</strong></h3>
                            <p style="font-weight: 400">Fill in your details and that of your referrer here to register for Marriage Board.</p>
                        </div>
                    </div>
                    <div class="form-bottom" id="registrationFrom">
                        <g:form action="startProfile" class="registration-form">
                            <h4>Candidate Details : </h4>
                            <div class="form-group">
                                <input type="text" name="donorName" required placeholder="Legal Name..." class="form-control" id="donorName">
                            </div>
                            <div class="form-group">
                                <input type="text" name="initiatedName" placeholder="Initiated Name..." class="form-control" id="initiatedName">
                            </div>
                            <div class="form-group">
                                <input type="text" name="donorContact" required placeholder="Contact Number..." class="form-control" id="donorContact">
                            </div>
                            <div class="form-group">
                                <input type="text" name="donorEmail" required placeholder="Email Address..." class="form-control" id="donorEmail">
                            </div>
                            <div class="form-group">
                                <input type="text" name="refClor" required placeholder="Counsellor / Mentor..." class="form-control" id="refClor">
                            </div>
                            <h4> Referrer Details : </h4>
                            <div class="form-group">
                                <input type="text" name="refName" required placeholder="Referred By..." class="form-control" id="refName">
                            </div>
                            <div class="form-group">
                                <g:select id="refCentre" style="width: 100%;height: 50px" name="refCentre" from="${['Pune','Mumbai']}" noSelection="['':'Centre...']"/>
                            </div>
                            <div class="form-group">
                                <input type="text" name="refContact" required placeholder="Referrer Contact Number..." class="form-control" id="refContact">
                            </div>
                            <div class="form-group">
                                <input type="text" name="refEmail" required placeholder="Referrer Email..." class="form-control" id="refEmail">
                            </div>
                            <div class="form-group">
                                <input type="text" name="refReln" required placeholder="Relation to Candidate..." class="form-control" id="refReln">
                            </div>
                            <button type="submit" class="btn btn-success">Register</button>
                        </g:form>
                        </div>
                        <div class="form-bottom">
                        <form hidden="hidden" action='${request.contextPath}/j_spring_security_check' method="POST" class="registration-form" id='loginForm' name='loginForm'>
                            <g:hiddenField name="successHandler.targetUrlParameter" value="${createLink(controller:'individual',action:'index')}" />
                            <div class="form-group">
                                <input type="text" name="j_username" placeholder="Login ID..." class="form-control" id="username">
                            </div>
                            <div class="form-group">
                                <input type="password" name="j_password" placeholder="Password..." class="form-control" id="password">
                            </div>
                            %{--<div class="input-group form-group">
                                <span class="input-group-addon">
                                    <input type="checkbox" name='_spring_security_remember_me' id='remember_me' aria-label="Remember Me">
                                </span>
                                <input type="text" class="form-control" aria-label="Remember Me">
                            </div>--}%
                            <button type="submit" class="btn btn-success">Login</button>
                            <button class="btn btn-success">Cancel</button>
                        </form>
                        </div>
                    </div>
                    </g:else>
                </div>
            </div>
        </div>
    </div>
<r:layoutResources />
<script type="text/javascript">
    $(document).ready(function(){
        $('#refCentre').select2({
            minimumResultsForSearch: -1
        });
    });
    function switchForms(){
        if($('#switchFormsBtn').html() == 'Login as MB user'){
            $('#registrationFrom').hide();
            $('#loginForm').show();
            $('#switchFormsBtn').html('Register as Candidate');
            $('h3','.form-top-left').html('Login as Member or Candidate');
            $('p','.form-top-left').html('Sign in with login id and password sent to you by mail and sms');
        }
        else
        {
            $('#loginForm').hide();
            $('#registrationFrom').show();
            $('#switchFormsBtn').html('Login as MB user');
            $('h3','.form-top-left').html('Register Now');
            $('p','.form-top-left').html('Fill in your details and that of your referrer here to register for Marriage Board.');
        }
    }
</script>
</body>
</html>