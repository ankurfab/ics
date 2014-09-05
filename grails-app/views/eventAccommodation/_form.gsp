<%@ page import="ics.EventAccommodation" %>
<r:require module="dateTimePicker" />

<script type="text/javascript">

function toggle(chkbox, group) { 
   var visSetting = (chkbox.checked) ? "block" : "none"; 
   document.getElementById(group).style.display = visSetting; 
} 

function toggleDiv(chkbox) { 
    //alert("checkbox name: " + chkbox.name);
    switch (chkbox.name) {
	case "isAccommodationContactSame":
	  var visSetting = (chkbox.checked) ? "none" : "block"; 
          document.getElementById("divisAccommodationContactSame").style.display = visSetting; 
	  break;
     }
} 

function calculareOverall() {
        
      var varRankNearnesstoNVCC = $('#rankNearnesstoNVCC').val()?parseInt($('#rankNearnesstoNVCC').val()):0;	
      var varRankEconomical = $('#rankEconomical').val()?parseInt($('#rankEconomical').val()):0;
      var varRankSafety = $('#rankSafety').val()?parseInt($('#rankSafety').val()):0;	
      var varRankFacilities = $('#rankFacilities').val()?parseInt($('#rankFacilities').val()):0;
      var varRankCleanlinessStandard = $('#rankCleanlinessStandard').val()?parseInt($('#rankCleanlinessStandard').val()):0;
      var varRankAttachedTNB = $('#rankAttachedTNB').val()?parseInt($('#rankAttachedTNB').val()):0;
      var varRankElevator = $('#rankElevator').val()?parseInt($('#rankElevator').val()):0;
      var varRankCooking = $('#rankCooking').val()?parseInt($('#rankCooking').val()):0;

      var cnt = parseInt($('#rankNearnesstoNVCC').val()?1:0) + parseInt($('#rankEconomical').val()?1:0) + parseInt($('#rankSafety').val()?1:0) + parseInt($('#rankFacilities').val()?1:0) + parseInt($('#rankCleanlinessStandard').val()?1:0) + parseInt($('#rankAttachedTNB').val()?1:0) + parseInt($('#rankElevator').val()?1:0) + parseInt($('#rankCooking').val()?1:0);

      var varRankOverall = Math.round((varRankNearnesstoNVCC + varRankEconomical + varRankSafety + varRankFacilities + varRankCleanlinessStandard + varRankAttachedTNB + varRankElevator + varRankCooking) /
				      cnt);
      
      //alert(cnt);
      //alert(varRankOverall);
      $('#rankOverall').val(varRankOverall);
}

function datePickerCall() {
    if(document.documentMode==9) {
	alert("Hare Krishna!!");
    } 

    $("#dateofBooking").datepicker({dateFormat: 'dd-mm-yy'});
    
    $('#availableFromDate').datetimepicker({
	    onClose: function(dateText, inst) {
		var endDateTextBox = $('#availableTillDate');
		if (endDateTextBox.val() != '') {
		    var testStartDate = new Date(dateText);
		    var testEndDate = new Date(endDateTextBox.val());
		    if (testStartDate > testEndDate)
			endDateTextBox.val(dateText);
		}
		else {
		    endDateTextBox.val(dateText);
		}
	    },
	    onSelect: function (selectedDateTime){
		var start = $(this).datetimepicker('getDate');
		$('#availableTillDate').datetimepicker('option', 'minDate', new Date(start.getTime()));
	    },
	    dateFormat: 'dd-mm-yy'
    });

    $('#availableTillDate').datetimepicker({
	    onClose: function(dateText, inst) {
		var startDateTextBox = $('#availableFromDate');
		if (startDateTextBox.val() != '') {
		    var testStartDate = new Date(startDateTextBox.val());
		    var testEndDate = new Date(dateText);
		    if (testStartDate > testEndDate)
			startDateTextBox.val(dateText);
		}
		else {
		    startDateTextBox.val(dateText);
		}
	    },
	    onSelect: function (selectedDateTime){
		var end = $(this).datetimepicker('getDate');
		$('#availableFromDate').datetimepicker('option', 'maxDate', new Date(end.getTime()) );
	    },
	    dateFormat: 'dd-mm-yy'
     });  
}

$(document).ready(function() {
    
    $("input[type='checkbox']").each(function() {
	    toggleDiv(this);
    });
    
    datePickerCall();
   
});

$(function(){
    
    $("input[type='checkbox']").click(function(e){
        toggleDiv(this)
    });

});

</script>

<div class="collection_group">

	<div class="dialog"><table>
	
		<tr class="prop"><div class="caption_title">General Information</div><tr>

		<!-- Name -->

		<tr class="prop">
			<td valign="top" class="name">
				<label for="name">
					<sec:ifAnyGranted roles="ROLE_VIP_COORDINATOR,ROLE_VIP_ACCOMMODATION">
						<g:message code="eventAccommodation.name" default="Host Name" />
					</sec:ifAnyGranted>
					<sec:ifNotGranted roles="ROLE_VIP_COORDINATOR,ROLE_VIP_ACCOMMODATION">
						<g:message code="eventAccommodation.name" default="Accommodation Name" />
					</sec:ifNotGranted>
					<span class="required-indicator">*</span>
				</label>
			</td>
			<td valign="top" class="fieldcontain ${hasErrors(bean: eventAccommodationInstance, field: 'name', 'error')} required">
				<g:textField name="name" value="${eventAccommodationInstance?.name}" required=""/>
			</td>
		</tr>

		<!-- Address -->

		<tr class="prop">
			<td valign="top" class="name">
				<label for="address">
					<g:message code="eventAccommodation.address" default="Address" />
					<span class="required-indicator">*</span>
				</label>
			</td>
			<td valign="top" class="fieldcontain ${hasErrors(bean: eventAccommodationInstance, field: 'address', 'error')} required">
				<g:textField name="address" value="${eventAccommodationInstance?.address}" required=""/>
			</td>
		</tr>

		<sec:ifAnyGranted roles="ROLE_VIP_COORDINATOR,ROLE_VIP_ACCOMMODATION">

			<!-- Host Mobile Number -->

			<tr class="prop">
				<td valign="top" class="name">
					<label for="hostMobileNumber">
						<g:message code="eventAccommodation.hostMobileNumber" default="Host Mobile Number" />
						<span class="required-indicator">*</span>
					</label>
				</td>
				<td valign="top" class="fieldcontain ${hasErrors(bean: eventAccommodationInstance, field: 'hostMobileNumber', 'error')} required">
					<g:textField name="hostMobileNumber" value="${eventAccommodationInstance?.hostMobileNumber}" class="hostMobileNumber" required=""/>
				</td>
			</tr>

			<!-- Host Alternate Mobile Number -->

			<tr class="prop">
				<td valign="top" class="name">
					<label for="hostAlternateMobileNumber">
						<g:message code="eventAccommodation.hostAlternateMobileNumber" default="Host Alternate Mobile Number" />
					</label>
				</td>
				<td valign="top" class="fieldcontain ${hasErrors(bean: eventAccommodationInstance, field: 'hostAlternateMobileNumber', 'error')}">
					<g:textField name="hostAlternateMobileNumber" value="${eventAccommodationInstance?.hostAlternateMobileNumber}" class="hostAlternateMobileNumber"/>
				</td>
			</tr>

			<!-- Host Email -->

			<tr class="prop">
				<td valign="top" class="name">
					<label for="hostEmail">
						<g:message code="eventAccommodation.hostEmail" default="Host Email" />
					</label>
				</td>
				<td valign="top" class="fieldcontain ${hasErrors(bean: eventAccommodationInstance, field: 'hostEmail', 'error')}">
					<g:textField name="hostEmail" value="${eventAccommodationInstance?.hostEmail}" class="hostEmail"/>
				</td>
			</tr>


		</sec:ifAnyGranted>

	</table></div>

</div>


<div class="collection_group">

	<div class="dialog"><table>
	
		<tr class="prop"><div class="caption_title">Booking Information</div><tr>

		<!-- Available From Date -->

		<tr class="prop">
			<td valign="top" class="name">
				<label for="availableFromDate">
					<g:message code="eventAccommodation.availableFromDate" default="Available From" />
					<span class="required-indicator">*</span>
				</label>
			</td>
			<td valign="top" class="fieldcontain ${hasErrors(bean: eventAccommodationInstance, field: 'availableFromDate', 'error')} ">
				<g:textField name="availableFromDate" value="${(eventAccommodationInstance?.availableFromDate)?.format('dd-MM-yyyy  HH:mm')}" required=""/>
			</td>
		</tr>

		<!-- Available Till Date -->

		<tr class="prop">
			<td valign="top" class="name">
				<label for="availableTillDate">
					<g:message code="eventAccommodation.availableTillDate" default="Available Till" />
					<span class="required-indicator">*</span>
				</label>
			</td>
			<td valign="top" class="fieldcontain ${hasErrors(bean: eventAccommodationInstance, field: 'availableTillDate', 'error')} ">
				<g:textField name="availableTillDate" value="${(eventAccommodationInstance?.availableTillDate)?.format('dd-MM-yyyy  HH:mm')}" required=""/>
			</td>
		</tr>
		
		<sec:ifNotGranted roles="ROLE_VIP_COORDINATOR,ROLE_VIP_ACCOMMODATION">
		
		<!-- Date of Booking -->

		<tr class="prop">
			<td valign="top" class="name">
				<label for="dateofBooking">
					<g:message code="eventAccommodation.dateofBooking" default="Date Booked" />
					<span class="required-indicator">*</span>
				</label>
			</td>
			<td valign="top" class="fieldcontain ${hasErrors(bean: eventAccommodationInstance, field: 'dateofBooking', 'error')} ">
				<g:textField name="dateofBooking" value="${(eventAccommodationInstance?.dateofBooking)?.format('dd-MM-yyyy')}" required=""/>
			</td>
		</tr>

		<!-- Negotiated Rate -->

		<tr class="prop">
			<td valign="top" class="name">
				<label for="negotiatedRate">
					<g:message code="eventAccommodation.negotiatedRate" default="Negotiated Rate" />
				</label>
			</td>
			<td valign="top" class="fieldcontain ${hasErrors(bean: eventAccommodationInstance, field: 'negotiatedRate', 'error')}">
				<g:field name="negotiatedRate" value="${eventAccommodationInstance.negotiatedRate}" class="negotiatedRate"/>
			</td>
		</tr>

		<!-- Advance Given -->

		<tr class="prop">
			<td valign="top" class="name">
				<label for="advanceGiven">
					<g:message code="eventAccommodation.advanceGiven" default="Advance Given" />
				</label>
			</td>
			<td valign="top" class="fieldcontain ${hasErrors(bean: eventAccommodationInstance, field: 'advanceGiven', 'error')}">
				<g:field name="advanceGiven" value="${eventAccommodationInstance.advanceGiven}" class="advanceGiven"/>
			</td>
		</tr>

		</sec:ifNotGranted>

	</table></div>

</div>


<sec:ifNotGranted roles="ROLE_VIP_COORDINATOR,ROLE_VIP_ACCOMMODATION">

<div class="collection_group">

	<div class="dialog"><table>
	
		<tr class="prop"><div class="caption_title">Contact Information</div><tr>

		<!-- Accommodation In Charge Name -->

		<tr class="prop">
			<td valign="top" class="name">
				<label for="accommodationInChargeName">
					Devotee In Charge Name
					<span class="required-indicator">*</span>
				</label>
			</td>
			<td valign="top" class="fieldcontain ${hasErrors(bean: eventAccommodationInstance, field: 'accommodationInChargeName', 'error')} required">
				<g:textField name="accommodationInChargeName" value="${eventAccommodationInstance?.accommodationInChargeName}" required=""/>
			</td>
		</tr>

		<!-- Accommodation In Charge Contact -->

		<tr class="prop">
			<td valign="top" class="name">
				<label for="accommodationInChargeContactNumber">
					Devotee In Charge Contact
					<span class="required-indicator">*</span>
				</label>
			</td>
			<td valign="top" class="fieldcontain ${hasErrors(bean: eventAccommodationInstance, field: 'accommodationInChargeName', 'error')} required">
				<g:textField name="accommodationInChargeContactNumber" value="${eventAccommodationInstance?.accommodationInChargeContactNumber}" required=""/>
			</td>
		</tr>

		<!-- Is Accommodation contact same -->
		
		<tr class="prop">
			<td valign="top" class="name">
				<label for="isAccommodationContactSame">
					<g:message code="eventAccommodation.isAccommodationContactSame" default="Is Accommodation Contact Same" />
				</label>
			</td>
			<td valign="top" class="fieldcontain ${hasErrors(bean: eventAccommodationInstance, field: 'isAccommodationContactSame', 'error')} ">
				<g:checkBox name="isAccommodationContactSame" value="${eventAccommodationInstance?.isAccommodationContactSame}" />
			</td>
		</tr>

		<tr class="prop" colspan="2">

			<table id="divisAccommodationContactSame">
		
				<!-- Accommodation Contact Person -->

				<tr class="prop">
					<td valign="top" class="name">
						<label for="accommodationContactPerson">
							<g:message code="eventAccommodation.accommodationContactPerson" default="Accommodation Contact Person" />
						</label>
					</td>
					<td valign="top" class="fieldcontain ${hasErrors(bean: eventAccommodationInstance, field: 'accommodationContactPerson', 'error')}">
						<g:textField name="accommodationContactPerson" value="${eventAccommodationInstance?.accommodationContactPerson}"/>
					</td>
				</tr>
				
				<!-- Accommodation Contact Number -->

				<tr class="prop">
					<td valign="top" class="name">
						<label for="accommodationContactNumber">
							<g:message code="eventAccommodation.accommodationContactNumber" default="Accommodation Contact Number" />
						</label>
					</td>
					<td valign="top" class="fieldcontain ${hasErrors(bean: eventAccommodationInstance, field: 'accommodationContactNumber', 'error')} ">
						<g:textField name="accommodationContactNumber" value="${eventAccommodationInstance?.accommodationContactNumber}"/>
					</td>
				</tr>

			</table>
		
		</tr>

	</table></div>

</div>

</sec:ifNotGranted>

<div class="collection_group">

	<div class="dialog"><table>
	
		<tr class="prop"><div class="caption_title">Accommodation Capacity</div><tr>

		<!-- Maximum Capacity -->

		<tr class="prop">
			<td valign="top" class="name">
				<label for="maxCapacity">
					<g:message code="eventAccommodation.maxCapacity" default="Max Capacity" />
					<span class="required-indicator">*</span>
				</label>
			</td>
			<td valign="top" class="fieldcontain ${hasErrors(bean: eventAccommodationInstance, field: 'maxCapacity', 'error')} required">
				<g:field name="maxCapacity" value="${eventAccommodationInstance.maxCapacity}" type="number" class="maxCapacity" required=""/>
			</td>
		</tr>

		<!-- Maximum Prabhujis -->

		
		<!--<tr class="prop">
			<td valign="top" class="name">
				<label for="maxPrabhujis">
					<g:message code="eventAccommodation.maxPrabhujis" default="Prabhujis" />
				</label>
			</td>
			<td valign="top" class="fieldcontain ${hasErrors(bean: eventAccommodationInstance, field: 'maxPrabhujis', 'error')}">
				<g:field name="maxPrabhujis" value="${eventAccommodationInstance.maxPrabhujis}" type="number" class="maxPrabhujis"/>
			</td>
		</tr>-->

		<!-- Maximum Matajis -->

		<!--<tr class="prop">
			<td valign="top" class="name">
				<label for="maxMatajis">
					<g:message code="eventAccommodation.maxMatajis" default="Matajis" />
				</label>
			</td>
			<td valign="top" class="fieldcontain ${hasErrors(bean: eventAccommodationInstance, field: 'maxMatajis', 'error')}">
				<g:field name="maxMatajis" value="${eventAccommodationInstance.maxMatajis}" type="number" class="maxMatajis"/>
			</td>
		</tr>-->

		<!-- Maximum Childrens -->

		<!--<tr class="prop">
			<td valign="top" class="name">
				<label for="maxChildrens">
					<g:message code="eventAccommodation.maxChildrens" default="Childrens" />
				</label>
			</td>
			<td valign="top" class="fieldcontain ${hasErrors(bean: eventAccommodationInstance, field: 'maxChildrens', 'error')}">
				<g:field name="maxChildrens" value="${eventAccommodationInstance.maxChildrens}" type="number" class="maxChildrens"/>
			</td>
		</tr>-->

		<!-- Maximum Brahmacharis -->

		<!--<tr class="prop">
			<td valign="top" class="name">
				<label for="maxBrahmacharis">
					<g:message code="eventAccommodation.maxBrahmacharis" default="Brahmacharis" />
				</label>
			</td>
			<td valign="top" class="fieldcontain ${hasErrors(bean: eventAccommodationInstance, field: 'maxBrahmacharis', 'error')}">
				<g:field name="maxBrahmacharis" value="${eventAccommodationInstance.maxBrahmacharis}"  type="number" class="maxBrahmacharis"/>
			</td>
		</tr>-->




	</table></div>

</div>

<div class="collection_group">

	<div class="dialog"><table>
	
		<tr class="prop"><div class="caption_title">Accommodation Facilities</div><tr>

		<!-- Distance From NVCC -->

		<tr class="prop">
			<td valign="top" class="name">
				<label for="distanceFromNVCC">
					<g:message code="eventAccommodation.distanceFromNVCC" default="Distance From NVCC(in KM)" />
					<span class="required-indicator">*</span>
				</label>
			</td>
			<td valign="top" class="fieldcontain ${hasErrors(bean: eventAccommodationInstance, field: 'distanceFromNVCC', 'error')} required">
				<g:field name="distanceFromNVCC" value="${eventAccommodationInstance.distanceFromNVCC}" type="number" class="distanceFromNVCC" required=""/>
			</td>
		</tr>

		<sec:ifNotGranted roles="ROLE_VIP_COORDINATOR,ROLE_VIP_ACCOMMODATION">
		
		<!-- Capacity of All Dormitories -->

		<tr class="prop">
			<td valign="top" class="name">
				<label for="capacityofAllDormitories">
					<g:message code="eventAccommodation.capacityofAllDormitories" default="Capacity of All Dormitories" />
				</label>
			</td>
			<td valign="top" class="fieldcontain ${hasErrors(bean: eventAccommodationInstance, field: 'capacityofAllDormitories', 'error')}">
				<g:field name="capacityofAllDormitories" value="${eventAccommodationInstance.capacityofAllDormitories}" type="number" class="capacityofAllDormitories"/>
			</td>
		</tr>

		<!-- Number of Rooms -->

		<tr class="prop">
			<td valign="top" class="name">
				<label for="numberofRooms">
					<g:message code="eventAccommodation.numberofRooms" default="Number of Rooms" />
				</label>
			</td>
			<td valign="top" class="fieldcontain ${hasErrors(bean: eventAccommodationInstance, field: 'numberofRooms', 'error')}">
				<g:field name="numberofRooms" value="${eventAccommodationInstance.numberofRooms}" type="number" class="numberofRooms"/>
			</td>
		</tr>

		<!-- Number of Toilets -->

		<tr class="prop">
			<td valign="top" class="name">
				<label for="numberofToilets">
					<g:message code="eventAccommodation.numberofToilets" default="Number of Toilets" />
				</label>
			</td>
			<td valign="top" class="fieldcontain ${hasErrors(bean: eventAccommodationInstance, field: 'numberofToilets', 'error')}">
				<g:field name="numberofToilets" value="${eventAccommodationInstance.numberofToilets}" type="number" class="numberofToilets"/>
			</td>
		</tr>

		<!-- Number of Bathrooms -->

		<tr class="prop">
			<td valign="top" class="name">
				<label for="numberofBathrooms">
					<g:message code="eventAccommodation.numberofBathrooms" default="Number of Bathrooms" />
				</label>
			</td>
			<td valign="top" class="fieldcontain ${hasErrors(bean: eventAccommodationInstance, field: 'numberofBathrooms', 'error')}">
				<g:field name="numberofBathrooms" value="${eventAccommodationInstance.numberofBathrooms}" type="number" class="numberofBathrooms"/>
			</td>
		</tr>

		<!-- Number of Buckets -->

		<tr class="prop">
			<td valign="top" class="name">
				<label for="numberofBuckets">
					<g:message code="eventAccommodation.numberofBuckets" default="Number of Buckets" />
				</label>
			</td>
			<td valign="top" class="fieldcontain ${hasErrors(bean: eventAccommodationInstance, field: 'numberofBuckets', 'error')}">
				<g:field name="numberofBuckets" value="${eventAccommodationInstance.numberofBuckets}" type="number" class="numberofBuckets"/>
			</td>
		</tr>

		<!-- Number of Clothes Line -->

		<tr class="prop">
			<td valign="top" class="name">
				<label for="numberofClothesLine">
					<g:message code="eventAccommodation.numberofClothesLine" default="Number of Clothes Line" />
				</label>
			</td>
			<td valign="top" class="fieldcontain ${hasErrors(bean: eventAccommodationInstance, field: 'numberofClothesLine', 'error')}">
				<g:field name="numberofClothesLine" value="${eventAccommodationInstance.numberofClothesLine}" type="number" class="numberofClothesLine"/>
			</td>
		</tr>

		</sec:ifNotGranted>

		<sec:ifAnyGranted roles="ROLE_VIP_COORDINATOR,ROLE_VIP_ACCOMMODATION">

		<!-- Number of Room With Attached T & B  -->

		<tr class="prop">
			<td valign="top" class="name">
				<label for="numberofRoomsWithAttachedTNB">
					<g:message code="eventAccommodation.numberofRoomsWithAttachedTNB" default="Number of Room With Attached T & B " />
				</label>
			</td>
			<td valign="top" class="fieldcontain ${hasErrors(bean: eventAccommodationInstance, field: 'numberofRoomsWithAttachedTNB', 'error')}">
				<g:field name="numberofRoomsWithAttachedTNB" value="${eventAccommodationInstance.numberofRoomsWithAttachedTNB}" type="number" class="numberofRoomsWithAttachedTNB"/>
			</td>
		</tr>
		
		<!-- Number of Room Without T & B  -->

		<tr class="prop">
			<td valign="top" class="name">
				<label for="numberofRoomsWithoutTNB">
					<g:message code="eventAccommodation.numberofRoomsWithoutTNB" default="Number of Room Without T & B " />
				</label>
			</td>
			<td valign="top" class="fieldcontain ${hasErrors(bean: eventAccommodationInstance, field: 'numberofRoomsWithoutTNB', 'error')}">
				<g:field name="numberofRoomsWithoutTNB" value="${eventAccommodationInstance.numberofRoomsWithoutTNB}" type="number" class="numberofRoomsWithoutTNB"/>
			</td>
		</tr>
		
		
		<!-- Is Cook Available For Guests -->

		<tr class="prop">
			<td valign="top" class="name">
				<label for="isCookAvailableForGuest">
					<g:message code="eventAccommodation.isCookAvailableForGuest" default="Is Cook Available For Guests" />
				</label>
			</td>
			<td valign="top" class="fieldcontain ${hasErrors(bean: eventAccommodationInstance, field: 'isCookAvailableForGuest', 'error')} ">
				<g:checkBox name="isCookAvailableForGuest" value="${eventAccommodationInstance?.isCookAvailableForGuest}" />
			</td>
		</tr>
		
		
		<!-- Are There Childrens Below 12 Years -->

		<tr class="prop">
			<td valign="top" class="name">
				<label for="areThereChildrensBelow12Years">
					<g:message code="eventAccommodation.isInternetFascilityAvailable" default="Are There Childrens Below 12 Years" />
				</label>
			</td>
			<td valign="top" class="fieldcontain ${hasErrors(bean: eventAccommodationInstance, field: 'areThereChildrensBelow12Years', 'error')} ">
				<g:checkBox name="areThereChildrensBelow12Years" value="${eventAccommodationInstance?.areThereChildrensBelow12Years}" />
			</td>
		</tr>
		
		<!-- Is Internet Facility Available -->

		<tr class="prop">
			<td valign="top" class="name">
				<label for="isInternetFascilityAvailable">
					<g:message code="eventAccommodation.isInternetFascilityAvailable" default="Is Internet Facility Available" />
				</label>
			</td>
			<td valign="top" class="fieldcontain ${hasErrors(bean: eventAccommodationInstance, field: 'isInternetFascilityAvailable', 'error')} ">
				<g:checkBox name="isInternetFascilityAvailable" value="${eventAccommodationInstance?.isInternetFascilityAvailable}" />
			</td>
		</tr>
		
		<!-- Is Elevator Facility Available -->

		<tr class="prop">
			<td valign="top" class="name">
				<label for="isElevatorFascilityAvailable">
					<g:message code="eventAccommodation.isElevatorFascilityAvailable" default="Is Elevator Facility Available" />
				</label>
			</td>
			<td valign="top" class="fieldcontain ${hasErrors(bean: eventAccommodationInstance, field: 'isElevatorFascilityAvailable', 'error')} ">
				<g:checkBox name="isElevatorFascilityAvailable" value="${eventAccommodationInstance?.isElevatorFascilityAvailable}" />
			</td>
		</tr>

		<!-- Is Car Facility Available -->

		<tr class="prop">
			<td valign="top" class="name">
				<label for="isCarFacilityAvailable">
					<g:message code="eventAccommodation.isCarFacilityAvailable" default="Is Car Facility Available" />
				</label>
			</td>
			<td valign="top" class="fieldcontain ${hasErrors(bean: eventAccommodationInstance, field: 'isCarFacilityAvailable', 'error')} ">
				<g:checkBox name="isCarFacilityAvailable" value="${eventAccommodationInstance?.isCarFacilityAvailable}" />
			</td>
		</tr>

		</sec:ifAnyGranted>

		<!-- Is Generator Back Up Available -->
		
		<tr class="prop">
			<td valign="top" class="name">
				<label for="isGeneratorBackUpAvailable">
					<g:message code="eventAccommodation.isGeneratorBackUpAvailable" default="Is Generator Back Up Available" />
				</label>
			</td>
			<td valign="top" class="fieldcontain ${hasErrors(bean: eventAccommodationInstance, field: 'isGeneratorBackUpAvailable', 'error')} ">
				<g:checkBox name="isGeneratorBackUpAvailable" value="${eventAccommodationInstance?.isGeneratorBackUpAvailable}" />
			</td>
		</tr>

	</table></div>

</div>

<div class="collection_group">

	<div class="dialog"><table>
	
		<tr class="prop"><div class="caption_title">Accommodation Rating</div><tr>

		<tr class="prop"><div class="message">Rate on scale of 1-10, 10 being best, 1 being worst</div><tr>

		<!-- Overall -->

		<tr class="prop">
			<td valign="top" class="name">
				<label for="rankOverall">
					<g:message code="eventAccommodation.rankOverall" default="Overall" />
				</label>
			</td>
			<td valign="top" class="fieldcontain ${hasErrors(bean: eventAccommodationInstance, field: 'rankOverall', 'error')}">
				<g:select name="rankOverall" noSelection="['':'-Choose-']" from="${1..10}" value="${eventAccommodationInstance.rankOverall}" />
			</td>
		</tr>
		
		<sec:ifNotGranted roles="ROLE_VIP_COORDINATOR,ROLE_VIP_ACCOMMODATION">
		
		<!-- Economical -->

		<tr class="prop">
			<td valign="top" class="name">
				<label for="rankEconomical">
					<g:message code="eventAccommodation.rankEconomical" default="Economical" />
				</label>
			</td>
			<td valign="top" class="fieldcontain ${hasErrors(bean: eventAccommodationInstance, field: 'rankEconomical', 'error')}">
				<g:select onchange="calculareOverall()" name="rankEconomical" noSelection="['':'-Choose-']" from="${1..10}" value="${eventAccommodationInstance.rankEconomical}" />
			</td>
		</tr>

		<!-- Facilities -->

		<tr class="prop">
			<td valign="top" class="name">
				<label for="rankFacilities">
					<g:message code="eventAccommodation.rankFacilities" default="Facilities" />
				</label>
			</td>
			<td valign="top" class="fieldcontain ${hasErrors(bean: eventAccommodationInstance, field: 'rankFacilities', 'error')}">
				<g:select onchange="calculareOverall()" name="rankFacilities" noSelection="['':'-Choose-']" from="${1..10}" value="${eventAccommodationInstance.rankFacilities}" />
			</td>
		</tr>

		</sec:ifNotGranted>

		<!-- Cleanliness Standard -->

		<tr class="prop">
			<td valign="top" class="name">
				<label for="rankCleanlinessStandard">
					<g:message code="eventAccommodation.rankCleanlinessStandard" default="Cleanliness Standard" />
				</label>
			</td>
			<td valign="top" class="fieldcontain ${hasErrors(bean: eventAccommodationInstance, field: 'rankCleanlinessStandard', 'error')}">
				<g:select onchange="calculareOverall()" name="rankCleanlinessStandard" noSelection="['':'-Choose-']" from="${1..10}" value="${eventAccommodationInstance.rankCleanlinessStandard}" />
			</td>
		</tr>

		<!-- Safety -->

		<tr class="prop">
			<td valign="top" class="name">
				<label for="rankSafety">
					<g:message code="eventAccommodation.rankSafety" default="Safety" />
				</label>
			</td>
			<td valign="top" class="fieldcontain ${hasErrors(bean: eventAccommodationInstance, field: 'rankSafety', 'error')}">
				<g:select onchange="calculareOverall()" name="rankSafety" noSelection="['':'-Choose-']" from="${1..10}" value="${eventAccommodationInstance.rankSafety}" />
			</td>
		</tr>

		<!-- Nearness to NVCC -->

		<tr class="prop">
			<td valign="top" class="name">
				<label for="rankNearnesstoNVCC">
					<g:message code="eventAccommodation.rankNearnesstoNVCC" default="Nearness to NVCC" />
				</label>
			</td>
			<td valign="top" class="fieldcontain ${hasErrors(bean: eventAccommodationInstance, field: 'rankNearnesstoNVCC', 'error')}">
				<g:select onchange="calculareOverall()" name="rankNearnesstoNVCC" noSelection="['':'-Choose-']" from="${1..10}" value="${eventAccommodationInstance.rankNearnesstoNVCC}" />
			</td>
		</tr>

		<sec:ifAnyGranted roles="ROLE_VIP_COORDINATOR,ROLE_VIP_ACCOMMODATION">

		
		<!-- Attached Toilet And Bathrooms -->

		<tr class="prop">
			<td valign="top" class="name">
				<label for="rankAttachedTNB">
					<g:message code="eventAccommodation.rankAttachedTNB" default="Attached Toilet And Bathrooms" />
				</label>
			</td>
			<td valign="top" class="fieldcontain ${hasErrors(bean: eventAccommodationInstance, field: 'rankAttachedTNB', 'error')}">
				<g:select onchange="calculareOverall()" name="rankAttachedTNB" noSelection="['':'-Choose-']" from="${1..10}" value="${eventAccommodationInstance.rankAttachedTNB}" />
			</td>
		</tr>
				
		<!-- Elevator -->

		<tr class="prop">
			<td valign="top" class="name">
				<label for="rankElevator">
					<g:message code="eventAccommodation.rankElevator" default="Elevator" />
				</label>
			</td>
			<td valign="top" class="fieldcontain ${hasErrors(bean: eventAccommodationInstance, field: 'rankElevator', 'error')}">
				<g:select onchange="calculareOverall()" name="rankElevator" noSelection="['':'-Choose-']" from="${1..10}" value="${eventAccommodationInstance.rankElevator}" />
			</td>
		</tr>
		
		
		<!-- Coocking -->

		<tr class="prop">
			<td valign="top" class="name">
				<label for="rankCooking">
					<g:message code="eventAccommodation.rankCooking" default="Cooking" />
				</label>
			</td>
			<td valign="top" class="fieldcontain ${hasErrors(bean: eventAccommodationInstance, field: 'rankCooking', 'error')}">
				<g:select onchange="calculareOverall()" name="rankCooking" noSelection="['':'-Choose-']" from="${1..10}" value="${eventAccommodationInstance.rankCooking}" />
			</td>
		</tr>
		
		</sec:ifAnyGranted>

	</table></div>

</div>

<div class="collection_group">

	<div class="dialog"><table>
	
		<tr class="prop"><div class="caption_title">Other Information</div></tr>

		<!-- Comments -->

		<tr class="prop">
			<td valign="top" class="name">
				<label for="comments">
					<g:message code="eventAccommodation.comments" default="Comments" />
				</label>
			</td>
			<td valign="top" class="fieldcontain ${hasErrors(bean: eventAccommodationInstance, field: 'comments', 'error')} ">
				<g:textArea name="comments" value="${eventAccommodationInstance?.comments}"/>
			</td>
		</tr>

	</table></div>

</div>
