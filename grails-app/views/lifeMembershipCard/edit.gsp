<%@ page import="ics.LifeMembershipCard" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'lifeMembershipCard.label', default: 'LifePatronCard')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
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

			  $("#dateFormSubmissionOriginatingDeptToForwardingDept").datepicker({yearRange: "-5:+5",changeMonth: true,changeYear: true,
					dateFormat: 'dd-mm-yy'});

			  $("#dateFormSubmissionForwardingDeptToLMDept").datepicker({yearRange: "-5:+5",changeMonth: true,changeYear: true,
					dateFormat: 'dd-mm-yy'});

			  $("#dateFormSentToProcessingDept").datepicker({yearRange: "-5:+5",changeMonth: true,changeYear: true,
					dateFormat: 'dd-mm-yy'});

			  $("#dateCardArrival").datepicker({yearRange: "-5:+5",changeMonth: true,changeYear: true,
					dateFormat: 'dd-mm-yy'});

			  $("#dateCardDelivery").datepicker({yearRange: "-5:+5",changeMonth: true,changeYear: true,
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
	
		<!--<a href="#edit-lifeMembershipCard" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>-->
		<div class="nav" role="navigation">
			<span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            		<span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>		
			<span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
			<!--<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>-->
		</div>
		<div id="edit-lifeMembershipCard" class="content scaffold-edit" role="main">
			<h1><g:message code="default.edit.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${lifeMembershipCardInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${lifeMembershipCardInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<g:form method="post" onsubmit="return validate();" >
				<g:hiddenField name="id" value="${lifeMembershipCardInstance?.id}" />
				<g:hiddenField name="version" value="${lifeMembershipCardInstance?.version}" />
				<fieldset class="form">
					<g:render template="formEdit"/>
				</fieldset>
				<fieldset class="buttons">
					<g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" formnovalidate="" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
		
		<script language="javascript">
			function validate()
			{
				if(document.getElementById('cardStatus').value == 'Form Submitted by Patron Care Dept To NVCC' && document.getElementById('dateFormSubmissionOriginatingDeptToForwardingDept').value == '')
				{
					alert('Please Enter Date Form Submission Patron Care Dept To NVCC!');
					return false;
				}
				if(document.getElementById('cardStatus').value == 'Form Sent To Juhu' && document.getElementById('dateFormSentToProcessingDept').value == '')
				{
					alert('Please Enter Date Form Sent To Juhu!');
					return false;
				}
				if(document.getElementById('cardStatus').value == 'Card Arrived' && document.getElementById('dateCardArrival').value == '')
				{
					alert('Please Enter Date Card Arrival!');
					return false;
				}
				if(document.getElementById('cardStatus').value == 'Card Delivered' && document.getElementById('dateCardDelivery').value == '')
				{
					alert('Please Enter Date Card Delivery!');
					return false;
				}
				
				return true;
			}
		</script>
	</body>
</html>
