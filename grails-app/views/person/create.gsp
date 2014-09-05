<%@ page import="ics.Person" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'person.label', default: 'Person')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
		<r:require module="jqui" />
		<gui:resources components="['autoComplete']"/>
		<style>
		.yui-skin-sam .yui-ac-content {
		  width: 350px !important;}
		</style>

		<link rel="stylesheet" href="${resource(dir: 'css/start', file: 'jquery-ui-1.8.18.custom.css')}" type="text/css">
	</head>
	<body onLoad="return tabOrders();">
	<g:javascript src="jquery-ui-1.8.18.custom.min.js" />    
	    <script type="text/javascript">
		$(document).ready(function()
		{

		  $("#dob").datepicker({yearRange: "-100:+0",changeMonth: true,changeYear: true,
				dateFormat: 'dd-mm-yy'});

		  $("#dom").datepicker({yearRange: "-100:+0",changeMonth: true,changeYear: true,
				dateFormat: 'dd-mm-yy'});

	    var tabindex = 1;
	    $('input,select,textarea').each(function() {
		if (this.type != "hidden") {
		    var $input = $(this);
		    $input.attr("tabindex", tabindex);
		    tabindex++;
		}
	    });          

		})
	    </script>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
        </div>
		<div id="create-person" class="body">
			<h1><g:message code="default.create.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${personInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${personInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<g:form action="save" onsubmit="return validate();" >
				<g:hiddenField name="reference" value="${session.individualid}" />
				<fieldset class="form">
					<g:render template="form"/>
				</fieldset>
				<fieldset class="buttons">
					<g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" />
				</fieldset>
			</g:form>
		</div>
		<script language="javascript">
			function validate()
			{
				if((document.getElementById('name').value).length <= 3)
				{
					alert('Please enter name greater than 3 characters');
					document.getElementById('name').focus();
					return false;
				}
				return true;
			}
		</script>
		
	</body>
</html>
