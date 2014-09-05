<style>
	#ajaxLogin {
	margin: 15px 0px; padding: 0px;
	text-align: center;
	display: none;
	}
	#ajaxLogin .inner {
	width: 260px;
	margin:0px auto;
	text-align:left;
	padding:10px;
	border-top:1px dashed #499ede;
	border-bottom:1px dashed #499ede;
	background-color:#EEF;
	}
	#ajaxLogin .inner .fheader {
	padding:4px;margin:3px 0px 3px 0;color:#2e3741;font-size:14px;font-weight:bold;
	}
	#ajaxLogin .inner .cssform p {
	clear: left;
	margin: 0;
	padding: 5px 0 8px 0;
	padding-left: 105px;
	border-top: 1px dashed gray;
	margin-bottom: 10px;
	height: 1%;
	}
	#ajaxLogin .inner .cssform input[type='text'] {
	width: 120px;
	}
	#ajaxLogin .inner .cssform label{
	font-weight: bold;
	float: left;
	margin-left: -105px;
	width: 100px;
	}
	#ajaxLogin .inner .login_message {color:red;}
	#ajaxLogin .inner .text_ {width:120px;}
	#ajaxLogin .inner .chk {height:12px;}
	.errorMessage { color: red; }
</style>

<div id='ajaxLogin'>
	<div class='inner'>
		<div class='fheader'>Please Login..</div>
		<form action='${request.contextPath}/j_spring_security_check' method='POST'
			id='ajaxLoginForm' name='ajaxLoginForm' class='cssform'>
			<p>
			<label for='username'>Login ID</label>
			<input type='text' class='text_' name='j_username' id='username' />
			</p>
			<p>
			<label for='password'>Password</label>
			<input type='password' class='text_' name='j_password' id='password' />
			</p>
			<p>
			<label for='remember_me'>Remember me</label>
			<input type='checkbox' class='chk' id='remember_me'
			name='_spring_security_remember_me'/>
			</p>
			<p>
			<a href='javascript:void(0)' onclick='authAjax(); return false;'>Login</a>
			<a href='javascript:void(0)' onclick='cancelLogin(); return false;'>Cancel</a>
			</p>
		</form>
		<div style='display: none; text-align: left;' id='loginMessage'></div>
	</div>
</div>


<script type='text/javascript'>

	function showLogin() {
		//$('ajaxLogin').style.display = 'block';
		//document.getElementById('ajaxLogin').style.display = 'block';
		$('#ajaxLogin').show();
	}

	function cancelLogin() {
		//Form.enable(document.ajaxLoginForm);
		$("#ajaxLoginForm :input").prop("disabled", false);
		//Element.hide('ajaxLogin');
		$('#ajaxLogin').hide();
	}

	function authAjax() {	
		$('#ajaxLoginForm :input').prop("disabled", false);
		$('#loginMessage').text('Sending request ...');
		$('#loginMessage').show();

		$("#ajaxLoginForm :input").prop("disabled", true);
		
		$.ajax({
			type : 'POST',
			url : 'j_spring_security_check',
			dataType : 'json',
			data: $('#ajaxLoginForm').serialize(),
			success : function(data){
				$('#loginMessage').text(data);
				//$('#ajaxLogin').hide();
			},
			error : function(XMLHttpRequest, textStatus, errorThrown) {
				$('#loginMessage').text(errorThrown);
			}
		});
		
	}
</script>