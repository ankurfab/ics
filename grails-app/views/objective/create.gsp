<%@ page import="ics.Objective" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'objective.label', default: 'Objective')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
		<gui:resources components="['autoComplete']"/>
			<style>
				.yui-skin-sam .yui-ac-content {
				  width: 350px !important;
			</style>

		<link rel="stylesheet" href="${resource(dir: 'css/start', file: 'jquery-ui-1.8.18.custom.css')}" type="text/css">
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'timepicker.css')}" type="text/css">
	</head>
	<body>
    	<g:javascript src="jquery-ui-1.8.18.custom.min.js" />
    	<g:javascript src="jquery-ui-timepicker-addon.js" />
    	<script type="text/javascript">
            $(document).ready(function()
            {
		$('#objFrom').datetimepicker({
		    onClose: function(dateText, inst) {
			var objToTextBox = $('#objTo');
			if (objToTextBox.val() != '') {
			    var testobjFrom = new Date(dateText);
			    var testobjTo = new Date(objToTextBox.val());
			    if (testobjFrom > testobjTo)
				objToTextBox.val(dateText);
			}
			else {
			    objToTextBox.val(dateText);
			}
		    },
		    onSelect: function (selectedDateTime){
			var start = $(this).datetimepicker('getDate');
			$('#objTo').datetimepicker('option', 'minDate', new Date(start.getTime()));
		    },
		    dateFormat: 'dd-mm-yy'
		});
		$('#objTo').datetimepicker({
		    onClose: function(dateText, inst) {
			var objFromTextBox = $('#objFrom');
			if (objFromTextBox.val() != '') {
			    var testobjFrom = new Date(objFromTextBox.val());
			    var testobjTo = new Date(dateText);
			    if (testobjFrom > testobjTo)
				objFromTextBox.val(dateText);
			}
			else {
			    objFromTextBox.val(dateText);
			}
		    },
		    onSelect: function (selectedDateTime){
			var end = $(this).datetimepicker('getDate');
			$('#objFrom').datetimepicker('option', 'maxDate', new Date(end.getTime()) );
		    },
		    dateFormat: 'dd-mm-yy'
		});          	
            })
    	</script>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
        </div>
		<div id="create-objective" class="content scaffold-create" role="main">
			<h1><g:message code="default.create.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${objectiveInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${objectiveInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<g:form action="save" >
				<fieldset class="form">
					<g:render template="form"/>
				</fieldset>
				<fieldset class="buttons">
					<g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
