
<%@ page import="ics.Farmer" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>${farmerInstance}</title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="farmer.list" default="Farmer List" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="farmer.new" default="New Farmer" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="printShareCertificate" id="${farmerInstance?.id}">Print Share Certificate</g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="farmer.show" default="Show Farmer" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:form>
                <g:hiddenField name="id" value="${farmerInstance?.id}" />
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
                                    ${fieldValue(bean: farmerInstance, field: 'firstName')}

                                </td>
                                <td valign="top" class="name">
                                    <label for="middleName"><g:message code="farmer.middleName" default="Middle Name" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: farmerInstance, field: 'middleName', 'errors')}">
                                    ${fieldValue(bean: farmerInstance, field: 'middleName')}

                                </td>
                                <td valign="top" class="name">
                                    <label for="lastName"><g:message code="farmer.lastName" default="Last Name" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: farmerInstance, field: 'lastName', 'errors')}">
                                    ${fieldValue(bean: farmerInstance, field: 'lastName')}

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
                                    ${farmerInstance?.dob?.format("dd-MM-yyyy")}

                                </td>
                                <td valign="top" class="name">
                                    <label for="caste"><g:message code="farmer.caste" default="Caste" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: farmerInstance, field: 'caste', 'errors')}">
                                    ${fieldValue(bean: farmerInstance, field: 'caste')}

                                </td>
                                <td valign="top" class="name">
                                    <label for="education"><g:message code="farmer.education" default="Education" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: farmerInstance, field: 'education', 'errors')}">
                                    ${fieldValue(bean: farmerInstance, field: 'education')}

                                </td>
                                <td valign="top" class="name">
                                    <label for="gender"><g:message code="farmer.gender" default="Gender" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: farmerInstance, field: 'gender', 'errors')}">
                                    ${fieldValue(bean: farmerInstance, field: 'gender')}

                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="mobileNo"><g:message code="farmer.mobileNo" default="Mobile No" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: farmerInstance, field: 'mobileNo', 'errors')}">
                                    ${fieldValue(bean: farmerInstance, field: 'mobileNo')}

                                </td>
                                <td valign="top" class="name">
                                    <label for="adharcardNo"><g:message code="farmer.adharcardNo" default="Adharcard No" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: farmerInstance, field: 'adharcardNo', 'errors')}">
                                    ${fieldValue(bean: farmerInstance, field: 'adharcardNo')}

                                </td>
                                <td valign="top" class="name">
                                    <label for="panCardNo"><g:message code="farmer.panCardNo" default="Pan Card No" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: farmerInstance, field: 'panCardNo', 'errors')}">
                                    ${fieldValue(bean: farmerInstance, field: 'panCardNo')}

                                </td>
                                <td valign="top" class="name">
                                    <label for="electionCardNo"><g:message code="farmer.electionCardNo" default="Election Card No" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: farmerInstance, field: 'electionCardNo', 'errors')}">
                                    ${fieldValue(bean: farmerInstance, field: 'electionCardNo')}

                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="category"><g:message code="farmer.category" default="Category" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: farmerInstance, field: 'category', 'errors')}">
					${farmerInstance?.category}
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
                                    ${farmerInstance?.district}
                                </td>
                                <td valign="top" class="name">
                                    <label for="taluka"><g:message code="farmer.taluka" default="Taluka" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: farmerInstance, field: 'taluka', 'errors')}">
                                    ${farmerInstance?.taluka}
                                </td>
                                <td valign="top" class="name">
                                    <label for="village">At:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: farmerInstance, field: 'village', 'errors')}">
                                    ${farmerInstance?.village}
                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="post"><g:message code="farmer.post" default="Post" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: farmerInstance, field: 'post', 'errors')}">
                                    ${farmerInstance?.postVillage}
                                </td>
                                <td valign="top" class="name">
                                    <label for="pincode"><g:message code="farmer.pincode" default="Pincode" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: farmerInstance, field: 'pincode', 'errors')}">
                                    ${fieldValue(bean: farmerInstance, field: 'pincode')}
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
                                    ${fieldValue(bean: farmerInstance, field: 'areaOfIrrigatedLand')}

                                </td>
                                <td valign="top" class="name">
                                    <label for="areaOfNonIrrigatedLand"><g:message code="farmer.areaOfNonIrrigatedLand" default="Area Of Non Irrigated Land" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: farmerInstance, field: 'areaOfNonIrrigatedLand', 'errors')}">
                                    ${fieldValue(bean: farmerInstance, field: 'areaOfNonIrrigatedLand')}

                                </td>
                                <td valign="top" class="name">
                                    <label for="areaOfTotalLand"><g:message code="farmer.areaOfTotalLand" default="Area Of Total Land" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: farmerInstance, field: 'areaOfTotalLand', 'errors')}">
                                    ${fieldValue(bean: farmerInstance, field: 'areaOfTotalLand')}

                                </td>
                            </tr>
                        
                        
                        
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="irrigationFacility"><g:message code="farmer.irrigationFacility" default="Irrigation Facility" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: farmerInstance, field: 'irrigationFacility', 'errors')}">
                                    ${farmerInstance?.irrigationFacility?'Yes':'No'}

                                </td>
                                <td valign="top" class="name">
                                    <label for="irrigationType"><g:message code="farmer.irrigationType" default="Irrigation Type" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: farmerInstance, field: 'irrigationType', 'errors')}">
                                    ${farmerInstance.irrigationType}

                                </td>
                                <td/>
                                <td/>
                            </tr>
                        
                       
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="microIrrigationType"><g:message code="farmer.microIrrigationType" default="Micro Irrigation Type" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: farmerInstance, field: 'microIrrigationType', 'errors')}">
                                    ${farmerInstance.microIrrigationType}

                                </td>
                                <td valign="top" class="name">
                                    <label for="areaUnderDrip"><g:message code="farmer.areaUnderDrip" default="Area Under Drip" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: farmerInstance, field: 'areaUnderDrip', 'errors')}">
                                    ${fieldValue(bean: farmerInstance, field: 'areaUnderDrip')}

                                </td>
                                <td valign="top" class="name">
                                    <label for="areaUnderSprinkler"><g:message code="farmer.areaUnderSprinkler" default="Area Under Sprinkler" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: farmerInstance, field: 'areaUnderSprinkler', 'errors')}">
                                    ${fieldValue(bean: farmerInstance, field: 'areaUnderSprinkler')}

                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="farmingProcess"><g:message code="farmer.farmingProcess" default="Farming Process" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: farmerInstance, field: 'farmingProcess', 'errors')}">
                                    ${farmerInstance.farmingProcess}

                                </td>
                                <td valign="top" class="name">
                                    <label for="areaOfOrganicLand"><g:message code="farmer.areaOfOrganicLand" default="Area Of Organic Land" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: farmerInstance, field: 'areaOfOrganicLand', 'errors')}">
                                    ${fieldValue(bean: farmerInstance, field: 'areaOfOrganicLand')}

                                </td>
                                <td valign="top" class="name">
                                    <label for="areaOfInorganicLand"><g:message code="farmer.areaOfInorganicLand" default="Area of Non-Organic Land" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: farmerInstance, field: 'areaOfInorganicLand', 'errors')}">
                                    ${fieldValue(bean: farmerInstance, field: 'areaOfInorganicLand')}

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

  <g:each status="i" var="ci" in="${farmerInstance.crops?.sort{-it.area}}">
                            <tr class="prop">
                                <td valign="top" class="name">
                                    Crop${i+1} Name
                                </td>
                                <td valign="top" class="value">
                                    ${ci.crop}
                                </td>
                                <td>Crop${i+1} Area</td>
                                <td valign="top" class="value">
                                ${ci.area}
                                </td>
                                <td/>
                                <td/>
                            </tr>
  </g:each>

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
                                    ${farmerInstance?.dairy?'Yes':'No'}

                                </td>
                                <td valign="top" class="name">
                                    <label for="numDesiCows"><g:message code="farmer.numDesiCows" default="Num Desi Cows" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: farmerInstance, field: 'numDesiCows', 'errors')}">
                                    ${fieldValue(bean: farmerInstance, field: 'numDesiCows')}

                                </td>
                                <td valign="top" class="name">
                                    <label for="numHybridCows"><g:message code="farmer.numHybridCows" default="Num Hybrid Cows" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: farmerInstance, field: 'numHybridCows', 'errors')}">
                                    ${fieldValue(bean: farmerInstance, field: 'numHybridCows')}

                                </td>
                                <td valign="top" class="name">
                                    <label for="numBuffaloes"><g:message code="farmer.numBuffaloes" default="Num Buffaloes" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: farmerInstance, field: 'numBuffaloes', 'errors')}">
                                    ${fieldValue(bean: farmerInstance, field: 'numBuffaloes')}

                                </td>
                            </tr>
                        
                      
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="anyOtherBusiness"><g:message code="farmer.anyOtherBusiness" default="Any Other Business" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: farmerInstance, field: 'anyOtherBusiness', 'errors')}">
                                    ${farmerInstance?.anyOtherBusiness?'Yes':'No'}

                                </td>
                                <td valign="top" class="name">
                                    <label for="otherBusinessDetails"><g:message code="farmer.otherBusinessDetails" default="Other Business Details" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: farmerInstance, field: 'otherBusinessDetails', 'errors')}">
                                    ${fieldValue(bean: farmerInstance, field: 'otherBusinessDetails')}

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
                                    ${farmerInstance?.shareHolder?'Yes':'No'}

                                </td>
                                <td valign="top" class="name">
                                    <label for="shareAmount"><g:message code="farmer.shareAmount" default="Share Amount" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: farmerInstance, field: 'shareAmount', 'errors')}">
                                    ${fieldValue(bean: farmerInstance, field: 'shareAmount')}

                                </td>
                                <td valign="top" class="name">
                                    <label for="shareCertificateNo"><g:message code="farmer.shareCertificateNo" default="Share Certificate No" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: farmerInstance, field: 'shareCertificateNo', 'errors')}">
                                    ${fieldValue(bean: farmerInstance, field: 'shareCertificateNo')}
                                    FolioNo: ${fieldValue(bean: farmerInstance, field: 'folioNo')}

                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="panCardSubmitted"><g:message code="farmer.panCardSubmitted" default="Pan Card Submitted" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: farmerInstance, field: 'panCardSubmitted', 'errors')}">
                                    ${farmerInstance?.panCardSubmitted?'Yes':'No'}

                                </td>
                                <td valign="top" class="name">
                                    <label for="electionCardSubmitted"><g:message code="farmer.electionCardSubmitted" default="Election Card Submitted" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: farmerInstance, field: 'electionCardSubmitted', 'errors')}">
                                    ${farmerInstance?.electionCardSubmitted?'Yes':'No'}

                                </td>
                                <td valign="top" class="name">
                                    <label for="lightBillSubmitted"><g:message code="farmer.lightBillSubmitted" default="Light Bill Submitted" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: farmerInstance, field: 'lightBillSubmitted', 'errors')}">
                                    ${farmerInstance?.lightBillSubmitted?'Yes':'No'}

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="dakhlaSubmitted"><g:message code="farmer.dakhlaSubmitted" default="Dakhla Submitted" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: farmerInstance, field: 'dakhlaSubmitted', 'errors')}">
                                    ${farmerInstance?.dakhlaSubmitted?'Yes':'No'}

                                </td>
                                <td valign="top" class="name">
                                    <label for="rationCardSubmitted"><g:message code="farmer.rationCardSubmitted" default="Ration Card Submitted" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: farmerInstance, field: 'rationCardSubmitted', 'errors')}">
                                    ${farmerInstance?.rationCardSubmitted?'Yes':'No'}

                                </td>
                                <td valign="top" class="name">
                                    <label for="sevenTwelveFormSubmitted"><g:message code="farmer.sevenTwelveFormSubmitted" default="7/12 Form Submitted" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: farmerInstance, field: 'sevenTwelveFormSubmitted', 'errors')}">
                                    ${farmerInstance?.sevenTwelveFormSubmitted?'Yes':'No'}

                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="receiptBookNo"><g:message code="farmer.receiptBookNo" default="Receipt Book No" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: farmerInstance, field: 'receiptBookNo', 'errors')}">
                                    ${fieldValue(bean: farmerInstance, field: 'receiptBookNo')}
                                </td>
                                <td valign="top" class="name">
                                    <label for="receiptNo"><g:message code="farmer.receiptNo" default="Receipt No" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: farmerInstance, field: 'receiptNo', 'errors')}">
                                    ${fieldValue(bean: farmerInstance, field: 'receiptNo')}
                                </td>
                                <td valign="top" class="name">
                                    <label for="comments"><g:message code="farmer.comments" default="Comments" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: farmerInstance, field: 'comments', 'errors')}">
                                    ${fieldValue(bean: farmerInstance, field: 'comments')}

                                </td>
                            </tr>

                        </tbody>
                    </table>
                </div>
		</fieldset>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'edit', 'default': 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'delete', 'default': 'Delete')}" onclick="return confirm('${message(code: 'delete.confirm', 'default': 'Are you sure?')}');" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
