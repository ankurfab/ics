<%@ page import="ics.EventRegistration" %>
<!doctype html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta name="layout" content="main" />
		<title>Registration details for Sri Sri Radha Kunjbihari Bhakta Samaj Devotees </title>
	</head>
	<body>
		<div class="nav">
		    <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
		    <span class="menuButton"><g:link class="list" action="listlocal">Local Registration List</g:link></span>
		</div>
		
		<div id="create-eventRegistration" class="content scaffold-create" role="main">
			<h1>Registration details for Sri Sri Radha Kunjbihari Bhakta Samaj Devotees</h1>
			<g:form action="savelocal" method="post" name="eventRegistrationForm" onsubmit="return validateForm()">
				<g:hiddenField name="eventName" value="RVTO" />
				<fieldset class="form">
					<g:render template="localform"/>
					<div class="buttons" style="width:100px;">
					    <span class="button">
						<g:submitButton name="create" class="save" value="Register" />
					    </span>
					</div>
				</fieldset>
			</g:form>
		</div>
		
		<script>
			function validateForm()
			{
				for (var i=1;i<11;i++)
					{
					var name=document.forms["eventRegistrationForm"]["name"+i].value;
					if (!(name==null || name==""))
					  {
						var category=document.forms["eventRegistrationForm"]["category"+i].value;
						if (category==null || category=="")
						  {
						  alert("In row:"+i+" category must be filled out!!");
						  return false;
						  }
						var contact=document.forms["eventRegistrationForm"]["contact"+i].value;
						if (contact==null || contact=="")
						  {
						  alert("In row:"+i+" contact must be filled out!!");
						  return false;
						  }
						var sevaid=document.forms["eventRegistrationForm"]["sevaid"+i].value;
						if (sevaid==null || sevaid=="" || sevaid=="null")
						  {
						  alert("In row:"+i+" service must be filled out!!");
						  return false;
						  }
					  }
					}
			}		
		</script>
	</body>
</html>
