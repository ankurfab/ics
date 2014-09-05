<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ page import="ics.EventAccommodation" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta name="layout" content="main" />
		<g:set var="entityName" value="${message(code: 'eventAccommodation.label', default: 'Accommodation')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
		<r:require module="jqui" />
	</head>
	<body>
		<g:javascript src="jquery.validate.min.js" />
		<jqval:resources />
		<jqvalui:resources />
		<script>
			  $(document).ready(function(){
			    $("#eventAccommodationForm").validate({
				rules: {
				    name: "required",
				    hostMobileNumber: {
				       number: true
				    },
				    hostAlternateMobileNumber: {
				       number: true
				    },
				    maxCapacity: {
				      required: true,
				      min: 0
				    },
				    maxPrabhujis: {
				      min: 0,
				      max: function(element) {
				         //return parseInt($("#maxCapacity").val()) - parseInt($("#maxMatajis").val()) - parseInt($("#maxChildrens").val()); 
				         return parseInt($("#maxCapacity").val())
				      }
				    },
				    maxMatajis: {
				      min: 0,
				      max: function(element) {
					//return parseInt($("#maxCapacity").val()) - parseInt($("#maxPrabhujis").val()) - parseInt($("#maxChildrens").val()); 
					return parseInt($("#maxCapacity").val())
				      }
				    },
				    maxChildrens: {
				      min: 0,
				      max: function(element) {
					//return parseInt($("#maxCapacity").val()) - parseInt($("#maxMatajis").val()) - parseInt($("#maxPrabhujis").val()); 
					return parseInt($("#maxCapacity").val())
				      }
				    },
				    maxBrahmacharis: {
				      min: 0,
				      max: function(element) {
					//return parseInt($("#maxCapacity").val()) - parseInt($("#maxMatajis").val()) - parseInt($("#maxPrabhujis").val()); 
					return parseInt($("#maxCapacity").val())
				      }
				    },
				    distanceFromNVCC: {
				      required: true,
				      min: 0
				    },
				    negotiatedRate: {
				      min: 0
				    },
				    advanceGiven: {
				      min: 0
				    },
				    capacityofAllDormitories: {
				      min: 0
				    },
				    numberofToilets: {
				      min: 0
				    },
				    numberofBathrooms: {
				      min: 0
				    },
				    numberofRooms: {
				      min: 0
				    },
				    numberofClothesLine: {
				      min: 0
				    },
				    numberofBuckets: {
				      min: 0
				    },
				    numberofRoomsWithAttachedTNB: {
				      min: 0
				    },
				    numberofRoomsWithoutTNB: {
				      min: 0
				    }
				   },
				messages: {
				    name: "Please specify accommodation name.",
				    hostMobileNumber: {
				       number: "Please enter valid contact number (only digits)." 
				    }, 
				    hostAlternateMobileNumber: {
				       number: "Please enter valid contact number (only digits)." 
				    },
				    maxCapacity: {
				       required: "Please specify Maximum capacity",
				       min: "Maximum capacity can not be less than 0."
				    },
				    maxPrabhujis: {
				       min: "Number of maximum Prabhujis can not be less than 0." ,
				       max: "Number of maximum Prabhujis should not more than maximum capacity." 
				    },
				    maxMatajis: {
				       min: "Number of maximum Matajis can not be less than 0." ,
				       max: "Number of maximum Matajis should not more than maximum capacity." 
				    },
				    maxChildrens: {
				       min: "Number of maximum Childrens can not be less than 0." ,
				       max: "Number of maximum Childrens should not more than maximum capacity." 
				    },
				    distanceFromNVCC: {
				       required: "Please specify Distance from NVCC",
				       min: "Distance from NVCC can not be less than 0."
				    },
				    negotiatedRate: {
				      min: "Negotiated Rate can not be less than 0"
				    },
				    advanceGiven: {
				      min: "Advance Given can not be less than 0"
				    },
				    capacityofAllDormitories: {
				      min: "Capacity of All Dormitories can not be less than 0"
				    },
				    numberofToilets: {
				      min: "Number of Toilets can not be less than 0"
				    },
				    numberofBathrooms: {
				      min: "Number of Bathrooms can not be less than 0"
				    },
				    numberofRooms: {
				      min: "Number of Rooms can not be less than 0"
				    },
				    numberofClothesLine: {
				      min: "Number of Clothes Line can not be less than 0"
				    },
				    numberofBuckets: {
				      min: "Number of Buckets can not be less than 0"
				    },
				    numberofRoomsWithAttachedTNB: {
				      min: "Number of Rooms With Attached Toilet and Bathroom can not be less than 0"
				    },
				    numberofRoomsWithoutTNB: {
				      min: "Number of Rooms Without Attached Toilet and Bathroom can not be less than 0"
				    }
				  }
			    });
			  });
		</script>
		<div class="nav" role="navigation">
			<ul>
				<span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
				<sec:ifAnyGranted roles="ROLE_VIP_COORDINATOR,ROLE_VIP_ACCOMMODATION,ROLE_COMMUNICATION_COORDINATOR,ROLE_REGISTRATION_COORDINATOR,ROLE_EVENTMANAGER,ROLE_EVENTADMIN,ROLE_NVCC_ADMIN">				    
					<span class="menuButton"><g:link class="list" action="list">Accommodation List</g:link></span>
				</sec:ifAnyGranted>
			</ul>
		</div>
		
		<div id="create-eventAccommodation" class="content scaffold-create" role="main">
			<h1><g:message code="default.create.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${eventAccommodationInstance}">
			<jqvalui:renderErrors style="margin-bottom:10px">
				<g:renderErrors bean="${eventAccommodationInstance}" as="list" />
			</jqvalui:renderErrors>
			</g:hasErrors>
			<jqvalui:renderErrors style="margin-bottom:10px"/>
			<g:form action="save" method="post" id="eventAccommodationForm" name="eventAccommodationForm">
				<fieldset class="form">
					<g:render template="form"/>
					<div class="buttons" style="width:100px;">
					    <span class="button">
						<g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" />
					    </span>
					</div>
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
