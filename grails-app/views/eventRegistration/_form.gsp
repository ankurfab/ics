<%@ page import="ics.EventRegistration" %>
<%@ page import="ics.TransportMode" %>
<%@ page import="ics.Country" %>
<%@ page import="ics.Airports" %>
<%@ page import="ics.RailwayStations" %>
<%@ page import="ics.GuestType" %>

<script type="text/javascript">

function toggle(chkbox, group) { 
   var visSetting = (chkbox.checked) ? "block" : "none"; 
   document.getElementById(group).style.display = visSetting; 
} 

function toggleOtherGT(group) { 
   var val = $(group).attr('value');
   if(val == "OTHER_POSTS") {
	 document.getElementById("divOtherGuestType").style.display = "block"; 
   } else {
	 document.getElementById("divOtherGuestType").style.display = "none"; 
   }
}

function toggleTransport() { 
//   var val = $(group).attr('value');
//   val = val.concat('-',group.name);
   var isPickUpChecked = $('#pickUpRequired').is(':checked');
   var isDropChecked = $('#dropRequired').is(':checked');
   //alert(val);
   if(isPickUpChecked == true) {
	switch ($('input[name=arrivalTransportMode]:checked').val()) {
	   //Arrival
	   case "BUS": $("#divarrivalBusMode").show();$("#divarrivalTrainMode").hide();$("#divarrivalFlightMode").hide();break; 
	   case "TRAIN": $("#divarrivalBusMode").hide(); $("#divarrivalTrainMode").show(); $("#divarrivalFlightMode").hide(); break;
	   case "FLIGHT": $("#divarrivalBusMode").hide(); $("#divarrivalTrainMode").hide(); $("#divarrivalFlightMode").show(); break;
	   default: $("input[name=arrivalTransportMode][value=Bus]").attr('checked', true); $('#arrivalBusStation').val("Shivaji Nagar"); $("#divarrivalBusMode").show(); $("#divarrivalTrainMode").hide(); $("#divarrivalFlightMode").hide(); break;
	}
   } else {
	$('#arrivalTransportMode').val("");
	$('#arrivalBusStation').val("");
	$('#arrivalBusNumber').val(null);
	$('#arrivalFlightCarrier').val(null);
	$('#arrivalFlightNumber').val(null);
	$('#arrivalTrainName').val(null);
	$('#arrivalTrainNumber').val(null);
	$("#divarrivalBusMode").hide(); $("#divarrivalTrainMode").hide(); $("#divarrivalFlightMode").hide();
   }

   if(isDropChecked == true) {
	switch ($('input[name=departureTransportMode]:checked').val()) {
	   // Departure
	   case "BUS": $("#divdepartureBusMode").show(); $("#divdepartureTrainMode").hide(); $("#divdepartureFlightMode").hide(); break; 
	   case "TRAIN": $("#divdepartureBusMode").hide(); $("#divdepartureTrainMode").show(); $("#divdepartureFlightMode").hide(); break;
	   case "FLIGHT": $("#divdepartureBusMode").hide(); $("#divdepartureTrainMode").hide(); $("#divdepartureFlightMode").show(); break;
	   default: $('#departureTransportMode').val("BUS"); $('#departureBusStation').val("Shivaji Nagar"); $("#divdepartureBusMode").show(); $("#divdepartureTrainMode").hide(); $("#divdepartureFlightMode").hide(); break;
	}	
   } else {
	$('#departureTransportMode').val("");
	$('#departureBusStation').val("");
	$('#departureBusNumber').val(null);
	$('#departureFlightCarrier').val(null);
	$('#departureFlightNumber').val(null);
	$('#departureTrainName').val(null);
	$('#departureTrainNumber').val(null);
	$("#divdepartureBusMode").hide(); $("#divdepartureTrainMode").hide(); $("#divdepartureFlightMode").hide();
   }
} 

function toggleDiv(chkbox) { 
    switch (chkbox.name) {
	case "isVolunteersAvailable":
	  toggle(chkbox, "divisVolunteersAvailable");
	  if(!chkbox.checked) {
		$('#numPrjiVolunteer').val(0);
		$('#numMatajiVolunteer').val(0);
	  }
	  break;
	case "isVipDevotee":
	  toggle(chkbox, "divisvip");
	  break;
	case "pickUpRequired":
	  toggle(chkbox, "divnoPickUp");
	  toggleTransport();
	  break;
	case "dropRequired":
	  toggle(chkbox, "divnoDrop");
	  toggleTransport();
	  break;
	case "isTravelingPrasadRequired":
	  toggle(chkbox, "divnoofTravelingPrasadRequired");
	  if(!chkbox.checked) {
		$('#noofBreakfasts').val(0);
		$('#noofLunches').val(0);
		$('#noofDinners').val(0);
	  }
	  break;
     }
} 

function datePickerCall() {
    $('#arrivalDate, #departureDate').datepicker({
	     showOn: "both",
	     beforeShow: customRange,
	     dateFormat: "dd-mm-yy",
	     firstDay: 1, 
	     changeFirstDay: false
    });

    $("#vipArrivalDate").datepicker({
	    dateFormat:'dd-mm-yy',
	    changeYear:true,
	    changeMonth:true,
	    defaultDate:"${eventRegistrationInstance?.event?.startDate?.format('dd-MM-yyyy')}"
    });

    $("#vipDepartureDate").datepicker({
	    dateFormat:'dd-mm-yy',
	    changeYear:true,
	    changeMonth:true,
	    defaultDate:"${eventRegistrationInstance?.event?.endDate?.format('dd-MM-yyyy')}"
    });
}

function customRange(input) { 
    var min = new Date(${(eventRegistrationInstance?.event?.startDate-1)?.getTime()}), //Set this to your absolute minimum date
        dateMin = min,
        dateMax = null,
        dayRange = ${eventRegistrationInstance?.event?.endDate-eventRegistrationInstance?.event?.startDate}; // Set this to the range of days you want to restrict to

    if (input.id === "arrivalDate") {
        if ($("#departureDate").datepicker("getDate") != null) {
            dateMax = $("#departureDate").datepicker("getDate");
            dateMin = $("#departureDate").datepicker("getDate");
            dateMin.setDate(dateMin.getDate() - dayRange);
            if (dateMin < min) {
                dateMin = min;
            }
        }
        else {
            dateMax = new Date(${(eventRegistrationInstance?.event?.endDate+1)?.getTime()}) //Set this to your absolute maximum date
        }                      
    }
    else if (input.id === "departureDate") {
        var deptMax = new Date(${(eventRegistrationInstance?.event?.endDate+1)?.getTime()});
	dateMax = deptMax; //Set this to your absolute maximum date
        if ($("#arrivalDate").datepicker("getDate") != null) {
            dateMin = $("#arrivalDate").datepicker("getDate");
            var rangeMax = new Date(${eventRegistrationInstance?.event?.startDate?.format('yyyy')}, ${eventRegistrationInstance?.event?.startDate?.format('MM')}, dateMin.getDate() + dayRange);

            if(rangeMax < dateMax) {
                dateMax = rangeMax; 
            }
        } else {
	    var deptMin = new Date(${(eventRegistrationInstance?.event?.endDate)?.getTime()});
	    dateMin = deptMin;	
	}
    }
    return {
        minDate: dateMin, 
        maxDate: dateMax
    };     
}

$(document).ready(function() {
    $("input[type='checkbox']").each(function() {
	    toggleDiv(this);
    });

    $('#arrivalTransportMode').each(function() {
	    toggleTransport(this);
    });

    $('#guestType').each(function() {
	    toggleOtherGT(this);
    });

    $('#departureTransportMode').each(function() {
	    toggleTransport(this);
    });
    if(document.documentMode!=9) {
	    datePickerCall(); 
    }
});

$(function(){
    $("input[type='checkbox']").click(function(e){
        toggleDiv(this)
    });

    $("input:radio[name=arrivalTransportMode]").click(function() { 
	  toggleTransport(this);
    }); 

    $("input:radio[name=guestType]").click(function() { 
	  toggleOtherGT(this);
    });

    $("input:radio[name=departureTransportMode]").click(function() { 
	  toggleTransport(this);
    });
    
});

</script>


<g:hiddenField name="browser" value="NOTIE9" />

<g:hiddenField name="indid" value="${eventRegistrationInstance?.individual?.id}" />
<g:hiddenField name="eid" value="${eventRegistrationInstance?.event?.id}" />

<div class="collection_group">

	<div class="dialog"><table>

		<tr class="prop"><div class="caption_title">General Information</div></tr>

		<sec:ifNotGranted roles="ROLE_EVENTPARTICIPANT">
		
			<!-- Event -->

			<tr class="prop" style="display:none">
				<td valign="top" class="name">
					<label for="event">
						<g:message code="eventRegistration.event.label" default="Event" />
						<span class="required-indicator">*</span>
					</label>
				</td>
				<td valign="top" class="fieldcontain ${hasErrors(bean: eventRegistrationInstance, field: 'event', 'error')} required">
					<g:select disabled="true" id="event" name="event.id" from="${ics.Event.list()}" optionKey="id" required="" value="${eventRegistrationInstance?.event?.id}" class="many-to-one"/>
				</td>
			</tr>

			<!-- Registration Code -->

			<g:if test="${eventRegistrationInstance?.regCode}">
			<tr class="prop">
				<td class="name">
					<g:message code="eventRegistration.regCode.label" default="Registration Code" />
				</td>
				<td class="value">
					<g:fieldValue bean="${eventRegistrationInstance}" field="regCode"/>
				</td>
			</tr>
			</g:if>

			<!-- Name -->

			
			<tr class="prop">
				<td valign="top" class="name">
					<label for="name">
						<sec:ifAnyGranted roles="ROLE_VIP_COORDINATOR,ROLE_VIP_REGISTRATION">
							<g:message code="eventRegistration.vipName" default="Name of Main Guest" />
						</sec:ifAnyGranted>
						<sec:ifNotGranted roles="ROLE_VIP_COORDINATOR,ROLE_VIP_REGISTRATION">
							<g:message code="eventRegistration.name" default="Name" />
						</sec:ifNotGranted>
						<span class="required-indicator">*</span>
					</label>
				</td>
				<td valign="top" class="fieldcontain ${hasErrors(bean: eventRegistrationInstance, field: 'name', 'error')} required">
					<g:textField name="name" value="${eventRegistrationInstance?.name}" required=""/>
				</td>
			</tr>

			<!-- Associated Center -->

			<sec:ifNotGranted roles="ROLE_VIP_COORDINATOR,ROLE_VIP_REGISTRATION">
				<tr class="prop">
					<td valign="top" class="name">
						<label for="connectedIskconCenter">
							<g:message code="eventRegistration.connectedIskconCenter" default="Connected Iskcon Temple/Center" />
							<span class="required-indicator">*</span>
						</label>
					</td>
					<!--placeholder="Isckon temple center"-->
					<td valign="top" class="fieldcontain ${hasErrors(bean: eventRegistrationInstance, field: 'connectedIskconCenter', 'error')} required">
						<g:textField name="connectedIskconCenter"  value="${eventRegistrationInstance?.connectedIskconCenter}" class="connectedIskconCenter" required=""/>
					</td>
				</tr>
			</sec:ifNotGranted>
			<sec:ifAnyGranted roles="ROLE_VIP_COORDINATOR,ROLE_VIP_REGISTRATION">
				<tr class="prop">
					<td valign="top" class="name">
						<label for="connectedIskconCenter">
							<g:message code="eventRegistration.connectedIskconCenter" default="Connected Iskcon Temple/Center" />
						</label>
					</td>
					<!--placeholder="Isckon temple center"-->
					<td valign="top" class="fieldcontain ${hasErrors(bean: eventRegistrationInstance, field: 'connectedIskconCenter', 'error')}">
						<g:textField name="vipConnectedIskconCenter"  value="${eventRegistrationInstance?.connectedIskconCenter}"/>
					</td>
				</tr>
			</sec:ifAnyGranted>

			
			<sec:ifAnyGranted roles="ROLE_VIP_COORDINATOR,ROLE_VIP_REGISTRATION">

				<!-- Type of Guest -->

				<tr class="prop">
					<td valign="top" class="name">
						<label for="guestType">
							<g:message code="eventRegistration.guestType" default="Guest Type" />
						 </label>
					</td>
					<td valign="top" class="fieldcontain ${hasErrors(bean: eventRegistrationInstance, field: 'guestType', 'error')} ">
						<g:radioGroup name="guestType" id="guestType"
								  values="${GuestType.values()}" 
								  labels="${GuestType.values().displayName}"
								  value="${fieldValue(bean: eventRegistrationInstance, field: 'guestType')}">
						  ${it.radio} <g:message code="${it.label}" />&nbsp;
						</g:radioGroup>
						
					</td>
				</tr>

				<!-- Other Type of Guest -->
				
				<tr class="prop" colspan="2">
					
					<table id="divOtherGuestType" style="display:none">

					<tr class="prop">
						<td valign="top" class="name">
							<label for="otherGuestType">
								<g:message code="eventRegistration.otherGuestType" default="Please Specify" />
							</label>
						</td>
						<!--placeholder="Isckon temple center"-->
						<td valign="top" class="fieldcontain ${hasErrors(bean: eventRegistrationInstance, field: 'otherGuestType', 'error')}">
							<g:textField name="otherGuestType"  value="${eventRegistrationInstance?.otherGuestType}"/>
						</td>
					</tr>

					</table>

				</tr>

			</sec:ifAnyGranted>

		</sec:ifNotGranted>

		<sec:ifAnyGranted roles="ROLE_EVENTPARTICIPANT">

			<!-- Registration Code -->

			<g:if test="${eventRegistrationInstance?.regCode}">
			<tr class="prop">
				<td class="name">
					<g:message code="eventRegistration.regCode.label" default="Registration Code" />
				</td>
				<td class="value">
					<g:fieldValue bean="${eventRegistrationInstance}" field="regCode"/>
				</td>
			</tr>
			</g:if>

			<!-- Name -->

			<g:if test="${eventRegistrationInstance?.name}">
			<tr class="prop">
				<td class="name">
					<g:message code="eventRegistration.name.label" default="Name" />
				</td>
				<td class="value">
					${eventRegistrationInstance?.name}
				</td>
			</tr>
			</g:if>

			<!-- Associated Center -->

			<g:if test="${eventRegistrationInstance?.connectedIskconCenter}">
			<tr class="prop">
				<td class="name">
					<g:message code="eventRegistration.connectedIskconCenter.label" default="Connected Iskcon Temple/Center" />
				</td>
				<td class="value">
					<g:fieldValue bean="${eventRegistrationInstance}" field="connectedIskconCenter"/>
				</td>
			</tr>
			</g:if>

		</sec:ifAnyGranted>
	</table></div>

</div>


<div class="collection_group">

	<div class="dialog"><table>
	
		<tr class="prop"><div class="caption_title">Contact Information</div></tr>

		<sec:ifNotGranted roles="ROLE_EVENTPARTICIPANT">

			<sec:ifNotGranted roles="ROLE_VIP_COORDINATOR,ROLE_VIP_REGISTRATION">
				<!-- Country -->

				<tr class="prop">
					<td valign="top" class="name">
						<label for="country">
							<g:message code="eventRegistration.country.label" default="Country" />
							<span class="required-indicator">*</span>
						</label>
					</td>
					<td valign="top" class="fieldcontain ${hasErrors(bean: eventRegistrationInstance, field: 'country', 'error')} required">
						<g:select id="country" name="country.id" from="${ics.Country.list(sort:'name')}" optionKey="id" value="${eventRegistrationInstance?.country?.id}" class="many-to-one"/>
					</td>
				</tr>

				<!-- Contact Number -->

				<tr class="prop">
					<td valign="top" class="name">
						<label for="contactNumber">
							<g:message code="eventRegistration.contactNumber" default="Contact Number" />
							<span class="required-indicator">*</span>
						</label>
					</td>
					<td valign="top" class="fieldcontain ${hasErrors(bean: eventRegistrationInstance, field: 'contactNumber', 'error')} required">
						<g:textField name="contactNumber" value="${eventRegistrationInstance.contactNumber}" class="contactNumber" required=""/>
					</td>
				</tr>

			</sec:ifNotGranted>
			<sec:ifAnyGranted roles="ROLE_VIP_COORDINATOR,ROLE_VIP_REGISTRATION">
				<!-- Country -->

				<tr class="prop">
					<td valign="top" class="name">
						<label for="country">
							<g:message code="eventRegistration.country.label" default="Country" />
						</label>
					</td>
					<td valign="top" class="fieldcontain ${hasErrors(bean: eventRegistrationInstance, field: 'country', 'error')}">
						<g:select id="country" name="country.id" from="${ics.Country.list(sort:'name')}" optionKey="id" value="${eventRegistrationInstance?.country?.id}" class="many-to-one"/>
					</td>
				</tr>

				<!-- Contact Number -->

				<tr class="prop">
					<td valign="top" class="name">
						<label for="contactNumber">
							<g:message code="eventRegistration.contactNumber" default="Contact Number" />
						</label>
					</td>
					<td valign="top" class="fieldcontain ${hasErrors(bean: eventRegistrationInstance, field: 'contactNumber', 'error')}">
						<g:textField name="vipContactNumber" value="${eventRegistrationInstance.contactNumber}" class="vipContactNumber"/>
					</td>
				</tr>
			</sec:ifAnyGranted>
			
		</sec:ifNotGranted>

		<sec:ifAnyGranted roles="ROLE_EVENTPARTICIPANT">

			<!-- Country -->

			<g:if test="${eventRegistrationInstance?.country}">
			<tr class="prop">
				<td class="name">
					<g:message code="eventRegistration.country.label" default="Country" />
				</td>
				<td class="value">
					<g:fieldValue bean="${eventRegistrationInstance}" field="country"/>
				</td>
			</tr>
			</g:if>

			<!-- Contact Number -->

			<g:if test="${eventRegistrationInstance?.contactNumber}">
			<tr class="prop">
				<td class="name">
					<g:message code="eventRegistration.contactNumber.label" default="Contact Number" />
				</td>
				<td class="value">
					${eventRegistrationInstance?.contactNumber}
				</td>
			</tr>
			</g:if>

		</sec:ifAnyGranted>

		<!-- Alternet Contact Number -->

		<tr class="prop">
			<td valign="top" class="name">
				<label for="alternateContactNumber">
					<g:message code="eventRegistration.alternateContactNumber" default="Alternate Contact Number" />
				</label>
			</td>
			<td valign="top" class="fieldcontain ${hasErrors(bean: eventRegistrationInstance, field: 'alternateContactNumber', 'error')}">
				<g:textField name="alternateContactNumber" value="${eventRegistrationInstance.alternateContactNumber}" class="alternateContactNumber"/>
			</td>
		</tr>

		<!-- Email Address -->

		<tr class="prop">
			<td valign="top" class="name">
				<label for="email">
					<g:message code="eventRegistration.email" default="Email" />
				</label>
			</td>
			<td valign="top" class="fieldcontain ${hasErrors(bean: eventRegistrationInstance, field: 'email', 'error')} ">
				<g:textField name="email" size="50" value="${eventRegistrationInstance?.email}" class="email"/>
			</td>
		</tr>


	</table></div>

</div>




<div class="collection_group">

	<div class="dialog"><table>
	
		<tr class="prop"><div class="caption_title">Accompanying Information</div></tr>

		<tr class="prop">
			<td></td>
			<td><sec:ifNotGranted roles="ROLE_VIP_COORDINATOR,ROLE_VIP_REGISTRATION">
				<div class="message">Kindly fill up the number of devotees arriving along with you, include yourself in the number.</div>
				<div class="message">You can register for an Individual or Family or Others (if traveling together). In case devotees from your group are not traveling together then register each group (which is traveling together) separately.</div>
			    </sec:ifNotGranted>
			    <sec:ifAnyGranted roles="ROLE_VIP_COORDINATOR,ROLE_VIP_REGISTRATION">
  				<div class="message">Please include main guest in the number.</div>
			    </sec:ifAnyGranted>
			</td>
		</tr>

		<!-- No Of Brahmacharis/Students Coming -->

		<tr class="prop">
			<td valign="top" class="name">
				<label for="numberofBrahmacharis">
					<g:message code="eventRegistration.numberofBrahmacharis" default="Accompanying Brahmacharis/Students" />
				</label>
			</td>
			<td valign="top" class="fieldcontain ${hasErrors(bean: eventRegistrationInstance, field: 'numberofBrahmacharis', 'error')} ">
				<g:field name="numberofBrahmacharis" type="number" value="${eventRegistrationInstance.numberofBrahmacharis}" class="numberofBrahmacharis"/>
			</td>
		</tr>		
		
		<!-- No Of Prabhujies Coming -->

		<tr class="prop">
			<td valign="top" class="name">
				<label for="numberofPrabhujis">
					<g:message code="eventRegistration.numberofPrabhujis" default="Accompanying Prabhujis" />
				</label>
			</td>
			<td valign="top" class="fieldcontain ${hasErrors(bean: eventRegistrationInstance, field: 'numberofPrabhujis', 'error')} ">
				<g:field name="numberofPrabhujis" type="number" value="${eventRegistrationInstance.numberofPrabhujis}" class="numberofPrabhujis"/>
			</td>
		</tr>

		<!-- No Of Matajis Coming -->

		<tr class="prop">
			<td valign="top" class="name">
				<label for="numberofMatajis">
					<g:message code="eventRegistration.numberofMatajis" default="Accompanying Matajis" />
				</label>
			</td>
			<td valign="top" class="fieldcontain ${hasErrors(bean: eventRegistrationInstance, field: 'numberofMatajis', 'error')} ">
				<g:field name="numberofMatajis" type="number" value="${eventRegistrationInstance.numberofMatajis}" class="numberofMatajis"/>
			</td>
		</tr>

		<!-- No Of Childrens Coming -->

		<tr class="prop">
			<td valign="top" class="name">
				<label for="numberofChildren">
					<g:message code="eventRegistration.numberofChildren" default="Accompanying Childrens" />
				</label>
			</td>
			<td valign="top" class="fieldcontain ${hasErrors(bean: eventRegistrationInstance, field: 'numberofChildren', 'error')} ">
				<g:field name="numberofChildren" type="number" value="${eventRegistrationInstance.numberofChildren}" class="numberofChildren"/>
			</td>
		</tr>

		<tr class="prop">
			<td valign="top" class="name">
				<label for="isAccommodationRequired">
					<g:message code="eventRegistration.isAccommodationRequired" default="Is Accommodation Required" />
				</label>
			</td>
			<td valign="top" class="fieldcontain ${hasErrors(bean: eventRegistrationInstance, field: 'isAccommodationRequired', 'error')} ">
				
				<sec:ifNotGranted roles="ROLE_VIP_COORDINATOR,ROLE_VIP_EGISTRATION,ROLE_EVENTADMIN,ROLE_REGISTRATION_COORDINATOR">
					<g:checkBox name="isAccommodationRequired" value="${eventRegistrationInstance?.isAccommodationRequired}"/>				
				</sec:ifNotGranted>			
				<sec:ifAnyGranted roles="ROLE_VIP_COORDINATOR,ROLE_VIP_EGISTRATION,ROLE_EVENTADMIN,ROLE_REGISTRATION_COORDINATOR">
					<g:checkBox name="isAccommodationRequired" value="${eventRegistrationInstance?.isAccommodationRequired}"/>				
				</sec:ifAnyGranted>			
			</td>
		</tr>

		<tr class="prop">
			<td valign="top" class="name">
				<label for="accomodationPreference">
					<g:message code="eventRegistration.accomodationPreference" default="Accommodation Preference" />
				</label>
			</td>
			<td valign="top" class="fieldcontain ${hasErrors(bean: eventRegistrationInstance, field: 'accomodationPreference', 'error')} ">
				<g:select name="accomodationPreference" from="${['None','AC','Non-AC']}" value="${eventRegistrationInstance.accomodationPreference}"
					  noSelection="['':'-Choose Accomodation Preference-']"/>				
			</td>
		</tr>

		<sec:ifNotGranted roles="ROLE_VIP_COORDINATOR,ROLE_VIP_REGISTRATION">

		<!-- Are Volunteers Available -->

		<tr class="prop">
			<td valign="top" class="name">
				<label for="isVolunteersAvailable">
					<g:message code="eventRegistration.isVolunteersAvailable" default="Like to volunteer during festival?" />
				</label>
			</td>
			<td valign="top" class="fieldcontain ${hasErrors(bean: eventRegistrationInstance, field: 'isVolunteersAvailable', 'error')} ">
				<g:checkBox name="isVolunteersAvailable" value="${eventRegistrationInstance?.isVolunteersAvailable}" />
			</td>
		</tr>

		<tr class="prop" colspan="2">

			<table id="divisVolunteersAvailable" style="display:none">
		
				<tr class="prop">
					<td></td>
					<td><div class="message">Volunteers offering services during event.</div></td>
				</tr>

				<!-- No Of Brahmacharis Volunteer -->

				<tr class="prop">
					<td valign="top" class="name">
						<label for="numBrahmacharisVolunteer">
							<g:message code="eventRegistration.numBrahmacharisVolunteer" default="No Of Brahmacharis Volunteer" />
						</label>
					</td>
					<td valign="top" class="fieldcontain ${hasErrors(bean: eventRegistrationInstance, field: 'numBrahmacharisVolunteer', 'error')} ">
						<g:field name="numBrahmacharisVolunteer" type="number" value="${eventRegistrationInstance.numBrahmacharisVolunteer}" class="numBrahmacharisVolunteer"/>
					</td>
				</tr>
				
				<!-- No Of Prabhuji Volunteer -->

				<tr class="prop">
					<td valign="top" class="name">
						<label for="numPrjiVolunteer">
							<g:message code="eventRegistration.numPrjiVolunteer" default="No Of Prabhujis Volunteer" />
						</label>
					</td>
					<td valign="top" class="fieldcontain ${hasErrors(bean: eventRegistrationInstance, field: 'numPrjiVolunteer', 'error')} ">
						<g:field name="numPrjiVolunteer" type="number" value="${eventRegistrationInstance.numPrjiVolunteer}" class="numPrjiVolunteer"/>
					</td>
				</tr>
				
				<!-- No Of Mataji Volunteer -->

				<tr class="prop">
					<td valign="top" class="name">
						<label for="numMatajiVolunteer">
							<g:message code="eventRegistration.numMatajiVolunteer" default="No Of Matajis Volunteer" />
						</label>
					</td>
					<td valign="top" class="fieldcontain ${hasErrors(bean: eventRegistrationInstance, field: 'numMatajiVolunteer', 'error')} ">
						<g:field name="numMatajiVolunteer" type="number" value="${eventRegistrationInstance.numMatajiVolunteer}" class="numMatajiVolunteer"/>
					</td>
				</tr>

			</table>
		
		</tr>

		</sec:ifNotGranted>
	
	</table></div>

</div>

<sec:ifAnyGranted roles="ROLE_VIP_COORDINATOR,ROLE_VIP_REGISTRATION">

	<div class="collection_group">

		<div class="dialog"><table>
		
			<tr class="prop"><div class="caption_title">VIP Devotee Information</div></tr>

			<!-- Is VIP Devotee -->

			<!--<tr class="prop">
				<td valign="top" class="name">
					<label for="isVipDevotee">
						<g:message code="eventRegistration.isVipDevotee" default="Is Vip Devotee" />
					</label>
				</td>
				<td valign="top" class="fieldcontain ${hasErrors(bean: eventRegistrationInstance, field: 'isVipDevotee', 'error')} ">
					<g:checkBox name="isVipDevotee" value="${eventRegistrationInstance?.isVipDevotee}" />
				</td>
			</tr>-->

			<tr class="prop" colspan="2">
				<table id="divisvip" style="display:block">
					<!-- Special Instructions -->
					<tr class="prop">
						<td valign="top" class="name">
							<label for="specialInstructions">
								<g:message code="eventRegistration.specialInstructions" default="Special Instructions" />
							</label>
						</td>
						<td valign="top" class="fieldcontain ${hasErrors(bean: eventRegistrationInstance, field: 'specialInstructions', 'error')} ">
							<g:textArea name="specialInstructions" value="${eventRegistrationInstance?.specialInstructions}"/>
						</td>
					</tr>
				</table>
			</tr>

		</table></div>

	</div>

</sec:ifAnyGranted>

<div class="collection_group">

	<div class="dialog"><table>
	
		<tr class="prop"><div class="caption_title">Arival Information</div><tr>

		<!-- Arival Information -->
		
		<sec:ifNotGranted roles="ROLE_VIP_COORDINATOR,ROLE_VIP_REGISTRATION">
			<tr class="prop">
				<td valign="top" class="name">
					<label for="arrivalDate">
						<g:message code="eventRegistration.arrivalDate" default="Arrival Date" />
						<span class="required-indicator">*</span>
					</label>
				</td>
				<td valign="top" class="fieldcontain ${hasErrors(bean: eventRegistrationInstance, field: 'arrivalDate', 'error')} ">
					<g:textField name="arrivalDate" value="${(eventRegistrationInstance?.arrivalDate)?.format('dd-MM-yyyy')}" required=""/>
				</td>
			</tr>
		</sec:ifNotGranted>

		<sec:ifAnyGranted roles="ROLE_VIP_COORDINATOR,ROLE_VIP_REGISTRATION">
			<tr class="prop">
				<td valign="top" class="name">
					<label for="arrivalDate">
						<g:message code="eventRegistration.arrivalDate" default="Arrival Date" />
					</label>
				</td>
				<td valign="top" class="fieldcontain ${hasErrors(bean: eventRegistrationInstance, field: 'arrivalDate', 'error')} ">
					<g:textField id="vipArrivalDate" name="vipArrivalDate" value="${(eventRegistrationInstance?.arrivalDate)?.format('dd-MM-yyyy')}"/>
				</td>
			</tr>
		</sec:ifAnyGranted>

		<tr class="prop">
			<td valign="top" class="name">
				<label for="arrivalTime">
					<g:message code="eventRegistration.arrivalTime" default="Arrival Time" />
					<sec:ifNotGranted roles="ROLE_VIP_COORDINATOR,ROLE_VIP_REGISTRATION">
						<span class="required-indicator">*</span>
					</sec:ifNotGranted>
				</label>
			</td>
			<td valign="top" class="fieldcontain ${hasErrors(bean: eventRegistrationInstance, field: 'arrivalDate', 'error')} ">
				<sec:ifNotGranted roles="ROLE_VIP_COORDINATOR,ROLE_VIP_REGISTRATION">
					HH:<g:select name="arrivalHr" from="${01..12}" value="${(eventRegistrationInstance?.arrivalDate)?.format('hh')}" required=""/>
					MM:<g:select name="arrivalMi" from="${00..59}" value="${(eventRegistrationInstance?.arrivalDate)?.format('mm')}" required=""/>
					AM/PM:<g:select name="arrivalAP" from="['AM','PM']" value="${(eventRegistrationInstance?.arrivalDate)?.format('aa')}" required=""/>
				</sec:ifNotGranted>
				<sec:ifAnyGranted roles="ROLE_VIP_COORDINATOR,ROLE_VIP_REGISTRATION">
					HH:<g:select name="arrivalHr" from="${01..12}" value="${(eventRegistrationInstance?.arrivalDate)?.format('hh')}" />
					MM:<g:select name="arrivalMi" from="${00..59}" value="${(eventRegistrationInstance?.arrivalDate)?.format('mm')}" />
					AM/PM:<g:select name="arrivalAP" from="['AM','PM']" value="${(eventRegistrationInstance?.arrivalDate)?.format('aa')}" />
				</sec:ifAnyGranted>
			</td>
		</tr>

		<!-- Pick Up Required -->
		
		<!--
		<tr class="prop">
			<td valign="top" class="name">
				<label for="pickUpRequired">
					<g:message code="eventRegistration.pickUpRequired" default="Pick Up Required" />
				</label>
			</td>
			<td valign="top" class="fieldcontain ${hasErrors(bean: eventRegistrationInstance, field: 'pickUpRequired', 'error')} ">
				<g:checkBox name="pickUpRequired" value="${eventRegistrationInstance?.pickUpRequired}" />
			</td>
		</tr>
		-->

		<tr class="prop" colspan="2">

			<table id="divnoPickUp" style="display:none">

				<tr class="prop">
					<td valign="top" class="name">
						<label for="arrivalTransportMode">
							<g:message code="eventRegistration.arrivalTransportMode" default="Arrival Transport Mode" />
						 </label>
					</td>
					<td valign="top" class="fieldcontain ${hasErrors(bean: eventRegistrationInstance, field: 'arrivalTransportMode', 'error')} ">
						<g:radioGroup name="arrivalTransportMode" id="arrivalTransportMode"
								  values="${TransportMode?.values()}" 
								  labels="${TransportMode?.values().displayName}"
								  value="${eventRegistrationInstance?.arrivalTransportMode}">
						  ${it.radio} <g:message code="${it.label}" />&nbsp;
						</g:radioGroup>
						
					</td>
				</tr>

				<tr class="prop">
					<table id="divarrivalBusMode" style="display:none">

						<tr class="prop">
							<td valign="top" class="name">
								<label for="arrivalBusStation">
									<g:message code="eventRegistration.arrivalBusStation" default="Arrival Bus Station" />
								</label>
							</td>
							<td valign="top" class="fieldcontain ${hasErrors(bean: eventRegistrationInstance, field: 'arrivalBusStation', 'error')} ">
								<g:radioGroup name="arrivalBusStation"
									      labels="['Shivaji Nagar','Pune Station','Swargate']"
									      values="['Shivaji Nagar','Pune Station','Swargate']"
									      value="${eventRegistrationInstance?.arrivalBusStation}">
									${it.radio} <g:message code="${it.label}" />&nbsp;
								</g:radioGroup>
							</td>
						</tr>

						<tr class="prop">
							<td valign="top" class="name">
								<label for="arrivalBusNumber">
									<g:message code="eventRegistration.arrivalBusNumber" default="Arrival Bus Number" />
								</label>
							</td>
							<td valign="top" class="fieldcontain ${hasErrors(bean: eventRegistrationInstance, field: 'arrivalBusNumber', 'error')} ">
								<g:textField name="arrivalBusNumber" value="${eventRegistrationInstance?.arrivalBusNumber}"/>
							</td>
						</tr>

					</table>
				</tr>

				<tr class="prop" colspan="2">
					
					<table id="divarrivalFlightMode" style="display:none">
						
						<sec:ifNotGranted roles="ROLE_VIP_COORDINATOR,ROLE_VIP_REGISTRATION">
							<tr class="prop">
								<td/>
								<td valign="top" class="message">
									<g:message code="default.flight.transport.label" default="Pick Up From Pune Airport Only"/>
								</td>
							</tr>
						</sec:ifNotGranted>
						<sec:ifAnyGranted roles="ROLE_VIP_COORDINATOR,ROLE_VIP_REGISTRATION">
							<tr class="prop">
								<td valign="top" class="name">
									<label for="arrivalFlightPickUpPoint">
										<g:message code="eventRegistration.arrivalFlightPickUpPoint" default="Arrival Airport" />
									 </label>
								</td>
								<td valign="top" class="fieldcontain ${hasErrors(bean: eventRegistrationInstance, field: 'arrivalFlightPickUpPoint', 'error')} ">
									<g:radioGroup name="arrivalFlightPickUpPoint" id="arrivalFlightPickUpPoint"
											  values="${Airports.values()}" 
											  labels="${Airports.values().displayName}"
											  value="${fieldValue(bean: eventRegistrationInstance, field: 'arrivalFlightPickUpPoint')}">
									  ${it.radio} <g:message code="${it.label}" />&nbsp;
									</g:radioGroup>
									
								</td>
							</tr>
						</sec:ifAnyGranted>
						
						<tr class="prop">
							<td valign="top" class="name">
								<label for="arrivalFlightCarrier">
									<g:message code="eventRegistration.arrivalFlightCarrier" default="Arrival Flight Carrier" />
								</label>
							</td>
							<td valign="top" class="fieldcontain ${hasErrors(bean: eventRegistrationInstance, field: 'arrivalFlightCarrier', 'error')} ">
								<g:textField name="arrivalFlightCarrier" value="${eventRegistrationInstance?.arrivalFlightCarrier}"/>
							</td>
						</tr>

						<tr class="prop">
							<td valign="top" class="name">
								<label for="arrivalFlightNumber">
									<g:message code="eventRegistration.arrivalFlightNumber" default="Arrival Flight Number" />
								</label>
							</td>
							<td valign="top" class="fieldcontain ${hasErrors(bean: eventRegistrationInstance, field: 'arrivalFlightNumber', 'error')} ">
								<g:textField name="arrivalFlightNumber" value="${eventRegistrationInstance?.arrivalFlightNumber}"/>
							</td>
						</tr>

					</table>
				</tr>

				<tr class="prop" colspan="2">
					<table id="divarrivalTrainMode" style="display:none">

						<sec:ifNotGranted roles="ROLE_VIP_COORDINATOR,ROLE_VIP_REGISTRATION">
							<tr class="prop">
								<td/>
								<td valign="top" class="message">
									<g:message code="default.train.transport.label" default="Pick Up From Pune Station Only"/>
								</td>
							</tr>
						</sec:ifNotGranted>
						<sec:ifAnyGranted roles="ROLE_VIP_COORDINATOR,ROLE_VIP_REGISTRATION">
							<tr class="prop">
								<td valign="top" class="name">
									<label for="arrivalTrainPickUpPoint">
										<g:message code="eventRegistration.arrivalTrainPickUpPoint" default="Arrival Railway Station" />
									 </label>
								</td>
								<td valign="top" class="fieldcontain ${hasErrors(bean: eventRegistrationInstance, field: 'arrivalTrainPickUpPoint', 'error')} ">
									<g:radioGroup name="arrivalTrainPickUpPoint" id="arrivalTrainPickUpPoint"
											  values="${RailwayStations.values()}" 
											  labels="${RailwayStations.values().displayName}"
											  value="${fieldValue(bean: eventRegistrationInstance, field: 'arrivalTrainPickUpPoint')}">
									  ${it.radio} <g:message code="${it.label}" />&nbsp;
									</g:radioGroup>
									
								</td>
							</tr>
						</sec:ifAnyGranted>
						
						<tr class="prop">
							<td valign="top" class="name">
								<label for="arrivalTrainName">
									<g:message code="eventRegistration.arrivalTrainName" default="Arrival Train Name" />
								</label>
							</td>
							<td valign="top" class="fieldcontain ${hasErrors(bean: eventRegistrationInstance, field: 'arrivalTrainName', 'error')} ">
								<g:textField name="arrivalTrainName" value="${eventRegistrationInstance?.arrivalTrainName}"/>
							</td>
						</tr>

						<tr class="prop">
							<td valign="top" class="name">
								<label for="arrivalTrainNumber">
									<g:message code="eventRegistration.arrivalTrainNumber" default="Arrival Train Number" />
								</label>
							</td>
							<td valign="top" class="fieldcontain ${hasErrors(bean: eventRegistrationInstance, field: 'arrivalTrainNumber', 'error')} ">
								<g:textField name="arrivalTrainNumber" value="${eventRegistrationInstance?.arrivalTrainNumber}"/>
							</td>
						</tr>

					</table>
				</tr>

				<tr class="prop" colspan="2">
					<table>
						<tr class="prop">
							<td valign="top" class="name">
								<label for="arrivalTravelingDetails">
									<g:message code="eventRegistration.arrivalTravelingDetails" default="Arrival Traveling Details" />
								</label>
							</td>
							<td valign="top" class="fieldcontain ${hasErrors(bean: eventRegistrationInstance, field: 'arrivalTravelingDetails', 'error')} ">
								<g:textArea name="arrivalTravelingDetails" value="${eventRegistrationInstance?.arrivalTravelingDetails}"/>
							</td>
						</tr>
					</table>
				</tr>

			</table>

		</tr>

	</table></div>

</div>

<div class="collection_group">

	<div class="dialog"><table>
	
		<tr class="prop"><div class="caption_title">Return Journey Information</div><tr>

		<!-- Return Journey Information -->

		<sec:ifNotGranted roles="ROLE_VIP_COORDINATOR,ROLE_VIP_REGISTRATION">
		<tr class="prop">
			<td valign="top" class="name">
				<label for="departureDate">
					<g:message code="eventRegistration.departureDate" default="Return Journey Date" />
					<span class="required-indicator">*</span>
				</label>
			</td>
			<td valign="top" class="fieldcontain ${hasErrors(bean: eventRegistrationInstance, field: 'departureDate', 'error')} ">
				<g:textField name="departureDate" value="${(eventRegistrationInstance?.departureDate)?.format('dd-MM-yyyy')}" required=""/>
			</td>
		</tr>
		</sec:ifNotGranted>

		<sec:ifAnyGranted roles="ROLE_VIP_COORDINATOR,ROLE_VIP_REGISTRATION">
		<tr class="prop">
			<td valign="top" class="name">
				<label for="departureDate">
					<g:message code="eventRegistration.departureDate" default="Return Journey Date" />
				</label>
			</td>
			<td valign="top" class="fieldcontain ${hasErrors(bean: eventRegistrationInstance, field: 'departureDate', 'error')} ">
				<g:textField id="vipDepartureDate" name="vipDepartureDate" value="${(eventRegistrationInstance?.departureDate)?.format('dd-MM-yyyy')}" required=""/>
			</td>
		</tr>
		</sec:ifAnyGranted>


		<tr class="prop">
			<td valign="top" class="name">
				<label for="departureTime">
					<g:message code="eventRegistration.departureTime" default="Return Journey Time" />
					<sec:ifNotGranted roles="ROLE_VIP_COORDINATOR,ROLE_VIP_REGISTRATION">
						<span class="required-indicator">*</span>
					</sec:ifNotGranted>
				</label>
			</td>
			<td valign="top" class="fieldcontain ${hasErrors(bean: eventRegistrationInstance, field: 'departureDate', 'error')} ">
				<sec:ifNotGranted roles="ROLE_VIP_COORDINATOR,ROLE_VIP_REGISTRATION">
					HH:<g:select name="departureHr" from="${01..12}" value="${(eventRegistrationInstance.departureDate)?.format('hh')}" required=""/>
					MM:<g:select name="departureMi" from="${00..59}" value="${(eventRegistrationInstance.departureDate)?.format('mm')}" required=""/>
					AM/PM:<g:select name="departureAP" from="['AM','PM']" value="${(eventRegistrationInstance?.departureDate)?.format('aa')}" required=""/>
				</sec:ifNotGranted>
				<sec:ifAnyGranted roles="ROLE_VIP_COORDINATOR,ROLE_VIP_REGISTRATION">
					HH:<g:select name="departureHr" from="${01..12}" value="${(eventRegistrationInstance.departureDate)?.format('hh')}"/>
					MM:<g:select name="departureMi" from="${00..59}" value="${(eventRegistrationInstance.departureDate)?.format('mm')}"/>
					AM/PM:<g:select name="departureAP" from="['AM','PM']" value="${(eventRegistrationInstance?.departureDate)?.format('aa')}"/>
				</sec:ifAnyGranted>
			</td>
		</tr>

		<!-- Drop Required -->
		<!--
		<tr class="prop">
			<td valign="top" class="name">
				<label for="dropRequired">
					<g:message code="eventRegistration.dropRequired" default="Drop Required" />
				</label>
			</td>
			<td valign="top" class="fieldcontain ${hasErrors(bean: eventRegistrationInstance, field: 'dropRequired', 'error')} ">
				<g:checkBox name="dropRequired" value="${eventRegistrationInstance?.dropRequired}" />
			</td>
		</tr>
		-->

		<tr class="prop" colspan="2">

			<table id="divnoDrop" style="display:none">

				<tr class="prop">
					<td valign="top" class="name">
						<label for="departureTransportMode">
							<g:message code="eventRegistration.departureTransportMode" default="Return Journey Transport Mode" />
						 </label>
					</td>
					<td valign="top" class="fieldcontain ${hasErrors(bean: eventRegistrationInstance, field: 'departureTransportMode', 'error')} ">
						<g:radioGroup name="departureTransportMode" id="departureTransportMode"
								  values="${TransportMode?.values()}" 
								  labels="${TransportMode?.values().displayName}"
								  value="${fieldValue(bean: eventRegistrationInstance, field: 'departureTransportMode')}">
						  ${it.radio} <g:message code="${it.label}" />&nbsp;
						</g:radioGroup>
					</td>
				</tr>

				<tr class="prop">
					<table id="divdepartureBusMode" style="display:none">

						<tr class="prop">
							<td valign="top" class="name">
								<label for="departureBusStation">
									<g:message code="eventRegistration.departureBusStation" default="Return Journey Bus Station" />
								</label>
							</td>
							<td valign="top" class="fieldcontain ${hasErrors(bean: eventRegistrationInstance, field: 'departureBusStation', 'error')} ">
								<g:radioGroup name="departureBusStation"
									      labels="['Shivaji Nagar','Pune Station','Swargate']"
									      values="['Shivaji Nagar','Pune Station','Swargate']"
									      value="${eventRegistrationInstance?.departureBusStation}">
									${it.radio} <g:message code="${it.label}" />&nbsp;
								</g:radioGroup>
							</td>
						</tr>

						<tr class="prop">
							<td valign="top" class="name">
								<label for="departureBusNumber">
									<g:message code="eventRegistration.departureBusNumber" default="Return Journey Bus Number" />
								</label>
							</td>
							<td valign="top" class="fieldcontain ${hasErrors(bean: eventRegistrationInstance, field: 'departureBusNumber', 'error')} ">
								<g:textField name="departureBusNumber" value="${eventRegistrationInstance?.departureBusNumber}"/>
							</td>
						</tr>

					</table>
				</tr>

				<tr class="prop" colspan="2">

					<table id="divdepartureFlightMode" style="display:none">

						<sec:ifNotGranted roles="ROLE_VIP_COORDINATOR,ROLE_VIP_REGISTRATION">
							<tr class="prop">
								<td/>
								<td valign="top" class="message">
									<g:message code="default.flight.transport.label" default="Drop to Pune Airport Only"/>
								</td>
							</tr>
						</sec:ifNotGranted>
						<sec:ifAnyGranted roles="ROLE_VIP_COORDINATOR,ROLE_VIP_REGISTRATION">
							<tr class="prop">
								<td valign="top" class="name">
									<label for="departureFlightDropPoint">
										<g:message code="eventRegistration.departureFlightDropPoint" default="Flight Drop Point" />
									 </label>
								</td>
								<td valign="top" class="fieldcontain ${hasErrors(bean: eventRegistrationInstance, field: 'departureFlightDropPoint', 'error')} ">
									<g:radioGroup name="departureFlightDropPoint" id="departureFlightDropPoint"
											  values="${Airports.values()}" 
											  labels="${Airports.values().displayName}"
											  value="${fieldValue(bean: eventRegistrationInstance, field: 'departureFlightDropPoint')}">
									  ${it.radio} <g:message code="${it.label}" />&nbsp;
									</g:radioGroup>
									
								</td>
							</tr>
						</sec:ifAnyGranted>
						
						<tr class="prop">
							<td valign="top" class="name">
								<label for="departureFlightCarrier">
									<g:message code="eventRegistration.departureFlightCarrier" default="Return Journey Flight Carrier" />
								</label>
							</td>
							<td valign="top" class="fieldcontain ${hasErrors(bean: eventRegistrationInstance, field: 'departureFlightCarrier', 'error')} ">
								<g:textField name="departureFlightCarrier" value="${eventRegistrationInstance?.departureFlightCarrier}"/>
							</td>
						</tr>

						<tr class="prop">
							<td valign="top" class="name">
								<label for="departureFlightNumber">
									<g:message code="eventRegistration.departureFlightNumber" default="Return Journey Flight Number" />
								</label>
							</td>
							<td valign="top" class="fieldcontain ${hasErrors(bean: eventRegistrationInstance, field: 'departureFlightNumber', 'error')} ">
								<g:textField name="departureFlightNumber" value="${eventRegistrationInstance?.departureFlightNumber}"/>
							</td>
						</tr>

					</table>
				</tr>

				<tr class="prop" colspan="2">
					<table id="divdepartureTrainMode" style="display:none">
						<sec:ifNotGranted roles="ROLE_VIP_COORDINATOR,ROLE_VIP_REGISTRATION">
							<tr class="prop">
								<td/>
								<td valign="top" class="message">
									<g:message code="default.train.transport.label" default="Drop to Pune Station Only"/>
								</td>
							</tr>
						</sec:ifNotGranted>
						<sec:ifAnyGranted roles="ROLE_VIP_COORDINATOR,ROLE_VIP_REGISTRATION">
							<tr class="prop">
								<td valign="top" class="name">
									<label for="departureTrainDropPoint">
										<g:message code="eventRegistration.departureTrainDropPoint" default="Train Drop Point" />
									 </label>
								</td>
								<td valign="top" class="fieldcontain ${hasErrors(bean: eventRegistrationInstance, field: 'departureTrainDropPoint', 'error')} ">
									<g:radioGroup name="departureTrainDropPoint" id="departureTrainDropPoint"
											  values="${RailwayStations.values()}" 
											  labels="${RailwayStations.values().displayName}"
											  value="${fieldValue(bean: eventRegistrationInstance, field: 'departureTrainDropPoint')}">
									  ${it.radio} <g:message code="${it.label}" />&nbsp;
									</g:radioGroup>
									
								</td>
							</tr>
						</sec:ifAnyGranted>
						
						<tr class="prop">
							<td valign="top" class="name">
								<label for="departureTrainName">
									<g:message code="eventRegistration.departureTrainName" default="Return Journey Train Name" />
								</label>
							</td>
							<td valign="top" class="fieldcontain ${hasErrors(bean: eventRegistrationInstance, field: 'departureTrainName', 'error')} ">
								<g:textField name="departureTrainName" value="${eventRegistrationInstance?.departureTrainName}"/>
							</td>
						</tr>

						<tr class="prop">
							<td valign="top" class="name">
								<label for="departureTrainNumber">
									<g:message code="eventRegistration.departureTrainNumber" default="Return Journey Train Number" />
								</label>
							</td>
							<td valign="top" class="fieldcontain ${hasErrors(bean: eventRegistrationInstance, field: 'departureTrainNumber', 'error')} ">
								<g:textField name="departureTrainNumber" value="${eventRegistrationInstance?.departureTrainNumber}"/>
							</td>
						</tr>

					</table>
				</tr>

				<tr class="prop" colspan="2">
					<table>
						<tr class="prop">
							<td valign="top" class="name">
								<label for="departureTravelingDetails">
									<g:message code="eventRegistration.departureTravelingDetails" default="Return Journey Traveling Details" />
								</label>
							</td>
							<td valign="top" class="fieldcontain ${hasErrors(bean: eventRegistrationInstance, field: 'departureTravelingDetails', 'error')} ">
								<g:textArea name="departureTravelingDetails" value="${eventRegistrationInstance?.departureTravelingDetails}"/>
							</td>
						</tr>
					</table>
				</tr>

			</table>

		</tr>

	</table></div>

</div>

<div class="collection_group">

	<div class="dialog"><table>
	
		<tr class="prop"><div class="caption_title">Return Journey Prasad Information</div></tr>

		<!-- Prasad in Travelling -->

		<tr class="prop">
			<td valign="top" class="name">
				<label for="isTravelingPrasadRequired">
					<g:message code="eventRegistration.isTravelingPrasadRequired" default="Is return journey prasad required for Group?" />
				</label>
			</td>
			<td valign="top" class="fieldcontain ${hasErrors(bean: eventRegistrationInstance, field: 'isTravelingPrasadRequired', 'error')} ">
				<g:checkBox name="isTravelingPrasadRequired" value="${eventRegistrationInstance?.isTravelingPrasadRequired}" />
			</td>
		</tr>

		<tr class="prop">
			<table id="divnoofTravelingPrasadRequired" style="display:none">
				<!-- No Of Breakfasts -->
				<tr class="prop">
					<td valign="top" class="name">
						<label for="noofBreakfasts">
							<g:message code="eventRegistration.noofBreakfasts" default="No Of Breakfasts" />
						</label>
					</td>
					<td valign="top" class="fieldcontain ${hasErrors(bean: eventRegistrationInstance, field: 'noofBreakfasts', 'error')} ">
						<g:field name="noofBreakfasts" type="number" value="${eventRegistrationInstance.noofBreakfasts}" />
					</td>
				</tr>

				<!-- No Of Lunches -->
				<tr class="prop">
					<td valign="top" class="name">
						<label for="noofLunches">
							<g:message code="eventRegistration.noofLunches" default="No Of Lunches" />
						</label>
					</td>
					<td valign="top" class="fieldcontain ${hasErrors(bean: eventRegistrationInstance, field: 'noofLunches', 'error')} ">
						<g:field name="noofLunches" type="number" value="${eventRegistrationInstance.noofLunches}" />
					</td>
				</tr>

				<!-- No Of Dinners -->
				<tr class="prop">
					<td valign="top" class="name">
						<label for="noofDinners">
							<g:message code="eventRegistration.noofDinners" default="No Of Dinners" />
						</label>
					</td>
					<td valign="top" class="fieldcontain ${hasErrors(bean: eventRegistrationInstance, field: 'noofDinners', 'error')} ">
						<g:field name="noofDinners" type="number" value="${eventRegistrationInstance.noofDinners}" />
					</td>
				</tr>
			</table>
		</tr>

	</table></div>

</div>

<div id="recordLog" class="collection_group" style="display:none">

	<div class="dialog"><table>
	
		<tr class="prop"><div class="caption_title">Registration Verification</div></tr>

		<!-- Gift Issued -->

		<tr class="prop"> 
			<td valign="top" class="name">
				<label for="giftIssued">
					<g:message code="eventRegistration.giftIssued.label" default="Gift Issued" />
				</label>
				
			</td>
			<td valign="top" class="fieldcontain ${hasErrors(bean: eventRegistrationInstance, field: 'giftIssued', 'error')} ">
				<!-- todo ajax selection -->
			</td>
		</tr>

	</table></div>

</div>
