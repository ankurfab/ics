<%@ page import="ics.*" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<title>${individualInstance?.toString()+" - Profile"}</title>
		<r:require module="jqui"/>
		<r:require module="wizard"/>
		<r:require module="ajaxform"/>
	</head>
	<body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="show" id="${individualInstance?.id}">Detailed View</g:link></span>
        </div>
		<div id="show-administrator" class="content scaffold-show" role="main">
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>

                <div class="dialog" id="dialogPhoto" >
                    <table>
                        <tbody>
                            <tr class="prop">
                                 <td valign="top" class="value">
 				  <g:form name="upload_avatar" action="upload_avatar" id="${individualInstance?.id}" method="post" enctype="multipart/form-data">
 				    <label><b>Front View Image (max 100K)</b></b></b></label>
 				    <input type="file" name="avatar" id="avatar" />
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


<g:form action="voiceupdate" name="mainForm">
	<g:hiddenField name="id" value="${individualInstance?.id}" />
	<g:hiddenField name="version" value="${individualInstance?.version}" />
	<g:hiddenField name="profile" value="true" />

<table align="center" border="0" cellpadding="0" cellspacing="0">
<tr><td> 
<!-- Smart Wizard -->
  		<div id="wizard" class="swMain">
  			<ul>
  				<li><a href="#step-1">
                <span class="stepNumber">1</span>
                <span class="stepDesc">
                  Personal Information<br />
                </span>
            </a></li>
  				<li><a href="#step-2">
                <span class="stepNumber">2</span>
                <span class="stepDesc">
                   Family Information<br />
                </span>
            </a></li>
  				<li><a href="#step-3">
                <span class="stepNumber">3</span>
                <span class="stepDesc">
                   Professional Information<br />
                </span>                   
             </a></li>
  				<li><a href="#step-4">
                <span class="stepNumber">4</span>
                <span class="stepDesc">
                   Services Rendered<br />
                </span>                   
            </a></li>
  				<li><a href="#step-5">
                <span class="stepNumber">5</span>
                <span class="stepDesc">
                   Devotional Information<br />
                </span>                   
            </a></li>
            <li><a href="#step-6">
	                    <span class="stepNumber">6</span>
	                    <span class="stepDesc">
	                       Training and Education in Krishna Consciousness<br />
	                    </span>                   
            </a></li>
  		
  			</ul>
  	<div id="step-1">	
            <h2 class="StepTitle">1. Personal Information</h2>
                <div class="dialog">
                    <table>
                        <tbody>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="legalName">Legal Name:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: individualInstance, field: 'legalName', 'errors')}">
                                    <g:textField name="legalName" maxlength="127" pattern=".{10,}" validationMessage="Please enter min 10 letters!" required="required" value="${individualInstance?.legalName}" />
                                </td>
                                 <td valign="top" class="value">
                                     <img id="photo" name="photo" class="avatar" src="${createLink(action:'avatar_image', id:individualInstance?.id)}" />
                                 </td>
                                 <td valign="top" class="value">
                                     <input class="menuButton" type="BUTTON" id="btnPhoto" value="Upload"/>
                                 </td>
                                
                            </tr>
                            <tr class="prop">
				    <td valign="top" class="name">
					<label for="dob">Date of Birth:</label>
				    </td>
				    <td valign="top" class="value ${hasErrors(bean: individualInstance, field: 'dob', 'errors')}">
					<g:textField name="dob"  value="${individualInstance?.dob?.format('dd-MM-yyyy')}"/>
				    </td>
				    <td valign="top" class="name">
					<label for="gender">Male:</label>
				    </td>
				    <td valign="top" class="value ${hasErrors(bean: individualInstance, field: 'gender', 'errors')}">
					<g:checkBox name="isMale" value="${individualInstance?.isMale}" />
				    </td>
                            </tr>                            
                            <tr class="prop">
                                 <td valign="top" class="name">
                                    <label for="mobile">Mobile:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: individualInstance, field: 'mobile', 'errors')}">
                                    <g:textField name="mobile" type="tel" value="${VoiceContact.findByCategoryAndIndividual('CellPhone',individualInstance)?.number}"/>
                                </td> 
                                <td valign="top" class="name">
				                                    <label for="home">Home(Phone):</label>
				                                </td>
				                                <td valign="top" class="value ${hasErrors(bean: individualInstance, field: 'home', 'errors')}">
				                                    <g:textField name="home" type="tel" value="${VoiceContact.findByCategoryAndIndividual('HomePhone',individualInstance)?.number}" />
                                </td> 
                                
                            </tr>  
                             <tr class="prop">
				<td valign="top" class="name">
				     <label for="emailPersonal">Email (Personal):</label>
				</td>
				   <td valign="top" class="value ${hasErrors(bean: individualInstance, field: 'emailPersonal', 'errors')}">
					<g:textField name="emailPersonal" value="${EmailContact.findByCategoryAndIndividual('Personal',individualInstance)?.emailAddress}" />
				 </td>
				    <td valign="top" class="name">
					<label for="bloodGroup">Blood Group:</label>
				    </td>
				    <td valign="top" class="value ${hasErrors(bean: individualInstance, field: 'bloodGroup', 'errors')}">
					<!--<g:textField name="bloodGroup"  value="${individualInstance?.bloodGroup}"/>-->
					<g:select name="bloodGroup" from="${['A+','A-','B+','B-','AB+','AB-','O+','O-','Unknown']}"  noSelection="['':'-Choose your blood group-']" value="${individualInstance?.bloodGroup}" />
				    </td>
                            </tr>
                            <tr class="prop">
			           <td valign="top" class="name">
			    	           <label for="languagesKnown">Languages Known:</label>
			    		</td>
			    	<td valign="top" class="value">
					<g:set var="languagesknownDone" value="${ics.IndividualLanguage.createCriteria().list{eq('individual',individualInstance)}}" />				        
							<g:select name="languagesKnown"
								from="${ics.Language.list([sort:'name'])}"
								value="${languagesknownDone?.language*.id}"
								optionKey="id" 
								multiple="true" size="30"/>
			    	    </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
        </div>
  	<div id="step-2">
            <h2 class="StepTitle">2. Family Information</h2>	
            <div class="dialog">
	                        <table>
	                            <tbody>
	                                <tr class="prop">
	                                    <td valign="top" class="name">
	                                        <label for="motherTongue">Mother Tongue:</label>
	                                    </td>
	                                    <td valign="top" class="value ${hasErrors(bean: individualInstance, field: 'motherTongue', 'errors')}">
										       <g:select name="motherTongue"
										                 from="${ics.Language.list([sort:'name'])}"
										                 value="${ics.Language.findByName(individualInstance?.motherTongue)?.id}"
										                 optionKey="id" />
	                                    </td>
	                                   
	                                   
	                                    
	                                </tr>
	                                <tr class="prop">
					    <td valign="top" class="name">
						<label for="fatherName">Father's Name:</label>
					    </td>
					    <td valign="top" class="value ${hasErrors(bean: individualInstance, field: 'fatherName', 'errors')}">
						<g:set var="fname" value="${ics.Relationship.createCriteria().list{eq('status','ACTIVE') eq('individual2',individualInstance) relation{eq('name','Father')} }[0]?.individual1?.legalName}" />
						<g:textField name="fatherName"  value="${fname}" size="50"/>
					    </td>
	                                </tr>
	                                <tr class="prop">
					    <td valign="top" class="name">
						<label for="motherName">Mother's Name:</label>
					    </td>
					    <td valign="top" class="value ${hasErrors(bean: individualInstance, field: 'motherName', 'errors')}">
						<g:set var="mname" value="${ics.Relationship.createCriteria().list{eq('status','ACTIVE') eq('individual2',individualInstance) relation{eq('name','Mother')} }[0]?.individual1?.legalName}" />
						<g:textField name="motherName"  value="${mname}" size="50"/>
					    </td>
	                                </tr>
	                                <tr class="prop">
					    <td valign="top" class="name">
						<label for="presentAddress">Present Address:</label>
					    </td>
					    <td valign="top" class="value ${hasErrors(bean: individualInstance, field: 'presentAddress', 'errors')}">
						<g:textArea name="presentAddress"  value="${Address.findByCategoryAndIndividual('Correspondence',individualInstance)?.addressLine1}" rows="3" columns="50" maxlength="255"/>
					    </td>
	                                </tr>
	                                <tr class="prop">
	                                <td valign="top" class="name">
	    			      <label for="permanentAddress">Permanent Address:</label>
	    			      </td>
	    			       	   <td valign="top" class="value ${hasErrors(bean: individualInstance, field: 'permanentAddress', 'errors')}">
	    			    	  	       <g:textArea name="permanentAddress" value="${Address.findByCategoryAndIndividual('Permanent',individualInstance)?.addressLine1}"  rows="3" columns="50" maxlength="255"/>
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
                                <label for="education">Education:</label>
                                   
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: individualInstance, field: 'education', 'errors')}">
                                    <g:textField name="education" value="${individualInstance?.education}" />
                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    Occupation:
                                </td>
                                <td valign="top" class="value">
                                    <g:textField name="profession" value="${individualInstance?.profession}" />
                                </td>
                            </tr>
                            <tr class="prop">
				    <td valign="top" class="name">
					Designation:
				    </td>
				    <td valign="top" class="value">
					<g:textField name="designation" value="${individualInstance?.designation}" />
				    </td>
                            </tr>
                            <tr class="prop">
				    <td valign="top" class="name">
				    <label for="companyName">Company Name:</label>

				    </td>
				    <td valign="top" class="value ${hasErrors(bean: individualInstance, field: 'companyName', 'errors')}">
					<g:textField name="companyName" value="${individualInstance?.companyName}" />
				    </td>
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name">
                                    Office Address:
                                </td>
                                <td valign="top" class="value">
                                    <g:textArea name="officeAddress" value="${Address.findByCategoryAndIndividual('Company',individualInstance)?.addressLine1}"   rows="3" columns="50" maxlength="255"/>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
        </div>
	<div id="step-4">
            <h2 class="StepTitle">4. Services Rendered</h2>
            <div class="dialog">
	                        <table>
	                            <tbody>
	                                <tr class="prop">
	                                    <td valign="top" class="name">
	                                    <label for="listofServices">List of services rendered till now:</label>
	                                       
	                                    </td>
	                                    <td valign="top" class="value ${hasErrors(bean: individualInstance, field: 'listofServices', 'errors')}">
						<g:set var="indSevaDone" value="${ics.IndividualSeva.createCriteria().list{eq('individual',individualInstance) seva{eq('category','Voice')}}}" />
						<g:select name="listofServices" from="${ics.Seva.findAllByCategory('Voice',[sort:'name'])}" value="${indSevaDone?.seva*.id}" optionKey="id">
						</g:select>
	                                    </td>
	                                </tr>
	                                <tr class="prop">
	                                    <td valign="top" class="name">
	                                    <label for="easyDonation"> EASY Donation (Rs. per annum):</label>
	                                       
	                                    </td>
	                                    <td valign="top" class="value">
						<g:set var="easyCommitmentVal" value="${ics.Commitment.createCriteria().list{eq('committedBy',individualInstance) scheme{eq('name','EASY')}}[0]?.committedAmount}" />
						<g:field type="number" name="easyCommitment" min="3" max="10" required="" value="${easyCommitmentVal}"/>
	                                    </td>
	                                </tr>
	                                <tr class="prop">
	    			                                    <td valign="top" class="name">
	    			                                    <label for="nityaSevaDonation"> Nitya Seva Donation (Rs. per annum):</label>
	    			                                        </td>
	    			                                    <td valign="top" class="value">
									<g:set var="nsCommitmentVal" value="${ics.Commitment.createCriteria().list{eq('committedBy',individualInstance) scheme{eq('name','Nitya Seva')}}[0]?.committedAmount}" />
									<g:field type="number" name="nsCommitment" min="3" max="10" required="" value="${nsCommitmentVal}"/>
	    			                                    </td>
	                                </tr>
	                                <tr class="prop">
	    			                                    <td valign="top" class="name">
	    			                                    <label for="indSkills">List of Krishna given talents <br />that can be engaged in His service:</label>
	    			                                              </td>
	    			                                    <td valign="top" class="value ${hasErrors(bean: individualInstance, field: 'ListofKrishnagivenTalents', 'errors')}">
									<g:set var="indSkillsDone" value="${ics.IndividualSkill.createCriteria().list{eq('individual',individualInstance) skill{eq('category','Voice')}}}" />
									<g:select name="indSkills"
										  from="${ics.Skill.findAllByCategory('Voice',[sort:'name'])}"
										  value="${indSkillsDone?.skill*.id}" optionKey="id">
									</g:select>
	    			                                    </td>
	                                </tr>
	                                
	                                
	                            </tbody>
	                        </table>
                </div>
        </div>
  	<div id="step-5">
            <h2 class="StepTitle">5. Devotional Information</h2>
            <div class="dialog">
	    	                        <table>
	    	                            <tbody>
	    	                                <tr class="prop">
	    	                                    <td valign="top" class="name">
	    	                                    <label for="introductionDate">Year of Introduction:</label>
	    	                                       
	    	                                    </td>
	    	                                    <td valign="top" class="value ${hasErrors(bean: individualInstance, field: 'yearofIntroduction', 'errors')}">
	    	                                        <g:textField name="introductionDate" value="${individualInstance?.introductionDate?.format('dd-MM-yyyy')}"/>
	    	                                    </td>
						    <td valign="top" class="name">
						    <label for="voiceDate"> Joined VOICE training program in:</label>
							</td>
						    <td valign="top" class="value">
							<g:textField name="voiceDate" value="${individualInstance?.voiceDate?.format('dd-MM-yyyy')}"/>
						    </td>
	    	                                </tr>
	    	                                <tr class="prop">
	    	                                    <td valign="top" class="name">
	    	                                    <label for="sixteenRoundsDate"> Chanting 16 rounds since:</label>
	    	                                       
	    	                                    </td>
	    	                                    <td valign="top" class="value">
	    	                                        <g:textField name="sixteenRoundsDate" value="${individualInstance?.sixteenRoundsDate?.format('dd-MM-yyyy')}"/>
	    	                                    </td>
							<td valign="top" class="name">
							  <label for="numRounds">No. of Rounds Chanting Currently:</label>
									   </td>
							 <td valign="top" class="value ${hasErrors(bean: individualInstance, field: 'numRounds', 'errors')}">
								     <g:textField name="numRounds" value="${individualInstance?.numRounds}"/>
						    </td>
	    	                                </tr>
	    	                                <tr class="prop">
	    	    			                                    <td valign="top" class="name">
	    	    			                                    <label for="firstCounselor">First Counselor:</label>
	    	    			                                              </td>
	    	    			                                    <td valign="top" class="value ${hasErrors(bean: individualInstance, field: 'FirstCounselor', 'errors')}">
										<g:set var="firstClor" value="${ics.Relationship.createCriteria().list{eq('status','FIRST') eq('individual1',individualInstance) relation{eq('name','Councellee of')}}[0]?.individual2}" />
										<g:hiddenField name="firstClorid" value=""/>
										<g:textField name="firstClor" value="${firstClor?.toString()}"/>
	    	    			                                    </td>
							                        <td valign="top" class="name">
							                          <label for="firstCentre">First Centre:</label>
							                                           </td>
							                              <td valign="top" class="value ${hasErrors(bean: individualInstance, field: 'firstVOICETemple', 'errors')}">
											<g:set var="firstCentre" value="${ics.IndividualCentre.createCriteria().list{eq('status','FIRST') eq('individual',individualInstance)}[0]?.centre}" />
											<g:hiddenField name="firstCentreid" value=""/>
											<g:textField name="firstCentre" value="${firstCentre?.toString()}"/>
							                                   </td>
	    	                                </tr>
	    	                                 <tr class="prop">
									       <td valign="top" class="name">
									             <label for="currentCounselor">Current Counselor:</label>
									         </td>
									        <td valign="top" class="value ${hasErrors(bean: individualInstance, field: 'currentCounselor', 'errors')}">
											<g:set var="currentClor" value="${ics.Relationship.createCriteria().list{eq('status','ACTIVE') eq('individual1',individualInstance) relation{eq('name','Councellee of')}}[0]?.individual2}" />
											<g:hiddenField name="currentClorid" value=""/>
											<g:textField name="currentClor" value="${currentClor?.toString()}"/>
										 </td>
										<td valign="top" class="name">
										  <label for="currentCentre">Current Centre:</label>
										   </td>
										<td valign="top" class="value ${hasErrors(bean: individualInstance, field: 'currentVOICE/Temple', 'errors')}">
										<g:set var="currentCentre" value="${ics.IndividualCentre.createCriteria().list{eq('status','ACTIVE') eq('individual',individualInstance)}[0]?.centre}" />
										<g:hiddenField name="currentCentreid" value=""/>
										<g:textField name="currentCentre" value="${currentCentre?.toString()}"/>
										   </td>
	    	                                </tr>  
	    	                             <tr class="prop">
							                        <td valign="top" class="name">
							                          <label for="firstInitiationStatus">First Initiation Status:</label>
							                                           </td>
							                         <td valign="top" class="value ${hasErrors(bean: individualInstance, field: 'firstInitiationStatus', 'errors')}">
												<g:select name="firstInitiationStatus" from="${['Aspiring From','Initiated By','Undecided']}" value="${individualInstance?.firstInitiationStatus}"
													  noSelection="['':'-First Initiation Status-']"/>	
							                                     
							                    </td>
									       <td valign="top" class="name">
									             <label for="currentGuru">Spiritual Master:</label>
									         </td>
									        <td valign="top" class="value ${hasErrors(bean: individualInstance, field: 'currentGuru', 'errors')}">
											<g:set var="currentGuru" value="${ics.Relationship.createCriteria().list{eq('status','ACTIVE') eq('individual1',individualInstance) relation{eq('name','Disciple of')}}[0]?.individual2}" />
											<g:hiddenField name="guruid" value=""/>
											<g:textField name="guru" value="${currentGuru?.toString()}"/>
										 </td>
	    	                                </tr>  
	    	                             <tr class="prop">
							                        <td valign="top" class="name">
							                          <label for="initiatedName">Initiated Name:</label>
							                                           </td>
							                         <td valign="top" class="value ${hasErrors(bean: individualInstance, field: 'initiatedName', 'errors')}">
							                                     <g:textField name="initiatedName" value="${individualInstance?.initiatedName}"/>
							                    </td>
								                   <td valign="top" class="name">
								                         <label for="firstInitiation">Date of First Initiation</label>
								                      </td>
								                       <td valign="top" class="value ${hasErrors(bean: individualInstance, field: 'firstInitiation', 'errors')}">
								                                     <g:textField name="firstInitiation" value="${individualInstance?.firstInitiation?.format('dd-MM-yyyy')}"/>
									                    </td>
	    	                                </tr>  
	    	                                 <tr class="prop">
								                   <td valign="top" class="name">
								                         <label for="secondInitiation">Date of Brahmin Initiation</label>
								                      </td>
								                       <td valign="top" class="value ${hasErrors(bean: individualInstance, field: 'secondInitiation', 'errors')}">
								                                     <g:textField name="secondInitiation" value="${individualInstance?.secondInitiation?.format('dd-MM-yyyy')}"/>
									                    </td>
	    	                                </tr>  
	    	                                <tr class="prop">
										          <td valign="top" class="name">
										                   <label for="ashram">Ashram:</label>
										                     </td>
										               <td valign="top" class="value">
												<g:select name="ashram" from="${['Brahmachari','GaurangaSabha','NityanandSabha','Undecided']}" value="${individualInstance?.ashram}"
													  noSelection="['':'-Choose your ashram-']"/>	
												</td>
								                   <td valign="top" class="name">
								                         <label for="joinAshram">Date of joining ashram: (tentative/joined)</label>
								                      </td>
								                       <td valign="top" class="value ${hasErrors(bean: individualInstance, field: 'joinAshram', 'errors')}">
								                                     <g:textField name="joinAshram" value="${individualInstance?.joinAshram?.format('dd-MM-yyyy')}"/>
									                    </td>
	    	                                </tr>
	    	                                 <tr class="prop">
						    <td valign="top" class="name">
						    <label for="roles">Groups</label>
							</td>
						    <td valign="top" class="value">
							<g:set var="currentRoles" value="${ics.IndividualRole.createCriteria().list{eq('individual',individualInstance) role{eq('category','VOICE')}}}" />
							<g:select name="roles"
								  from="${ics.Role.findAllByCategory('VOICE',[sort:'name'])}"
								  value="${currentRoles?.role*.id}"
								  optionKey="id"  multiple="true"  size="20"/>
						    </td>
	    	                                </tr>   
	    	                            </tbody>
	    	                        </table>
                </div>
        </div>
        <div id="step-6">
	            <h2 class="StepTitle">6. Training and Education in Krishna Consciousness</h2>
	            <div class="dialog">
		    	    	       <table>
	    	                            <tbody>
	    	                            <tr class="prop">
						    <td valign="top" class="name">
						    <label for="EBGCoursesDone"> EBG Courses Done</label>
							</td>
						    <td valign="top" class="value">
							<g:set var="ebgcoursesDone" value="${ics.IndividualCourse.createCriteria().list{eq('individual',individualInstance) course{eq('category','Voice') eq('type','EBG Course')}}}" />
							<g:select name="ebgcourses"
								  from="${ics.Course.findAllByCategoryAndType('Voice','EBG Course',[sort:'name'])}"
								  value="${ebgcoursesDone?.course*.id}"
								  optionKey="id"  multiple="true" size="5"/>
						    </td>
						    <td valign="top" class="name">
						    <label for="otherCourses"> Other Courses</label>
							</td>
						    <td valign="top" class="value">
							<g:set var="otherCoursesDone" value="${ics.IndividualCourse.createCriteria().list{eq('individual',individualInstance) course{eq('category','Voice') eq('type','Other Courses')}}}" />
							<g:select name="otherCourses"
								  from="${ics.Course.findAllByCategoryAndType('Voice','Other Courses',[sort:'name'])}"
								  value="${otherCoursesDone?.course*.id}"
								  optionKey="id"  multiple="true"  size="5"/>
						    </td>
	    	                                </tr>
	    	                                 <tr class="prop">
						    <td valign="top" class="name">
						    <label for="campsAttended"> Camps Attended</label>
							</td>
						    <td valign="top" class="value">
							<g:set var="campsAttendedDone" value="${ics.IndividualCourse.createCriteria().list{eq('individual',individualInstance) course{eq('category','Voice') eq('type','Camp')}}}" />
							<g:select name="campsAttended"
								  from="${ics.Course.findAllByCategoryAndType('Voice','Camp',[sort:'name'])}"
								  value="${campsAttendedDone?.course*.id}"
								  optionKey="id"  multiple="true"  size="5"/>
						    </td>
						    <td valign="top" class="name">
						    <label for="workshopsAttended"> Workshops Attended</label>
							</td>
						    <td valign="top" class="value">
							<g:set var="workshopsAttendedDone" value="${ics.IndividualCourse.createCriteria().list{eq('individual',individualInstance) course{eq('category','Voice') eq('type','Workshop')}}}" />
							<g:select name="workshopsAttended"
								  from="${ics.Course.findAllByCategoryAndType('Voice','Workshop',[sort:'name'])}"
								  value="${workshopsAttendedDone?.course*.id}"
								  optionKey="id"  multiple="true"  size="20"/>
						    </td>
	    	                                </tr>   
	    	                                <tr class="prop">
						    <td valign="top" class="name">
						    <label for="srilPrabhupadaBooksRead"> Srila Prabhupada Books read uptil now</label>
							</td>
						    <td valign="top" class="value">
							<g:set var="srilPrabhupadaBooksReadDone" value="${ics.BookRead.createCriteria().list{eq('individual',individualInstance) book{eq('author','Srila Prabhupada')}}}" />
							<g:select name="srilPrabhupadaBooksRead"
								  from="${ics.Book.findAllByAuthor('Srila Prabhupada',[sort:'name'])}"
								  value="${srilPrabhupadaBooksReadDone?.book*.id}"
								  optionKey="id"  multiple="true"  size="30"/>
						    </td>
	    	                                </tr>
	    	                                </tbody>
	    	                          </table>
	    	                          </div>
        </div>
   

  	
<!-- End SmartWizard Content -->  		
 		
</td></tr>
</table>
</g:form>



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
        if(validateAllSteps()){
            $('#mainForm').submit();
        }
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

			$("#dob").datepicker({
				yearRange : "-100:+0",
				changeMonth : true,
				changeYear : true,
				dateFormat : 'dd-mm-yy'
			});
			$("#introductionDate").datepicker({
				yearRange : "-100:+0",
				changeMonth : true,
				changeYear : true,
				dateFormat : 'dd-mm-yy'
			});
			$("#sixteenRoundsDate").datepicker({
				yearRange : "-100:+0",
				changeMonth : true,
				changeYear : true,
				dateFormat : 'dd-mm-yy'
			});
			$("#voiceDate").datepicker({
				yearRange : "-100:+0",
				changeMonth : true,
				changeYear : true,
				dateFormat : 'dd-mm-yy'
			});
			$("#firstInitiation").datepicker({
				yearRange : "-100:+0",
				changeMonth : true,
				changeYear : true,
				dateFormat : 'dd-mm-yy'
			});

			$("#secondInitiation").datepicker({
				yearRange : "-100:+0",
				changeMonth : true,
				changeYear : true,
				dateFormat : 'dd-mm-yy'
			});

			$("#joinAshram").datepicker({
				yearRange : "-50:+25",
				changeMonth : true,
				changeYear : true,
				dateFormat : 'dd-mm-yy'
			});


		$( "#firstClor" ).autocomplete({
			source: "${createLink(controller:'individual',action:'allCounsellorsAsJSON_JQ')}",
			minLength: 0,
			  select: function(event, ui) { // event handler when user selects a company from the list.
			   $("#firstClorid").val(ui.item.id); // update the hidden field.
			  }
		});          

		$( "#firstCentre" ).autocomplete({
			source: "${createLink(controller:'individual',action:'allCentresAsJSON_JQ')}",
			minLength: 0,
			  select: function(event, ui) { // event handler when user selects a company from the list.
			   $("#firstCentreid").val(ui.item.id); // update the hidden field.
			  }
		});          

		$( "#currentClor" ).autocomplete({
			source: "${createLink(controller:'individual',action:'allCounsellorsAsJSON_JQ')}",
			minLength: 0,
			  select: function(event, ui) { // event handler when user selects a company from the list.
			   $("#currentClorid").val(ui.item.id); // update the hidden field.
			  }
		});          

		$( "#currentCentre" ).autocomplete({
			source: "${createLink(controller:'individual',action:'allCentresAsJSON_JQ')}",
			minLength: 0,
			  select: function(event, ui) { // event handler when user selects a company from the list.
			   $("#currentCentreid").val(ui.item.id); // update the hidden field.
			  }
		});          

		$( "#guru" ).autocomplete({
			source: "${createLink(controller:'individual',action:'allGurusAsJSON_JQ')}",
			minLength: 0,
			  select: function(event, ui) { // event handler when user selects a company from the list.
			   $("#guruid").val(ui.item.id); // update the hidden field.
			  }
		});          

	$('#avatar').live('change', function() {
	    $("#upload_avatar").ajaxForm({
		target: '#photo',
		success: reloadImages
	    }).submit();
	    });

	function reloadImages(responseText, statusText, xhr, $form){
		var d = new Date();
		$("#photo").attr("src", "${createLink(action:'avatar_image', id:individualInstance?.id)}"+"?"+d.getTime());
		$( "#dialogPhoto" ).dialog( "close" );
	}		

		$( "#btnPhoto" )
			.button()
			.click(function() {
				$( "#dialogPhoto" ).dialog( "open" );
			});

		$( "#dialogPhoto" ).dialog({
			autoOpen: false,
			height: 150,
			width: 350,
			modal: true,
			buttons: {
				Cancel: function() {
					$( this ).dialog( "close" );
				}
			},
			close: function() {
				
			}
		});


});
</script>


	</body>
</html>