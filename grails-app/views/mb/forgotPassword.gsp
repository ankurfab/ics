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
<section id="services" class="services" style="background-color: #337ab7">
    <div class="container">
        <div class="row">
            <div id="resetPwdWrapper" class="col-sm-offset-3 col-sm-6 text">
                <div class="form-top-left" style="color: white">
                    <h3><strong>Reset Password</strong></h3>
                    <p style="font-weight: 600">Please enter the user ID and new passwords below.</p>
                </div>
                <g:formRemote name="myForm" class='cssform' on404="alert('not found!')" update="changePasswordMessage"
                              onSuccess="processPasswordReset(data)"
                              url="[controller: 'helper', action:'resetPassword']">
                    <g:hiddenField name="tokKey" value="${params.tokKey}"/>
                    <div class="form-group">
                        <input type="text" name="userName" placeholder="Login ID..." class="form-control" id="userName">
                    </div>
                    <div class="form-group">
                        <input type="password" name="password" placeholder="Password..." class="form-control" id="password">
                    </div>
                    <div class="form-group">
                        <input type="password" name="rpassword" placeholder="Retype Password..." class="form-control" id="rpassword">
                    </div>
                    <button type="submit" class="btn btn-success">Confirm</button>
                </g:formRemote>
            </div>
            <div id="otherOptionsWrapper" class="col-sm-offset-3 col-sm-6 text" style="display: none">
                <div class="form-top-left" style="color: white">
                    <h3 class="resetMessage"></h3>
                </div>
            </div>
        </div>
    </div>
</section>
<r:layoutResources />
<script type="text/javascript">
    function processPasswordReset(data){
        $('.resetMessage').html(data.message)
        if(data.success){
            $('#resetPwdWrapper').hide();
            $('#otherOptionsWrapper').append('<div class="actionItems" style="color: white;font-size:18px">To login now <a style="color: white" href="/ics/mb/mbLogin">Click Here</a></div>').show();
        }
        else{
            $('#resetPwdWrapper').hide();
            $('#otherOptionsWrapper').append('<div class="actionItems" style="color: white;font-size:18px">To fix the problem <a style="color: white" onClick="handleResetError();">Click Here</a></div>').show();
        }
    }
    function handleResetError(){
        $('.actionItems').remove();
        $('#otherOptionsWrapper').hide();
        $('#resetPwdWrapper').show();
    }
</script>
</body>
</html>
