<style>
	#ajaxResetPassword {
	margin: 15px 0px; padding: 0px;
	text-align: center;
	display: none;
	}
	#ajaxResetPassword .inner {
	width: 260px;
	margin:0px auto;
	text-align:left;
	padding:10px;
	border-top:1px dashed #499ede;
	border-bottom:1px dashed #499ede;
	background-color:#EEF;
	}
	#ajaxResetPassword .inner .fheader {
	padding:4px;margin:3px 0px 3px 0;color:#2e3741;font-size:14px;font-weight:bold;
	}
	#ajaxResetPassword .inner .cssform p {
	clear: left;
	margin: 0;
	padding: 5px 0 8px 0;
	padding-left: 105px;
	border-top: 1px dashed gray;
	margin-bottom: 10px;
	height: 1%;
	}
	#ajaxResetPassword .inner .cssform input[type='text'] {
	width: 120px;
	}
	#ajaxResetPassword .inner .cssform label{
	font-weight: bold;
	float: left;
	margin-left: -105px;
	width: 100px;
	}
	#ajaxResetPassword .inner .ResetPassword_message {color:red;}
	#ajaxResetPassword .inner .text_ {width:120px;}
	#ajaxResetPassword .inner .chk {height:12px;}
	.errorMessage { color: red; }
</style>

<div id='ajaxResetPassword'>
	<div class='inner'>
	<div class='fheader'>Reset Password ..</div>
	<g:formRemote name="myForm" class='cssform' on404="alert('not found!')" update="ResetPasswordMessage"
		onSuccess="cancelResetPassword();"
		url="[controller: 'helper', action:'resetPassword']">
		<p>
		<label for='username'>Login ID</label>
		<input type='text' class='text_' name='username' id='username' />
		</p>
		<p>
		<g:submitButton name="update" value="Reset" />
		<a href='javascript:void(0)' onclick='cancelResetPassword(); return false;'>Cancel</a>
		</p>
	</g:formRemote>

	<div style='display: none; text-align: left;' id='ResetPasswordMessage'></div>
	</div>
</div>

<script type='text/javascript'>
	function showResetPassword() {
		$('#ajaxResetPassword').show();
	}

	function cancelResetPassword() {
		$("#ajaxResetPasswordForm :input").prop("disabled", false);
		$('#ajaxResetPassword').hide();
	}

	function authResetPasswordAjax() {
		$("#ajaxResetPasswordForm :input").prop("disabled", false);
		$('#ResetPasswordMessage').text('Sending request ...');
		$('#ResetPasswordMessage').show();

		$("#ajaxResetPasswordForm :input").prop("disabled", true);
		
		$.ajax({
			type : 'POST',
			url : $('#ajaxResetPasswordForm').attr( 'action' ),
			data: $(this).serialize(),
			success : function(data){
				$('#ResetPasswordMessage').text(data);
				//$('#ajaxResetPassword').hide();
			},
			error : function(XMLHttpRequest, textStatus, errorThrown) {
				$('#ResetPasswordMessage').text(errorThrown);
			}
		});
	}
</script>