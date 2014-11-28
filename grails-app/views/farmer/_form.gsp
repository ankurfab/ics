<%@ page import="ics.Farmer" %>



<div class="fieldcontain ${hasErrors(bean: farmerInstance, field: 'firstName', 'error')} ">
	<label for="firstName">
		<g:message code="farmer.firstName.label" default="First Name" />
		
	</label>
	<g:textField name="firstName" value="${fieldValue(bean: farmerInstance, field: 'firstName')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: farmerInstance, field: 'middleName', 'error')} ">
	<label for="middleName">
		<g:message code="farmer.middleName.label" default="Middle Name" />
		
	</label>
	<g:textField name="middleName" value="${fieldValue(bean: farmerInstance, field: 'middleName')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: farmerInstance, field: 'lastName', 'error')} ">
	<label for="lastName">
		<g:message code="farmer.lastName.label" default="Last Name" />
		
	</label>
	<g:textField name="lastName" value="${fieldValue(bean: farmerInstance, field: 'lastName')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: farmerInstance, field: 'address', 'error')} ">
	<label for="address">
		<g:message code="farmer.address.label" default="Address" />
		
	</label>
	<g:textField name="address" value="${fieldValue(bean: farmerInstance, field: 'address')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: farmerInstance, field: 'village', 'error')} ">
	<label for="village">
		<g:message code="farmer.village.label" default="Village" />
		
	</label>
	<g:textField name="village" value="${fieldValue(bean: farmerInstance, field: 'village')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: farmerInstance, field: 'taluka', 'error')} ">
	<label for="taluka">
		<g:message code="farmer.taluka.label" default="Taluka" />
		
	</label>
	<g:textField name="taluka" value="${fieldValue(bean: farmerInstance, field: 'taluka')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: farmerInstance, field: 'district', 'error')} ">
	<label for="district">
		<g:message code="farmer.district.label" default="District" />
		
	</label>
	<g:textField name="district" value="${fieldValue(bean: farmerInstance, field: 'district')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: farmerInstance, field: 'pincode', 'error')} ">
	<label for="pincode">
		<g:message code="farmer.pincode.label" default="Pincode" />
		
	</label>
	<g:textField name="pincode" value="${fieldValue(bean: farmerInstance, field: 'pincode')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: farmerInstance, field: 'dob', 'error')} required">
	<label for="dob">
		<g:message code="farmer.dob.label" default="Dob" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="dob" value="${farmerInstance?.dob}"  />

</div>

<div class="fieldcontain ${hasErrors(bean: farmerInstance, field: 'education', 'error')} ">
	<label for="education">
		<g:message code="farmer.education.label" default="Education" />
		
	</label>
	<g:textField name="education" value="${fieldValue(bean: farmerInstance, field: 'education')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: farmerInstance, field: 'occupation', 'error')} ">
	<label for="occupation">
		<g:message code="farmer.occupation.label" default="Occupation" />
		
	</label>
	<g:textField name="occupation" value="${fieldValue(bean: farmerInstance, field: 'occupation')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: farmerInstance, field: 'caste', 'error')} ">
	<label for="caste">
		<g:message code="farmer.caste.label" default="Caste" />
		
	</label>
	<g:textField name="caste" value="${fieldValue(bean: farmerInstance, field: 'caste')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: farmerInstance, field: 'mobileNo', 'error')} ">
	<label for="mobileNo">
		<g:message code="farmer.mobileNo.label" default="Mobile No" />
		
	</label>
	<g:textField name="mobileNo" value="${fieldValue(bean: farmerInstance, field: 'mobileNo')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: farmerInstance, field: 'adharcardNo', 'error')} ">
	<label for="adharcardNo">
		<g:message code="farmer.adharcardNo.label" default="Adharcard No" />
		
	</label>
	<g:textField name="adharcardNo" value="${fieldValue(bean: farmerInstance, field: 'adharcardNo')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: farmerInstance, field: 'panCardNo', 'error')} ">
	<label for="panCardNo">
		<g:message code="farmer.panCardNo.label" default="Pan Card No" />
		
	</label>
	<g:textField name="panCardNo" value="${fieldValue(bean: farmerInstance, field: 'panCardNo')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: farmerInstance, field: 'shareHolder', 'error')} ">
	<label for="shareHolder">
		<g:message code="farmer.shareHolder.label" default="Share Holder" />
		
	</label>
	<g:checkBox name="shareHolder" value="${farmerInstance?.shareHolder}" />

</div>

<div class="fieldcontain ${hasErrors(bean: farmerInstance, field: 'shareAmount', 'error')} ">
	<label for="shareAmount">
		<g:message code="farmer.shareAmount.label" default="Share Amount" />
		
	</label>
	<g:textField name="shareAmount" value="${fieldValue(bean: farmerInstance, field: 'shareAmount')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: farmerInstance, field: 'shareCertificateNo', 'error')} ">
	<label for="shareCertificateNo">
		<g:message code="farmer.shareCertificateNo.label" default="Share Certificate No" />
		
	</label>
	<g:textField name="shareCertificateNo" value="${fieldValue(bean: farmerInstance, field: 'shareCertificateNo')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: farmerInstance, field: 'areaOfIrrigatedLand', 'error')} required">
	<label for="areaOfIrrigatedLand">
		<g:message code="farmer.areaOfIrrigatedLand.label" default="Area Of Irrigated Land" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="areaOfIrrigatedLand" value="${fieldValue(bean: farmerInstance, field: 'areaOfIrrigatedLand')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: farmerInstance, field: 'areaOfNonIrrigatedLand', 'error')} required">
	<label for="areaOfNonIrrigatedLand">
		<g:message code="farmer.areaOfNonIrrigatedLand.label" default="Area Of Non Irrigated Land" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="areaOfNonIrrigatedLand" value="${fieldValue(bean: farmerInstance, field: 'areaOfNonIrrigatedLand')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: farmerInstance, field: 'areaOfTotalLand', 'error')} required">
	<label for="areaOfTotalLand">
		<g:message code="farmer.areaOfTotalLand.label" default="Area Of Total Land" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="areaOfTotalLand" value="${fieldValue(bean: farmerInstance, field: 'areaOfTotalLand')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: farmerInstance, field: 'dairy', 'error')} ">
	<label for="dairy">
		<g:message code="farmer.dairy.label" default="Dairy" />
		
	</label>
	<g:checkBox name="dairy" value="${farmerInstance?.dairy}" />

</div>

<div class="fieldcontain ${hasErrors(bean: farmerInstance, field: 'numDesiCows', 'error')} ">
	<label for="numDesiCows">
		<g:message code="farmer.numDesiCows.label" default="Num Desi Cows" />
		
	</label>
	<g:textField name="numDesiCows" value="${fieldValue(bean: farmerInstance, field: 'numDesiCows')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: farmerInstance, field: 'numHybridCows', 'error')} ">
	<label for="numHybridCows">
		<g:message code="farmer.numHybridCows.label" default="Num Hybrid Cows" />
		
	</label>
	<g:textField name="numHybridCows" value="${fieldValue(bean: farmerInstance, field: 'numHybridCows')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: farmerInstance, field: 'anyOtherBusiness', 'error')} ">
	<label for="anyOtherBusiness">
		<g:message code="farmer.anyOtherBusiness.label" default="Any Other Business" />
		
	</label>
	<g:checkBox name="anyOtherBusiness" value="${farmerInstance?.anyOtherBusiness}" />

</div>

<div class="fieldcontain ${hasErrors(bean: farmerInstance, field: 'otherBusinessDetails', 'error')} ">
	<label for="otherBusinessDetails">
		<g:message code="farmer.otherBusinessDetails.label" default="Other Business Details" />
		
	</label>
	<g:textField name="otherBusinessDetails" value="${fieldValue(bean: farmerInstance, field: 'otherBusinessDetails')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: farmerInstance, field: 'irrigationFacility', 'error')} ">
	<label for="irrigationFacility">
		<g:message code="farmer.irrigationFacility.label" default="Irrigation Facility" />
		
	</label>
	<g:checkBox name="irrigationFacility" value="${farmerInstance?.irrigationFacility}" />

</div>

<div class="fieldcontain ${hasErrors(bean: farmerInstance, field: 'irrigationType', 'error')} ">
	<label for="irrigationType">
		<g:message code="farmer.irrigationType.label" default="Irrigation Type" />
		
	</label>
	<g:select name="irrigationType" from="${farmerInstance.constraints.irrigationType.inList}" value="${farmerInstance.irrigationType}" valueMessagePrefix="farmer.irrigationType"  />

</div>

<div class="fieldcontain ${hasErrors(bean: farmerInstance, field: 'microIrrigationType', 'error')} ">
	<label for="microIrrigationType">
		<g:message code="farmer.microIrrigationType.label" default="Micro Irrigation Type" />
		
	</label>
	<g:select name="microIrrigationType" from="${farmerInstance.constraints.microIrrigationType.inList}" value="${farmerInstance.microIrrigationType}" valueMessagePrefix="farmer.microIrrigationType"  />

</div>

<div class="fieldcontain ${hasErrors(bean: farmerInstance, field: 'areaUnderDrip', 'error')} ">
	<label for="areaUnderDrip">
		<g:message code="farmer.areaUnderDrip.label" default="Area Under Drip" />
		
	</label>
	<g:textField name="areaUnderDrip" value="${fieldValue(bean: farmerInstance, field: 'areaUnderDrip')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: farmerInstance, field: 'areaUnderSprinkler', 'error')} ">
	<label for="areaUnderSprinkler">
		<g:message code="farmer.areaUnderSprinkler.label" default="Area Under Sprinkler" />
		
	</label>
	<g:textField name="areaUnderSprinkler" value="${fieldValue(bean: farmerInstance, field: 'areaUnderSprinkler')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: farmerInstance, field: 'farmingProcess', 'error')} ">
	<label for="farmingProcess">
		<g:message code="farmer.farmingProcess.label" default="Farming Process" />
		
	</label>
	<g:select name="farmingProcess" from="${farmerInstance.constraints.farmingProcess.inList}" value="${farmerInstance.farmingProcess}" valueMessagePrefix="farmer.farmingProcess"  />

</div>

<div class="fieldcontain ${hasErrors(bean: farmerInstance, field: 'panCardSubmitted', 'error')} ">
	<label for="panCardSubmitted">
		<g:message code="farmer.panCardSubmitted.label" default="Pan Card Submitted" />
		
	</label>
	<g:checkBox name="panCardSubmitted" value="${farmerInstance?.panCardSubmitted}" />

</div>

<div class="fieldcontain ${hasErrors(bean: farmerInstance, field: 'electionCardSubmitted', 'error')} ">
	<label for="electionCardSubmitted">
		<g:message code="farmer.electionCardSubmitted.label" default="Election Card Submitted" />
		
	</label>
	<g:checkBox name="electionCardSubmitted" value="${farmerInstance?.electionCardSubmitted}" />

</div>

<div class="fieldcontain ${hasErrors(bean: farmerInstance, field: 'lightBillSubmitted', 'error')} ">
	<label for="lightBillSubmitted">
		<g:message code="farmer.lightBillSubmitted.label" default="Light Bill Submitted" />
		
	</label>
	<g:checkBox name="lightBillSubmitted" value="${farmerInstance?.lightBillSubmitted}" />

</div>

<div class="fieldcontain ${hasErrors(bean: farmerInstance, field: 'dakhlaSubmitted', 'error')} ">
	<label for="dakhlaSubmitted">
		<g:message code="farmer.dakhlaSubmitted.label" default="Dakhla Submitted" />
		
	</label>
	<g:checkBox name="dakhlaSubmitted" value="${farmerInstance?.dakhlaSubmitted}" />

</div>

<div class="fieldcontain ${hasErrors(bean: farmerInstance, field: 'rationCardSubmitted', 'error')} ">
	<label for="rationCardSubmitted">
		<g:message code="farmer.rationCardSubmitted.label" default="Ration Card Submitted" />
		
	</label>
	<g:checkBox name="rationCardSubmitted" value="${farmerInstance?.rationCardSubmitted}" />

</div>

<div class="fieldcontain ${hasErrors(bean: farmerInstance, field: 'comments', 'error')} ">
	<label for="comments">
		<g:message code="farmer.comments.label" default="Comments" />
		
	</label>
	<g:textField name="comments" value="${fieldValue(bean: farmerInstance, field: 'comments')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: farmerInstance, field: 'crops', 'error')} ">
	<label for="crops">
		<g:message code="farmer.crops.label" default="Crops" />
		
	</label>
	
<ul>
<g:each in="${farmerInstance?.crops}" var="farmerCropInstance">
    <li><g:link controller="farmerCrop" action="show" id="${farmerCropInstance.id}">${farmerCropInstance?.encodeAsHTML()}</g:link></li>
</g:each>
</ul>
<g:link controller="farmerCrop" params="['farmer.id': farmerInstance?.id]" action="create"><g:message code="farmerCrop.new" default="New FarmerCrop" /></g:link>


</div>

