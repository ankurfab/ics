<html>
<head>
	<meta name='layout' content='main'/>
	<title>Change Password</title>
</head>

<body>
<style>
	#forceChangePassword {
	margin: 15px 0px; padding: 0px;
	text-align: center;
	display: block;
	}
	#forceChangePassword .inner {
	width: 260px;
	margin:0px auto;
	text-align:left;
	padding:10px;
	border-top:1px dashed #499ede;
	border-bottom:1px dashed #499ede;
	background-color:#EEF;
	}
	#forceChangePassword .inner .fheader {
	padding:4px;margin:3px 0px 3px 0;color:#2e3741;font-size:14px;font-weight:bold;
	}
	#forceChangePassword .inner .cssform p {
	clear: left;
	margin: 0;
	padding: 5px 0 8px 0;
	padding-left: 105px;
	border-top: 1px dashed gray;
	margin-bottom: 10px;
	height: 1%;
	}
	#forceChangePassword .inner .cssform input[type='text'] {
	width: 120px;
	}
	#forceChangePassword .inner .cssform label{
	font-weight: bold;
	float: left;
	margin-left: -105px;
	width: 100px;
	}
	#forceChangePassword .inner .ChangePassword_message {color:red;}
	#forceChangePassword .inner .text_ {width:120px;}
	#forceChangePassword .inner .chk {height:12px;}
	.errorMessage { color: red; }
</style>
<div id='forceChangePassword'>
	<div class='inner'>
	<div class='fheader'>Your password has expired. Pls change password..</div>
	<g:formRemote name="myForm" class='cssform' on404="alert('not found!')" update="changePasswordMessage"
		onSuccess="handleResponse(data);"
		url="[controller: 'helper', action:'changePassword']">
		<p>
		<label for='opassword'>Old Password</label>
		<input type='password' class='text_' name='opassword' id='opassword' />
		</p>
		<p>
		<label for='password'>New Password</label>
		<input type='password' class='text_' name='password' id='password' />
		</p>
		<p>
		<label for='rpassword'>Retype Password</label>
		<input type='password' class='text_' name='rpassword' id='rpassword' />
		</p>
		<p>
		<g:submitButton name="update" value="Change" />
		<a href='javascript:void(0)' onclick='cancelChangePassword(); return false;'>Cancel</a>
		</p>
	</g:formRemote>
	<div style='display: block; text-align: left;' id='changePasswordMessage'></div>
	</div>
</div>

<script type='text/javascript'>
	function showChangePassword() {
		$('#forceChangePassword').show();
	}
	
	function cancelChangePassword() {
		$("#forceChangePasswordForm :input").prop("disabled", false);
		$('#forceChangePassword').hide();
	}

	function handleResponse(data) {
		if(data.success)
			{
			$('#changePasswordMessage').text('');
			$("#forceChangePasswordForm :input").prop("disabled", false);
			$('#forceChangePassword').hide();
			}
		else
			$('#changePasswordMessage').text(data.message);
	}

	function authChangePasswordAjax() {
		$("#forceChangePasswordForm :input").prop("disabled", false);
		$('#changePasswordMessage').text('Sending request ...');
		$('#changePasswordMessage').text($('#forceChangePasswordForm').serialize());
		$('#changePasswordMessage').show();

		$("#forceChangePasswordForm :input").prop("disabled", true);
		
		$.ajax({
			type : 'POST',
			url : $('#forceChangePasswordForm').attr( 'action' ),
			dataType : 'json',
			data: $('#forceChangePasswordForm').serialize(),
			//data: {password:"test"},
			success : function(data){
				alert("succ:"+data);
				$('#changePasswordMessage').text(data.message);
				//$('#forceChangePassword').hide();
			},
			error : function(XMLHttpRequest, textStatus, errorThrown) {
				alert("eror");
				var err = eval("(" + XMLHttpRequest.responseText + ")");
				alert("err:"+err);
				alert(textStatus);
				alert(errorThrown);
				$('#changePasswordMessage').text(err.message);
			},
			statusCode: {
			  404: function() {
			    $("#changePasswordMessage").html('Could not contact server.');
			  },
			  500: function() {
			    $("#changePasswordMessage").html('A server-side error has occurred.');
			  }
			}		
		});
	}
</script>
</body>
</html>