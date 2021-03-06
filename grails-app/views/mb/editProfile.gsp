<%@ page import="ics.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <title>Candidate Profile</title>
    <r:require module="wizard"/>
    <r:require module="jqui"/>
    <r:require module="jqval"/>
    <r:require module="ajaxform"/>
    <r:require module="multiselect"/>
    <r:require module="dateTimePicker"/>
</head>

<body>
<div class="nav">
    <span class="menuButton"><a class="home" href="${createLink(controller:'Mb',action:'home')}"><g:message code="default.home.label"/></a></span>
    <sec:ifAnyGranted roles="ROLE_MB_CANDIDATE">
        <g:hiddenField name="finishShow" id="finishShow" value="true"/>
        <g:if test="${mbProfile?.profileStatus == 'STARTED' || mbProfile?.profileStatus == 'INCOMPLETE'}">
            <span class="menuButton"><a class="create" href="javascript:void(0);" onclick="processSubmit();">Submit Profile to MB</a></span>
        </g:if>
    </sec:ifAnyGranted>
    <sec:ifAnyGranted roles="ROLE_MB_ADMIN,ROLE_MB_SEC">
        <g:if test="${mbProfile?.profileStatus == 'SUBMITTED'}">
            <g:hiddenField name="finishShow" id="finishShow" value="false"/>
            <span class="menuButton"><a href="javascript:void(0);" onclick='$( "#MarkIncomleteForm" ).dialog("open")' class="create">Mark Incomplete</a></span>
            <span class="menuButton"><g:link class="create" action="updateProfileStatus" id="${mbProfile?.id}"
                                             params="['status': 'COMPLETE']">Mark Complete</g:link></span>
            <span class="menuButton"><g:link class="create" action="updateProfileStatus" id="${mbProfile?.id}"
                                             params="['status': 'REJECTED']">Mark Rejected</g:link></span>
            <span class="menuButton"><g:link class="create" action="updateProfileStatus" id="${mbProfile?.id}"
                                             params="['status': 'DUPLICATE']">Mark Duplicate</g:link></span>
        </g:if>
    </sec:ifAnyGranted>
</div>

<div id="show-administrator" class="content scaffold-show" role="main">
<div class="errMsgWrap">
    <g:if test="${flash.message}">
         <div class="message" role="status">${flash.message}</div>
    </g:if>
</div>

<div id="MarkIncomleteForm" title="Reason for marking incomplete">
    <div id="msgWrap">
        <g:hiddenField name="id" value="${mbProfile?.id}"/>
        <textarea id="msgArea"></textarea>
    </div>
</div>

<g:form action="updateProfile" name="mainForm">
<g:hiddenField name="id" value="${mbProfile?.id}"/>
<g:hiddenField name="version" value="${mbProfile?.version}"/>
<g:hiddenField name="stat" value="${mbProfile?.profileStatus}"/>
<input type="submit" hidden="hidden" name="formSubmitSilent" id="formSubmitSilent"/>
<input type="submit" hidden="hidden" name="formSubmit" id="formSubmit"/>
<g:set var="candAddr" value="${ics.Address.findByIndividualAndCategory(mbProfile.candidate,'PresentAddress')}"/>
<g:set var="iskconCentres" value="${ics.AttributeValue.findAllByAttribute(ics.Attribute.findByDomainClassNameAndDomainClassAttributeNameAndCategory('Mb','iskcon_centre','Config'))?.collect{it.value}}" />
<g:set var="spiritualMasters" value="${ics.AttributeValue.findAllByAttribute(ics.Attribute.findByDomainClassNameAndDomainClassAttributeNameAndCategory('Mb','sp_master','Config'))?.collect{it.value}}" />

<table align="center" border="0" cellpadding="0" cellspacing="0">
<tr><td> 
<!-- Smart Wizard -->
  		<div id="wizard" class="swMain">
  			<ul>
  				<li><a href="#step-1">
                <span class="stepNumber">1</span>
                <span class="stepDesc">
                   Personal Info<br />
                </span>
            </a></li>
  				<li><a href="#step-2">
                <span class="stepNumber">2</span>
                <span class="stepDesc">
                   Family Info<br />
                </span>
            </a></li>
  				<li><a href="#step-3">
                <span class="stepNumber">3</span>
                <span class="stepDesc">
                   Professional Info<br />
                </span>                   
             </a></li>
  				<li><a href="#step-4">
                <span class="stepNumber">4</span>
                <span class="stepDesc">
                   Devotional Info<br />
                </span>                   
            </a></li>
  				<li><a href="#step-5">
                <span class="stepNumber">5</span>
                <span class="stepDesc">
                   Expectations<br />
                </span>                   
            </a></li>
  				<li><a href="#step-6">
                <span class="stepNumber">6</span>
                <span class="stepDesc">
                   Photograph<br />
                </span>                   
            </a></li>
  			</ul>
  	<div id="step-1">	
            <h2 class="StepTitle">1. Personal Details</h2>
                <div class="dialog">
                    <table>
                        <tbody>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="legalName">Legal Name:</label><span class="mand">*</span>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: mbProfile, field: 'legalName', 'errors')}">
<g:textField name="legalName" maxlength="40" placeholder="Enter Full name (first name middle name last name)"
             pattern=".{10,}" validationMessage="Please enter min 10 letters!" required="required"
             value="${mbProfile?.candidate?.legalName}"/>
</td>
<td valign="top" class="name">
    <label for="initiatedName">Initiated Name:</label>
</td>
<td valign="top" class="value ${hasErrors(bean: mbProfile, field: 'initiatedName', 'errors')}">
    <g:textField name="initiatedName" maxlength="40" placeholder="Enter Initiated Name here" pattern=".{10,}"
                 value="${mbProfile?.candidate?.initiatedName}"/>
    <div>&nbsp;&nbsp;&nbsp;(Blank if not initiated)</div>
</td>
<td valign="top" class="name">
    <label for="isMale">Gender:</label><span class="mand">*</span>
</td>
<!-- Checking for adding comments -->
<td valign="top" class="value">
    <g:select name="isMale" class="required" from="${['FEMALE','MALE']}" value="${mbProfile?.candidate?.isMale==null?'Select Gender':(mbProfile?.candidate?.isMale ? 'MALE' : 'FEMALE')}" noSelection="['':'Select Gender']"/>
</td>
</tr>
<tr class="prop">
    <td valign="top" class="name">
        <label for="dob">Date of Birth:</label><span class="mand">*</span>
    </td>
    <td valign="top" class="value ${hasErrors(bean: mbProfile, field: 'dob', 'errors')}">
        <g:textField name="dob" id="dob" placeholder="Format of DD/MM/YYYY"
                     value="${mbProfile?.candidate?.dob?.format('dd/MM/yyyy')}" required="required"/>
    </td>
    <td valign="top" class="name">
        <label for="pob">Place of Birth:</label><span class="mand">*</span>
    </td>
    <td valign="top" class="value ${hasErrors(bean: mbProfile, field: 'dob', 'errors')}">
        <g:textField name="pob" placeholder="Actual City/Village" required="required"
                         value="${mbProfile?.candidate?.pob}"/>
    </td>
    <td valign="top" class="name">
        <label for="tob">Time of Birth:</label><span class="mand">*</span>
    </td>
    <td valign="top" class="value ${hasErrors(bean: mbProfile, field: 'dob', 'errors')}">

        <g:textField name="tob" id="tob" placeholder="Format of HH:MM:SS"
                     value="${mbProfile?.candidate?.dob?.format('HH:mm:ss')}" required="required"/>
    </td>
</tr>
<tr class="prop">
    <td valign="top" class="name">
        <label for="iskconCentre">ISKCON Centre:</label><span class="mand">*</span>
    </td>
    <td valign="top" class="value">
        <g:select name="iskconCentre" from="${iskconCentres}" class="required"
                  value="${mbProfile?.candidate?.iskconCentre}" noSelection="['':'Select One']"/>
    </td>
    <td valign="top" class="name">
        <label for="counselor">Counselor / Mentor:</label><span class="mand">*</span>
    </td>
    <td valign="top" class="value">
        <g:textField name="counselor" placeholder="Enter Counselor Name here" required="required"
                         value="${mbProfile?.candCounsellor}"/>
    </td>
    <td valign="top" class="name">
        <label for="counselorAshram">Counselor is a:</label><span class="mand">*</span>
    </td>
    <td valign="top" class="value">
        <g:select name="counselorAshram" from="${['NA', 'Grihastha', 'Brahmacari']}" class="required"
                  value="${mbProfile?.candCounsellorAshram}" noSelection="['':'Select One']"/>
    </td>
</tr>
<tr class="prop">
    <td valign="top" class="name">
        <label for="originState">State Of Birth</label><span class="mand">*</span>
    </td>
    <td valign="top" class="value">
        <g:select name="originState" class="required"
                  from="${['Andaman and Nicobar Islands', 'Andhra Pradesh', 'Arunachal Pradesh', 'Assam', 'Bihar', 'Chandigarh', 'Chhattisgarh', 'Dadara and Nagar Haveli', 'Daman and Diu', 'Goa', 'Gujarat', 'Haryana', 'Himachal Pradesh', 'Jammu and Kashmir', 'Jharkhand', 'Karnataka', 'Kerala', 'Lakshadweep', 'Madhya Pradesh', 'Maharashtra', 'Manipur', 'Meghalaya', 'Mizoram', 'Nagaland', 'NCT of Delhi', 'Orissa', 'Pondicherry', 'Punjab', 'Rajasthan', 'Sikkim', 'Tamil Nadu', 'Telangana', 'Tripura', 'Uttar Pradesh', 'Uttarakhand', 'West Bengal', 'Foreign State']}"
                  value="${mbProfile?.candidate?.origin}" noSelection="['':'Select One']"/>
    </td>
    <td valign="top" class="name">
        <label for="currentCountry">Are you currently settled in India or Abroad : </label><span class="mand">*</span>
    </td>
    <td valign="top" class="value">
        <g:select name="currentCountry" style="width: 100%" class="required"
                  from="${['India','Abroad']}"
                  value="${mbProfile?.currentCountry}" noSelection="['':'Select One']"/>
    </td>
    <td valign="top" class="name">
        <label for="culturalInfluence">Primary Cultural Background:</label><span class="mand">*</span>
    </td>
    <td valign="top" class="value">
        <g:select name="culturalInfluence" class="required"
                  from="${['Assamese','Andhraite','Bengali','Bihari','Gujarati','Himachal Pradesh','Kannadiga','Kasmiri','Konkani','Keralite','Madhya Pradesh','Manipuri','Maharashtrian','Marwari','Nepali','Oriyan','Punjabi','Sindhi','Tamilian','Typical North Indian','Typical South Indian','Typical Cosmopolitan','Typical Village','Uttar Pradesh','Urdu','Western']}"
                  value="${mbProfile?.culturalInfluence}" noSelection="['':'Select One']"/>
    </td>
</tr>
<tr class="prop">
    <td valign="top" class="name">
        <label for="scstCategory">Category:</label><span class="mand">*</span>
    </td>
    <td valign="top" class="value">
        <g:select name="scstCategory" class="required"
                  from="${['Open','Other Backward Class','Backward Class','Scheduled Caste','Scheduled Tribe','Nomadic Tribes']}"
                  value="${mbProfile?.scstCategory ?: 'Open'}" noSelection="['':'Select One']"/>
    </td>
    <td valign="top" class="name">
        <label for="caste">Caste:</label><span class="mand">*</span>
    </td>
    <td valign="top" class="value">
        <g:textField name="caste" placeholder="Enter the Actual Caste here" required="required"
             value="${mbProfile?.candidate?.caste}" maxlength="40"/>
    </td>
    <td valign="top" class="name">
        <label for="subCaste">Sub-Caste:</label>
    </td>
    <td valign="top" class="value">
        <g:textField name="subCaste" maxlength="40" placeholder="Enter a Sub Caste"
                     value="${mbProfile?.candidate?.subCaste}"/>
    </td>
</tr>
<tr class="prop">
    <td valign="top" class="name">
        <label for="varna">Varna, if you<br>are aware:</label><span class="mand">*</span>
    </td>
    <td valign="top" class="value">
        <g:select name="varna" from="${['Brahmin', 'Kshatriya', 'Vaishya', 'Sudra', 'Not Known']}" class="required"
                  value="${mbProfile?.candidate?.varna ?: 'Not Known'}" noSelection="['':'Select One']"/>
    </td>
    <td valign="top" class="name">
        <label for="heightInFt">Height</label><span class="mand">*</span>
    </td>
    <td valign="top" class="value">
        <g:select class="required" name="heightInFt" from="${2..7}" value="${(mbProfile?.candidate?.height?: 2)/12}"/><span>&nbsp;ft</span>
        <g:select class="required" name="heightInInch" from="${0..11}" value="${(mbProfile?.candidate?.height?: 0)%12}"/><span>&nbsp;inches</span>
    </td>
    <td valign="top" class="name">
        <label for="weight">Weight</label>
    </td>
    <td valign="top" class="value">
        <g:select name="weight" from="${40..150}" value="${mbProfile?.weight}"/><span> Kg</span>
    </td>
</tr>
<tr class="prop">
    <td valign="top" class="name">
        <label for="motherTongue">Mother Tongue:</label><span class="mand">*</span>
    </td>
    <td valign="top" class="value">
        <g:select name="motherTongue" class="required"
                  from="${['Assamese', 'Bengali', 'English', 'Gujarati', 'Hindi', 'Kannada', 'Kashmiri', 'Konkani', 'Malayalam', 'Manipuri', 'Marathi', 'Marwari', 'Nepali', 'Oriya', 'Punjabi', 'Sanskrit', 'Sindhi', 'Tamil', 'Telugu', 'Urdu', 'Other Indian languages', 'Foreign languages']}"
                  value="${mbProfile?.candidate?.motherTongue ?: 'Marathi'}" noSelection="['':'Select One']"/>
    </td>
    <td valign="top" class="name">
        <label for="nationality">Nationality:</label><span class="mand">*</span>
    </td>
    <td valign="top" class="value">
        <g:select name="nationality" class="required" from="${['Indian', 'Others']}" value="${mbProfile?.candidate?.nationality}"/>
    </td>
    <td valign="top" class="name">
        <label for="candidateIncome">Candidate's <br>Income(p.a):</label><span class="mand">*</span>
    </td>
    <td valign="top" class="value">
        <g:select name="candidateIncome" class="required"
                  from="${1..100}"
                  value="${mbProfile?.candidate?.income ? Integer.parseInt(mbProfile?.candidate?.income.split(' ')[0]):''}" noSelection="['':'Select One']"/>
        <span>Lakhs per Annum</span>
    </td>
</tr>
<tr class="prop">
    <td valign="top" class="name">
        <label for="horoscopeToBeMatched">Horoscope<br> to be matched:</label><span class="mand">*</span>
    </td>
    <td valign="top" class="value">
        <g:select name="horoscopeToBeMatched" from="${['Yes', 'No', 'No Specific Choice']}" class="required"
                  value="${mbProfile?.horoscopeToBeMatched}" noSelection="['':'Select One']"/>
    </td>
    <td valign="top" class="name">
        <label for="manglik">Manglik:</label><span class="mand">*</span>
    </td>
    <td valign="top" class="value">
        <g:select name="manglik" class="required" from="${['No', 'Low', 'Medium', 'High', 'Not aware']}" value="${mbProfile?.manglik}" noSelection="['':'Select One']"/>
    </td>
    <td valign="top" class="name">
        <label for="maritalStatus">Marital Status:</label><span class="mand">*</span>
    </td>
    <td valign="top" class="value">
        <g:select name="maritalStatus" required="required"
                  from="${['Never Married','Divorcee','Divorcee with children', 'Divorcee without children', 'Widow with children', 'Widow without children', 'Widower with children', 'Widower without children']}"
                  value="${mbProfile?.maritalStatus?: 'Never Married'}"/>`
    </td>
</tr>
<tr class="prop">
    <td valign="top" class="name">
        <label for="addrline1">Present Address : </label><span class="mand">*</span>
    </td>
    <td valign="top" class="value">
        <g:textArea name="addrline1" placeholder="Enter Address here" required="required" maxLength="100"
                     value="${candAddr?.addressLine1}"/>
    </td>
    <td valign="top" class="name">
        <label for="city">City:</label><span class="mand">*</span>
    </td>
    <td valign="top" class="value">
        <g:textField name="city" maxLength="20" placeholder="Enter City here" required="required"
                     value="${candAddr?.city}"/>
    </td>
    <td valign="top" class="name">
        <label for="state">State:</label><span class="mand">*</span>
    </td>
    <td valign="top" class="value">
        <g:select name="state" class="required"
                  from="${['Andaman and Nicobar Islands', 'Andhra Pradesh', 'Arunachal Pradesh', 'Assam', 'Bihar', 'Chandigarh', 'Chhattisgarh', 'Dadara and Nagar Haveli', 'Daman and Diu', 'Goa', 'Gujarat', 'Haryana', 'Himachal Pradesh', 'Jammu and Kashmir', 'Jharkhand', 'Karnataka', 'Kerala', 'Lakshadweep', 'Madhya Pradesh', 'Maharashtra', 'Manipur', 'Meghalaya', 'Mizoram', 'Nagaland', 'NCT of Delhi', 'Orissa', 'Pondicherry', 'Punjab', 'Rajasthan', 'Sikkim', 'Tamil Nadu', 'Telangana', 'Tripura', 'Uttar Pradesh', 'Uttarakhand', 'West Bengal', 'Foreign State']}"
                  value="${candAddr?.state?.name}" noSelection="['':'Select One']"/>
    </td>
</tr>
<tr class="prop">
    <td valign="top" class="name">
        <label for="pincode">Pin Code:</label><span class="mand">*</span>
    </td>
    <td valign="top" class="value">
        <g:textField name="pincode" maxLength="6" placeholder="Enter Pin Code here" required="required"
                     value="${candAddr?.pincode}"/>
    </td>
    <td valign="top" class="name">
        <label for="residenceType">Above Residence is:</label><span class="mand">*</span>
    </td>
    <td valign="top" class="value">
        <g:select name="residenceType" class="required"
                  from="${['Rented','Owned','Company provided','BACE / VOICE']}"
                  value="${mbProfile?.residenceType}" noSelection="['':'Select One']"/>
    </td>
    <td valign="top" class="name">
        <label for="areaCurrHouse">Area (in sq.ft):</label><span class="mand">*</span>
    </td>
    <td valign="top" class="value">
        <g:textField name="areaCurrHouse" maxLength="6" placeholder="Enter the area value" required="required"
                     value="${mbProfile?.areaCurrHouse}"/>
    </td>
</tr>
<tr class="prop">
    <td valign="top" class="name">
        <label for="contact">Contact Number:</label><span class="mand">*</span>
    </td>
    <td valign="top" class="value ${hasErrors(bean: mbProfile, field: 'contact', 'errors')}">
        <g:textField name="contact" type="tel"
                     value="${VoiceContact.findByCategoryAndIndividual('CellPhone', mbProfile?.candidate)?.number}"
                     required="required"/>
    </td>
    <td valign="top" class="name">
        <label for="email">Email Address:</label><span class="mand">*</span>
    </td>
    <td valign="top" class="value ${hasErrors(bean: mbProfile, field: 'email', 'errors')}">
        <g:textField name="email" type="email"
                     value="${EmailContact.findByCategoryAndIndividual('Personal', mbProfile?.candidate)?.emailAddress}"
                     required="required"/>
    </td>
    <td valign="top" class="name">
        <label for="languagesKnown">Languages <br>Known:</label>
    </td>
    <td valign="top" class="value">
        <g:select class="multiple" name="languagesKnown" multiple="multiple"
                  from="${['Assamese', 'Bengali', 'English', 'Gujarati', 'Hindi', 'Kannada', 'Kashmiri', 'Konkani', 'Malayalam', 'Manipuri', 'Marathi', 'Marwari', 'Nepali', 'Oriya', 'Punjabi', 'Sanskrit', 'Sindhi', 'Tamil', 'Telugu', 'Urdu', 'Other Indian languages', 'Foreign languages']}"
                  value="${org.springframework.util.StringUtils.commaDelimitedListToStringArray(mbProfile?.languagesKnown).toList()}"/>
    </td>
</tr>
<tr class="prop">
    <td valign="top" class="name">
        <label for="referrer">Reference Name:</label>
    </td>
    <td valign="top" class="value">
        <g:textField name="referrer" maxLength="80" placeholder="Enter name of someone who knows you"
                     value="${mbProfile?.referrer}"/>
    </td>
    <td valign="top" class="name">
        <label for="referrerEmail">Reference Email:</label>
    </td>
    <td valign="top" class="value">
        <g:textField name="referrerEmail" maxLength="50" placeholder="Enter reference's email address"
                     value="${mbProfile?.referrerEmail}"/>
    </td>
    <td valign="top" class="name">
        <label for="referrerContact">Reference Contact No.:</label>
    </td>
    <td valign="top" class="value">
        <g:textField name="referrerContact" maxLength="20" placeholder="Enter reference's phone number"
                     value="${mbProfile?.referrerContact}"/>
    </td>
</tr>
<tr class="prop">
    <td valign="top" class="name">
        <label for="personalInfo">Any Personal or Important information you would like us to know:</label>
    </td>
    <td colspan="4" valign="top" class="value">
        <g:textArea name="personalInfo" maxlength="500"
                    placeholder="Enter any Personal information you would like us to know as a Marriage board"
                    value="${mbProfile?.personalInfo}"/>
        <span style="display:block;text-align: center">0-500 Characters</span>
    </td>
</tr>
</tbody>
</table>
</div>
</div>
<div id="step-2">
<h2 class="StepTitle">2. Family Details</h2>

<div class="dialog">
<table>
<tbody>
<tr class="prop">
    <td valign="top" class="name">
        <label for="nativePlace">Native Place:</label><span class="mand">*</span>
    </td>
    <td valign="top" class="value">
        <g:textField name="nativePlace" maxLength="40" placeholder="Enter Region of Native place" required="required"
                         value="${mbProfile?.nativePlace}"/>
    </td>
    <td valign="top" class="name">
        <label for="nativeState">Native(State):</label><span class="mand">*</span>
    </td>
    <td valign="top" class="value">
        <g:select name="nativeState" required="required"
                  from="${['Andaman and Nicobar Islands', 'Andhra Pradesh', 'Arunachal Pradesh', 'Assam', 'Bihar', 'Chandigarh', 'Chhattisgarh', 'Dadara and Nagar Haveli', 'Daman and Diu', 'Goa', 'Gujarat', 'Haryana', 'Himachal Pradesh', 'Jammu and Kashmir', 'Jharkhand', 'Karnataka', 'Kerala', 'Lakshadweep', 'Madhya Pradesh', 'Maharashtra', 'Manipur', 'Meghalaya', 'Mizoram', 'Nagaland', 'NCT of Delhi', 'Orissa', 'Pondicherry', 'Punjab', 'Rajasthan', 'Sikkim', 'Tamil Nadu', 'Telangana', 'Tripura', 'Uttar Pradesh', 'Uttarakhand', 'West Bengal', 'Foreign State']}"
                  value="${mbProfile?.nativeState}" noSelection="['':'Select One']"/>
    </td>
</tr>
<tr class="prop">
    <td valign="top" class="name">
        <label for="famaddrline1">Present Address<br>of family:</label><span class="mand">*</span>
    </td>
    <td valign="top" class="value">
        <g:textArea name="famaddrline1" maxLength="100" placeholder="Enter Address here" required="required" value="${mbProfile?.familyAddress?.addressLine1}"/>
    </td>
    <td valign="top" class="name">
        <label for="permcity">City:</label><span class="mand">*</span>
    </td>
    <td valign="top" class="value">
        <g:textField name="permcity" maxLength="20" placeholder="Enter City here" required="required" value="${mbProfile?.familyAddress?.city}"/>
    </td>
    <td valign="top" class="name">
        <label for="familystate">State:</label><span class="mand">*</span>
    </td>
    <td valign="top" class="value">
        <g:select name="familystate" class="required"
                  from="${['Andaman and Nicobar Islands', 'Andhra Pradesh', 'Arunachal Pradesh', 'Assam', 'Bihar', 'Chandigarh', 'Chhattisgarh', 'Dadara and Nagar Haveli', 'Daman and Diu', 'Goa', 'Gujarat', 'Haryana', 'Himachal Pradesh', 'Jammu and Kashmir', 'Jharkhand', 'Karnataka', 'Kerala', 'Lakshadweep', 'Madhya Pradesh', 'Maharashtra', 'Manipur', 'Meghalaya', 'Mizoram', 'Nagaland', 'NCT of Delhi', 'Orissa', 'Pondicherry', 'Punjab', 'Rajasthan', 'Sikkim', 'Tamil Nadu', 'Telangana', 'Tripura', 'Uttar Pradesh', 'Uttarakhand', 'West Bengal', 'Foreign State']}"
                  value="${mbProfile?.familyAddress?.state?.name}" noSelection="['':'Select One']"/>
    </td>
</tr>
<tr class="prop">
    <td valign="top" class="name">
        <label for="permpincode">Pin Code:</label><span class="mand">*</span>
    </td>
    <td valign="top" class="value">
        <g:textField name="permpincode" maxLength="6" placeholder="Enter Pin Code here" required="required" value="${mbProfile?.familyAddress?.pincode}"/>
    </td>
    <td valign="top" class="name">
        <label for="houseIs">Above House is:</label><span class="mand">*</span>
    </td>
    <td valign="top" class="value">
        <g:select name="houseIs"  class="required" from="${['Owned', 'Rented', 'Govt/Company provided', 'Others']}" value="${mbProfile?.houseIs}" noSelection="['':'Select One']"/>
    </td>
    <td valign="top" class="name">
        <label for="houseArea">Area of House:</label>
    </td>
    <td valign="top" class="value">
        <g:textField name="houseArea" placeholder="Enter Area in sq.ft" value="${mbProfile?.houseArea}"/>
    </td>
</tr>
<tr class="prop">
    <td valign="top" class="name">
        <label for="yourFamily">Have you been brought<br>up in a devotee family:</label>
    </td>
    <td valign="top" class="value">
        <g:select name="yourFamily"  from="${['Yes', 'No', 'For considerable years']}" value="${mbProfile?.yourFamily}" noSelection="['':'Select One']"/>
    </td>
    <td valign="top" class="name">
        <label for="parentsInfo">Are Parents favourable?:</label>
    </td>
    <td valign="top" class="value">
        <g:select name="parentsInfo"  from="${['Yes', 'No', 'Moderate']}" value="${mbProfile?.parentsInfo}" noSelection="['':'Select One']"/>
    </td>
    <td valign="top" class="name">
        <label for="parentsChanting">Parents Chanting<br>(Daily,no.of.rounds):</label>
    </td>
    <td valign="top" class="value">
        <g:select name="parentsChanting"
                  from="${['Not Chanting', 'Sometimes', 'Upto 4 rounds', 'Between 5 to 8', 'Between 9 to 15', 'Chant 16 rounds']}"
                  value="${mbProfile?.parentsChanting}" noSelection="['':'Select One']"/>
    </td>
</tr>
<tr class="prop">
    <td valign="top" class="name">
        <label for="parentsInitiation">Parents Initiation<br> Status:</label>
    </td>
    <td valign="top" class="value">
        <g:select name="parentsInitiation"
                  from="${['Not Initiated', 'Aspiring for Initiation', 'In the Initiation List', 'First Initiated', 'Second Initiated', 'One parent is Initiated', 'Both are initiated']}"
                  value="${mbProfile?.parentsInitiation}" noSelection="['':'Select One']"/>
    </td>
    <td valign="top" class="name">
        <label for="parentsSpMaster">If Parents are <br>initiated, by whom?:</label>
    </td>
    <td valign="top" class="value">
        <g:select name="parentsSpMaster" class="multiple" multiple="multiple"
                  from="${spiritualMasters}"
                  value="${org.springframework.util.StringUtils.commaDelimitedListToStringArray(mbProfile?.parentsSpMaster).toList()}"/>
    </td>
</tr>
<tr class="prop">
    <td valign="top" class="name">
        <label for="fatherIncome">Father's Income (p.a):</label><span class="mand">*</span>
    </td>
    <td valign="top" class="value">
        <g:select name="fatherIncome" class="required"
        from="${['NA', 'Retired', 'Receiving Pension', 'Less than 2 lakhs', 'Between 2 to 3.99 lakhs', 'Between 4 to 5.99 lakhs', 'Between 6 to 7.99 lakhs', 'Between 8 to 9.99 lakhs', 'Between 10 to 11.99 lakhs', 'Between 12 to 13.99 lakhs', 'Between 14 to 15.99 lakhs', 'Above 16 lakhs']}"
        value="${mbProfile?.fatherIncome}" noSelection="['':'Select One']"/>
    </td>
    <td valign="top" class="name">
        <label for="otherIncome">Other Family members Income (p.a):</label><span class="mand">*</span>
    </td>
    <td valign="top" class="value">
        <g:select name="otherIncome" class="required"
        from="${['NA', 'Less than 2 lakhs', 'Between 2 to 4.99 lakhs', 'Between 5 to 7.99 lakhs', 'Between 8 to 11.99 lakhs', 'Between 12 to 15.99 lakhs', 'Between 16 to 19.99 lakhs', 'Between 20 to 24.99 lakhs', 'Between 25 to 29.99 lakhs', 'Above 30 lakhs']}"
        value="${mbProfile?.otherIncome}" noSelection="['':'Select One']"/>
    </td>
    <td valign="top" class="name">
        <label for="noFamilyMembers">No. of family members <br> staying at home:</label><span class="mand">*</span>
    </td>
    <td valign="top" class="value">
        <g:select class="required" name="noFamilyMembers" from="${0..30}" value="${mbProfile?.noFamilyMembers}"/>
    </td>
</tr>

<!-- Added this to make family details dynamic -->

<!-- Start of family details comment-->
<tr class="prop">
    <td valign="top" class="name">
        <label for="relativeName1">Father's Name:</label><span class="mand">*</span>
    </td>
    <td valign="top" class="value">
        <g:textField name="relativeName1" placeholder="Legal Name" required="required"
                     value="${Relationship.findAllByIndividual2AndRelation(mbProfile?.candidate,Relation.findByName('Father'))[0]?.individual1?.legalName}"/>
        <g:textField name="relativeIName1" placeholder="Initiated Name(If applicable)"
                     value="${Relationship.findAllByIndividual2AndRelation(mbProfile?.candidate,Relation.findByName('Father'))[0]?.individual1?.initiatedName}"/>
    </td>
    <td valign="top" class="name">
        <label for="relativeEducation1">Education:</label><span class="mand">*</span>
    </td>
    <td valign="top" class="value">
        <g:textField name="relativeEducation1" placeholder="Enter Father's Education Name" required="required"
                     value="${Relationship.findAllByIndividual2AndRelation(mbProfile?.candidate,Relation.findByName('Father'))[0]?.individual1?.education}"/>
    </td>
    <td valign="top" class="name">
        <label for="relativeProfession1">Occupation:</label><span class="mand">*</span>
    </td>
    <td valign="top" class="value">
        <g:textField name="relativeProfession1" placeholder="Enter Father's Occupation here" required="required"
                     value="${Relationship.findAllByIndividual2AndRelation(mbProfile?.candidate,Relation.findByName('Father'))[0]?.individual1?.profession}"/>
    </td>
    <g:hiddenField name="relationName1" value="Father"/>
    <g:hiddenField name="relativeId1" value="${Relationship.findAllByIndividual2AndRelation(mbProfile?.candidate,Relation.findByName('Father'))[0]?.individual1?.id}"/>
</tr>
<tr class="prop">
    <td valign="top" class="name">
        <label for="relativeName2">Mother's Name:</label><span class="mand">*</span>
    </td>
    <td valign="top" class="value">
        <g:textField name="relativeName2" placeholder="Legal Name" required="required"
                     value="${Relationship.findAllByIndividual2AndRelation(mbProfile?.candidate,Relation.findByName('Mother'))[0]?.individual1?.legalName}"/>
        <g:textField name="relativeIName2" placeholder="Initiated Name(If Applicable)"
                     value="${Relationship.findAllByIndividual2AndRelation(mbProfile?.candidate,Relation.findByName('Mother'))[0]?.individual1?.initiatedName}"/>
    </td>
    <td valign="top" class="name">
        <label for="relativeEducation2">Education:</label><span class="mand">*</span>
    </td>
    <td valign="top" class="value">
        <g:textField name="relativeEducation2" placeholder="Enter Mother's Education Name" required="required"
                     value="${Relationship.findAllByIndividual2AndRelation(mbProfile?.candidate,Relation.findByName('Mother'))[0]?.individual1?.education}"/>
    </td>
    <td valign="top" class="name">
        <label for="relativeProfession2">Occupation:</label><span class="mand">*</span>
    </td>
    <td valign="top" class="value">
        <g:textField name="relativeProfession2" placeholder="Enter Mother's Occupation here" required="required"
                     value="${Relationship.findAllByIndividual2AndRelation(mbProfile?.candidate,Relation.findByName('Mother'))[0]?.individual1?.profession}"/>
    </td>
    <g:hiddenField name="relationName2" value="Mother"/>
    <g:hiddenField name="relativeId2" value="${Relationship.findAllByIndividual2AndRelation(mbProfile?.candidate,Relation.findByName('Mother'))[0]?.individual1?.id}"/>
</tr>
<tr class="prop">
    <td valign="top" class="name">
        <label for="relativeName3">Brother's Name:</label>
    </td>
    <td valign="top" class="value">
        <g:textField name="relativeName3" placeholder="Legal Name"
                     value="${Relationship.findAllByIndividual2AndRelation(mbProfile?.candidate,Relation.findByName('Brother'))[0]?.individual1?.legalName}"/>
        <g:textField name="relativeIName3" placeholder="Initiated Name(If Applicable)"
                     value="${Relationship.findAllByIndividual2AndRelation(mbProfile?.candidate,Relation.findByName('Brother'))[0]?.individual1?.initiatedName}"/>
    </td>
    <td valign="top" class="name">
        <label for="relativeEducation3">Education:</label>
    </td>
    <td valign="top" class="value">
        <g:textField name="relativeEducation3" placeholder="Enter Brother's Education Name"
                     value="${Relationship.findAllByIndividual2AndRelation(mbProfile?.candidate,Relation.findByName('Brother'))[0]?.individual1?.education}"/>
    </td>
    <td valign="top" class="name">
        <label for="relativeProfession3">Occupation:</label>
    </td>
    <td valign="top" class="value">
        <g:textField name="relativeProfession3" placeholder="Enter Brother's Occupation here"
                     value="${Relationship.findAllByIndividual2AndRelation(mbProfile?.candidate,Relation.findByName('Brother'))[0]?.individual1?.profession}"/>
    </td>
    <g:hiddenField name="relationName3" value="Brother"/>
    <g:hiddenField name="relativeId3" value="${Relationship.findAllByIndividual2AndRelation(mbProfile?.candidate,Relation.findByName('Brother'))[0]?.individual1?.id}"/>
</tr>
<tr class="prop">
    <td valign="top" class="name">
        <label for="relativeName4">Brother's Name:</label>
    </td>
    <td valign="top" class="value">
        <g:textField name="relativeName4" placeholder="Legal Name"
                     value="${Relationship.findAllByIndividual2AndRelation(mbProfile?.candidate,Relation.findByName('Brother'))[1]?.individual1?.legalName}"/>
        <g:textField name="relativeIName4" placeholder="Initiated Name(If Applicable)"
                     value="${Relationship.findAllByIndividual2AndRelation(mbProfile?.candidate,Relation.findByName('Brother'))[1]?.individual1?.initiatedName}"/>
    </td>
    <td valign="top" class="name">
        <label for="relativeEducation4">Education:</label>
    </td>
    <td valign="top" class="value">
        <g:textField name="relativeEducation4" placeholder="Enter Brother's Education Name"
                     value="${Relationship.findAllByIndividual2AndRelation(mbProfile?.candidate,Relation.findByName('Brother'))[1]?.individual1?.education}"/>
    </td>
    <td valign="top" class="name">
        <label for="relativeProfession4">Occupation:</label>
    </td>
    <td valign="top" class="value">
        <g:textField name="relativeProfession4" placeholder="Enter Brother's Occupation here"
                     value="${Relationship.findAllByIndividual2AndRelation(mbProfile?.candidate,Relation.findByName('Brother'))[1]?.individual1?.profession}"/>
    </td>
    <g:hiddenField name="relationName4" value="Brother"/>
    <g:hiddenField name="relativeId4" value="${Relationship.findAllByIndividual2AndRelation(mbProfile?.candidate,Relation.findByName('Brother'))[1]?.individual1?.id}"/>
</tr>
<tr class="prop">
    <td valign="top" class="name">
        <label for="relativeName5">Brother's Name:</label>
    </td>
    <td valign="top" class="value">
        <g:textField name="relativeName5" placeholder="Legal Name"
                     value="${Relationship.findAllByIndividual2AndRelation(mbProfile?.candidate,Relation.findByName('Brother'))[2]?.individual1?.legalName}"/>
        <g:textField name="relativeIName5" placeholder="Initiated Name(If Applicable)"
                     value="${Relationship.findAllByIndividual2AndRelation(mbProfile?.candidate,Relation.findByName('Brother'))[2]?.individual1?.initiatedName}"/>
    </td>
    <td valign="top" class="name">
        <label for="relativeEducation5">Education:</label>
    </td>
    <td valign="top" class="value">
        <g:textField name="relativeEducation5" placeholder="Enter Brother's Education Name"
                     value="${Relationship.findAllByIndividual2AndRelation(mbProfile?.candidate,Relation.findByName('Brother'))[2]?.individual1?.education}"/>
    </td>
    <td valign="top" class="name">
        <label for="relativeProfession5">Occupation:</label>
    </td>
    <td valign="top" class="value">
        <g:textField name="relativeProfession5" placeholder="Enter Brother's Occupation here"
                     value="${Relationship.findAllByIndividual2AndRelation(mbProfile?.candidate,Relation.findByName('Brother'))[2]?.individual1?.profession}"/>
    </td>
    <g:hiddenField name="relationName5" value="Brother"/>
    <g:hiddenField name="relativeId5" value="${Relationship.findAllByIndividual2AndRelation(mbProfile?.candidate,Relation.findByName('Brother'))[2]?.individual1?.id}"/>
</tr>
<tr class="prop">
    <td valign="top" class="name">
        <label for="relativeName6">Sister's Name:</label>
    </td>
    <td valign="top" class="value">
        <g:textField name="relativeName6" placeholder="Legal Name"
                     value="${Relationship.findAllByIndividual2AndRelation(mbProfile?.candidate,Relation.findByName('Sister'))[0]?.individual1?.legalName}"/>
        <g:textField name="relativeIName6" placeholder="Initiated Name(If Applicable)"
                     value="${Relationship.findAllByIndividual2AndRelation(mbProfile?.candidate,Relation.findByName('Sister'))[0]?.individual1?.initiatedName}"/>
    </td>
    <td valign="top" class="name">
        <label for="relativeEducation6">Education:</label>
    </td>
    <td valign="top" class="value">
        <g:textField name="relativeEducation6" placeholder="Enter Sister's Education Name"
                     value="${Relationship.findAllByIndividual2AndRelation(mbProfile?.candidate,Relation.findByName('Sister'))[0]?.individual1?.education}"/>
    </td>
    <td valign="top" class="name">
        <label for="relativeProfession6">Occupation:</label>
    </td>
    <td valign="top" class="value">
        <g:textField name="relativeProfession6" placeholder="Enter Sister's Occupation here"
                     value="${Relationship.findAllByIndividual2AndRelation(mbProfile?.candidate,Relation.findByName('Sister'))[0]?.individual1?.profession}"/>
    </td>
    <g:hiddenField name="relationName6" value="Sister"/>
    <g:hiddenField name="relativeId6" value="${Relationship.findAllByIndividual2AndRelation(mbProfile?.candidate,Relation.findByName('Sister'))[0]?.individual1?.id}"/>
</tr>
<tr class="prop">
    <td valign="top" class="name">
        <label for="relativeName7">Sister's Name:</label>
    </td>
    <td valign="top" class="value">
        <g:textField name="relativeName7" placeholder="Legal Name"
                     value="${Relationship.findAllByIndividual2AndRelation(mbProfile?.candidate,Relation.findByName('Sister'))[1]?.individual1?.legalName}"/>
        <g:textField name="relativeIName7" placeholder="Initiated Name(If Applicable)"
                     value="${Relationship.findAllByIndividual2AndRelation(mbProfile?.candidate,Relation.findByName('Sister'))[1]?.individual1?.initiatedName}"/>
    </td>
    <td valign="top" class="name">
        <label for="relativeEducation7">Education:</label>
    </td>
    <td valign="top" class="value">
        <g:textField name="relativeEducation7" placeholder="Enter Sister's Education Name"
                     value="${Relationship.findAllByIndividual2AndRelation(mbProfile?.candidate,Relation.findByName('Sister'))[1]?.individual1?.education}"/>
    </td>
    <td valign="top" class="name">
        <label for="relativeProfession7">Occupation:</label>
    </td>
    <td valign="top" class="value">
        <g:textField name="relativeProfession7" placeholder="Enter Sister's Occupation here"
                     value="${Relationship.findAllByIndividual2AndRelation(mbProfile?.candidate,Relation.findByName('Sister'))[1]?.individual1?.profession}"/>
    </td>
    <g:hiddenField name="relationName7" value="Sister"/>
    <g:hiddenField name="relativeId7" value="${Relationship.findAllByIndividual2AndRelation(mbProfile?.candidate,Relation.findByName('Sister'))[1]?.individual1?.id}"/>
</tr>
<tr class="prop">
    <td valign="top" class="name">
        <label for="relativeName8">Sister's Name:</label>
    </td>
    <td valign="top" class="value">
        <g:textField name="relativeName8" placeholder="Legal Name"
                     value="${Relationship.findAllByIndividual2AndRelation(mbProfile?.candidate,Relation.findByName('Sister'))[2]?.individual1?.legalName}"/>
        <g:textField name="relativeIName8" placeholder="Initiated Name(If Applicable)"
                     value="${Relationship.findAllByIndividual2AndRelation(mbProfile?.candidate,Relation.findByName('Sister'))[2]?.individual1?.initiatedName}"/>
    </td>
    <td valign="top" class="name">
        <label for="relativeEducation8">Education:</label>
    </td>
    <td valign="top" class="value">
        <g:textField name="relativeEducation8" placeholder="Enter Sister's Education Name"
                     value="${Relationship.findAllByIndividual2AndRelation(mbProfile?.candidate,Relation.findByName('Sister'))[2]?.individual1?.education}"/>
    </td>
    <td valign="top" class="name">
        <label for="relativeProfession8">Occupation:</label>
    </td>
    <td valign="top" class="value">
        <g:textField name="relativeProfession8" placeholder="Enter Sister's Occupation here"
                     value="${Relationship.findAllByIndividual2AndRelation(mbProfile?.candidate,Relation.findByName('Sister'))[2]?.individual1?.profession}"/>
    </td>
    <g:hiddenField name="relationName8" value="Sister"/>
    <g:hiddenField name="relativeId8" value="${Relationship.findAllByIndividual2AndRelation(mbProfile?.candidate,Relation.findByName('Sister'))[2]?.individual1?.id}"/>
</tr>

<!--End of family details comment -->
<tr class="prop">
    <td valign="top" class="name">
        <label for="otherFamilyMember">Details about the family members <br>(in case of more members):</label>
    </td>
    <td valign="top" class="value" colspan="2">
        <g:textArea name="otherFamilyMember"
                    placeholder="Enter any Personal information you would like us to know as a Marriage board"
                    value="${mbProfile?.otherFamilyMember}"/>
    </td>
    <td valign="top" class="name">
        <label for="otherProperty">Do you(or family) own<br> any other house/Property:</label>
    </td>
    <td valign="top" class="value" colspan="2">
    <g:textArea name="otherProperty"
                placeholder="Enter the details of the property here"
                value="${mbProfile?.otherProperty}"/>
    </td>
</tr>
</tbody>
</table>
</div>

</div>

<div id="step-3">
    <h2 class="StepTitle">3. Professional Information</h2>

    <div class="dialog">
        <table>
            <tbody>
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="eduCat">Education Category:</label><span class="mand">*</span>
                </td>
                <td valign="top" class="value">
                    <g:select name="eduCat" class="required"
                              from="${['Below SSC','SSC (10th equivalent)', 'HSC (12th equivalent)', 'Undergraduate', 'Diploma(or equivalent)', 'Graduate', 'Post Graduate', 'Doctorate']}"
                              value="${mbProfile?.eduCat}" noSelection="['':'Select One']"/>
                </td>
            </tr>
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="eduQual">Qualifications:</label><span class="mand">*</span>
                </td>
                <td valign="top" class="value">
                    <g:textField name="eduQual" maxlength="30" placeholder="Enter your qualification here" required="required"
                                 value="${mbProfile?.eduQual}"/>
                </td>
            </tr>
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="occupationStatus">Occupation Status:</label><span class="mand">*</span>
                </td>
                <td valign="top" class="value">
                    <g:select name="occupationStatus" class="required"
                              from="${['Diploma Student', 'Graduate Student', 'PostGraduate Student', 'Doctorate Student', 'Currently in Internship', 'Searching for Job', 'Establishing a Startup Company', 'Salaried', 'Business', 'Family Business']}"
                              value="${mbProfile?.occupationStatus}" noSelection="['':'Select One']"/>
                </td>
            </tr>
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="companyName">Organisation Name:</label>
                </td>
                <td valign="top" class="value">
                    <g:textField name="companyName" placeholder="Enter Company Name here" maxlength="60"
                                 value="${mbProfile?.companyName}"/>
                </td>
            </tr>
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="designation">Designation:</label>
                </td>
                <td valign="top" class="value">
                    <g:textField name="designation" placeholder="Enter your current designation here" maxlength="30"
                                 value="${mbProfile?.designation}"/>
                </td>
            </tr>
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="compAddrLine1">Company Address</label>
                </td>
                <td valign="top" class="value">
                    <g:textArea name="compAddrLine1" placeholder="Enter Address here" style="width: 35%;"
                                 value="${mbProfile?.companyAddress?.addressLine1}"/>
                </td>
            </tr>
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="compCity">City:</label>
                </td>
                <td valign="top" class="value">
                    <g:textField name="compCity" placeholder="Enter City here"
                                 value="${mbProfile?.companyAddress?.city}"/>
                </td>
            </tr>
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="compState">State:</label>
                </td>
                <td valign="top" class="value">
                    <g:select name="compState"
                              from="${['Andaman and Nicobar Islands', 'Andhra Pradesh', 'Arunachal Pradesh', 'Assam', 'Bihar', 'Chandigarh', 'Chhattisgarh', 'Dadara and Nagar Haveli', 'Daman and Diu', 'Goa', 'Gujarat', 'Haryana', 'Himachal Pradesh', 'Jammu and Kashmir', 'Jharkhand', 'Karnataka', 'Kerala', 'Lakshadweep', 'Madhya Pradesh', 'Maharashtra', 'Manipur', 'Meghalaya', 'Mizoram', 'Nagaland', 'NCT of Delhi', 'Orissa', 'Pondicherry', 'Punjab', 'Rajasthan', 'Sikkim', 'Tamil Nadu', 'Telangana', 'Tripura', 'Uttar Pradesh', 'Uttarakhand', 'West Bengal', 'Foreign State']}"
                              value="${mbProfile?.companyAddress?.state?.name}" noSelection="['':'Select One']"/>
                </td>
            </tr>
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="compPin">Pin Code:</label>
                </td>
                <td valign="top" class="value">
                    <g:textField name="compPin" placeholder="Enter Pin Code here"
                                 value="${mbProfile?.companyAddress?.pincode}"/>
                </td>
            </tr>
            </tbody>
        </table>
    </div>
</div>

<div id="step-4">
    <h2 class="StepTitle">4. Devotional Information</h2>

    <div class="dialog">
        <table>
            <tbody>
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="introductionYear">Year of Introduction to KC:</label><span class="mand">*</span>
                </td>
                <td valign="top" class="value">
                    <g:select name="introductionYear" from="${(mbProfile?.candidate?.dob ? Integer.parseInt(mbProfile?.candidate?.dob.format('yyyy')) : 1980)..Integer.parseInt(new Date().format('yyyy'))}" class="required" value="${mbProfile?.introductionYear}" noSelection="['':'Select One']"/>
                </td>
                <td valign="top" class="name">
                    <label for="introductionCentre">Introduced in which<br> Temple/ Centre:</label><span class="mand">*</span>
                </td>
                <td valign="top" class="value">
                    <g:select name="introductionCentre" from="${iskconCentres}" class="required"
                              value="${mbProfile?.introductionCentre}" noSelection="['':'Select One']"/>
                </td>
                <td valign="top" class="name">
                    <label for="frequencyOfTempleVisits">Frequency of <br>visiting the Temple:</label><span class="mand">*</span>
                </td>
                <td valign="top" class="value">
                    <g:select name="frequencyOfTempleVisits" class="required"
                              from="${['Almost Daily', 'Once or twice a week', 'Once or twice a month', 'Once or twice a year', 'Usually on all festivals', 'Usually on Sundays', 'Only specific programs']}"
                              value="${mbProfile?.frequencyOfTempleVisits}" noSelection="['':'Select One']"/>
                </td>
            </tr>
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="currentlyVisiting">Which ISKCON Temple<br>do you regularly visit:</label><span class="mand">*</span>
                </td>
                <td valign="top" class="value">
                    <g:select name="currentlyVisiting" from="${iskconCentres}" class="required"
                              value="${mbProfile?.currentlyVisiting}" noSelection="['':'Select One']"/>
                </td>
                <td valign="top" class="name">
                    <label for="regularSince">Since when are you<br>associated regularly with KC:</label><span class="mand">*</span>
                </td>
                <td valign="top" class="value">
                    <g:select name="regularSince" class="required" from="${(mbProfile?.candidate?.dob ? Integer.parseInt(mbProfile?.candidate?.dob.format('yyyy')) : 1980)..Integer.parseInt(new Date().format('yyyy'))}" value="${mbProfile?.regularSince}" noSelection="['':'Select One']"/>
                </td>
            </tr>
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="chantingSince">Chanting since:</label><span class="mand">*</span>
                </td>
                <td valign="top" class="value ${hasErrors(bean: mbProfile, field: 'dob', 'errors')}">
                    <g:select name="chantingSince" class="required" from="${(mbProfile?.candidate?.dob ? Integer.parseInt(mbProfile?.candidate?.dob.format('yyyy')) : 1980)..Integer.parseInt(new Date().format('yyyy'))}" value="${mbProfile?.chantingSince}" noSelection="['':'Select One']"/>
                </td>
                <td valign="top" class="name">
                    <label for="numberOfRounds">No.of Rounds currently<br>Chanting(Daily):</label><span class="mand">*</span>
                </td>
                <td>
                    <g:select name="numberOfRounds" placeholder="Enter number of rounds chanting currently" class="required"
                              from="${0..16}"  value="${mbProfile?.numberOfRounds}" noSelection="['':'Select One']"/>
                </td>
                <td valign="top" class="name chantingSixteenSince">
                    <label for="chantingSixteenSince">Chanting 16 rounds since:</label><span class="mand">*</span>
                </td>
                <td valign="top" class="chantingSixteenSince value ${hasErrors(bean: mbProfile, field: 'dob', 'errors')}">
                    <g:select name="chantingSixteenSince" from="${(mbProfile?.candidate?.dob ? Integer.parseInt(mbProfile?.candidate?.dob.format('yyyy')) : 1980)..Integer.parseInt(new Date().format('yyyy'))}" class="required" value="${mbProfile?.chantingSixteenSince}" noSelection="['':'Select One']"/>
                </td>
            </tr>
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="spiritualMaster">Spiritual Master<br>(Aspiring from/Initiated By)</label>
                </td>
                <td valign="top" class="value">
                    <g:select name="spiritualMaster"
                              from="${spiritualMasters}"
                              value="${mbProfile?.spiritualMaster}" noSelection="['':'Select One']"/>
                </td>
                <td valign="top" class="name">
                    <label for="firstInitiation">Date of 1st Initiation:</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: mbProfile, field: 'dob', 'errors')}">
                    <g:textField name="firstInitiation" id="firstInitiation" placeholder="Format of DD/MM/YYYY"
                                 value="${mbProfile?.firstInitiation?.format('dd/MM/yyyy')}"/>
                </td>
                <td valign="top" class="name">
                    <label for="secondInitiation">Date of 2nd Initiation:</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: mbProfile, field: 'dob', 'errors')}" colspan="2">
                    <g:textField name="secondInitiation" id="secondInitiation" placeholder="Format of DD/MM/YYYY"
                                 value="${mbProfile?.secondInitiation?.format('dd/MM/yyyy')}"/>
                </td>
            </tr>
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="regulated">Are you following 4 <br>regulative principles:</label>
                </td>
                <td valign="top" class="value">
                    <g:select name="regulated" from="${['Yes', 'No']}" value="${mbProfile?.regulated ? 'Yes':'No'}"/>
                </td>
                <td valign="top" class="name">
                    <label for="regulatedSince">If yes, since when:</label>
                </td>
                <td valign="top" class="value">
                    <g:select name="regulatedSince" from="${(mbProfile?.candidate?.dob ? Integer.parseInt(mbProfile?.candidate?.dob.format('yyyy')) : 1980)..Integer.parseInt(new Date().format('yyyy'))}" value="${mbProfile?.regulatedSince}" noSelection="['':'Select One']"/>
                </td>
                <td valign="top" class="name">
                    <label for="teacoffee">Do you take<br>tea/coffee:</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: mbProfile, field: 'legalName', 'errors')}">
                    <g:select name="teacoffee" from="${['No', 'Yes']}" value="${mbProfile?.teacoffee ? 'Yes':'No'}"/>
                </td>
            </tr>
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="oniongarlic">Do you take<br>onion/garlic:</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: mbProfile, field: 'legalName', 'errors')}">
                    <g:select name="oniongarlic" from="${['No', 'Yes']}" value="${mbProfile?.oniongarlic ? 'Yes':'No'}"/>
                </td>
                <td valign="top" class="name">
                    <label for="nonveg">Do you take<br>non-vegetarian<br>(meat,eggs,etc):</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: mbProfile, field: 'legalName', 'errors')}">
                    <g:select name="nonveg" from="${['No', 'Yes']}" value="${mbProfile?.nonveg ? 'Yes':'No'}"/>
                </td>
                <td valign="top" class="name">
                    <label for="intoxication">Do you take any<br>intoxication<br>(Smoking,drinking,etc):</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: mbProfile, field: 'legalName', 'errors')}">
                    <g:select name="intoxication" from="${['No', 'Yes']}" value="${mbProfile?.intoxication ? 'Yes':'No'}"/>
                </td>
            </tr>
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="gambling">Do you take part<br>in any type of gambling<br>(including lottery):</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: mbProfile, field: 'legalName', 'errors')}">
                    <g:select name="gambling" from="${['No', 'Yes']}" value="${mbProfile?.gambling ? 'Yes':'No'}"/>
                </td>
                <td valign="top" class="name">
                    <label for="regDetails">Elaborate, if answer to<br>any of the above 5 Q's<br>is Not 'NO':</label>
                </td>
                <td valign="top" class="value" colspan="3">
                    <g:textArea name="regDetails" maxlength="200"
                                 placeholder="Please elaborate here, if answer to any of the above 5 Q's is Not a 'No'"
                                 value="${mbProfile?.regDetails}"/>
                </td>
            </tr>
            <tr>
                <td colspan="6">
                    <fieldset>
                    <legend><b>KC Details</b></legend>
                    <table>
                    <tbody>
                    <tr class="prop">
                        <td valign="top" class="name">
                            <label for="likesInKc">Which aspect of Krishna<br>Consciousness<br> you like most:</label>
                        </td>
                        <td valign="top" class="value" colspan="2">
                            <g:textArea name="likesInKc" maxlength="255" placeholder="Enter different aspects of KC you like"
                                        value="${mbProfile?.likesInKc}"/>
                        </td>
                        <td valign="top" class="name">
                            <label for="dislikesInKc">Which aspect of Krishna<br>Consciousness<br>you do not like:</label>
                        </td>
                        <td valign="top" class="value" colspan="2">
                            <g:textArea name="dislikesInKc" maxlength="255"
                                        placeholder="Enter different aspects of KC you don't like"
                                        value="${mbProfile?.dislikesInKc}"/>
                        </td>
                    </tr>
                    <tr class="prop">
                        <td valign="top" class="name">
                            <label for="services">Various services rendered:</label><span class="mand">*</span>
                        </td>
                        <td valign="top" class="value" colspan="5">
                            <g:textArea name="services" required="required" maxlength="255"
                                         placeholder="Please mention the various services rendered by you"
                                         value="${mbProfile?.services}"/>
                        </td>
                    </tr>
                    <tr class="prop">
                        <td valign="top" class="name">
                            <label for="interests">Main Interests & Activities:</label><span class="mand">*</span>
                        </td>
                        <td valign="top" class="value" colspan="5">
                            <g:textArea name="interests" maxlength="255" placeholder="Please mention any interests" required="required"
                                         value="${mbProfile?.interests}"/>
                        </td>
                    </tr>
                    <tr class="prop">
                        <td valign="top" class="name">
                            <label for="remarks">Remarks (Anything else <br> you would like us to know):</label>
                        </td>
                        <td valign="top" class="value" colspan="5">
                            <g:textArea name="remarks" maxlength="255"
                                         placeholder="Please mention any remarks or any information you would like the Marriage Board to know"
                                         value="${mbProfile?.remarks}"/>
                        </td>
                    </tr>
                    </tbody>
                    </table>
                    </fieldset>
                </td>
                </tr>
            </tbody>
        </table>
    </div>

</div>

<div id="step-5">
<h2 class="StepTitle">5. Expecations about the partner</h2>

<div class="dialog">
<table>
<tbody>
<tr class="prop">
    <td valign="top" class="name">
        <label for="devotionalCulture">Devotional & Cultural:</label><span class="mand">*</span>

    </td>
    <td valign="top" class="value">
        <g:textArea name="devotionalCulture" maxLength="200" required="required"
                    value="${mbProfile?.devotionalCulture}"/>
    </td>
</tr>
<tr class="prop">
    <td valign="top" class="name">
        <label for="prefChanting">Preferably Chanting:</label>
    </td>
    <td valign="top" class="value">
        <g:select name="prefChanting"
                  from="${['Any','Not Chanting', 'Sometimes', 'Upto 4 rounds', 'Between 5 to 8 rounds', 'Between 9 to 12 rounds', 'Between 13 to 15 rounds', '16 rounds']}"
                  value="${mbProfile?.prefChanting}" noSelection="['':'Select One']"/>
    </td>
    <td valign="top" class="name">
        <label for="flexibleChanting">I am flexible on Chanting:</label>
    </td>
    <td>
        <g:radioGroup name="flexibleChanting" labels="['No', 'Yes']" values="[false, true]"
                      value="${mbProfile?.flexibleChanting ? mbProfile?.flexibleChanting : false }">
            <span>${it.radio} ${it.label}</span>
        </g:radioGroup>
    </td>
</tr>
<tr class="prop">
    <td valign="top" class="name">
        <label for="prefSpMaster">Preferred Spiritual Master:</label>
    </td>
    <td valign="top" class="value">
        <g:select name="prefSpMaster" class="multiple" multiple="multiple"
                  from="${spiritualMasters}"
                  value="${org.springframework.util.StringUtils.commaDelimitedListToStringArray(mbProfile?.prefSpMaster).toList()}"/>
    </td>
    <td valign="top" class="name">
        <label for="flexibleSpMaster">I am flexible on Spiritual master:</label>
    </td>
    <td>
        <g:radioGroup name="flexibleSpMaster" labels="['No', 'Yes']" values="[false, true]"
                      value="${mbProfile?.flexibleSpMaster ? mbProfile?.flexibleSpMaster : false}">
            <span>${it.radio} ${it.label}</span>
        </g:radioGroup>
    </td>
</tr>
<tr class="prop">
    <td valign="top" class="name">
        <label for="prefCentre">Preferred Centre:</label>
    </td>
    <td valign="top" class="value">
        <g:select name="prefCentre" from="${iskconCentres}" class="multiple" multiple="multiple"
                  value="${mbProfile?.prefCentre}" noSelection="['':'Select One']"/>
    </td>
    <td valign="top" class="name">
        <label for="flexibleOnCentre">I am flexible  on Centre:</label>
    </td>
    <td>
        <g:radioGroup name='flexibleOnCentre' labels="['No', 'Yes']" values="[false, true]"
                      value="${mbProfile?.flexibleCentre ? mbProfile?.flexibleCentre : false}">
            <span>${it.radio} ${it.label}</span>
        </g:radioGroup>
    </td>
</tr>

<tr class="prop">
    <td valign="top" class="name">
        <label for="prefNationality">Preferred Nationality:</label>
    </td>
    <td valign="top" class="value">
        <g:select name="prefNationality" from="${['Indian', 'Others']}" value="${mbProfile?.prefNationality}"/>
    </td>
    <td valign="top" class="name">
        <label for="flexibleNationality">I am flexible  on Nationality:</label>
    </td>
    <td>
        <g:radioGroup name="flexibleNationality" labels="['No', 'Yes']" values="[false, true]"
                      value="${mbProfile?.flexibleNationality ? mbProfile?.flexibleNationality : false}">
            <span>${it.radio} ${it.label}</span>
        </g:radioGroup>
    </td>
</tr>
<tr class="prop">
    <td valign="top" class="name">
        <label for="prefCurrentCountry">Preferred Current Country:</label>
    </td>
    <td valign="top" class="value">
        <g:select name="prefCurrentCountry" from="${['India', 'Abroad']}" value="${mbProfile?.prefCurrentCountry}"/>
    </td>
    <td valign="top" class="name">
        <label for="flexibleCurrentCountry">I am flexible on prospect's Current Country:</label>
    </td>
    <td>
        <g:radioGroup name="flexibleCurrentCountry" labels="['No', 'Yes']" values="[false, true]"
                      value="${mbProfile?.flexibleCurrentCountry ? mbProfile?.flexibleCurrentCountry : false}">
            <span>${it.radio} ${it.label}</span>
        </g:radioGroup>
    </td>
</tr>
<tr class="prop">
    <td valign="top" class="name">
        <label for="prefCulturalInfluence">Preferred Cultural Influence</label>
    </td>
    <td valign="top" class="value">
        <g:select class="multiple" name="prefCulturalInfluence" multiple="multiple"
                  from="${['Assamese','Andhraite','Bengali','Bihari','Gujarati','Himachal Pradesh','Kannadiga','Kasmiri','Konkani','Keralite','Madhya Pradesh','Manipuri','Maharashtrian','Marwari','Nepali','Oriyan','Punjabi','Sindhi','Tamilian','Typical North Indian','Typical South Indian','Typical Cosmopolitan','Typical Village','Uttar Pradesh','Urdu','Western']}"
                  value="${org.springframework.util.StringUtils.commaDelimitedListToStringArray(mbProfile?.prefCulturalInfluence).toList()}"/>
    </td>
    <td valign="top" class="name">
        <label for="flexibleCulturalInfluence">I am flexible Cultural Influence</label>
    </td>
    <td>
        <g:radioGroup name="flexibleCulturalInfluence" labels="['No', 'Yes']" values="[false, true]"
                      value="${mbProfile?.flexibleCulturalInfluence ? mbProfile?.flexibleCulturalInfluence : false}">
            <span>${it.radio} ${it.label}</span>
        </g:radioGroup>
    </td>
</tr>
<tr class="prop">
    <td valign="top" class="name">
        <label for="prefVarna">Preferred  Varna:</label>
    </td>
    <td valign="top" class="value">
        <g:select name="prefVarna" class="multiple" multiple="multiple" from="${['Brahmin', 'Kshatriya', 'Vaishya', 'Sudra','Not Known']}"
                  value="${org.springframework.util.StringUtils.commaDelimitedListToStringArray(mbProfile?.prefVarna).toList()}"/>
    </td>
    <td valign="top" class="name">
        <label for="flexibleVarna">I am flexible  on Varna:</label>
    </td>
    <td>
        <g:radioGroup name="flexibleVarna" labels="['No', 'Yes']" values="[false, true]"
                      value="${mbProfile?.flexibleVarna ? mbProfile?.flexibleVarna : false}">
            <span>${it.radio} ${it.label}</span>
        </g:radioGroup>
    </td>
</tr>
<tr class="prop">
    <td valign="top" class="name">
        <label for="prefCategory">Preferred Category:</label>
    </td>
    <td valign="top" class="value">
        <g:select name="prefCategory" class="multiple" multiple="multiple"
                  from="${['Open', 'Backward Class', 'Other Backward Class', 'Scheduled Caste', 'Scheduled Tribe', 'Nomadic Tribes','Others']}"
                  value="${org.springframework.util.StringUtils.commaDelimitedListToStringArray(mbProfile?.prefCategory).toList()}"/>
    </td>
    <td valign="top" class="name">
        <label for="flexibleCategory">I am flexible  on Category:</label>
    </td>
    <td>
        <g:radioGroup name="flexibleCategory" labels="['No', 'Yes']" values="[false, true]"
                      value="${mbProfile?.flexibleCategory ? mbProfile?.flexibleCategory : false}">
            <span>${it.radio} ${it.label}</span>
        </g:radioGroup>
    </td>
</tr>
<tr class="prop">
    <td valign="top" class="name">
        <label for="prefCaste">Preferred Caste:</label>
    </td>
    <td valign="top" class="value">
        <g:textField name="prefCaste" placeholder="Enter preferred Caste here" value="${mbProfile?.prefCaste}"/>
    </td>
    <td valign="top" class="name">
        <label for="flexibleCaste">I am flexible  on Caste:</label>
    </td>
    <td>
        <g:radioGroup name="flexibleCaste" labels="['No', 'Yes']" values="[false, true]"
                      value="${mbProfile?.flexibleCaste ? mbProfile?.flexibleCaste : false}">
            <span>${it.radio} ${it.label}</span>
        </g:radioGroup>
    </td>
</tr>
<tr class="prop">
    <td valign="top" class="name">
        <label for="prefsubCaste">Preferred Sub-Caste:</label>
    </td>
    <td valign="top" class="value">
        <g:textField name="prefsubCaste" placeholder="Enter preferred Sub Caste" value="${mbProfile?.prefsubCaste}"/>
    </td>
    <td valign="top" class="name">
        <label for="flexibleSubcaste">I am flexible  on Sub-Caste:</label>
    </td>
    <td>
        <g:radioGroup name="flexibleSubcaste" labels="['No', 'Yes']" values="[false, true]"
                      value="${mbProfile?.flexibleSubcaste ? mbProfile?.flexibleSubcaste : false}">
            <span>${it.radio} ${it.label}</span>
        </g:radioGroup>
    </td>
</tr>

<tr class="prop">
    <td valign="top" class="name">
        <label for="prefeducationCategory">Preferred Education Category:</label>
    </td>
    <td valign="top" class="value">
        <g:select name="prefeducationCategory"
                  from="${['SSC (10th equivalent)', 'HSC (12th equivalent)', 'Undergraduate', 'Diploma(or equivalent)', 'Graduate', 'Post Graduate', 'Doctorate']}"
                  value="${mbProfile?.prefeducationCategory}"/>
        <span> & above</span>
    </td>
    <td valign="top" class="name">
        <label for="flexibleEducationCat">I am flexible  on Education Category:</label>
    </td>
    <td>
        <g:radioGroup name="flexibleEducationCat" labels="['No', 'Yes']" values="[false, true]"
                      value="${mbProfile?.flexibleEducationCat ? mbProfile?.flexibleEducationCat : false}">
            <span>${it.radio} ${it.label}</span>
        </g:radioGroup>
    </td>
</tr>
<tr class="prop">
    <td valign="top" class="name">
        <label for="prefqualification">Preferred Qualifications:</label>
    </td>
    <td valign="top" class="value">
        <g:textField name="prefqualification" placeholder="Enter your qualification here"
                     value="${mbProfile?.prefqualification}"/>
    </td>
    <td valign="top" class="name">
        <label for="flexibleQualifications">I am flexible  on Qualifications:</label>
    </td>
    <td>
        <g:radioGroup name="flexibleQualifications" labels="['No', 'Yes']" values="[false, true]"
                      value="${mbProfile?.flexibleQualifications ? mbProfile?.flexibleQualifications : false}">
            <span>${it.radio} ${it.label}</span>
        </g:radioGroup>
    </td>
</tr>

<tr class="prop">
    <td valign="top" class="name">
        <label for="prefAgeDiff">Preferred Age difference:</label>
    </td>
    <td valign="top" class="value">
        <input type="text" class="slider-input" name="prefAgeDiff" id="prefAgeDiff" readonly data-min-val="0" data-max-val="10" data-min="${mbProfile?.prefAgeDiff? mbProfile?.prefAgeDiff.split(" - ")[0]: 0}" data-max="${mbProfile?.prefAgeDiff? mbProfile?.prefAgeDiff.split(" - ")[1]:10}"><span> Years</span>
        <div class="slider-range"></div>
    </td>
    <td valign="top" class="name">
        <label for="flexibleAgediff">I am flexible  on Age difference:</label>
    </td>
    <td>
        <g:radioGroup name="flexibleAgediff" labels="['No', 'Yes']" values="[false, true]"
                      value="${mbProfile?.flexibleAgediff ? mbProfile?.flexibleAgediff : false}">
            <span>${it.radio} ${it.label}</span>
        </g:radioGroup>
    </td>
</tr>
<tr class="prop">
    <td valign="top" class="name">
        <label for="prefHeight">Preferred Height:</label>
    </td>
    <td valign="top" class="value">
        <input type="text" class="slider-input" name="prefHeight" id="prefHeight" readonly data-min-val="53" data-max-val="77" data-min="${mbProfile?.prefHeight? mbProfile?.prefHeight.split(" - ")[0]:53}" data-max="${mbProfile?.prefHeight? mbProfile?.prefHeight.split(" - ")[1]:77}">
        <div class="slider-range"></div>
    </td>
    <td valign="top" class="name">
        <label for="flexibleHeight">I am flexible  on Height:</label>
    </td>
    <td>
        <g:radioGroup name="flexibleHeight" labels="['No', 'Yes']" values="[false, true]"
                      value="${mbProfile?.flexibleHeight ? mbProfile?.flexibleHeight : false}">
            <span>${it.radio} ${it.label}</span>
        </g:radioGroup>
    </td>
</tr>
<tr class="prop">
    <td valign="top" class="name">
        <label for="prefLooks">Preferred Looks:</label>
    </td>
    <td valign="top" class="value">
        <g:textField name="prefLooks" placeholder="Enter any specific looks you prefer"
                     value="${mbProfile?.prefLooks}"/>
    </td>
    <td valign="top" class="name">
        <label for="flexibleLooks">I am flexible  on Looks:</label>
    </td>
    <td>
        <g:radioGroup name="flexibleLooks" labels="['No', 'Yes']" values="[false, true]"
                      value="${mbProfile?.flexibleLooks ? mbProfile?.flexibleLooks : false}">
            <span>${it.radio} ${it.label}</span>
        </g:radioGroup>
    </td>
</tr>
<tr class="prop">
    <td valign="top" class="name">
        <label for="prefCandIncome">Preferred Candidate Income:</label>
    </td>
    <td valign="top" class="value">
        <input type="text" class="slider-input" name="prefCandIncome" id="prefCandIncome" readonly data-min-val="1" data-max-val="100" data-min="${mbProfile?.prefCandIncome? mbProfile?.prefCandIncome.split(" - ")[0]:4}" data-max="${mbProfile?.prefCandIncome? mbProfile?.prefCandIncome.split(" - ")[1]:16}"><span> Lakhs Per Annum</span>
        <div class="slider-range"></div>
    </td>
    <td valign="top" class="name">
        <label for="flexibleCandidateIncome">I am flexible  on Candidate Income:</label>
    </td>
    <td>
        <g:radioGroup name="flexibleCandidateIncome" labels="['No', 'Yes']" values="[false, true]"
                      value="${mbProfile?.flexibleCandidateIncome ? mbProfile?.flexibleCandidateIncome : false}">
            <span>${it.radio} ${it.label}</span>
        </g:radioGroup>
    </td>
</tr>
<tr class="prop">
    <td valign="top" class="name">
        <label for="prefLangKnown">Preferred Languages Known:</label>
    </td>
    <td valign="top" class="value">
        <g:select name="prefLangKnown" class="multiple" multiple="multiple"
                  from="${['Assamese', 'Bengali', 'English', 'Gujarati', 'Hindi', 'Kannada', 'Kashmiri', 'Konkani', 'Malayalam', 'Manipuri', 'Marathi', 'Marwari', 'Nepali', 'Oriya', 'Punjabi', 'Sanskrit', 'Sindhi', 'Tamil', 'Telugu', 'Urdu', 'Other Indian languages', 'Foreign languages']}"
                  value="${org.springframework.util.StringUtils.commaDelimitedListToStringArray(mbProfile?.prefLangKnown).toList()}"/>
    </td>
    <td valign="top" class="name">
        <label for="flexibleLangknown">I am flexible  on Languages known:</label>
    </td>
    <td>
        <g:radioGroup name="flexibleLangknown" labels="['No', 'Yes']" values="[false, true]"
                      value="${mbProfile?.flexibleLangknown ? mbProfile?.flexibleLangknown : false}">
            <span>${it.radio} ${it.label}</span>
        </g:radioGroup>
    </td>
</tr>
<tr class="prop">
    <td valign="top" class="name">
        <label for="prefManglik">Manglik preferences:</label>
    </td>
    <td valign="top" class="value">
        <g:select name="prefManglik" class="multiple" multiple="multiple" from="${['Not Manglik', 'Low', 'Medium', 'High']}"
                  value="${org.springframework.util.StringUtils.commaDelimitedListToStringArray(mbProfile?.prefManglik).toList()}"/>
    </td>
    <td valign="top" class="name">
        <label for="flexibleManglik">I am flexible  on Manglik aspect:</label>
    </td>
    <td>
        <g:radioGroup name="flexibleManglik" labels="['No', 'Yes']" values="[false, true]"
                      value="${mbProfile?.flexibleManglik ? mbProfile?.flexibleManglik : false}">
            <span>${it.radio} ${it.label}</span>
        </g:radioGroup>
    </td>
</tr>

<tr class="prop">
    <g:if test="${mbProfile?.candidate?.isMale}">
        <td valign="top" class="name">
            <label for="settleAbroadWorkingWife">Do you want a working wife</label>
        </td>
    </g:if>
    <g:else>
        <td valign="top" class="name">
            <label for="settleAbroadWorkingWife">Are you open to Settle Abroad after marriage</label>
        </td>
    </g:else>
    <td valign="top" class="value">
        <g:select name="settleAbroadWorkingWife" from="${['Flexible','Yes', 'No']}" value="${mbProfile?.settleAbroadWorkingWife}"/>
    </td>
</tr>
<tr class="prop">
    <td valign="top" class="name">
        <label for="otherExpectations">Any other Expectations /Remarks:</label>

    </td>
    <td valign="top" class="value">
        <g:textArea name="otherExpectations" maxlength="500" value="${mbProfile?.otherExpectations}"/>
        <span style="display:block;text-align: center">0-500 Characters</span>
    </td>
</tr>

</tbody>
</table>
</div>
</g:form>
</div>


<div id="step-6">
    <h2 class="StepTitle">6. Photograph</h2>

    <div class="dialog">
        <table>
            <tbody>
            <tr class="prop">
                <td valign="top" class="value">
                <div style="text-align: center"><img id="closeUpPrim" name="closeUpPrim" class="avatar"
                         src="${createLink(action: 'showImage', params: ['imgType': 'closePrim', entity: 'mbProfile', entityId: mbProfile?.id])}"/><br><br>
                    <g:form name="closeUpPrimForm" action="uploadImage" method="post"
                            enctype="multipart/form-data">
                        <g:hiddenField name="imgType" value="closePrim"/>
                        <label><b>Close Up (Primary)</b></label><span class="mand">*</span><br><br>
                        <input type="file" name="closeUpPrimInput" id="closeUpPrimInput"/></div>

                        <div style="font-size:0.8em; margin: 1.0em;">
                            For best results, your image should have a width-to-height ratio of 4:5.
                            For example, if your image is 80 pixels wide, it should be 100 pixels high.
                        </div>
                    </g:form>
                </td>
                <td valign="top" class="value">
                    <div style="text-align: center"><img id="closeUpSec" name="closeUpSec" class="avatar"
                         src="${createLink(action: 'showImage', params: ['imgType': 'closeSec', entity: 'mbProfile', entityId: mbProfile?.id])}"/><br><br>
                    <g:form name="closeUpSecForm" action="uploadImage" method="post"
                            enctype="multipart/form-data">
                        <g:hiddenField name="imgType" value="closeSec"/>
                        <label><b>Close Up (Secondary)</b></label><br><br>
                        <input type="file" name="closeUpSecInput" id="closeUpSecInput"/></div>

                        <div style="font-size:0.8em; margin: 1.0em;">
                            For best results, your image should have a width-to-height ratio of 4:5.
                            For example, if your image is 80 pixels wide, it should be 100 pixels high.
                        </div>
                    </g:form>
                </td>
            </tr>
            <tr class="prop">
                <td valign="top" class="value">
                <div style="text-align: center"><img id="fullPrim" name="fullPrim" class="avatar"
                         src="${createLink(action: 'showImage', params: ['imgType': 'fullPrim', entity: 'mbProfile', entityId: mbProfile?.id])}"/><br><br>
                    <g:form name="fullPrimForm" action="uploadImage" method="post"
                            enctype="multipart/form-data">
                        <g:hiddenField name="imgType" value="fullPrim"/>
                        <label><b>Full Profile (Primary)</b></label><span class="mand">*</span><br><br>
                        <input type="file" name="fullPrimInput" id="fullPrimInput"/></div>

                        <div style="font-size:0.8em; margin: 1.0em;">
                            For best results, your image should have a width-to-height ratio of 4:5.
                            For example, if your image is 80 pixels wide, it should be 100 pixels high.
                        </div>
                    </g:form>
                </td>
                <td valign="top" class="value">
                    <div style="text-align: center"><img id="fullSec" name="fullSec" class="avatar"
                         src="${createLink(action: 'showImage', params: ['imgType': '`', entity: 'mbProfile', entityId: mbProfile?.id])}"/><br><br>
                    <g:form name="fullSecForm" action="uploadImage" method="post"
                            enctype="multipart/form-data">
                        <g:hiddenField name="imgType" value="fullSec"/>
                        <label><b>Full Profile (Secondary)</b></label><br><br>
                        <input type="file" name="fullSecInput" id="fullSecInput"/></div>

                        <div style="font-size:0.8em; margin: 1.0em;">
                            For best results, your image should have a width-to-height ratio of 4:5.
                            For example, if your image is 80 pixels wide, it should be 100 pixels high.
                        </div>
                    </g:form>
                </td>
            </tr>
            </tbody>
        </table>
    </div>


    <h2 class="StepTitle">6a. Q's for Internal Purpose:</h2>

    <div class="dialog">
        <table>
            <tbody>
            <tr>
                <td valign="top" class="name">
                    <em>The following answers are required for internal purposes only, and will not be displayed anywhere in your bio-data:
                    </em>
                </td>
            </tr>
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="keenDevprofile">Are you very keen for a devotee profile:</label><span class="mand">*</span>
                </td>
                <td valign="top" class="value">
                    <g:select name="keenDevprofile" class="required"
                              from="${['Yes,keen on devotee profile only', 'Preferably devotee, else Upcoming devotee', 'Keen on only upcoming devotee', 'Preferably upcoming devotee, else from pious cultured family']}"
                              value="${mbProfile?.keenDevProfile}" noSelection="['':'Select One']"/>
                </td>
            </tr>
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="primdepMB">Are you primarily dependent on Marriage Board(MB) for getting matches:</label><span class="mand">*</span>
                </td>
                <td valign="top" class="value">
                    <g:select name="primdepMB" class="required"
                              from="${['Yes,very much', 'Yes, however I still have other options', 'No, MB is just one of the options', 'No, primarily searching outside']}"
                              value="${mbProfile?.primdepMB}" noSelection="['':'Select One']"/>
                </td>
            </tr>
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="regotherMB">Have you registered (will be registering) in other MB sites/Centres:</label><span class="mand">*</span>
                </td>
                <td valign="top" class="value">
                    <g:select name="regotherMB" class="required"
                              from="${['Yes,already registered', 'Yes, will be registering soon', 'No, this is the only MB I wish to register']}"
                              value="${mbProfile?.regotherMB}" noSelection="['':'Select One']"/>
                </td>
            </tr>
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="parentsSearch">Are parents simultaneously searching for a suitable candidate:</label><span class="mand">*</span>
                </td>
                <td valign="top" class="value">
                    <g:select name="parentsSearch" class="required"
                              from="${['Not started yet', 'Yes', 'No', 'Not as of now(On Hold)']}"
                              value="${mbProfile?.parentsSearch}" noSelection="['':'Select One']"/>
                </td>
            </tr>
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="profileoutsideISKCON">Are you(or your family) also searching for profiles outside of ISKCON:</label><span class="mand">*</span>
                </td>
                <td valign="top" class="value">
                    <g:select name="profileoutsideISKCON" from="${['Yes', 'No']}" class="required"
                              value="${mbProfile?.profileoutsideISKCON}"/>
                </td>
            </tr>

            </tbody>
        </table>
    </div>

    <h2 class="StepTitle">6b. Q's from MB:</h2>

    <div class="dialog">
        <table>
            <tbody>
            <tr>
                <td valign="top" class="name">
                    <em>The following questions  & their answers will not be displayed anywhere in your bio-data, and will be shared cautiously only if required:
                    </em>
                </td>
            </tr>
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="financialDiff">Any financial difficulties(inherited loan) at home:</label>
                </td>
                <td valign="top" class="value">
                    <g:textArea name="financialDiff" maxlength="200"
                                 placeholder="Enter any financial difficulties at home"
                                 value="${mbProfile?.financialDiff}"/>
                </td>
            </tr>
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="physicalMental">Any physical or mental problems either you or your family members are undergoing:</label>
                </td>
                <td valign="top" class="value">
                    <g:textArea name="physicalMental" maxlength="200"
                                 placeholder="Enter any physical or mental problems at home"
                                 value="${mbProfile?.physicalMental}"/>
                </td>
            </tr>
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="depLifelong">Any dependent other than parents that you have to take care life long:</label>
                </td>
                <td valign="top" class="value">
                    <g:textArea name="depLifelong" maxlength="200"
                                 placeholder="Enter any dependent info who needs to be taken care life long"
                                 value="${mbProfile?.depLifelong}"/>
                </td>
            </tr>

            </tbody>
        </table>
    </div>
</div> <!-- for step 6 -->

</div>
<!-- End SmartWizard Content -->

</td></tr>
</table>

</div>

<script type="text/javascript">
    function processSubmit(){
        validateAllSteps();
    }
    function validateStep(validateSection) {
        var isStepValid = true;
        $("#culturalInfluence").validate({
            rules:{
                name: "required"
            }
        });
        validateSection.find('input').each(function(){
            if(!$(this).valid()){
                isStepValid=false;
            }
        });
        validateSection.find('textarea').each(function(){
            if(!$(this).valid()){
                isStepValid=false;
            }
        });
        validateSection.find('select').each(function(){
            if(!$(this).valid()){
                isStepValid=false;
            }
        });
        return isStepValid;
    }

    function validateAllSteps() {
        var formValid = true;
        $('.anchor li a').each(function(){
            formValid = validateStep($($(this).attr('href')));
            return formValid
        })
        if(formValid) {
            $('#formSubmit').click();
        }
        else{
            $('.errMsgWrap').empty().append('<div class="message" role="status" style="color:red">Some of the Mandatory fields are not filled out. Please fill the same to complete your profile.</div>')
        }
    }

    $(document).ready(function () {
        // Smart Wizard
        $('#wizard').smartWizard({
            enableFinishButton : true,
            keyNavigation : false,
            enableAllSteps : true,
            labelFinish: 'Save',
            onFinish: onFinishCallback
        });


        $( "#MarkIncomleteForm" ).dialog({
            autoOpen: false,
            modal: true,
            buttons: {
                "Done": function() {
                    var url = "${createLink(controller:'Mb',action:'updateProfileStatus')}";

                    // post data
                    $.post(url, {
                        mbMessage: $('#msgArea').val(),
                        id: $('#id').val(),
                        status: 'INCOMPLETE'
                        } , function(returnData){
                        //alert(returnData);
                        $( "#MarkIncomleteForm" ).dialog( "close" )
                    });

                    $( this ).dialog( "close" );
                },
                "Cancel": function() {
                    $( this ).dialog( "close" );
                }
            },
            close: function() {

            }
        });

        setTimeout(function(){
            if($('#finishShow').val() == "true")
                $('.buttonFinish').show();
            else
                $('.buttonFinish').hide();
        },0);

        $('.multiple').multiselect({
            noneSelectedText: 'Select One/More option',
            menuWidth: 225,
            checkAllText: 'Select All',
            uncheckAllText: 'Select None',
            selectedList: 40
        });

        $('#numberOfRounds').change(function(){
           if($(this).val() == 16 ){
               $('.chantingSixteenSince').show();
               $('#chantingSixteenSince').addClass('required');
           }
            else{
               $('#chantingSixteenSince').val('Select One').removeClass('required');
               $('.chantingSixteenSince').hide();
           }
        }).trigger('change');

        initSliders();

        $('#mainForm').removeAttr('novalidate');

        function onFinishCallback() {
            if($('#stat').val() == 'STARTED') {
                $('#mainForm').attr('novalidate', 'novalidate');
                $('#formSubmitSilent').click();
            }
            else{
                processSubmit();
            }
        }

        $('#closeUpPrimInput').live('change', function () {
            $("#closeUpPrimForm").ajaxForm({
                success: function(){
                    $("#closeUpPrim").attr('src',$("#closeUpPrim").attr('src')+'&timestamp='+new Date().getTime());
                }
            }).submit();
        });

        $('#closeUpSecInput').live('change', function () {
            $("#closeUpSecForm").ajaxForm({
                success: function () {
                    $("#closeUpSec").attr('src',$("#closeUpSec").attr('src')+'&timestamp='+new Date().getTime());
                }
            }).submit();
        });

        $('#fullPrimInput').live('change', function () {
            $("#fullPrimForm").ajaxForm({
                success: function(){
                    $("#fullPrim").attr('src',$("#fullPrim").attr('src')+'&timestamp='+new Date().getTime());
                }
            }).submit();
        });

        $('#fullSecInput').live('change', function () {
            $("#fullSecForm").ajaxForm({
                success: function () {
                    $("#fullSec").attr('src',$("#fullSec").attr('src')+'&timestamp='+new Date().getTime());
                }
            }).submit();
        });

        var showMessage = function (msg) {
            // of course, you wouldn't use alert,
            // but would inject the message into the dom somewhere
            alert(msg);
        }
        $("#dob").datepicker({
            changeMonth: true,
            changeYear: true,
            yearRange: '1975:2050',
            dateFormat: 'dd/mm/yy',
            minDate: new Date(1975, 10 - 1, 25)
        }).change(function(){
            var birthDate = $(this).datepicker('getDate');
            var nowDate = new Date();
            $("#firstInitiation,#secondInitiation").datepicker('destroy').datepicker({
                changeMonth: true,
                changeYear: true,
                maxDate: nowDate,
                minDate: birthDate,
                yearRange: birthDate.getFullYear() + ':' + nowDate.getFullYear(),
                dateFormat: 'dd/mm/yy'
            });
            $('#introductionYear,#regularSince,#chantingSince,#regulatedSince,#chantingSixteenSince').empty().append($('<option />').val('').html('Select One'));
            for(var i = birthDate.getFullYear();i <= nowDate.getFullYear(); i++){
                $('#introductionYear,#regularSince,#chantingSince,#regulatedSince,#chantingSixteenSince').append($('<option />').val(i).html(i));
            }
        });
        $("#firstInitiation,#secondInitiation").datepicker({
            changeMonth: true,
            changeYear: true,
            maxDate: new Date(),
            minDate: $('#dob').datepicker('getDate') || new Date(),
            dateFormat: 'dd/mm/yy'
        });
        $('#tob').timepicker({
            timeFormat: 'hh:mm:ss',
            controlType: 'select',
            showSecond: true,
            showButtonPanel: false
        });

        $("#isMale").change(function(){
            if($(this).val().trim()==='MALE')
                $("label[for='settleAbroadWorkingWife']").html("Do you want a working wife");
            else
                $("label[for='settleAbroadWorkingWife']").html("Are you open to Settle Abroad after marriage");
        });
    });
    function initSliders(){
        $(".slider-range").each(function() {
            var slideInput = $(this).siblings();
            $(this).slider({
                range: true,
                min: slideInput.data('min-val'),
                max: slideInput.data('max-val'),
                values: [slideInput.data('min'), slideInput.data('max')],
                step: slideInput.data('step') || 1,
                slide: function (event, ui) {
                var slideInput = $(this).siblings();
                    if(slideInput.attr('id')=='prefHeight'){
                        slideInput.val(Math.floor(ui.values[0]/12) + '"' + ui.values[0]%12 + "'" + " - " + Math.floor(ui.values[1]/12) + '"' + ui.values[1]%12 + "'");
                    }
                    else{
                        slideInput.val(ui.values[0] + " - " + ui.values[1]);
                    }
                }
            });
            if(slideInput.attr('id')=='prefHeight'){
                slideInput.val(Math.floor($(this).slider( "values", 0 )/12) + '"' + $(this).slider( "values", 0 )%12 + "'" + " - " + Math.floor($(this).slider( "values", 1 )/12) + '"' + $(this).slider( "values", 1 )%12 + "'");
            }
            else{
                slideInput.val($(this).slider("values",0) + " - " + $(this).slider("values",1));
            }
            slideInput.attr('size',slideInput.val().length);
        });
    }
</script>

</body>
</html>
