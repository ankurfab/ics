
<%@ page import="ics.*" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<title>Candidate Profile</title>
		<r:require module="wizard"/>
	</head>
	<body>
	    <g:javascript src="jquery.form.min.js" />
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
		<sec:ifAnyGranted roles="ROLE_MB_CANDIDATE">
		    <g:if test="${mbProfile?.profileStatus != 'COMPLETE'}">
			<span class="menuButton"><g:link class="create" action="markProfileComplete">Mark Complete</g:link></span>
		    </g:if>
		 </sec:ifAnyGranted>
		<sec:ifAnyGranted roles="ROLE_MB_ADMIN,ROLE_MB_SEC">
		    <g:if test="${mbProfile?.profileStatus == 'COMPLETE'}">
			<span class="menuButton"><g:link class="create" action="updateProfileStatus" id="${mbProfile?.id}" params="['status':'INCOMPLETE']">Mark InComplete</g:link></span>
			<span class="menuButton"><g:link class="create" action="updateProfileStatus" id="${mbProfile?.id}" params="['status':'VERIFIED']">Mark Verified</g:link></span>
			<span class="menuButton"><g:link class="create" action="updateProfileStatus" id="${mbProfile?.id}" params="['status':'REJECTED']">Mark Rejected</g:link></span>
		    </g:if>
		 </sec:ifAnyGranted>
        </div>
		<div id="show-administrator" class="content scaffold-show" role="main">
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>


<g:form action="updateProfile" name="mainForm">
	<g:hiddenField name="id" value="${mbProfile?.id}" />
	<g:hiddenField name="version" value="${mbProfile?.version}" />

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
                                    <g:textField name="legalName" maxlength="127" pattern=".{10,}" validationMessage="Please enter min 10 letters!" required="required" value="${mbProfile?.candidate?.legalName}" />
                                </td>
                                <td valign="top" class="name">
                                    <label for="initiatedName">Initiated Name:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: mbProfile, field: 'initiatedName', 'errors')}">
                                    <g:textField name="initiatedName" maxlength="127" pattern=".{10,}" value="${mbProfile?.candidate?.initiatedName}" />
                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="contact">Contact Number:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: mbProfile, field: 'contact', 'errors')}">
                                    <g:textField name="contact" type="tel" value="${VoiceContact.findByCategoryAndIndividual('CellPhone',mbProfile?.candidate)?.number}" required="required"/>
                                </td>
                                <td valign="top" class="name">
                                    <label for="email">Email Address:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: mbProfile, field: 'email', 'errors')}">
                                    <g:textField name="email" type="email" value="${EmailContact.findByCategoryAndIndividual('Personal',mbProfile?.candidate)?.emailAddress}" required="required" />
                                </td>
                            </tr>                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="dob">Date/Time of Birth:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: mbProfile, field: 'dob', 'errors')}">
				    <g:datePicker name="dob" value="${mbProfile?.candidate?.dob?:new Date()}"/>
                                </td>
                                <td valign="top" class="name">
                                	Place of Birth:
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: mbProfile, field: 'dob', 'errors')}">
                                	<g:textField name="pob" value="${mbProfile?.candidate?.pob}" />
                                </td>
                            </tr>                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                	Mother Tongue:
                                </td>
                                <td valign="top" class="value">
                                	<g:textField name="motherTongue" value="${mbProfile?.candidate?.motherTongue}" />
                                </td>
                                <td valign="top" class="name">
                                	Other Languages:
                                </td>
                                <td valign="top" class="value">
                                	<g:textField name="otherLanguages" value="${mbProfile?.candidate?.otherLanguages}" />
                                </td>
                            </tr>                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                	Income (p.a.):
                                </td>
                                <td valign="top" class="value">
                                	<g:textField name="income" value="${mbProfile?.candidate?.income}" />
                                </td>
                                <td valign="top" class="name">
                                	Height (inches):
                                </td>
                                <td valign="top" class="value">
                                	<g:textField name="height" value="${mbProfile?.candidate?.height}" />
                                </td>
                            </tr>                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                	Origin:
                                </td>
                                <td valign="top" class="value">
                                	<g:textField name="origin" value="${mbProfile?.candidate?.origin}" />
                                </td>
                                <td valign="top" class="name">
                                	Caste:
                                </td>
                                <td valign="top" class="value">
                                	<g:textField name="caste" value="${mbProfile?.candidate?.caste}" />
                                </td>
                            </tr>                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                	Eg surnames:
                                </td>
                                <td valign="top" class="value">
                                	<g:textField name="egSurnames" value="${mbProfile?.candidate?.egSurnames}" />
                                </td>
                                <td valign="top" class="name">
                                </td>
                                <td valign="top" class="value">
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
                                    <label for="Houseownedrented">House is (owned/rented):</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: mbProfile, field: 'legalName', 'errors')}">
                                    <g:textField name="legalName" maxlength="20" pattern=".{10,}" required="required" value="${mbProfile?.candidate?.legalName}" />
                                </td>
                                <td valign="top" class="name">
                                    <label for="initiatedName">Area of House:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: mbProfile, field: 'initiatedName', 'errors')}">
                                    <g:textField name="initiatedName" maxlength="20" pattern=".{10,}" value="${mbProfile?.candidate?.initiatedName}" />
                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="PresentAddressline1">Present Address:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: mbProfile, field: 'legalName', 'errors')}">
                                    <g:textField name="legalName" maxlength="127" pattern=".{10,}"  value="${mbProfile?.candidate?.legalName}" />
                                </td>
                                <td valign="bottom" class="value ${hasErrors(bean: mbProfile, field: 'legalName', 'errors')}">
                                    <g:textField name="legalName" maxlength="127" pattern=".{10,}"  value="${mbProfile?.candidate?.legalName}" />
                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="PresentAddressline1">Permanent Address:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: mbProfile, field: 'legalName', 'errors')}">
                                    <g:textField name="legalName" maxlength="127" pattern=".{10,}"   />
                                </td>
                                <td valign="bottom" class="value ${hasErrors(bean: mbProfile, field: 'legalName', 'errors')}">
                                    <g:textField name="legalName" maxlength="127" pattern=".{10,}"   />
                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                	No.of Family Members:
                                </td>
                                <td valign="top" class="value">
                                	<g:textField name="income" value="${mbProfile?.candidate?.income}" />
                                </td>
                            </tr>                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="Father Name">Father's Name :</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: mbProfile, field: 'legalName', 'errors')}">
                                    <g:textField name="legalName" maxlength="30" pattern=".{10,}"  />
                                </td>
                                <td valign="top" class="name">
                                    <label for="Education & Occupation">Edu & Occu :</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: mbProfile, field: 'legalName', 'errors')}">
                                    <g:textField name="legalName" maxlength="30" pattern=".{10,}"  />
                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="Mother Name">Mother's Name :</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: mbProfile, field: 'legalName', 'errors')}">
                                    <g:textField name="legalName" maxlength="30" pattern=".{10,}"  />
                                </td>
                                <td valign="top" class="name">
                                    <label for="Education & Occupation">Edu & Occu :</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: mbProfile, field: 'legalName', 'errors')}">
                                    <g:textField name="legalName" maxlength="30" pattern=".{10,}"  />
                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="Brother Name">Brother's Name :</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: mbProfile, field: 'legalName', 'errors')}">
                                    <g:textField name="legalName" maxlength="30" pattern=".{10,}"  />
                                </td>
                                <td valign="top" class="name">
                                    <label for="Education & Occupation">Edu & Occu :</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: mbProfile, field: 'legalName', 'errors')}">
                                    <g:textField name="legalName" maxlength="30" pattern=".{10,}"  />
                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="Sister Name">Sister's Name :</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: mbProfile, field: 'legalName', 'errors')}">
                                    <g:textField name="legalName" maxlength="30" pattern=".{10,}"  />
                                </td>
                                <td valign="top" class="name">
                                    <label for="Education & Occupation">Edu & Occu :</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: mbProfile, field: 'legalName', 'errors')}">
                                    <g:textField name="legalName" maxlength="30" pattern=".{10,}"  />
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
                                    Qualification:
                                </td>
                                <td valign="top" class="value">
                                    <g:textField name="education" value="${mbProfile?.candidate?.education}" />
                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    Occupation:
                                </td>
                                <td valign="top" class="value">
                                    <g:textField name="profession" value="${mbProfile?.candidate?.profession}" />
                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    Employer Name (if working):
                                </td>
                                <td valign="top" class="value">
                                    <g:textField name="companyName" value="${mbProfile?.candidate?.companyName}" />
                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    Designation:
                                </td>
                                <td valign="top" class="value">
                                    <g:textField name="designation" value="${mbProfile?.candidate?.designation}" />
                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    Company Address:
                                </td>
                                <td valign="top" class="value">
                                    <g:textField name="companyAddress" value="${Address.findByCategoryAndIndividual('Company',mbProfile?.candidate)?.addressLine1}" />
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
                                    <label for="legalName">No.of Rounds Chanting :</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: mbProfile, field: 'legalName', 'errors')}">
                                    <g:textField name="legalName" maxlength="20" pattern=".{10,}"  />
                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="contact">Chanting Since:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: mbProfile, field: 'legalName', 'errors')}">
                                    <g:textField name="legalName" maxlength="20" pattern=".{10,}"  />
                                </td>
                            </tr>                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="contact">How did you get introduced:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: mbProfile, field: 'legalName', 'errors')}">
                                    <g:textField name="legalName" maxlength="127" pattern=".{10,}"  />
                                </td>
                            </tr>                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="contact">Year of Introduction:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: mbProfile, field: 'legalName', 'errors')}">
                                    <g:textField name="legalName" maxlength="10"   />
                                </td>
                                <td valign="top" class="name">
                                    <label for="initiatedName">Introduced in which Temple/ Centre :</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: mbProfile, field: 'initiatedName', 'errors')}">
                                    <g:textField name="initiatedName" maxlength="50"  />
                                </td>
                            </tr>                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="legalName">Which Temple are you connected with and for how long :</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: mbProfile, field: 'legalName', 'errors')}">
                                    <g:textField name="legalName" maxlength="20" pattern=".{10,}"  />
                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="legalName">Frequency of visiting the Temple :</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: mbProfile, field: 'legalName', 'errors')}">
                                    <g:textField name="legalName" maxlength="20" pattern=".{10,}"  />
                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="legalName">Services Rendered if any :</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: mbProfile, field: 'legalName', 'errors')}">
                                    <g:textField name="legalName" maxlength="20" pattern=".{10,}"  />
                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="legalName">Which aspect/s of Krishna Consciousness do you like the most :</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: mbProfile, field: 'legalName', 'errors')}">
                                    <g:textField name="legalName" maxlength="20" pattern=".{10,}"  />
                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="legalName">Which aspect/s of Krishna Consciousness do you find difficult to follow :</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: mbProfile, field: 'legalName', 'errors')}">
                                    <g:textField name="legalName" maxlength="20" pattern=".{10,}"  />
                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="contact">Do you follow 4 regulative principles :</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: mbProfile, field: 'legalName', 'errors')}">
                                    <g:textField name="legalName" maxlength="10"   />
                                </td>
                                <td valign="top" class="name">
                                    <label for="initiatedName">Since when :</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: mbProfile, field: 'initiatedName', 'errors')}">
                                    <g:textField name="initiatedName" maxlength="50"  />
                                </td>
                            </tr>                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="legalName">Do you take tea/coffee :</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: mbProfile, field: 'legalName', 'errors')}">
                                    <g:textField name="legalName" maxlength="20" pattern=".{10,}"  />
                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="legalName">Do you take any intoxication :</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: mbProfile, field: 'legalName', 'errors')}">
                                    <g:textField name="legalName" maxlength="20" pattern=".{10,}"  />
                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="legalName">Do you take onion/garlic :</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: mbProfile, field: 'legalName', 'errors')}">
                                    <g:textField name="legalName" maxlength="20" pattern=".{10,}"  />
                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="legalName">Do you take non-vegetarian :</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: mbProfile, field: 'legalName', 'errors')}">
                                    <g:textField name="legalName" maxlength="20" pattern=".{10,}"  />
                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="legalName">Do you take part in any form of gambling :</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: mbProfile, field: 'legalName', 'errors')}">
                                    <g:textField name="legalName" maxlength="20" pattern=".{10,}"  />
                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="legalName">If answer to any of the above is 'Yes', please provide more details  :</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: mbProfile, field: 'legalName', 'errors')}">
                                    <g:textField name="legalName" maxlength="20" pattern=".{10,}"  />
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
                                    Origin Preferences:
                                </td>
                                <td valign="top" class="value">
                                    <g:textField name="education" value="${mbProfile?.candidate?.education}" />
                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    Caste Preferences:
                                </td>
                                <td valign="top" class="value">
                                    <g:textField name="profession" value="${mbProfile?.candidate?.profession}" />
                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    Educational Qualification:
                                </td>
                                <td valign="top" class="value">
                                    <g:textField name="companyName" value="${mbProfile?.candidate?.companyName}" />
                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    Devotional Expectation:
                                </td>
                                <td valign="top" class="value">
                                    <g:textField name="designation" value="${mbProfile?.candidate?.designation}" />
                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    Whether working wife required (for prabhuji's):
                                </td>
                                <td valign="top" class="value">
                                    <g:textField name="companyAddress" value="${Address.findByCategoryAndIndividual('Company',mbProfile?.candidate)?.addressLine1}" />
                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    Would you mind settling outside your centre/Temple:
                                </td>
                                <td valign="top" class="value">
                                    <g:textField name="education" value="${mbProfile?.candidate?.education}" />
                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    Remarks (Anything else you would like us to know):
                                </td>
                                <td valign="top" class="value">
                                    <g:textField name="education" value="${mbProfile?.candidate?.education}" />
                                </td>
                            </tr>
                            
                        </tbody>
                    </table>
                </div>
        
        </div>
</g:form>

  	<div id="step-6">
            <h2 class="StepTitle">6. Photograph</h2>	
                 <div class="dialog">
                     <table>
                         <tbody>
                             <tr class="prop">
                                 <td valign="top" class="value">
                                     <img name="fvimage" class="avatar" src="${createLink(action:'showImage', id:mbProfile?.id,params:['imgtype':'fv'])}" />
 				  <g:form name="uploadImage" action="uploadImage" id="${mbProfile?.id}" method="post" enctype="multipart/form-data">
 				    <g:hiddenField name="type" value="fv" />
 				    <label><b>Front View Image (max 100K)</b></b></b></label>
 				    <input type="file" name="imgFile" id="imgFile" />
 				    <div style="font-size:0.8em; margin: 1.0em;">
 				      For best results, your image should have a width-to-height ratio of 4:5.
 				      For example, if your image is 80 pixels wide, it should be 100 pixels high.
 				    </div>
 				  </g:form>
                                 </td>
                                 <td valign="top" class="value">
                                     <img name="svimage" class="avatar" src="${createLink(action:'showImage', id:mbProfile?.id,params:['imgtype':'sv'])}" />
 				  <g:form name="uploadImageSV" action="uploadImage" id="${mbProfile?.id}" method="post" enctype="multipart/form-data">
 				    <g:hiddenField name="type" value="sv" />
 				    <label><b>Side View Image (max 500K)</b></b></b></label>
 				    <input type="file" name="imgFileSV" id="imgFileSV" />
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

        </div> <!-- for step 6 -->


</div>
<!-- End SmartWizard Content -->  		
 		
</td></tr>
</table>



		</div>

<script type="text/javascript">
    $(document).ready(function(){
    	// Smart Wizard 	
  		$('#wizard').smartWizard({
			onLeaveStep:leaveAStepCallback,
			onFinish:onFinishCallback
  			});
      
    function leaveAStepCallback(obj, context){
        /*alert("Leaving step " + context.fromStep + " to go to step " + context.toStep);
        return validateSteps(context.fromStep); // return false to stay on step and true to continue navigation 
        */
        return true;
    }

    function onFinishCallback(objs, context){
        $('#wizard').smartWizard('showMessage','Finish Clicked');

	<sec:ifAnyGranted roles="ROLE_MB_CANDIDATE">

        if(validateAllSteps()){
            $('#mainForm').submit();
        }
        </sec:ifAnyGranted>
    }

    // Your Step validation logic
    function validateSteps(stepnumber){
        var isStepValid = true;
        // validate step 1
        if(stepnumber == 1){
            // Your step validation logic
            // set isStepValid = false if has errors
        }
        // ...      
    }
    function validateAllSteps(){
        var isStepValid = true;
        // all step validation logic     
        return isStepValid;
    }          

	$('#imgFile').live('change', function() {
	    $("#uploadImage").ajaxForm({
		target: '#view',
		success: reloadImages
	    }).submit();
	    });

	$('#imgFileSV').live('change', function() {
	    $("#uploadImageSV").ajaxForm({
		success: function() {  alert($("#svimage").attr("src"));$("#svimage").attr("src", "&ts=" + new Date().getTime());$("#svimage").load()}
	    }).submit();	    
	    });

	function reloadImages(responseText, statusText, xhr, $form){$("#fvimage").reload();}		

var showMessage = function (msg) {
    // of course, you wouldn't use alert, 
    // but would inject the message into the dom somewhere
    alert(msg);
}

});
</script>


	</body>
</html>
