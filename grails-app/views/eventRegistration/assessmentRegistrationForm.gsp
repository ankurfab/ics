
<%@ page import="ics.EventRegistration" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="assessment" />
        <title>GPL Registration Form</title>
	<r:require module="jqui" />
	<r:require module="jqval" />
    </head>
    <body>
        <div class="body">
            <h1>Registration Form</h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:hasErrors bean="${eventRegistrationInstance}">
            <div class="errors">
                <g:renderErrors bean="${eventRegistrationInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form id="gplRegForm" action="save" method="post" >
            
            <g:hiddenField name="event.id" value="${event?.id}" />
            
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="name">Name:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventRegistrationInstance, field: 'name', 'errors')}">
                                    <input id="name" name="name" value="${fieldValue(bean: eventRegistrationInstance, field: 'name')}" placeholder="Full name of the candidate (FirstName Father'sName SurName)" minlength="5" type="text" required>
                                </td>
                                <td valign="top" class="name">
                                    <label for="dob">Date of Birth:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventRegistrationInstance, field: 'dob', 'errors')}">
                                    <g:textField name="dob" value="${eventRegistrationInstance?.dob?.format('dd-MM-yy')}" placeholder="Date of Birth in dd-MM-yyyy format" required="true"/>
                                    Male<g:radio name="isMale" value="true" checked="${eventRegistrationInstance?.isMale?:true}"/>
				    Female<g:radio name="isMale" value="false" checked="${eventRegistrationInstance?.isMale?:false}"/>
                                </td>
                            </tr>
                                                
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="name">Mobile No:</label>
                                </td>
                                <td valign="top" class="value">
                                    <g:textField name="contactNumber" value="${fieldValue(bean: eventRegistrationInstance, field: 'contactNumber')}" placeholder="Mobile no (10 digit only)" required="true"/>
                                </td>
                                <td valign="top" class="name">
                                    <label for="name">Email:</label>
                                </td>
                                <td valign="top" class="value">
                                    <!--<g:textField name="email" value="${fieldValue(bean: eventRegistrationInstance, field: 'email')}" placeholder="Email address" type="email" required="true"/>-->
                                    <input id="email" type="email" name="email" required>
                                </td>
                            </tr>
                                                
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="name">Address:</label>
                                </td>
                                <td valign="top" class="value">
                                    <g:textArea name="address" value="${fieldValue(bean: eventRegistrationInstance, field: 'address')}" rows="5" columns="30" placeholder="Correspondence Address (The study material would be posted to this address)" required="true"/>
                                </td>
                                <td valign="top" class="name">
                                    <label for="year">AddressPincode:</label>
                                </td>
                                <td valign="top" class="value">
                                    <g:textField name="addressPincode" value="${fieldValue(bean: eventRegistrationInstance, field: 'addressPincode')}" placeholder="Pincode of correspondence address." required="true"/>
                                </td>
                            </tr>
                                                
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="name">School/College/Company:</label>
                                </td>
                                <td valign="top" class="value">
                                    <g:textField name="connectedIskconCenter" value="${fieldValue(bean: eventRegistrationInstance, field: 'connectedIskconCenter')}" placeholder="Name of the place where studying or working" required="true"/>
                                    <g:textField name="centerLocation" value="${fieldValue(bean: eventRegistrationInstance, field: 'centerLocation')}" placeholder="Location" required="true"/>
                                </td>
                                <td valign="top" class="name">
                                    <label for="year">Year / Working Since:</label>
                                </td>
                                <td valign="top" class="value">
                                    <g:textField name="year" value="${fieldValue(bean: eventRegistrationInstance, field: 'year')}" placeholder="Studying in std or year. If working, working since." />
                                </td>
                            </tr>
                                                
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="idproofType">Photo ID Proof Type:</label>
                                </td>
                                <td valign="top" class="value">
                                    <g:select name="idproofType" from="${['SCHOOL/COLLEGE/COMPANY ID CARD','PAN CARD','DRIVING LICENSE','OTHER']}" value="${eventRegistrationInstance?.idproofType}"/>
                                </td>
                                <td valign="top" class="name">
                                    <label for="year">Photo ID Proof No:</label>
                                </td>
                                <td valign="top" class="value">
                                    <g:textField name="idProofId" value="${fieldValue(bean: eventRegistrationInstance, field: 'idProofId')}" placeholder="ID no" required="true"/>
                                </td>
                            </tr>
                                                
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="name">Registering for Exam:</label>
                                </td>
                                <td valign="top" class="value">
					<g:select name='assessment.id'
					    noSelection="${['null':'Select One...']}"
					    from="${ics.Assessment.findAllByDepartment(event?.department,[sort:'name'])}"
					    optionKey="id"></g:select>
                                </td>
                                <td valign="top" class="name">
                                    <label for="name">Language Preference:</label>
                                </td>
                                <td valign="top" class="value">
                                    <g:select name="otherGuestType" from="${['English','Hindi','Marathi']}" value="English"/>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="name">Do you want to paying online?:</label>
                                </td>
                                <td valign="top" class="value">
					<g:checkBox name="onlinePayment" value="${true}" />
                                </td>
                                <td><label for="name">If already paid, pls provide details:</label></td>
                                <td><g:textField name="comments" value="${fieldValue(bean: eventRegistrationInstance, field: 'comments')}" placeholder="Comments"/></td>
                            </tr>

                            <tr class="prop">
                                <td></td>
                                <td valign="top" class="name">
                                    <img src="${createLink(controller: 'simpleCaptcha', action: 'captcha')}"/>
                                </td>
				<td valign="top" class="name">
					<label for="captcha" style="vertical-align:center;">Type the letters in the box:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventRegistrationInstance, field: 'regCode', 'errors')}">
				    <g:textField name="captcha" required="true"/>
                                </td>
                            </tr>

                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="Register" /></span>
                </div>
            </g:form>
        </div>

	<script>
	$(function() {
		  $("#dob").datepicker({yearRange : "-100:+0",changeMonth: true,changeYear: true,dateFormat: 'dd-mm-yy'});
		  $("#gplRegForm").validate();				  
		
	});
	</script>

    </body>
</html>
