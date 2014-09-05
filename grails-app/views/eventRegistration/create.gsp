<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ page import="ics.EventRegistration" %>
<%@ page import="ics.TransportMode" %>
<%@ page import="ics.Country" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta name="layout" content="main" />
		<title>Registration details for opening of NVCC, Pune</title>
		<r:require module="jqui" />
	</head>
	<body>
 		<g:javascript src="jquery.validate.min.js" />
		<jqval:resources />
		<jqvalui:resources />
		<script type="text/javascript">
			  $(document).ready(function(){
			    $("#eventRegistrationForm").validate({
				rules: {
				     // simple rule, converted to {required:true}
				     name: "required",
				     connectedIskconCenter: "required",
				     // compound rule
				     email: {
				       required: false,
				       email: true
				     },
				     contactNumber: {
				       required: true,
				       number: true
				     },
				     vipContactNumber: {
				       number: true
				     },
				     alternateContactNumber: {
				       number: true
				     },
				     numberofBrahmacharis: {
				      min: 0
				     },
				     numberofPrabhujis: {
				      min: 0
				     },
				     numberofMatajis: {
				      min: 0
				     },
				     numberofChildren: {
				      min: 0
				     }, 
				     noofBreakfasts: {
				      min: 0
				     }, 
				     noofLunches: {
				      min: 0
				     },
				     noofDinners: {
				      min: 0
				     },
				     numPrjiVolunteer: {
				      min: 0,
				      max: function(element) {
					return $("#numberofPrabhujis").val(); 
				      }
				     },
				     numBrahmacharisVolunteer: {
				      min: 0,
				      max: function(element) {
					return $("#numberofBrahmacharis").val(); 
				      }
				     },
				     numMatajiVolunteer: {
				      min: 0,
				      max: function(element) {
					return $("#numberofMatajis").val(); 
				      }
				     },
				    arrivalTravelingDetails: {
				      maxlength: 255
				    },				     
				    departureTravelingDetails: {
				      maxlength: 255
				    },				     
				    specialInstructions: {
				      maxlength: 255
				    }				     
				   },
				messages: {
				     name: "Please specify your name.",
				     connectedIskconCenter: "Please specify connected Iskcon Center/ Temple.",
				     email: {
				       email: "Your email address must be in the format of name@domain.com."
				     },
				     contactNumber: {
				       required: "Please enter contact number.",
				       number: "Please enter valid contact number (only digits)." 
				     },
				     vipContactNumber: {
				       number: "Please enter valid contact number (only digits)." 
				     },
				     alternateContactNumber: {
				       number: "Please enter valid alternate contact number (only digits)." 
				     },
				     numBrahmacharisVolunteer: {
				       min: "Number of volunteers can not be less than 0." ,
				       max: "Number of volunteers should not more than number of participants." 
				     },
				     numPrjiVolunteer: {
				       min: "Number of volunteers can not be less than 0." ,
				       max: "Number of volunteers should not more than number of participants." 
				     },
				     numberofBrahmacharis: {
				       min: "Number of Accompanying Brahmacharis/Students can not be less than 0."
				     },
				     numberofPrabhujis: {
				       min: "Number of Accompanying Prabhujis can not be less than 0."
				     },
				     numberofMatajis: {
				       min: "Number of Accompanying Matajis can not be less than 0."
				     },
				     numberofChildren: {
				       min: "Number of Accompanying Childrens can not be less than 0."
				     },
				     noofBreakfasts: {
				       min: "Number of Breakfast Packets can not be less than 0."
				     },
				     noofLunches: {
				       min: "Number of Lunch Packets can not be less than 0."
				     },
				     noofDinners: {
				       min: "Number of Dinner packets can not be less than 0."
				     },
				     numMatajiVolunteer: {
				       min: "Number of volunteers can not be less than 0." ,
				       max: "Number of volunteers should not more than number of participants." 
				     }
				   }
			    });
			  });
		</script>

		<div class="nav" role="navigation">
			<ul>
				<span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
				<sec:ifAnyGranted roles="ROLE_VIP_COORDINATOR,ROLE_VIP_REGISTRATION,ROLE_COMMUNICATION_COORDINATOR,ROLE_REGISTRATION_COORDINATOR,ROLE_EVENTMANAGER,ROLE_EVENTADMIN,ROLE_NVCC_ADMIN">				    
					<span class="menuButton"><g:link class="list" action="list">Registration List</g:link></span>
				</sec:ifAnyGranted>
			</ul>
		</div>
		
		<div id="create-eventRegistration" class="content scaffold-create" role="main">
			<h1>Registration details for opening of NVCC, Pune</h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${eventRegistrationInstance}">
			<jqvalui:renderErrors style="margin-bottom:10px">
				<g:renderErrors bean="${eventRegistrationInstance}" as="list" />
			</jqvalui:renderErrors>
			</g:hasErrors>
			<jqvalui:renderErrors style="margin-bottom:10px"/>
			<g:form action="save" method="post" id="eventRegistrationForm" name="eventRegistrationForm">
				<g:hiddenField name="eventName" value="RVTO" />
				<fieldset class="form">
					<g:render template="form"/>
					<div class="buttons" style="width:100px;">
					    <span class="button">
						<g:submitButton name="create" class="save" value="Register" />
					    </span>
					</div>
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
