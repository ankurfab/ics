<%@ page import="ics.Mb" %>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>ICS : Marriage Board</title>
    <link rel="shortcut icon" href="${resource(dir: 'images', file: 'icsmb.ico')}" type="image/x-icon">
    <r:require module="mbHome"/>
    <r:layoutResources />
    <link href="http://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,700,300italic,400italic,700italic" rel="stylesheet" type="text/css">
</head>

<body>
<div class="nav">
    <span class="menuButton"><a class="home" href="${createLink(controller:'Mb',action:'index')}"><g:message code="default.home.label"/></a></span>
</div>

<section id="services" class="services" style="background-color: #337ab7">
        <div class="container">
            <div class="row">
                <div id="loginFrmWrapper" class="col-sm-5 text">
                    <div class="form-top-left" style="color: white">
                        <h3><strong>Already a member</strong></h3>
                        <p style="font-weight: 600">Login if you are a registered candidate or marriage board member.</p>
                    </div>
                    <form action='${request.contextPath}/j_spring_security_check' method="POST" class="registration-form" id='loginForm' name='loginForm'>
                        <h4 style="color: white;font-weight: 600">Login Details : </h4>
                        <g:hiddenField name="spring-security-redirect" value="/mb/home" />
                        <div class="form-group">
                            <input type="text" name="j_username" placeholder="Login ID..." class="form-control" id="username">
                        </div>
                        <div class="form-group">
                            <input type="password" name="j_password" placeholder="Password..." class="form-control" id="password">
                        </div>
                        <div class="form-group">
                            <a onclick="resetPwd()" style="color: white">Forgot Password?</a>
                        </div>
                        <button type="submit" class="btn btn-success">Login</button>
                    </form>
                </div>
                <div id="forgotPwdWrapper" class="col-sm-5 text" style="display: none">
                    <div class="form-top-left" style="color: white">
                        <h3><strong>Forgot Password</strong></h3>
                        <p style="font-weight: 600">Enter your user Id here and we shall revert with link to reset your password to your registered Email Address.</p>
                    </div>
                    <div class="form-group">
                        <input type="text" name="loginId" placeholder="User Name..." class="form-control" id="loginId" required="required">
                    </div>
                    <button type="submit" class="btn btn-success">Request</button>
                    <a class="btn btn-danger" style="margin-left: 15px">Cancel</a>
                </div>
                <div class="col-sm-offset-2 col-sm-5 form-box">
                    <div class="form-top">
                    <g:if test="${textMsg}">
                        <h2 style="text-align: center;font-weight:600;color:ghostwhite">${textMsg}</h2>
                    </div>
                    </g:if>
                    <g:else>
                        <div class="form-top-left" style="color: white">
                            <h3><strong>Register As Candidate</strong></h3>
                            <p style="font-weight: 600">Fill in your details and that of your referrer here to register.</p>
                        </div>
                    </div>
                    <div class="form-bottom" id="registrationFrom">
                        <g:form action="startProfile" class="registration-form" onsubmit="return validateSelect();">
                            <h4 style="color: white;font-weight: 600">Candidate Details : </h4>
                            <div class="form-group input-group">
                                <input type="text" name="donorName" required="required" placeholder="Legal Name (Full Name with Surname)..." class="form-control" id="donorName"/>
                                <span class="mand input-group-addon">*</span>
                            </div>
                            <div class="form-group">
                                <input type="text" name="initiatedName" placeholder="Initiated Name (Leave empty if not initiated)..." class="form-control" id="initiatedName">
                            </div>
                            <div class="form-group input-group">
                                <input type="tel" name="donorContact" required="required" placeholder="Contact Number..." class="form-control" id="donorContact" pattern="[0-9]{10,10}" maxlength="10">
                                <span class="mand input-group-addon">*</span>
                            </div>
                            <div class="form-group input-group">
                                <input type="email" name="donorEmail" required="required" placeholder="Email Address..." class="form-control" id="donorEmail">
                                <span class="mand input-group-addon">*</span>
                            </div>
                            <div class="form-group input-group">
                                <input type="text" name="refClor" required="required" placeholder="Counsellor / Mentor..." class="form-control" id="refClor">
                                <span class="mand input-group-addon">*</span>
                            </div>
                            <h4 style="color: white;font-weight: 600"> Referrer Details : </h4>
                            <div class="form-group input-group">
                                <input type="text" name="refName" required="required" placeholder="Referred By..." class="form-control" id="refName">
                                <span class="mand input-group-addon">*</span>
                            </div>
                            <g:set var="attr" value="${ics.Attribute.findByDomainClassNameAndDomainClassAttributeNameAndCategory('Mb','Centre','Config')}" />
                            <g:set var="centres" value="${ics.AttributeValue.findAllByAttribute(attr)?.collect{it.value}}" />
                            <div class="form-group">
                                <g:select id="refCentre" style="width: 100%;height: 50px" name="refCentre" from="${centres}" noSelection="['':'Referrer Centre...']" class="required"/>
                            </div>
                            <div class="form-group input-group">
                                <input type="tel" name="refContact" required="required" placeholder="Referrer Contact Number..." class="form-control" id="refContact" pattern="[0-9]{10,10}" maxlength="10">
                                <span class="mand input-group-addon">*</span>
                            </div>
                            <div class="form-group input-group">
                                <input type="email" name="refEmail" required="required" placeholder="Referrer Email..." class="form-control" id="refEmail">
                                <span class="mand input-group-addon">*</span>
                            </div>
                            <div class="form-group">
                                <g:select id="refReln" style="width: 100%;height: 50px" name="refReln" from="${['Counsellor/Mentor','Spiritual Master','Friend','Relative','Acquaintance']}" noSelection="['':'Referrer Relationship to Candidate...']" class="required"/>
                            </div>
                            <button type="submit" class="btn btn-success">Register</button>
                        </g:form>
                        </div>
                    </div>
                    </g:else>
                </div>
            </div>
    </section>
<r:layoutResources />
<script type="text/javascript">
    function validateSelect(){
        var isStepValid = true;
        $('#registrationFrom').find('select').each(function(){
            if(!$(this).valid()){
                isStepValid=false;
            }
        });
        $('#refCentre').select2({
            minimumResultsForSearch: -1
        });
        $('#refReln').select2({
            minimumResultsForSearch: -1
        });
        return isStepValid;
    }
    function resetPwd(){
        $('#loginFrmWrapper').hide();
        $('#forgotPwdWrapper').show();
        $('.btn-success','#forgotPwdWrapper').click(function() {
            $.ajax({
                method: "POST",
                url: "/ics/helper/forgotPassword",
                data: { loginId : $('#loginId').val()}
            }).success(function(data){
               $('#forgotPwdWrapper').html('<h2 style="text-align: center;font-weight:600;color:ghostwhite">'+data.message+'</h2>');
            });
            $('#loginId').val('');
        });
        $('.btn-danger','#forgotPwdWrapper').click(function(){
            $('#loginId').val('');
            $('#loginFrmWrapper').show();
            $('#forgotPwdWrapper').hide();
        });

    }
    $(document).ready(function() {
        $('#refCentre').select2({
            minimumResultsForSearch: -1
        });
        $('#refReln').select2({
            minimumResultsForSearch: -1
        });
        $("#menu-close").click(function (e) {
            e.preventDefault();
            $("#sidebar-wrapper").toggleClass("active");
        });

        // Opens the sidebar menu
        $("#menu-toggle").click(function (e) {
            e.preventDefault();
            $("#sidebar-wrapper").toggleClass("active");
        });
    });
</script>
</body>
</html>