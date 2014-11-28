
<%@ page import="ics.Farmer" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="farmer.edit" default="Edit Farmer" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="farmer.list" default="Farmer List" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="farmer.new" default="New Farmer" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="farmer.edit" default="Edit Farmer" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${farmerInstance}">
            <div class="errors">
                <g:renderErrors bean="${farmerInstance}" as="list" />
            </div>
            </g:hasErrors>

	<fieldset>
	  <legend><b>Image Upload</b></legend>
	  <g:form action="upload_avatar" method="post" enctype="multipart/form-data">
            <g:hiddenField name="id" value="${farmerInstance?.id}" />
	    <label for="avatar"><b>Image (max 100K)</b></b></b></label>
	    <input type="file" name="avatar" id="avatar" />
	    <div style="font-size:0.8em; margin: 1.0em;">
	      For best results, your image should have a width-to-height ratio of 4:5.
	      For example, if your image is 80 pixels wide, it should be 100 pixels high.
	    </div>
	    <input type="submit" class="buttons" value="Upload" />
	  </g:form>
	</fieldset>

            <g:form method="post" >
                <g:hiddenField name="id" value="${farmerInstance?.id}" />
                <g:hiddenField name="version" value="${farmerInstance?.version}" />
		<fieldset>
		<legend><b>A: Personal Details</b></legend>
                <div class="dialog">
                    <table>
                        <tbody>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="firstName"><g:message code="farmer.firstName" default="First Name" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: farmerInstance, field: 'firstName', 'errors')}">
                                    <g:textField required="required" name="firstName" value="${fieldValue(bean: farmerInstance, field: 'firstName')}" />

                                </td>
                                <td valign="top" class="name">
                                    <label for="middleName"><g:message code="farmer.middleName" default="Middle Name" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: farmerInstance, field: 'middleName', 'errors')}">
                                    <g:textField required="required" name="middleName" value="${fieldValue(bean: farmerInstance, field: 'middleName')}" />

                                </td>
                                <td valign="top" class="name">
                                    <label for="lastName"><g:message code="farmer.lastName" default="Last Name" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: farmerInstance, field: 'lastName', 'errors')}">
                                    <g:textField required="required" name="lastName" value="${fieldValue(bean: farmerInstance, field: 'lastName')}" />

                                </td>
                            <td rowspan="3">
				  <img class="avatar" src="${createLink(controller:'farmer', action:'avatar_image', id:farmerInstance?.id)}" />
                            </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="dob"><g:message code="farmer.dob" default="Dob" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: farmerInstance, field: 'dob', 'errors')}">
                                    <g:datePicker name="dob" precision="day" value="${farmerInstance?.dob}"  />

                                </td>
                                <td valign="top" class="name">
                                    <label for="caste"><g:message code="farmer.caste" default="Caste" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: farmerInstance, field: 'caste', 'errors')}">
                                    <g:textField name="caste" value="${fieldValue(bean: farmerInstance, field: 'caste')}" />

                                </td>
                                <td valign="top" class="name">
                                    <label for="education"><g:message code="farmer.education" default="Education" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: farmerInstance, field: 'education', 'errors')}">
				<g:select name="education" from="${["Uneducated","Primary","Below SSC","SSC","HSC","Graduate","Post Graduate"]}" value="${farmerInstance?.education}"
					  noSelection="['':'-- Please Select Education--']"/>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="mobileNo"><g:message code="farmer.mobileNo" default="Mobile No" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: farmerInstance, field: 'mobileNo', 'errors')}">
                                    <g:textField required="required" name="mobileNo" value="${fieldValue(bean: farmerInstance, field: 'mobileNo')}" />

                                </td>
                                <td valign="top" class="name">
                                    <label for="adharcardNo"><g:message code="farmer.adharcardNo" default="Adharcard No" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: farmerInstance, field: 'adharcardNo', 'errors')}">
                                    <g:textField name="adharcardNo" value="${fieldValue(bean: farmerInstance, field: 'adharcardNo')}" />

                                </td>
                                <td valign="top" class="name">
                                    <label for="panCardNo"><g:message code="farmer.panCardNo" default="Pan Card No" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: farmerInstance, field: 'panCardNo', 'errors')}">
                                    <g:textField name="panCardNo" value="${fieldValue(bean: farmerInstance, field: 'panCardNo')}" />

                                </td>
                                <td valign="top" class="name">
                                    <label for="category"><g:message code="farmer.category" default="Category" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: farmerInstance, field: 'category', 'errors')}">
				<g:select name="category" from="${["General","Coordinator","Spokesperson","VIP"]}" value="${farmerInstance?.category}"
					  noSelection="['':'-- Please Select Category--']"/>
                                </td>
                            </tr>

                        </tbody>
                    </table>
                </div>
		</fieldset>

		<fieldset>
		<legend><b>B: Address</b></legend>
                <div class="dialog">
                    <table>
                        <tbody>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="district"><g:message code="farmer.district" default="District" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: farmerInstance, field: 'district', 'errors')}">
                                    <g:select name="district"
				              from="${ics.District.list(['sort':'name'])}"
				              value="${farmerInstance?.district?.id}"
						noSelection="${['':'Select District...']}"
          					optionKey="id" required="required"/>
                                </td>
                                <td valign="top" class="name">
                                    <label for="taluka"><g:message code="farmer.taluka" default="Taluka" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: farmerInstance, field: 'taluka', 'errors')}">
                                    <g:select name="taluka"
				              from="${farmerInstance?.taluka}"
				              value="${farmerInstance?.taluka?.id}"
						noSelection="${['':'Select Taluka...']}"
          					optionKey="id" required="required"/>
                                </td>
                                <td valign="top" class="name">
                                    <label for="village">At:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: farmerInstance, field: 'village', 'errors')}">
                                    <g:select name="village"
				              from="${farmerInstance?.village}"
				              value="${farmerInstance?.village?.id}"
						noSelection="${['':'Select Village...']}"
          					optionKey="id" required="required"/>
                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="post"><g:message code="farmer.post" default="Post" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: farmerInstance, field: 'post', 'errors')}">
                                    <g:select name="postVillage"
				              from="${(farmerInstance?.postVillage)?:(ics.Village.findAllByTaluka(farmerInstance?.taluka,[sort:'name']))}"
				              value="${farmerInstance?.postVillage?.id}"
						noSelection="${['':'Select Post Village...']}"
          					optionKey="id"/>
                                </td>
                                <td valign="top" class="name">
                                    <label for="pincode"><g:message code="farmer.pincode" default="Pincode" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: farmerInstance, field: 'pincode', 'errors')}">
                                    <g:textField name="pincode" value="${fieldValue(bean: farmerInstance, field: 'pincode')}" />
                                </td>
                                <td></td>
                                <td></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
		</fieldset>

		<fieldset>
		<legend><b>C: Farming Details</b></legend>
                <div class="dialog">
                    <table>
                        <tbody>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="areaOfIrrigatedLand"><g:message code="farmer.areaOfIrrigatedLand" default="Area Of Irrigated Land" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: farmerInstance, field: 'areaOfIrrigatedLand', 'errors')}">
                                    <g:textField required="required" name="areaOfIrrigatedLand" value="${fieldValue(bean: farmerInstance, field: 'areaOfIrrigatedLand')}" />

                                </td>
                                <td valign="top" class="name">
                                    <label for="areaOfNonIrrigatedLand"><g:message code="farmer.areaOfNonIrrigatedLand" default="Area Of Non Irrigated Land" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: farmerInstance, field: 'areaOfNonIrrigatedLand', 'errors')}">
                                    <g:textField required="required" name="areaOfNonIrrigatedLand" value="${fieldValue(bean: farmerInstance, field: 'areaOfNonIrrigatedLand')}" />

                                </td>
                                <td valign="top" class="name">
                                    <label for="areaOfTotalLand"><g:message code="farmer.areaOfTotalLand" default="Area Of Total Land" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: farmerInstance, field: 'areaOfTotalLand', 'errors')}">
                                    <g:textField required="required" name="areaOfTotalLand" value="${fieldValue(bean: farmerInstance, field: 'areaOfTotalLand')}" />

                                </td>
                            </tr>
                        
                        
                        
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="irrigationFacility"><g:message code="farmer.irrigationFacility" default="Irrigation Facility" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: farmerInstance, field: 'irrigationFacility', 'errors')}">
                                    <g:checkBox name="irrigationFacility" value="${farmerInstance?.irrigationFacility}" />

                                </td>
                                <td valign="top" class="name">
                                    <label for="irrigationType"><g:message code="farmer.irrigationType" default="Irrigation Type" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: farmerInstance, field: 'irrigationType', 'errors')}">
                                    <g:select name="irrigationType" from="${farmerInstance.constraints.irrigationType.inList}" value="${farmerInstance.irrigationType}" valueMessagePrefix="farmer.irrigationType"  />

                                </td>
                                <td/>
                                <td/>
                            </tr>
                        
                       
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="microIrrigationType"><g:message code="farmer.microIrrigationType" default="Micro Irrigation Type" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: farmerInstance, field: 'microIrrigationType', 'errors')}">
                                    <g:select name="microIrrigationType" from="${farmerInstance.constraints.microIrrigationType.inList}" value="${farmerInstance.microIrrigationType}" valueMessagePrefix="farmer.microIrrigationType"  />

                                </td>
                                <td valign="top" class="name">
                                    <label for="areaUnderDrip"><g:message code="farmer.areaUnderDrip" default="Area Under Drip" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: farmerInstance, field: 'areaUnderDrip', 'errors')}">
                                    <g:textField name="areaUnderDrip" value="${fieldValue(bean: farmerInstance, field: 'areaUnderDrip')}" />

                                </td>
                                <td valign="top" class="name">
                                    <label for="areaUnderSprinkler"><g:message code="farmer.areaUnderSprinkler" default="Area Under Sprinkler" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: farmerInstance, field: 'areaUnderSprinkler', 'errors')}">
                                    <g:textField name="areaUnderSprinkler" value="${fieldValue(bean: farmerInstance, field: 'areaUnderSprinkler')}" />

                                </td>
                            </tr>


                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="farmingProcess"><g:message code="farmer.farmingProcess" default="Farming Process" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: farmerInstance, field: 'farmingProcess', 'errors')}">
                                    <g:select name="farmingProcess" from="${farmerInstance.constraints.farmingProcess.inList}" value="${farmerInstance.farmingProcess}" valueMessagePrefix="farmer.farmingProcess"  />

                                </td>
                                <td valign="top" class="name">
                                    <label for="areaOfOrganicLand"><g:message code="farmer.areaOfOrganicLand" default="Area Of Organic Land" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: farmerInstance, field: 'areaOfOrganicLand', 'errors')}">
                                    <g:textField name="areaOfOrganicLand" value="${fieldValue(bean: farmerInstance, field: 'areaOfOrganicLand')}" />

                                </td>
                                <td valign="top" class="name">
                                    <label for="areaOfInorganicLand"><g:message code="farmer.areaOfInorganicLand" default="Area of Non-Organic Land" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: farmerInstance, field: 'areaOfInorganicLand', 'errors')}">
                                    <g:textField name="areaOfInorganicLand" value="${fieldValue(bean: farmerInstance, field: 'areaOfInorganicLand')}" />

                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <b>Major Crops:</b>
                                </td>
                                <td/>
                                <td/>
                                <td/>
                                <td/>
                                <td/>
                            </tr>
  
  <g:set var="numc" value="${farmerInstance?.crops?.size()?:0}" />

  <g:each var="cropi" in="${farmerInstance?.crops?.sort{-it.area}}" status="i">
                            <tr class="prop">
                                <td valign="top" class="name">
                                    Crop${i+1} Name
                                </td>
                                <td valign="top" class="value">
                                    <g:select name="${'crop'+(i+1)}" from="${ics.Crop.list([sort:'name'])}" value="${cropi?.crop?.name}" optionKey="name" optionValue="name" noSelection="['':'--Please Select Crop--']"/>
                                </td>
                                <td>Crop${i+1} Area</td>
                                <td valign="top" class="value">
                                <g:textField name="${'cropArea'+(i+1)}" value="${cropi?.area}" />
                                </td>
                                <td/>
                                <td/>
                            </tr>
  </g:each>
  

    <g:if test="${numc<10}">
    <g:each var="i" in="${ ((numc+1)..<11) }">
                              <tr class="prop">
                                  <td valign="top" class="name">
                                      Crop${i} Name
                                  </td>
                                  <td valign="top" class="value">
                                      <g:select name="${'crop'+i}" from="${ics.Crop.list([sort:'name'])}" value=""  noSelection="['':'--Please Select Crop--']"/>
                                  </td>
                                  <td>Crop${i} Area</td>
                                  <td valign="top" class="value">
                                  <g:textField name="${'cropArea'+i}" value="" />
                                  </td>
                                  <td/>
                                  <td/>
                              </tr>
    </g:each>
    </g:if>


                        </tbody>
                    </table>
                </div>
		</fieldset>

		<fieldset>
		<legend><b>D: Other Details</b></legend>
                <div class="dialog">
                    <table>
                        <tbody>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="dairy"><g:message code="farmer.dairy" default="Dairy" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: farmerInstance, field: 'dairy', 'errors')}">
                                    <g:checkBox name="dairy" value="${farmerInstance?.dairy}" />

                                </td>
                                <td valign="top" class="name">
                                    <label for="numDesiCows"><g:message code="farmer.numDesiCows" default="Num Desi Cows" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: farmerInstance, field: 'numDesiCows', 'errors')}">
                                    <g:textField name="numDesiCows" value="${fieldValue(bean: farmerInstance, field: 'numDesiCows')}" />

                                </td>
                                <td valign="top" class="name">
                                    <label for="numHybridCows"><g:message code="farmer.numHybridCows" default="Num Hybrid Cows" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: farmerInstance, field: 'numHybridCows', 'errors')}">
                                    <g:textField name="numHybridCows" value="${fieldValue(bean: farmerInstance, field: 'numHybridCows')}" />

                                </td>
                            </tr>
                        
                      
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="anyOtherBusiness"><g:message code="farmer.anyOtherBusiness" default="Any Other Business" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: farmerInstance, field: 'anyOtherBusiness', 'errors')}">
                                    <g:checkBox name="anyOtherBusiness" value="${farmerInstance?.anyOtherBusiness}" />

                                </td>
                                <td valign="top" class="name">
                                    <label for="otherBusinessDetails"><g:message code="farmer.otherBusinessDetails" default="Other Business Details" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: farmerInstance, field: 'otherBusinessDetails', 'errors')}">
                                    <g:textField name="otherBusinessDetails" value="${fieldValue(bean: farmerInstance, field: 'otherBusinessDetails')}" />

                                </td>
                            </tr>

                        </tbody>
                    </table>
                </div>
		</fieldset>

		<fieldset>
		<legend><b>E: Admin Details</b></legend>
                <div class="dialog">
                    <table>
                        <tbody>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="shareHolder"><g:message code="farmer.shareHolder" default="Share Holder" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: farmerInstance, field: 'shareHolder', 'errors')}">
                                    <!--<g:checkBox name="shareHolder" value="${farmerInstance?.shareHolder}" />-->
                                    ${farmerInstance?.shareHolder}

                                </td>
                                <td valign="top" class="name">
                                    <label for="shareAmount"><g:message code="farmer.shareAmount" default="Share Amount" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: farmerInstance, field: 'shareAmount', 'errors')}">
                                    <!--<g:textField name="shareAmount" value="${fieldValue(bean: farmerInstance, field: 'shareAmount')}" />-->
                                    ${farmerInstance?.shareAmount}

                                </td>
                                <td valign="top" class="name">
                                    <label for="shareCertificateNo"><g:message code="farmer.shareCertificateNo" default="Share Certificate No" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: farmerInstance, field: 'shareCertificateNo', 'errors')}">
                                    <!--<g:textField name="shareCertificateNo" value="${fieldValue(bean: farmerInstance, field: 'shareCertificateNo')}" />-->
                                    ${farmerInstance?.shareCertificateNo}
                                    FolioNo: ${fieldValue(bean: farmerInstance, field: 'folioNo')}

                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="panCardSubmitted"><g:message code="farmer.panCardSubmitted" default="Pan Card Submitted" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: farmerInstance, field: 'panCardSubmitted', 'errors')}">
                                    <g:checkBox name="panCardSubmitted" value="${farmerInstance?.panCardSubmitted}" />

                                </td>
                                <td valign="top" class="name">
                                    <label for="electionCardSubmitted"><g:message code="farmer.electionCardSubmitted" default="Election Card Submitted" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: farmerInstance, field: 'electionCardSubmitted', 'errors')}">
                                    <g:checkBox name="electionCardSubmitted" value="${farmerInstance?.electionCardSubmitted}" />

                                </td>
                                <td valign="top" class="name">
                                    <label for="lightBillSubmitted"><g:message code="farmer.lightBillSubmitted" default="Light Bill Submitted" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: farmerInstance, field: 'lightBillSubmitted', 'errors')}">
                                    <g:checkBox name="lightBillSubmitted" value="${farmerInstance?.lightBillSubmitted}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="dakhlaSubmitted"><g:message code="farmer.dakhlaSubmitted" default="Dakhla Submitted" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: farmerInstance, field: 'dakhlaSubmitted', 'errors')}">
                                    <g:checkBox name="dakhlaSubmitted" value="${farmerInstance?.dakhlaSubmitted}" />

                                </td>
                                <td valign="top" class="name">
                                    <label for="rationCardSubmitted"><g:message code="farmer.rationCardSubmitted" default="Ration Card Submitted" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: farmerInstance, field: 'rationCardSubmitted', 'errors')}">
                                    <g:checkBox name="rationCardSubmitted" value="${farmerInstance?.rationCardSubmitted}" />

                                </td>
                                <td valign="top" class="name">
                                    <label for="sevenTwelveFormSubmitted"><g:message code="farmer.sevenTwelveFormSubmitted" default="7/12 Form Submitted" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: farmerInstance, field: 'sevenTwelveFormSubmitted', 'errors')}">
                                    <g:checkBox name="sevenTwelveFormSubmitted" value="${farmerInstance?.sevenTwelveFormSubmitted}" />

                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="receiptBookNo"><g:message code="farmer.receiptBookNo" default="Receipt Book No" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: farmerInstance, field: 'receiptBookNo', 'errors')}">
                                    <g:textField name="receiptBookNo" value="${fieldValue(bean: farmerInstance, field: 'receiptBookNo')}" />

                                </td>
                                <td valign="top" class="name">
                                    <label for="receiptNo"><g:message code="farmer.receiptNo" default="Receipt No" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: farmerInstance, field: 'receiptNo', 'errors')}">
                                    <g:textField name="receiptNo" value="${fieldValue(bean: farmerInstance, field: 'receiptNo')}" />

                                </td>
                                <td valign="top" class="name">
                                    <label for="comments"><g:message code="farmer.comments" default="Comments" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: farmerInstance, field: 'comments', 'errors')}">
                                    <g:textArea name="comments" value="${fieldValue(bean: farmerInstance, field: 'comments')}" />

                                </td>
                            </tr>

                        </tbody>
                    </table>
                </div>
		</fieldset>

                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'update', 'default': 'Update')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'delete', 'default': 'Delete')}" onclick="return confirm('${message(code: 'delete.confirm', 'default': 'Are you sure?')}');" /></span>
                </div>
            </g:form>
        </div>

    <script type="text/javascript">
        $(document).ready(function()
        {
        	disableShareDetails();
        	disableIrrigationType();
        	
        	function disableShareDetails() {
			if($("#shareHolder").is(":checked")) {
				enableShareDetails()
        		}
        		else {
				$("#shareAmount").attr("disabled", "disabled");
				$("#shareCertificateNo").attr("disabled", "disabled");
        		}
        	}

        	function enableShareDetails() {
        		$("#shareAmount").removeAttr("disabled");
        		$("#shareCertificateNo").removeAttr("disabled");
        	}
        	
	    $('#shareHolder').change(function() {
		if($(this).is(":checked")) {
		    enableShareDetails();
		}
		else
			disableShareDetails();
	    });        	

        	function disableIrrigationType() {
			if($("#irrigationFacility").is(":checked")) {
				enableIrrigationType()
        		}
        		else {
				$("#irrigationType").attr("disabled", "disabled");
        		}
        			
        	}

        	function enableIrrigationType() {
        		$("#irrigationType").removeAttr("disabled");
        	}
        	
	    $('#irrigationFacility').change(function() {
		if($(this).is(":checked")) {
		    enableIrrigationType();
		}
		else
			disableIrrigationType();
	    });        	

      $("#district").change(function() {
	      $.ajax({
		      url: "${createLink(controller:'taluka',action:'districtSelected')}",
		      data: "id=" + this.value,
		      cache: false,
		      success: function(html) {
		      $("#taluka").html(html);
		      $("#village").html("<select id='village' required='required' name='village'><option value=''>Select Village...</option></select>");
		      $("#postVillage").html("<select id='postVillage' name='postVillage'><option value=''>Select Post Village...</option></select>");
		      }
		    });
         });

      $("#taluka").change(function() {
	      $.ajax({
		      url: "${createLink(controller:'village',action:'talukaSelected')}",
		      data: "id=" + this.value,
		      cache: false,
		      success: function(html) {
		      	var pos = html.indexOf("ZZZ");
		      	var villageHtml = html.substring(0,pos);
		      	var postVillageHtml = html.substring(pos+3);
		      	$("#village").html(villageHtml);
		      	$("#postVillage").html(postVillageHtml);
		      }
		    });
         });

        });
    </script>	


    </body>
</html>
