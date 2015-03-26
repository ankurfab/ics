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
</head>

<body>
<div class="nav">
    <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message default="Home"/></a></span>
    <sec:ifAnyGranted roles="ROLE_MB_CANDIDATE">
        <g:if test="${mbProfile?.profileStatus == 'STARTED' || mbProfile?.profileStatus == 'INCOMPLETE'}">
            <span class="menuButton"><g:link class="create" action="markProfileComplete">Submit Profile to MB</g:link></span>
        </g:if>
    </sec:ifAnyGranted>
    <sec:ifAnyGranted roles="ROLE_MB_ADMIN,ROLE_MB_SEC">
        <g:if test="${mbProfile?.profileStatus == 'SUBMITTED'}">
            <span class="menuButton"><g:link class="create" action="updateProfileStatus" id="${mbProfile?.id}"
                                             params="['status': 'INCOMPLETE']">Mark InComplete</g:link></span>
            <span class="menuButton"><g:link class="create" action="updateProfileStatus" id="${mbProfile?.id}"
                                             params="['status': 'COMPLETE']">Mark Completed</g:link></span>
            <span class="menuButton"><g:link class="create" action="updateProfileStatus" id="${mbProfile?.id}"
                                             params="['status': 'REJECTED']">Mark Rejected</g:link></span>
            <span class="menuButton"><g:link class="create" action="updateProfileStatus" id="${mbProfile?.id}"
                                             params="['status': 'DUPLICATE']">Mark Duplicate</g:link></span>
        </g:if>
    </sec:ifAnyGranted>
</div>

<div id="show-administrator" class="content scaffold-show" role="main">
<g:if test="${flash.message}">
    <div class="message" role="status">${flash.message}</div>
</g:if>


<g:form action="updateProfile" name="mainForm">
<g:hiddenField name="id" value="${mbProfile?.id}"/>
<g:hiddenField name="version" value="${mbProfile?.version}"/>
<input type="submit" hidden="hidden" id="formSubmit"/>
<g:set var="candAddr" value="${ics.Address.findByIndividualAndCategory(mbProfile.candidate,'PresentAddress')}"/>

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
                                    <label for="legalName">Legal Name:</label>
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
</td>
<td valign="top" class="name">
    <label for="isMale">Gender:</label>
</td>
<!-- Checking for adding comments -->
<td valign="top" class="value">
    <g:select name="isMale" from="${['MALE', 'FEMALE']}" value="${mbProfile?.candidate?.isMale ? 'MALE' : 'FEMALE'}"/>
</td>
</tr>
<tr class="prop">
    <td valign="top" class="name">
        <label for="dob">Date of Birth:</label>
    </td>
    <td valign="top" class="value ${hasErrors(bean: mbProfile, field: 'dob', 'errors')}">
        <g:textField name="dob" id="dob" placeholder="Format of DD/MM/YYYY"
                     value="${mbProfile?.candidate?.dob?.format('dd/MM/yyyy')}" required="required"/>
    </td>
    <td valign="top" class="name">
        <label for="pob">Place of Birth:</label>
    </td>
    <td valign="top" class="value ${hasErrors(bean: mbProfile, field: 'dob', 'errors')}">
        <g:textField name="pob" placeholder="Enter Actual Region with State" required="required"
                     value="${mbProfile?.candidate?.pob}"/>
    </td>
    <td valign="top" class="name">
        <label for="tob">Time of Birth:</label>
    </td>
    <td valign="top" class="value ${hasErrors(bean: mbProfile, field: 'dob', 'errors')}">

        <g:textField name="tob" id="tob" placeholder="Format of HH:MM:SS"
                     value="${mbProfile?.candidate?.dob?.format('H:m:s')}" required="required"/>
    </td>
</tr>
<tr class="prop">
    <td valign="top" class="name">
        <label for="iskconCentre">ISKCON Centre:</label>
    </td>
    <td valign="top" class="value">
        <g:textField name="iskconCentre" placeholder="Enter ISKCON Centre Name here" required="required"
                     value="${mbProfile?.candidate?.iskconCentre}"/>
    </td>
    <td valign="top" class="name">
        <label for="counselor">Counselor:</label>
    </td>
    <td valign="top" class="value">
        <g:textField name="counselor" placeholder="Enter Counselor Name here" required="required"
                     value="${mbProfile?.candCounsellor}"/>
    </td>
    <td valign="top" class="name">
        <label for="counselorAshram">Counselor is a :</label>
    </td>
    <td valign="top" class="value">
        <g:select name="counselorAshram" from="${['NA', 'Grihastha', 'Brahmacari']}"
                  value="${mbProfile?.candCounsellorAshram}"/>
    </td>
</tr>
<tr class="prop">
    <td valign="top" class="name">
        <label for="nationality">Nationality:</label>
    </td>
    <td valign="top" class="value">
        <g:select name="nationality" from="${['Indian', 'Non-Indian']}" value="${mbProfile?.candidate?.nationality}"/>
    </td>
    <td valign="top" class="name">
        <label for="originState">Origin (State/UT):</label>
    </td>
    <td valign="top" class="value">
        <g:select name="originState"
                  from="${['Andaman&Nicobar Islands', 'Andhra Pradesh', 'Arunachal Pradesh', 'Assam', 'Bihar', 'Chandigarh', 'Chhattisgarh', 'Dadara and Nagar Haveli', 'Daman and Diu', 'Goa', 'Gujarat', 'Haryana', 'Himachal Pradesh', 'Jammu and Kashmir', 'Jharkhand', 'Karnataka', 'Kerala', 'Lakshadweep', 'Madhya Pradesh', 'Maharashtra', 'Manipur', 'Meghalaya', 'Mizoram', 'Nagaland', 'NCT of Delhi', 'Orissa', 'Pondicherry', 'Punjab', 'Rajasthan', 'Sikkim', 'Tamil Nadu', 'Telangana', 'Tripura', 'Uttar Pradesh', 'Uttarakhand', 'West Bengal', 'Foreign State']}"
                  value="${mbProfile?.candidate?.origin ?: 'Maharashtra'}"/>
    </td>
    <td valign="top" class="name">
        <label for="varna">Varna, if you<br>are aware:</label>
    </td>
    <td valign="top" class="value">
        <g:select name="varna" from="${['Brahmin', 'Kshatriya', 'Vaishya', 'Sudra', 'Not Known']}"
                  value="${mbProfile?.candidate?.varna ?: 'Not Known'}"/>
    </td>
</tr>
<tr class="prop">
    <td valign="top" class="name">
        <label for="scstCategory">Category:</label>
    </td>
    <td valign="top" class="value">
        <g:select name="scstCategory"
                  from="${['General', 'Backward Class', 'Other Backward Class', 'Scheduled Caste', 'Scheduled Tribe', 'Nomadic Tribes']}"
                  value="${mbProfile?.scstCategory ?: 'Open'}"/>
    </td>
    <td valign="top" class="name">
        <label for="caste">Caste:</label>
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
        <label for="heightInFt">Height</label>
    </td>
    <td valign="top" class="value">
        <g:select name="heightInFt" from="${2..7}" value="${(mbProfile?.candidate?.height?: 2)/12}"/><span>&nbsp;ft</span>
        <g:select name="heightInInch" from="${0..11}" value="${(mbProfile?.candidate?.height?: 0)%12}"/><span>&nbsp;inches</span>
    </td>
    <td valign="top" class="name">
        <label for="weight">Weight</label>
    </td>
    <td valign="top" class="value">
        <g:select name="weight" from="${40..150}" value="${mbProfile?.weight}"/><span> Kg</span>
    </td>
    <td valign="top" class="name">
        <label for="motherTongue">Mother Tongue:</label>
    </td>
    <td valign="top" class="value">
        <g:select name="motherTongue"
                  from="${['Assamese', 'Bengali', 'English', 'Gujarati', 'Hindi', 'Kannada', 'Kashmiri', 'Konkani', 'Malayalam', 'Manipuri', 'Marathi', 'Marwari', 'Nepali', 'Oriya', 'Punjabi', 'Sanskrit', 'Sindhi', 'Tamil', 'Telugu', 'Urdu', 'Other Indian languages', 'Foreign languages']}"
                  value="${mbProfile?.candidate?.motherTongue ?: 'Marathi'}"/>
    </td>
</tr>
<tr class="prop">
    <td valign="top" class="name">
        <label for="languagesKnown">Languages <br>Known:</label>
    </td>
    <td valign="top" class="value">
        <g:select name="languagesKnown"
                  from="${['Assamese', 'Bengali', 'English', 'Gujarati', 'Hindi', 'Kannada', 'Kashmiri', 'Konkani', 'Malayalam', 'Manipuri', 'Marathi', 'Marwari', 'Nepali', 'Oriya', 'Punjabi', 'Sanskrit', 'Sindhi', 'Tamil', 'Telugu', 'Urdu', 'Other Indian languages', 'Foreign languages']}"
                  value="${mbProfile?.languagesKnown}"/>
    </td>
    <td valign="top" class="name">
        <label for="candidateIncome">Candidate's <br>Income(p.a):</label>
    </td>
    <td valign="top" class="value">
        <g:select name="candidateIncome"
                  from="${['Receiving Stipend', 'Less than 2 lakhs', 'Between 2 to 3.99 lakhs', 'Between 4 to 5.99 lakhs', 'Between 6 to 7.99 lakhs', 'Between 8 to 9.99 lakhs', 'Between 10 to 11.99 lakhs', 'Between 12 to 13.99 lakhs', 'Between 14 to 15.99 lakhs', 'Above 16 lakhs']}"
                  value="${mbProfile?.candidate?.income}"/>
    </td>
    <td valign="top" class="name">
        <label for="horoscopeToBeMatched">Horoscope<br> to be matched:</label>
    </td>
    <td valign="top" class="value">
        <g:select name="horoscopeToBeMatched" from="${['Yes', 'No', 'No Specific Choice']}"
                  value="${mbProfile?.horoscopeToBeMatched}"/>
    </td>

</tr>
<tr class="prop">
    <td valign="top" class="name">
        <label for="manglik">Manglik:</label>
    </td>
    <td valign="top" class="value">
        <g:select name="manglik" from="${['No', 'Low', 'Medium', 'High', 'Not aware']}" value="${mbProfile?.manglik}"/>
    </td>
    <td valign="top" class="name">
        <label for="addrline1">Present Address</label>
    </td>
    <td valign="top" class="value">
        <g:textArea name="addrline1" placeholder="Enter Address here" required="required" maxLength="100"
                     value="${candAddr?.addressLine1}"/>
    </td>
</tr>
<tr class="prop">
    <td valign="top" class="name">
        <label for="city">City:</label>
    </td>
    <td valign="top" class="value">
        <g:textField name="city" maxLength="20" placeholder="Enter City here" required="required"
                     value="${candAddr?.city}"/>
    </td>
    <td valign="top" class="name">
        <label for="state">State:</label>
    </td>
    <td valign="top" class="value">
        <g:select name="state"
                  from="${['Andaman&Nicobar Islands', 'Andhra Pradesh', 'Arunachal Pradesh', 'Assam', 'Bihar', 'Chandigarh', 'Chhattisgarh', 'Dadara and Nagar Haveli', 'Daman and Diu', 'Goa', 'Gujarat', 'Haryana', 'Himachal Pradesh', 'Jammu and Kashmir', 'Jharkhand', 'Karnataka', 'Kerala', 'Lakshadweep', 'Madhya Pradesh', 'Maharashtra', 'Manipur', 'Meghalaya', 'Mizoram', 'Nagaland', 'NCT of Delhi', 'Orissa', 'Pondicherry', 'Punjab', 'Rajasthan', 'Sikkim', 'Tamil Nadu', 'Telangana', 'Tripura', 'Uttar Pradesh', 'Uttarakhand', 'West Bengal', 'Foreign State']}"
                  value="${candAddr?.state?.name}"/>
    </td>
    <td valign="top" class="name">
        <label for="pincode">Pin Code:</label>
    </td>
    <td valign="top" class="value">
        <g:textField name="pincode" maxLength="6" placeholder="Enter Pin Code here"
                     value="${candAddr?.pincode}"/>
    </td>
</tr>
<tr class="prop">
    <td valign="top" class="name">
        <label for="maritalStatus">Marital Status:</label>
    </td>
    <td valign="top" class="value">
        <g:select name="maritalStatus" required="required"
                  from="${['Never Married','Divorced']}"
                  value="${mbProfile?.maritalStatus?: 'Never Married'}"/>
    </td>
    <td valign="top" class="name">
        <label for="contact">Contact Number:</label>
    </td>
    <td valign="top" class="value ${hasErrors(bean: mbProfile, field: 'contact', 'errors')}">
        <g:textField name="contact" type="tel"
                     value="${VoiceContact.findByCategoryAndIndividual('CellPhone', mbProfile?.candidate)?.number}"
                     required="required"/>
    </td>
    <td valign="top" class="name">
        <label for="email">Email Address:</label>
    </td>
    <td valign="top" class="value ${hasErrors(bean: mbProfile, field: 'email', 'errors')}">
        <g:textField name="email" type="email"
                     value="${EmailContact.findByCategoryAndIndividual('Personal', mbProfile?.candidate)?.emailAddress}"
                     required="required"/>
    </td>
</tr>
<tr class="prop">
    <td valign="top" class="name">
        <label for="references">References:</label>
    </td>
    <td valign="top" class="value">
        <g:textField name="references" maxLength="80" placeholder="Enter a Reference person who knows you"
                     value="${mbProfile?.referrer}"/>
    </td>
    <td valign="top" class="name">
        <label for="personalInfo">Any Personal or Important information you would like us to know :</label>
    </td>
    <td valign="top" class="value">
        <!--<g:textArea name="personalInfo"
                        placeholder="Enter any Personal information you would like us to know as a Marriage board"
                        value="${mbProfile?.personalInfo}"/>-->
        <g:textField name="personalInfo" maxLength="200"
                     Placeholder="Enter any Personal information you would like us to know as a Marriage board"
                     value="${mbProfile?.personalInfo}"/>
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
        <label for="nativePlace">Native Place:</label>
    </td>
    <td valign="top" class="value">
        <g:textField name="nativePlace" maxLength="40" placeholder="Enter Region of Native place" required="required"
                     value="${mbProfile?.nativePlace}"/>
    </td>
    <td valign="top" class="name">
        <label for="nativeState">Native(State):</label>
    </td>
    <td valign="top" class="value">
        <g:select name="nativeState" required="required"
                  from="${['Andaman&Nicobar Islands', 'Andhra Pradesh', 'Arunachal Pradesh', 'Assam', 'Bihar', 'Chandigarh', 'Chhattisgarh', 'Dadara and Nagar Haveli', 'Daman and Diu', 'Goa', 'Gujarat', 'Haryana', 'Himachal Pradesh', 'Jammu and Kashmir', 'Jharkhand', 'Karnataka', 'Kerala', 'Lakshadweep', 'Madhya Pradesh', 'Maharashtra', 'Manipur', 'Meghalaya', 'Mizoram', 'Nagaland', 'NCT of Delhi', 'Orissa', 'Pondicherry', 'Punjab', 'Rajasthan', 'Sikkim', 'Tamil Nadu', 'Telangana', 'Tripura', 'Uttar Pradesh', 'Uttarakhand', 'West Bengal', 'Foreign State']}"
                  value="${mbProfile?.nativeState}"/>
    </td>
    <td valign="top" class="name">
        <label for="famaddrline1">Present Address<br>of family:</label>
    </td>
    <td valign="top" class="value">
        <g:textArea name="famaddrline1" maxLength="100" placeholder="Enter Address here" required="required" value="${mbProfile?.familyAddress?.addressLine1}"/>
    </td>
</tr>
<tr class="prop">
    <td valign="top" class="name">
        <label for="permcity">City:</label>
    </td>
    <td valign="top" class="value">
        <g:textField name="permcity" maxLength="20" placeholder="Enter City here" required="required" value="${mbProfile?.familyAddress?.city}"/>
    </td>
    <td valign="top" class="name">
        <label for="familystate">State:</label>
    </td>
    <td valign="top" class="value">
        <g:select name="familystate"
                  from="${['Andaman&Nicobar Islands', 'Andhra Pradesh', 'Arunachal Pradesh', 'Assam', 'Bihar', 'Chandigarh', 'Chhattisgarh', 'Dadara and Nagar Haveli', 'Daman and Diu', 'Goa', 'Gujarat', 'Haryana', 'Himachal Pradesh', 'Jammu and Kashmir', 'Jharkhand', 'Karnataka', 'Kerala', 'Lakshadweep', 'Madhya Pradesh', 'Maharashtra', 'Manipur', 'Meghalaya', 'Mizoram', 'Nagaland', 'NCT of Delhi', 'Orissa', 'Pondicherry', 'Punjab', 'Rajasthan', 'Sikkim', 'Tamil Nadu', 'Telangana', 'Tripura', 'Uttar Pradesh', 'Uttarakhand', 'West Bengal', 'Foreign State']}"
                  value="${mbProfile?.familyAddress?.state?.name}"/>
    </td>
    <td valign="top" class="name">
        <label for="permpincode">Pin Code:</label>
    </td>
    <td valign="top" class="value">
        <g:textField name="permpincode" maxLength="6" placeholder="Enter Pin Code here" value="${mbProfile?.familyAddress?.pincode}"/>
    </td>
</tr>
<tr class="prop">
    <td valign="top" class="name">
        <label for="houseIs">Above House is:</label>
    </td>
    <td valign="top" class="value">
        <g:select name="houseIs" from="${['Owned', 'Rented', 'Others']}" value="${mbProfile?.houseIs}"/>
    </td>
    <td valign="top" class="name">
        <label for="houseArea">Area of House:<br>(sq.ft)</label>
    </td>
    <td valign="top" class="value">
        <g:textField name="houseArea" placeholder="Enter Area in sq.ft" value="${mbProfile?.houseArea}"/>
    </td>
    <td valign="top" class="name">
        <label for="otherProperty">Do you(or family) own<br> any other house/Property:</label>
    </td>
    <td valign="top" class="value">
        <g:select name="otherProperty" from="${['Yes', 'No']}" value="${mbProfile?.otherProperty}"/>
    </td>
</tr>
<tr class="prop">
    <td valign="top" class="name">
        <label for="fatherIncome">Father's <br>Income (p.a):</label>
    </td>
    <td valign="top" class="value">
        <g:select name="fatherIncome"
                  from="${['NA', 'Retired', 'Receiving Pension', 'Less than 2 lakhs', 'Between 2 to 3.99 lakhs', 'Between 4 to 5.99 lakhs', 'Between 6 to 7.99 lakhs', 'Between 8 to 9.99 lakhs', 'Between 10 to 11.99 lakhs', 'Between 12 to 13.99 lakhs', 'Between 14 to 15.99 lakhs', 'Above 16 lakhs']}"
                  value="${mbProfile?.fatherIncome}"/>
    </td>
    <td valign="top" class="name">
        <label for="otherIncome">Other Family<br> members Income (p.a):</label>
    </td>
    <td valign="top" class="value">
        <g:select name="otherIncome"
                  from="${['NA', 'Less than 2 lakhs', 'Between 2 to 4.99 lakhs', 'Between 5 to 7.99 lakhs', 'Between 8 to 11.99 lakhs', 'Between 12 to 15.99 lakhs', 'Between 16 to 19.99 lakhs', 'Between 20 to 24.99 lakhs', 'Between 25 to 29.99 lakhs', 'Above 30 lakhs']}"
                  value="${mbProfile?.otherIncome}"/>
    </td>
</tr>

<!-- Added this to make family details dynamic -->

<!-- Start of family details comment-->
<tr class="prop">
    <td valign="top" class="name">
        <label for="relativeName1">Father's Name :</label>
    </td>
    <td valign="top" class="value">
        <g:textField name="relativeName1" placeholder="Enter Father's legal Name"
                     value="${Relationship.findAllByIndividual2AndRelation(mbProfile?.candidate,Relation.findByName('Father'))[0]?.individual1?.legalName}"/>
    </td>
    <td valign="top" class="name">
        <label for="relativeEducation1">Education:</label>
    </td>
    <td valign="top" class="value">
        <g:textField name="relativeEducation1" placeholder="Enter Father's Education Name"
                     value="${Relationship.findAllByIndividual2AndRelation(mbProfile?.candidate,Relation.findByName('Father'))[0]?.individual1?.education}"/>
    </td>
    <td valign="top" class="name">
        <label for="relativeProfession1">Occupation:</label>
    </td>
    <td valign="top" class="value">
        <g:textField name="relativeProfession1" placeholder="Enter Father's Occupation here"
                     value="${Relationship.findAllByIndividual2AndRelation(mbProfile?.candidate,Relation.findByName('Father'))[0]?.individual1?.profession}"/>
    </td>
</tr>
<tr class="prop">
    <td valign="top" class="name">
        <label for="relativeName2">Mother's Name :</label>
    </td>
    <td valign="top" class="value">
        <g:textField name="relativeName2" placeholder="Enter Mother's legal Name"
                     value="${Relationship.findAllByIndividual2AndRelation(mbProfile?.candidate,Relation.findByName('Mother'))[0]?.individual1?.legalName}"/>
    </td>
    <td valign="top" class="name">
        <label for="relativeEducation2">Education:</label>
    </td>
    <td valign="top" class="value">
        <g:textField name="relativeEducation2" placeholder="Enter Mother's Education Name"
                     value="${Relationship.findAllByIndividual2AndRelation(mbProfile?.candidate,Relation.findByName('Mother'))[0]?.individual1?.education}"/>
    </td>
    <td valign="top" class="name">
        <label for="relativeProfession2">Occupation:</label>
    </td>
    <td valign="top" class="value">
        <g:textField name="relativeProfession2" placeholder="Enter Mother's Occupation here"
                     value="${Relationship.findAllByIndividual2AndRelation(mbProfile?.candidate,Relation.findByName('Mother'))[0]?.individual1?.profession}"/>
    </td>
    <g:hiddenField name="relationName2" value="Mother"/>
    <g:hiddenField name="relativeId2" value="${Relationship.findAllByIndividual2AndRelation(mbProfile?.candidate,Relation.findByName('Mother'))[0]?.individual1?.id}"/>
</tr>
<tr class="prop">
    <td valign="top" class="name">
        <label for="relativeName3">Brother's Name :</label>
    </td>
    <td valign="top" class="value">
        <g:textField name="relativeName3" placeholder="Enter Brother's legal Name"
                     value="${Relationship.findAllByIndividual2AndRelation(mbProfile?.candidate,Relation.findByName('Brother'))[0]?.individual1?.legalName}"/>
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
        <label for="relativeName4">Brother's Name :</label>
    </td>
    <td valign="top" class="value">
        <g:textField name="relativeName4" placeholder="Enter Brother's legal Name"
                     value="${Relationship.findAllByIndividual2AndRelation(mbProfile?.candidate,Relation.findByName('Brother'))[1]?.individual1?.legalName}"/>
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
        <label for="relativeName5">Brother's Name :</label>
    </td>
    <td valign="top" class="value">
        <g:textField name="relativeName5" placeholder="Enter Brother's legal Name"
                     value="${Relationship.findAllByIndividual2AndRelation(mbProfile?.candidate,Relation.findByName('Brother'))[2]?.individual1?.legalName}"/>
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
        <label for="relativeName6">Sister's Name :</label>
    </td>
    <td valign="top" class="value">
        <g:textField name="relativeName6" placeholder="Enter Sister's legal Name"
                     value="${Relationship.findAllByIndividual2AndRelation(mbProfile?.candidate,Relation.findByName('Sister'))[0]?.individual1?.legalName}"/>
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
        <label for="relativeName7">Sister's Name :</label>
    </td>
    <td valign="top" class="value">
        <g:textField name="relativeName7" placeholder="Enter Sister's legal Name"
                     value="${Relationship.findAllByIndividual2AndRelation(mbProfile?.candidate,Relation.findByName('Sister'))[1]?.individual1?.legalName}"/>
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
        <label for="relativeName8">Sister's Name :</label>
    </td>
    <td valign="top" class="value">
        <g:textField name="relativeName8" placeholder="Enter Sister's legal Name"
                     value="${Relationship.findAllByIndividual2AndRelation(mbProfile?.candidate,Relation.findByName('Sister'))[2]?.individual1?.legalName}"/>
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
        <label for="noFamilyMembers">No. of family members <br> staying at home:</label>
    </td>
    <td valign="top" class="value">
        <g:select name="noFamilyMembers" from="${0..30}" value="${mbProfile?.noFamilyMembers}"/>
    </td>
    <td valign="top" class="name">
        <label for="otherFamilyMember">Details about the family members <br>(in case of more members) :</label>
    </td>
    <td valign="top" class="value">
        <g:textArea name="otherFamilyMember"
                    placeholder="Enter any Personal information you would like us to know as a Marriage board"
                    value="${mbProfile?.otherFamilyMember}"/>
    </td>
</tr>
<tr class="prop">

    <td valign="top" class="name">
        <label for="parentsInfo">Are Parents favourable?:</label>
    </td>
    <td valign="top" class="value">
        <g:select name="parentsInfo" from="${['Yes', 'No', 'Moderate']}" value="${mbProfile?.parentsInfo}"/>
    </td>
    <td valign="top" class="name">
        <label for="parentsChanting">Parents Chanting<br>(Daily,no.of.rounds):</label>
    </td>
    <td valign="top" class="value">
        <g:select name="parentsChanting"
                  from="${['Not Chanting', 'Sometimes', 'Upto 4 rounds', 'Between 5 to 8', 'Between 9 to 12', 'Between 13 to 15', 'Chant 16 rounds', 'Above 16 rounds']}"
                  value="${mbProfile?.parentsChanting}"/>
    </td>
    <td valign="top" class="name">
        <label for="parentsInitiation">Parents Initiation<br> Status:</label>
    </td>
    <td valign="top" class="value">
        <g:select name="parentsInitiation"
                  from="${['Not Initiated', 'Aspiring for Initiation', 'In the Initiation List', 'First Initiated', 'Second Initiated', 'One parent is Initiated', 'Both are initiated']}"
                  value="${mbProfile?.parentsInitiation}"/>
    </td>
</tr>
<tr class="prop">

    <td valign="top" class="name">
        <label for="parentsSpMaster">If Parents are <br>initiated, by whom?:</label>
    </td>
    <td valign="top" class="value">
        <g:textField name="parentsSpMaster" placeholder="Enter name of Spiritual Master of your parents"
                     value="${mbProfile?.parentsSpMaster}"/>
    </td>
    <td valign="top" class="name">
        <label for="yourFamily">Have you been brought<br>up in a devotee family:</label>
    </td>
    <td valign="top" class="value">
        <g:select name="yourFamily" from="${['Yes', 'No', 'For considerable years']}" value="${mbProfile?.yourFamily}"/>
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
                    <label for="eduCat">Education Category:</label>
                </td>
                <td valign="top" class="value">
                    <g:select name="eduCat"
                              from="${['Below SSC','SSC (or equivalent)', 'HSC (or equivalent)', 'Undergraduate', 'Diploma(or equivalent)', 'Graduate', 'Post Graduate', 'Doctorate']}"
                              value="${mbProfile?.eduCat}"/>
                </td>
            </tr>
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="eduQual">Qualifications:</label>
                </td>
                <td valign="top" class="value">
                    <g:textField name="eduQual" maxlength="40" placeholder="Enter your qualification here"
                                 value="${mbProfile?.eduQual}"/>
                </td>
            </tr>
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="occupationStatus">Occupation Status:</label>
                </td>
                <td valign="top" class="value">
                    <g:select name="occupationStatus"
                              from="${['Diploma Student', 'Graduate Student', 'PostGraduate Student', 'Doctorate Student', 'Currently in Internship', 'Searching for Job', 'Establishing a Startup Company', 'Salaried', 'Business', 'Family Business']}"
                              value="${mbProfile?.occupationStatus}"/>
                </td>
            </tr>
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="companyName">Organisation Name:</label>
                </td>
                <td valign="top" class="value">
                    <g:textField name="companyName" placeholder="Enter Company Name here"
                                 value="${mbProfile?.companyName}"/>
                </td>
            </tr>
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="designation">Designation:</label>
                </td>
                <td valign="top" class="value">
                    <g:textField name="designation" placeholder="Enter your current designation here"
                                 value="${mbProfile?.designation}"/>
                </td>
            </tr>
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="compAddrLine1">Company Address</label>
                </td>
                <td valign="top" class="value">
                    <g:textArea name="compAddrLine1" placeholder="Enter Address here"
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
                              from="${['Andaman&Nicobar Islands', 'Andhra Pradesh', 'Arunachal Pradesh', 'Assam', 'Bihar', 'Chandigarh', 'Chhattisgarh', 'Dadara and Nagar Haveli', 'Daman and Diu', 'Goa', 'Gujarat', 'Haryana', 'Himachal Pradesh', 'Jammu and Kashmir', 'Jharkhand', 'Karnataka', 'Kerala', 'Lakshadweep', 'Madhya Pradesh', 'Maharashtra', 'Manipur', 'Meghalaya', 'Mizoram', 'Nagaland', 'NCT of Delhi', 'Orissa', 'Pondicherry', 'Punjab', 'Rajasthan', 'Sikkim', 'Tamil Nadu', 'Telangana', 'Tripura', 'Uttar Pradesh', 'Uttarakhand', 'West Bengal', 'Foreign State']}"
                              value="${mbProfile?.companyAddress?.state?.name}"/>
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
                    <label for="introductionYear">Year of Introduction:</label>
                </td>
                <td valign="top" class="value">
                    <g:select name="introductionYear" from="${1965..2099}" value="${mbProfile?.introductionYear}"/>
                </td>
                <td valign="top" class="name">
                    <label for="introductionCentre">Introduced in which<br> Temple/ Centre:</label>
                </td>
                <td valign="top" class="value">
                    <g:textField name="introductionCentre" placeholder="Enter ISKCON Centre Name here"
                                 value="${mbProfile?.introductionCentre}"/>
                </td>
            </tr>
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="currentlyVisiting">Which ISKCON Temple<br>do you regularly visit:</label>
                </td>
                <td valign="top" class="value">
                    <g:textField name="currentlyVisiting" placeholder="Enter ISKCON Centre Name here of connectivity "
                                 value="${mbProfile?.currentlyVisiting}"/>
                </td>
                <td valign="top" class="name">
                    <label for="regularSince">Since when are you<br>associated regularly:</label>
                </td>
                <td valign="top" class="value">
                    <g:select name="regularSince" from="${1965..2099}" value="${mbProfile?.regularSince}"/>                                  
                </td>
                <td valign="top" class="name">
                    <label for="frequencyOfTempleVisits">Frequency of <br>visiting the Temple:</label>
                </td>
                <td valign="top" class="value">
                    <g:select name="frequencyOfTempleVisits"
                              from="${['Almost Daily', 'Once or twice a week', 'Once or twice a month', 'Once or twice a year', 'Usually on all festivals', 'Usually on Sundays', 'Only specific programs']}"
                              value="${mbProfile?.frequencyOfTempleVisits}"/>
                </td>
            </tr>
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="likesInKc">Which aspect of Krishna<br>Consciousness<br> you like most:</label>
                </td>
                <td valign="top" class="value">
                    <g:textField name="likesInKc" maxlength="80" placeholder="Enter different aspects of KC you like"
                                 value="${mbProfile?.likesInKc}"/>
                </td>
                <td valign="top" class="name">
                    <label for="dislikesInKc">Which aspect of Krishna<br>Consciousness<br>you do not like:</label>
                </td>
                <td valign="top" class="value">
                    <g:textField name="dislikesInKc" maxlength="80"
                                 placeholder="Enter different aspects of KC you don't like"
                                 value="${mbProfile?.dislikesInKc}"/>
                </td>
            </tr>
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="teacoffee">Do you take<br>tea/coffee :</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: mbProfile, field: 'legalName', 'errors')}">
                    <g:select name="teacoffee" from="${['No', 'Yes']}" value="${mbProfile?.teacoffee ? 'Yes':'No'}"/>
                </td>
                <td valign="top" class="name">
                    <label for="oniongarlic">Do you take<br>onion/garlic :</label>
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
            </tr>
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="intoxication">Do you take any<br>intoxication<br>(Smoking,drinking,etc):</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: mbProfile, field: 'legalName', 'errors')}">
                    <g:select name="intoxication" from="${['No', 'Yes']}" value="${mbProfile?.intoxication ? 'Yes':'No'}"/>
                </td>
                <td valign="top" class="name">
                    <label for="gambling">Do you take part<br>in any type of gambling<br>(including lottery):</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: mbProfile, field: 'legalName', 'errors')}">
                    <g:select name="gambling" from="${['No', 'Yes']}" value="${mbProfile?.gambling ? 'Yes':'No'}"/>
                </td>
            </tr>
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="regDetails">Elaborate, if answer to<br>any of the above 6 Q's<br>is Not 'NO':</label>
                </td>
                <td valign="top" class="value">
                    <g:textField name="regDetails" maxlength="200"
                                 placeholder="Please elaborate here, if answer to any of the above 4 Q's is Not a 'No'"
                                 value="${mbProfile?.regDetails}"/>
                </td>
                <td valign="top" class="name">
                    <label for="regulated">Are you following 4 <br>regulative principles:</label>
                </td>
                <td valign="top" class="value">
                    <g:select name="regulated" from="${['Yes', 'No']}" value="${mbProfile?.regulated}"/>
                </td>
                <td valign="top" class="name">
                    <label for="regulatedSince">If yes, since when:</label>
                </td>
                <td valign="top" class="value">
                    <g:select name="regulatedSince" from="${1965..2099}" value="${mbProfile?.regulatedSince}"/>
                </td>
            </tr>
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="chantingSince">Chanting since:</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: mbProfile, field: 'dob', 'errors')}">
                    <g:select name="chantingSince" from="${1965..2099}" value="${mbProfile?.chantingSince}"/>
                </td>
                <td valign="top" class="name">
                    <label for="numberOfRounds">No.of Rounds currently<br>Chanting(Daily):</label>
                </td>
                <td>
                <g:textField name="numberOfRounds" placeholder="Enter number of rounds chanting currently"
                             value="${mbProfile?.numberOfRounds}"/>
                </td>
            </tr>
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="chantingSixteenSince">Chanting 16 rounds since:</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: mbProfile, field: 'dob', 'errors')}">
                    <g:select name="chantingSixteenSince" from="${1965..2099}" value="${mbProfile?.chantingSixteenSince}"/>
                </td>
                <td valign="top" class="name">
                    <label for="spiritualMaster">Spiritual Master<br>(Aspiring from/Initiated By)</label>
                </td>
                <td valign="top" class="value">
                    <g:textField name="spiritualMaster" maxlength="40"
                                 placeholder="Enter Name of your Spiritual Master(Aspiring from/Initiated By)"
                                 value="${mbProfile?.spiritualMaster}"/>
                </td>
            </tr>
            <tr class="prop">
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
                    <label for="services">Various services rendered:</label>
                </td>
                <td valign="top" class="value ${hasErrors(bean: mbProfile, field: 'legalName', 'errors')}">
                    <g:textField name="services" maxlength="80"
                                 placeholder="Please mention the various services rendered by you"
                                 value="${mbProfile?.services}"/>
                </td>
                <td valign="top" class="name">
                    <label for="interests">Main Interests & Activities:</label>
                </td>
                <td valign="top" class="value">
                    <g:textField name="interests" maxlength="80" placeholder="Please mention any interests"
                                 value="${mbProfile?.interests}"/>
                </td>
                <td valign="top" class="name">
                    <label for="remarks">Remarks (Anything else <br> you would like us to know):</label>
                </td>
                <td valign="top" class="value">
                    <g:textField name="remarks" maxlength="200"
                                 placeholder="Please mention any remarks or any information you would like the Marriage Board to know"
                                 value="${mbProfile?.remarks}"/>
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
        <label for="devotionalCulture">Devotional & Cultural:</label>

    </td>
    <td valign="top" class="value">
        <g:textArea name="devotionalCulture" maxLength="200"
                    value="${mbProfile?.devotionalCulture}"/>
    </td>
</tr>
<tr class="prop">
    <td valign="top" class="name">
        <label for="prefChanting">Preferably<br>Chanting:</label>
    </td>
    <td valign="top" class="value">
        <g:select name="prefChanting"
                  from="${['Not Chanting', 'Sometimes', 'Upto 4 rounds', 'Between 5 to 8 rounds', 'Between 9 to 12 rounds', 'Between 13 to 15 rounds', '16 rounds', 'Above 16 rounds']}"
                  value="${mbProfile?.prefChanting}"/>
    </td>
    <td valign="top" class="name">
        <label for="flexibleChanting">I am flexible<br> on Chanting:</label>
    </td>
    <td>
        <g:radioGroup name="flexibleChanting" labels="['No', 'Yes']" values="[false, true]"
                      value="${mbProfile?.flexibleChanting}">
            <span>${it.radio} ${it.label}</span>
        </g:radioGroup>
    </td>
</tr>
<tr class="prop">
    <td valign="top" class="name">
        <label for="prefSpMaster">Preferred<br>Aspiring<br>Spiritual Master:</label>
    </td>
    <td valign="top" class="value">
        <g:textField name="prefSpMaster" placeholder="Enter Name of Preferred aspiring Spiritual Master of Partner"
                     maxlength="40" value="${mbProfile?.prefSpMaster}"/>
    </td>
    <td valign="top" class="name">
        <label for="flexibleSpMaster">I am flexible<br> on Aspiring <br>Spiritual master:</label>
    </td>
    <td>
        <g:radioGroup name="flexibleSpMaster" labels="['No', 'Yes']" values="[false, true]"
                      value="${mbProfile?.flexibleSpMaster}">
            <span>${it.radio} ${it.label}</span>
        </g:radioGroup>
    </td>
</tr>
<tr class="prop">
    <td valign="top" class="name">
        <label for="prefCentre">Preferred<br>Centre:</label>
    </td>
    <td valign="top" class="value">
        <g:textField name="prefCentre" placeholder="Enter ISKCON Centre Name here" value="${mbProfile?.prefCentre}"/>
    </td>
    <td valign="top" class="name">
        <label for="flexibleOnCentre">I am flexible<br> on Centre:</label>
    </td>
    <td>
        <g:radioGroup name='flexibleOnCentre' labels="['No', 'Yes']" values="[false, true]"
                      value="${mbProfile?.flexibleCentre}">
            <span>${it.radio} ${it.label}</span>
        </g:radioGroup>
    </td>
</tr>

<tr class="prop">
    <td valign="top" class="name">
        <label for="prefNationality">Preferred<br>Nationality:</label>
    </td>
    <td valign="top" class="value">
        <g:select name="prefNationality" from="${['Indian', 'Non-Indian']}" value="${mbProfile?.prefNationality}"/>
    </td>
    <td valign="top" class="name">
        <label for="flexibleNationality">I am flexible<br> on Nationality:</label>
    </td>
    <td>
        <g:radioGroup name="flexibleNationality" labels="['No', 'Yes']" values="[false, true]"
                      value="${mbProfile?.flexibleNationality}">
            <span>${it.radio} ${it.label}</span>
        </g:radioGroup>
    </td>
</tr>
<tr class="prop">
    <td valign="top" class="name">
        <label for="prefOrigin">Preferred<br>Origin (State):</label>
    </td>
    <td valign="top" class="value">
        <g:select name="prefOrigin"
                  from="${['Andaman&Nicobar Islands', 'Andhra Pradesh', 'Arunachal Pradesh', 'Assam', 'Bihar', 'Chandigarh', 'Chhattisgarh', 'Dadara and Nagar Haveli', 'Daman and Diu', 'Goa', 'Gujarat', 'Haryana', 'Himachal Pradesh', 'Jammu and Kashmir', 'Jharkhand', 'Karnataka', 'Kerala', 'Lakshadweep', 'Madhya Pradesh', 'Maharashtra', 'Manipur', 'Meghalaya', 'Mizoram', 'Nagaland', 'NCT of Delhi', 'Orissa', 'Pondicherry', 'Punjab', 'Rajasthan', 'Sikkim', 'Tamil Nadu', 'Telangana', 'Tripura', 'Uttar Pradesh', 'Uttarakhand', 'West Bengal', 'Foreign State']}"
                  value="${mbProfile?.prefOrigin}"/>
    </td>
    <td valign="top" class="name">
        <label for="flexibleOrigin">I am flexible<br> on Origin(State):</label>
    </td>
    <td>
        <g:radioGroup name="flexibleOrigin" labels="['No', 'Yes']" values="[false, true]"
                      value="${mbProfile?.flexibleOrigin}">
            <span>${it.radio} ${it.label}</span>
        </g:radioGroup>
    </td>
</tr>
<tr class="prop">
    <td valign="top" class="name">
        <label for="prefVarna">Preferred<br> Varna:</label>
    </td>
    <td valign="top" class="value">
        <g:select name="prefVarna" from="${['Brahmin', 'Kshatriya', 'Vaishya', 'Sudra','Not Known']}"
                  value="${mbProfile?.prefVarna}"/>
    </td>
    <td valign="top" class="name">
        <label for="flexibleVarna">I am flexible<br> on Varna:</label>
    </td>
    <td>
        <g:radioGroup name="flexibleVarna" labels="['No', 'Yes']" values="[false, true]"
                      value="${mbProfile?.flexibleVarna}">
            <span>${it.radio} ${it.label}</span>
        </g:radioGroup>
    </td>
</tr>
<tr class="prop">
    <td valign="top" class="name">
        <label for="prefCategory">Preferred<br>Category:</label>
    </td>
    <td valign="top" class="value">
        <g:select name="prefCategory"
                  from="${['Open', 'Backward Class', 'Other Backward Class', 'Scheduled Caste', 'Scheduled Tribe', 'Nomadic Tribes','Others']}"
                  value="${mbProfile?.prefCategory}"/>
    </td>
    <td valign="top" class="name">
        <label for="flexibleCategory">I am flexible<br> on Category:</label>
    </td>
    <td>
        <g:radioGroup name="flexibleCategory" labels="['No', 'Yes']" values="[false, true]"
                      value="${mbProfile?.flexibleCategory}">
            <span>${it.radio} ${it.label}</span>
        </g:radioGroup>
    </td>
</tr>
<tr class="prop">
    <td valign="top" class="name">
        <label for="prefCaste">Preferred<br>Caste:</label>
    </td>
    <td valign="top" class="value">
        <g:textField name="prefCaste" placeholder="Enter preferred Caste here" value="${mbProfile?.prefCaste}"/>
    </td>
    <td valign="top" class="name">
        <label for="flexibleCaste">I am flexible<br> on Caste:</label>
    </td>
    <td>
        <g:radioGroup name="flexibleCaste" labels="['No', 'Yes']" values="[false, true]"
                      value="${mbProfile?.flexibleCaste}">
            <span>${it.radio} ${it.label}</span>
        </g:radioGroup>
    </td>
</tr>
<tr class="prop">
    <td valign="top" class="name">
        <label for="prefsubCaste">Preferred<br>Sub-Caste:</label>
    </td>
    <td valign="top" class="value">
        <g:textField name="prefsubCaste" placeholder="Enter preferred Sub Caste" value="${mbProfile?.prefsubCaste}"/>
    </td>
    <td valign="top" class="name">
        <label for="flexibleSubcaste">I am flexible<br> on Sub-Caste:</label>
    </td>
    <td>
        <g:radioGroup name="flexibleSubcaste" labels="['No', 'Yes']" values="[false, true]"
                      value="${mbProfile?.flexibleSubcaste}">
            <span>${it.radio} ${it.label}</span>
        </g:radioGroup>
    </td>
</tr>

<tr class="prop">
    <td valign="top" class="name">
        <label for="prefeducationCategory">Preferred<br>Education Category:</label>
    </td>
    <td valign="top" class="value">
        <g:select name="prefeducationCategory"
                  from="${['SSC(or equivalent)&above', 'HSC(or equivalent)&above', 'Diploma &above', 'Graduate &above', 'Post Graduate&above', 'Doctorate']}"
                  value="${mbProfile?.prefeducationCategory}"/>
    </td>
    <td valign="top" class="name">
        <label for="flexibleEducationCat">I am flexible<br> on Education Category:</label>
    </td>
    <td>
        <g:radioGroup name="flexibleEducationCat" labels="['No', 'Yes']" values="[false, true]"
                      value="${mbProfile?.flexibleEducationCat}">
            <span>${it.radio} ${it.label}</span>
        </g:radioGroup>
    </td>
</tr>
<tr class="prop">
    <td valign="top" class="name">
        <label for="prefqualification">Preferred<br>Qualifications:</label>
    </td>
    <td valign="top" class="value">
        <g:textField name="prefqualification" placeholder="Enter your qualification here"
                     value="${mbProfile?.prefqualification}"/>
    </td>
    <td valign="top" class="name">
        <label for="flexibleQualifications">I am flexible<br> on Qualifications:</label>
    </td>
    <td>
        <g:radioGroup name="flexibleQualifications" labels="['No', 'Yes']" values="[false, true]"
                      value="${mbProfile?.flexibleQualifications}">
            <span>${it.radio} ${it.label}</span>
        </g:radioGroup>
    </td>
</tr>

<tr class="prop">
    <td valign="top" class="name">
        <label for="prefAgeDiff">Preferred<br>Age difference:</label>
    </td>
    <td valign="top" class="value">
        <g:select name="prefAgeDiff"
                  from="${['More or less same', '6 months', '1 year', '2 years', '3 years', '4 years', '5 years', '6 years', '7 years', '8 years', '9 years', '10 years']}"
                  value="${mbProfile?.prefAgeDiff}"/>
    </td>
    <td valign="top" class="name">
        <label for="flexibleAgediff">I am flexible<br> on Age difference:</label>
    </td>
    <td>
        <g:radioGroup name="flexibleAgediff" labels="['No', 'Yes']" values="[false, true]"
                      value="${mbProfile?.flexibleAgediff}">
            <span>${it.radio} ${it.label}</span>
        </g:radioGroup>
    </td>
</tr>
<tr class="prop">
    <td valign="top" class="name">
        <label for="prefHeight">Preferred<br>Height:</label>
    </td>
    <td valign="top" class="value">
        <g:select name="prefHeight"
                  from="${['less than 5 feet', 'Between 5 to 5.4', 'Between 5.5 to 5.8', 'Between 5.9 to 6.0', 'Above 6 feet']}"
                  value="${mbProfile?.prefHeight}"/>
    </td>
    <td valign="top" class="name">
        <label for="flexibleHeight">I am flexible<br> on Height:</label>
    </td>
    <td>
        <g:radioGroup name="flexibleHeight" labels="['No', 'Yes']" values="[false, true]"
                      value="${mbProfile?.flexibleHeight}">
            <span>${it.radio} ${it.label}</span>
        </g:radioGroup>
    </td>
</tr>
<tr class="prop">
    <td valign="top" class="name">
        <label for="prefLooks">Preferred<br>Looks:</label>
    </td>
    <td valign="top" class="value">
        <g:textField name="prefLooks" placeholder="Enter any specific looks you prefer"
                     value="${mbProfile?.prefLooks}"/>
    </td>
    <td valign="top" class="name">
        <label for="flexibleLooks">I am flexible<br> on Looks:</label>
    </td>
    <td>
        <g:radioGroup name="flexibleLooks" labels="['No', 'Yes']" values="[false, true]"
                      value="${mbProfile?.flexibleLooks}">
            <span>${it.radio} ${it.label}</span>
        </g:radioGroup>
    </td>
</tr>
<tr class="prop">
    <td valign="top" class="name">
        <label for="prefCandIncome">Preferred<br>Candidate Income:</label>
    </td>
    <td valign="top" class="value">
        <g:select name="prefCandIncome"
                  from="${['Above 1 lakh', 'Above 2 lakhs', 'Above 3 lakhs', 'Above 4 lakhs', 'Above 5 lakhs', 'Above 6 lakhs', 'Above 7 lakhs', 'Above 8 lakhs', 'Above 9 lakhs', 'Above 10 lakhs', 'Above 11 lakhs', 'Above 12 lakhs', 'Above 13 lakhs', 'Above 14 lakhs', 'Above 15 lakhs', 'Above 16 lakhs']}"
                  value="${mbProfile?.prefCandIncome}"/>
    </td>
    <td valign="top" class="name">
        <label for="flexibleCandidateIncome">I am flexible<br> on Candidate Income:</label>
    </td>
    <td>
        <g:radioGroup name="flexibleCandidateIncome" labels="['No', 'Yes']" values="[false, true]"
                      value="${mbProfile?.flexibleCandidateIncome}">
            <span>${it.radio} ${it.label}</span>
        </g:radioGroup>
    </td>
</tr>
<tr class="prop">
    <td valign="top" class="name">
        <label for="PrefLangKnown">Preferred<br>Languages Known:</label>
    </td>
    <td valign="top" class="value">
        <g:select name="PrefLangKnown"
                  from="${['Assamese', 'Bengali', 'English', 'Gujarati', 'Hindi', 'Kannada', 'Kashmiri', 'Konkani', 'Malayalam', 'Manipuri', 'Marathi', 'Marwari', 'Nepali', 'Oriya', 'Punjabi', 'Sanskrit', 'Sindhi', 'Tamil', 'Telugu', 'Urdu', 'Other Indian languages', 'Foreign languages']}"
                  value="${mbProfile?.prefLangKnown}"/>
    </td>
    <td valign="top" class="name">
        <label for="flexibleLangknown">I am flexible<br> on Languages known:</label>
    </td>
    <td>
        <g:radioGroup name="flexibleLangknown" labels="['No', 'Yes']" values="[false, true]"
                      value="${mbProfile?.flexibleLangknown}">
            <span>${it.radio} ${it.label}</span>
        </g:radioGroup>
    </td>
</tr>
<tr class="prop">
    <td valign="top" class="name">
        <label for="prefManglik">Manglik<br>preferences:</label>
    </td>
    <td valign="top" class="value">
        <g:select name="prefManglik" from="${['Not Manglik', 'Low', 'Medium', 'High']}"
                  value="${mbProfile?.prefManglik}"/>
    </td>
    <td valign="top" class="name">
        <label for="flexibleManglik">I am flexible<br> on Manglik aspect:</label>
    </td>
    <td>
        <g:radioGroup name="flexibleManglik" labels="['No', 'Yes']" values="[false, true]"
                      value="${mbProfile?.flexibleManglik}">
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
        <g:select name="settleAbroadWorkingWife" from="${['Yes', 'No']}" value="${mbProfile?.settleAbroadWorkingWife}"/>
    </td>
</tr>
<tr class="prop">
    <td valign="top" class="name">
        <label for="otherExpectations">Any other Expectations<br>/Remarks:</label>

    </td>
    <td valign="top" class="value">
        <g:textArea name="otherExpectations" maxlength="200" value="${mbProfile?.otherExpectations}"/>
    </td>
</tr>

</tbody>
</table>
</div>

</div>


<div id="step-6">
    <h2 class="StepTitle">6. Photograph</h2>

    <div class="dialog">
        <table>
            <tbody>
            <tr class="prop">
                <td valign="top" class="value">
                    <div style="text-align: center"><img name="fvimage" class="avatar"
                         src="${createLink(action: 'showImage', id: mbProfile?.id, params: ['imgtype': 'fv'])}"/><br><br>
                    <g:form name="uploadImage" action="uploadImage" id="${mbProfile?.id}" method="post"
                            enctype="multipart/form-data">
                        <g:hiddenField name="type" value="fv"/>
                        <label><b>Passport Size Image (max 100K)</b></label><br><br>
                        <input type="file" name="imgFile" id="imgFile"/></div>

                        <div style="font-size:0.8em; margin: 1.0em;">
                            For best results, your image should have a width-to-height ratio of 4:5.
                            For example, if your image is 80 pixels wide, it should be 100 pixels high.
                        </div>
                    </g:form>
                </td>
                <td valign="top" class="value">
                    <div style="text-align: center"><img name="svimage" class="avatar"
                         src="${createLink(action: 'showImage', id: mbProfile?.id, params: ['imgtype': 'sv'])}"/><br><br>
                    <g:form name="uploadImageSV" action="uploadImage" id="${mbProfile?.id}" method="post"
                            enctype="multipart/form-data">
                        <g:hiddenField name="type" value="sv"/>
                        <label><b>Portfolio Image (max 500K)</b></label><br><br>
                        <input type="file" name="imgFileSV" id="imgFileSV"/></div>

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
            <tr class="prop">
                <td valign="top" class="name">
                    <em>The following answers are required for internal purposes only,<br> and will not be displayed anywhere in your bio-data:
                    </em>
                </td>
            </tr>
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="keenDevprofile">Are you very keen for a devotee profile:</label>
                </td>
                <td valign="top" class="value">
                    <g:select name="keenDevprofile"
                              from="${['Yes,keen on devotee profile only', 'Preferably devotee, else Upcoming devotee', 'Keen on only upcoming devotee', 'Preferably upcoming devotee, else from pious cultured family']}"
                              value="${mbPrPfile?.keenDevProfile}"/>
                </td>
            </tr>
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="primdepMB">Are you primarily dependent on Marriage Board(MB) for getting matches:</label>
                </td>
                <td valign="top" class="value">
                    <g:select name="primdepMB"
                              from="${['Yes,very much', 'Yes, however I still have other options', 'No, MB is just one of the options', 'No, primarily searching outside']}"
                              value="${mbProfile?.primdepMB}"/>
                </td>
            </tr>
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="regotherMB">Have you registered (will be registering) in other MB sites/Centres:</label>
                </td>
                <td valign="top" class="value">
                    <g:select name="regotherMB"
                              from="${['Yes,already registered', 'Yes, will be registering soon', 'No, this is the only MB I wish to register']}"
                              value="${mbProfile?.regotherMB}"/>
                </td>
            </tr>
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="parentsSearch">Are parents simultaneously searching for a suitable candidate:</label>
                </td>
                <td valign="top" class="value">
                    <g:select name="parentsSearch"
                              from="${['Not started yet', 'Yes', 'No', 'Not as of now(On Hold)']}"
                              value="${mbProfile?.parentsSearch}"/>
                </td>
            </tr>
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="profileoutsideISKCON">Are you(or your family) also searching for profiles outside of ISKCON:</label>
                </td>
                <td valign="top" class="value">
                    <g:select name="profileoutsideISKCON" from="${['Yes', 'No']}"
                              value="${mbProfile?.profileoutsideISKCON}"/>
                </td>
            </tr>

            </tbody>
        </table>
    </div>

    <h2 class="StepTitle">6b. Q's from MB :</h2>

    <div class="dialog">
        <table>
            <tbody>
            <tr class="prop">
                <td valign="top" class="name">
                    <em>The following questions  & their answers will not be displayed anywhere <br>in your bio-data, and will be shared cautiously only if required:
                    </em>
                </td>
            </tr>
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="financialDiff">Any financial difficulties(inherited loan) at home:</label>
                </td>
                <td valign="top" class="value">
                    <g:textField name="financialDiff" maxlength="200"
                                 placeholder="Enter any financial difficulties at home"
                                 value="${mbProfile?.financialDiff}"/>
                </td>
            </tr>
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="physicalMental">Any physical or mental problems either you or your family members are undergoing:</label>
                </td>
                <td valign="top" class="value">
                    <g:textField name="physicalMental" maxlength="200"
                                 placeholder="Enter any physical or mental problems at home"
                                 value="${mbProfile?.physicalMental}"/>
                </td>
            </tr>
            <tr class="prop">
                <td valign="top" class="name">
                    <label for="depLifelong">Any dependent other than parents that you have to take care life long:</label>
                </td>
                <td valign="top" class="value">
                    <g:textField name="depLifelong" maxlength="200"
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
</g:form>
</div>

<script type="text/javascript">
    $(document).ready(function () {
        // Smart Wizard
        $('#wizard').smartWizard({
            onLeaveStep: leaveAStepCallback,
            onFinish: onFinishCallback
        });

        function leaveAStepCallback(obj, context) {
            var stepSec=$(obj.attr('href'));
            var status=validateStep(stepSec); // return false to stay on step and true to continue navigation
            if(status)
                $('label.error').remove();
            return status;
        }

        function onFinishCallback(objs, context) {
          <sec:ifAnyGranted roles="ROLE_MB_CANDIDATE">
            validateAllSteps();
            </sec:ifAnyGranted>
        }

        function validateStep(validateSection) {
            var isStepValid = true;
            $("[name='mainForm']").validate();
            validateSection.find('input').each(function(){
                if(!$(this).valid()){
                    isStepValid=false;
                }
            });
            $("[name='mainForm']").validate();
            validateSection.find('textarea').each(function(){
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
            if(formValid)
                $('#formSubmit').click();
        }

        $('#imgFile').live('change', function () {
            $("#uploadImage").ajaxForm({
                target: '#view',
                success: reloadImages
            }).submit();
        });

        $('#imgFileSV').live('change', function () {
            $("#uploadImageSV").ajaxForm({
                success: function () {
                    alert($("#svimage").attr("src"));
                    $("#svimage").attr("src", "&ts=" + new Date().getTime());
                    $("#svimage").load()
                }
            }).submit();
        });

        function reloadImages(responseText, statusText, xhr, $form) {
            $("#fvimage").reload();
        }

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
        });
        $("#firstInitiation").datepicker({
            changeMonth: true,
            changeYear: true,
            yearRange: '1975:2050',
            dateFormat: 'dd/mm/yy',
            minDate: new Date(1965,10 - 1, 25)
        });
        $("#secondInitiation").datepicker({
            changeMonth: true,
            changeYear: true,
            yearRange: '1975:2050',
            dateFormat: 'dd/mm/yy',
            minDate: new Date(1975, 10 - 1, 25)
        });

        $("#isMale").change(function(){
            if($(this).val().trim()==='MALE')
                $("label[for='settleAbroadWorkingWife']").html("Do you want a working wife");
            else
                $("label[for='settleAbroadWorkingWife']").html("Are you open to Settle Abroad after marriage");
        });
    });
</script>

</body>
</html>
