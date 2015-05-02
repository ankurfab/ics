
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
            <div>Please fill in your details with proper mobile no, email and postal address. We will send you subsequent communications on these.
            Furthermore, you can now pay the fees online for quicker processing.
            If you have any queries/clarifications, please mention in the comments section at the end.
            You will receive the registration confirmation email after submitting  this form along with login details.
            Please provide your loginid/username  in all subsequent communications. Thank you. 
            <b>(
            <!--<a id="helpLink" class="external" href="https://www.gitapl.com/registration-guidelines.html" title="GPL Registration Guidelines">Pls click here for detailed instructions.</a>-->
            <a target="_new" href="http://www.gitapl.com/registration-guidelines.html" title="GPL Registration Guidelines">Pls click here for detailed instructions.(opens in new window)</a>
            )</b>
            </div>

            <g:form id="gplRegForm" action="save" method="post" >
            
            <g:hiddenField name="event.id" value="${event?.id}" />
            <g:hiddenField name="assessment.id" value="" />

		<fieldset>
		<legend><b>A: Personal Details</b></legend>
                <div class="dialog">
                    <table>
                        <tbody>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="name">Name:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventRegistrationInstance, field: 'name', 'errors')}">
                                    <input id="name" name="name" value="${fieldValue(bean: eventRegistrationInstance, field: 'name')}" placeholder="Full name of the candidate" minlength="5" size="30" pattern="[a-zA-Z0-9 .]+" type="text" required>
                                </td>
                                <td valign="top" class="name">
                                    <label for="dob">Date of Birth:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventRegistrationInstance, field: 'dob', 'errors')}">
                                    <g:textField name="dob" value="${eventRegistrationInstance?.dob?.format('dd-MM-yy')}" placeholder="Date of Birth in dd-MM-yyyy format" required="true"/>
                                </td>
                                <td valign="top" class="name">
                                    <label for="gender">Gender:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: eventRegistrationInstance, field: 'dob', 'errors')}">                                    
                                    Male<g:radio name="gender" value="male"/>
				    Female<g:radio name="gender" value="female"/>
                                </td>  
                            </tr>                        
                        </tbody>
                    </table>
                </div>		
		</fieldset>

		<fieldset>
		<legend><b>B: Communication Details</b></legend>
                <div class="dialog">
                    <table>
                        <tbody>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="name">Mobile No:</label>
                                </td>
                                <td valign="top" class="value">
                                    <input id="contactNumber" type="text" name="contactNumber" placeholder="Mobile no (10 digit only)" pattern="\d{10}" required>
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
                                    <g:textArea name="address" value="${fieldValue(bean: eventRegistrationInstance, field: 'address')}" rows="5" columns="30" placeholder="Correspondence Address (The study material would be posted to this address)" required="true" maxlength="255"/>
                                </td>
                                <td valign="top" class="name">
                                    <label for="year">AddressPincode:</label>
                                </td>
                                <td valign="top" class="value">
                                    <g:textField name="addressPincode" value="${fieldValue(bean: eventRegistrationInstance, field: 'addressPincode')}" placeholder="Six digit pincode of correspondence address." required="true"/>
                                </td>
                            </tr>                            
                        </tbody>
                    </table>
                </div>
		</fieldset>

		<fieldset>
		<legend><b>C: Occupation Details</b></legend>
                <div class="dialog">
                    <table>
                        <tbody>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="name">School/College/Company Name:</label>
                                </td>
                                <td valign="top" class="value">
                                    <g:textField name="connectedIskconCenter" value="${fieldValue(bean: eventRegistrationInstance, field: 'connectedIskconCenter')}" placeholder="Name of the place where studying or working" required="true" size="40"/>
                                </td>
                                <td valign="top" class="name">
                                    <label for="name">City:</label>
                                </td>
                                <td valign="top" class="value">
                                    <g:textField name="centerLocation" value="${fieldValue(bean: eventRegistrationInstance, field: 'centerLocation')}" placeholder="City" required="true"/>
                                </td>
                                <td valign="top" class="name">
                                    <label for="year">Std in school/college/Working Since:</label>
                                </td>
                                <td valign="top" class="value">
                                    <g:textField name="year" value="${fieldValue(bean: eventRegistrationInstance, field: 'year')}" placeholder="NA if not a student or professional." size="35"/>
                                </td>
                            </tr>                        
                        </tbody>
                    </table>
                </div>
		</fieldset>

		<fieldset>
		<legend><b>D: Identification Details</b></legend>
                <div class="dialog">
                    <table>
                        <tbody>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="idproofType">Photo ID Proof Type:</label>
                                </td>
                                <td valign="top" class="value">
                                    <g:select name="idproofType" from="${['SCHOOL/COLLEGE/COMPANY ID CARD','PAN CARD','DRIVING LICENSE','OTHER']}" noSelection="${['':'Select ID Card Type...']}" required="true"/>
                                </td>
                                <td valign="top" class="name">
                                    <label for="year">Photo ID Proof No:</label>
                                </td>
                                <td valign="top" class="value">
                                    <g:textField name="idProofId" value="${fieldValue(bean: eventRegistrationInstance, field: 'idProofId')}" placeholder="ID no" required="true"/>
                                </td>
                            </tr>                        
                        </tbody>
                    </table>
                </div>
		</fieldset>

		<fieldset>
		<legend><b>E: Registration Details</b></legend>
                <div class="dialog">
			<div id="radioPacket">
			    <table>
				<tbody>
				    <tr class="prop">
					<td valign="top" class="name">
					    <label for="name">Do you already have a GPL Packet? </label>
					</td>
					<td valign="top" class="value">
						<input type="radio" id="radioPacketYes" name="radioPacket"><label for="radioPacketYes">Yes</label>
						<input type="radio" id="radioPacketNo" name="radioPacket"><label for="radioPacketNo">No</label>
					</td>
				    </tr>                        
				</tbody>
			    </table>
			</div>                    
			<div id="divPacketCode">
			    <table>
				<tbody>
				    <tr class="prop">
					<td valign="top" class="name">
					    <label for="name">Registration code (Mentioned on the cover of the DVD in the GPL packet): </label>
					</td>
					<td valign="top" class="value">
						<g:textField name="packetcode" value="" maxlength="9"  placeholder="Registration Code" pattern = "[0-9]{9}"  title='Registration Confirmation Code must contain digits only'/>
					</td>
				    </tr>                        
				</tbody>
			    </table>
			</div>                    
			<div id="radioPacketDelivery">
			    <table>
				<tbody>
				    <tr class="prop">
					<td valign="top" class="name">
					    <label for="name">How do you want the GPL Packet? </label>
					</td>
					<td valign="top" class="value">
						<input type="radio" id="radioPacketCourier" name="radioPacketDelivery"><label for="radioPacketCourier">By Courier</label>
						<input type="radio" id="radioPacketPickup" name="radioPacketDelivery"><label for="radioPacketPickup">Self Pickup</label>
						<input type="radio" id="radioPacketContactMe" name="radioPacketDelivery"><label for="radioPacketContactMe">Contact Me</label>
					</td>
				    </tr>                        
				</tbody>
			    </table>
			</div>                    
			<div id="radioPacketDeliveryCourier">
			    <table>
				<tbody>
				    <tr class="prop">
					<td>The GPL packet would be couriered to your communication addressed as mentioned above. There would be some additional charges as per your location. Also, courier would be sent only if you are paying online. If you are unable to pay online for some reasons, you could deposit the amount in the GPL bank account directly and inform us the details (name,phone,email,amount deposited,date,transaction number). The bank a/c details are: A/C Name - ISKCON Sankirtan, Bank: SBI, Branch: East Street, Pune, Account#: 30689063236, IFSC: SBIN0003861</td>
				    </tr>
				</tbody>
			    </table>
			    <table>
				<tbody>
				    <tr class="prop">
					<td valign="top" class="name">
					    <label for="name">Do you want Gita in the packet? </label>
					</td>
					<td valign="top" class="value">
						<input type="radio" id="radioPacketCourierGitaYes" name="radioPacketDeliveryCourier" checked="checked"><label for="radioPacketCourierGitaYes">Yes</label>
						<input type="radio" id="radioPacketCourierGitaNo" name="radioPacketDeliveryCourier"><label for="radioPacketCourierGitaNo">No</label>
					</td>
				    </tr>                        
				</tbody>
			    </table>
			</div>                    
			                   
			<div id="radioPacketDeliveryPickup">
			    <table>
				<tbody>
				    <tr class="prop">
					<td>Please collect the GPL packet from ISKCON Pune. Please call Ph:+91-8605413415 to get further details. You may also pay online for quicker processing.</td>
				    </tr>
				</tbody>
			    </table>
			    <table>
				<tbody>
				    <tr class="prop">
					<td valign="top" class="name">
					    <label for="name">Do you want Gita in the packet? </label>
					</td>
					<td valign="top" class="value">
						<input type="radio" id="radioPacketPickupGitaYes" name="radioPacketDeliveryPickup" checked="checked"><label for="radioPacketPickupGitaYes">Yes</label>
						<input type="radio" id="radioPacketPickupGitaNo" name="radioPacketDeliveryPickup"><label for="radioPacketPickupGitaNo">No</label>
					</td>
				    </tr>                        
				</tbody>
			    </table>
			</div>                    

			<div id="radioPacketDeliveryContactMe">
			    <table>
				<tbody>
				    <tr class="prop">
					<td>Thank you for showing interest in the GPL. Please provide your specific query/comments in the 'comments' field at the end of the form. Someone from the GPL team would contact you soon.</td>
				    </tr>
				</tbody>
			    </table>
			</div>                    
                </div>
                <div class="dialog">
                    <table>
                        <tbody>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="name">Language Preference:</label>
                                </td>
                                <td valign="top" class="value">
                                    <g:select name="otherGuestType" from="${['English','Hindi','Marathi','Telugu']}" noSelection="${['':'Select Language...']}" required="true"/>
                                </td>
                            </tr>                        
                        </tbody>
                    </table>
                </div>
		</fieldset>


		<fieldset>
		<legend><b>F: Payment Details</b></legend>
                <div id="calculatedfees"></div>
                <div class="dialog" id="divPayment">
                    <table>
                        <tbody>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="name">Online Payment:</label>
                                </td>
                                <td valign="top" class="value">
					<g:checkBox name="onlinePayment" value="${false}" />
					Please tick this box if you want to pay online, as per the option chosen above.
					*Courier charges extra
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
		</fieldset>
            
                <div class="dialog">
                    <table>
                        <tbody>
                            <tr class="prop">
                                <td><label for="name">Comments:</label></td>
                                <td><g:textField name="comments" value="${fieldValue(bean: eventRegistrationInstance, field: 'comments')}" placeholder="Comments/Feedback/Queries" maxlength="255" size="100"/></td>
                            </tr>
                        </tbody>
                    </table>
                    <table>
                        <tbody>
                            <tr class="prop">
                                <td><g:checkBox name="agree" value="${false}" required="true"/>
                                <!--<a id="rulesLink" class="external" href="https://www.gitapl.com/rules---details.html" title="GPL Rules and Regulations">I agree to all the rules and regulations.(click to open)</a>-->
                                <a target="_new" href="http://www.gitapl.com/rules---details.html" title="GPL Rules and Regulations">I agree to all the rules and regulations.(click to open in new window)</a></td>
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
                    <span class="button"><g:submitButton style="font-size:40px;" name="create" class="save" value="Register" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/></span>
                </div>
            </g:form>
        </div>

<div id="somediv" title="GPL" style="display:none;">
    <iframe id="thedialog" width="750" height="350"></iframe>
</div>

	<script>
	$(function() {
		  hideAll();
		  
		  $("#dob").datepicker({yearRange : "-100:+0",changeMonth: true,changeYear: true,dateFormat: 'dd-mm-yy'});
		  $("#gplRegForm").validate();	
		  
		    $(".external").click(function () {
			$("#thedialog").attr('src', $(this).attr("href"));
			$("#somediv").attr('title', $(this).attr("title"));
			$("#somediv").dialog({
			    width: 800,
			    height: 450,
			    modal: true,
			    close: function () {
				$("#thedialog").attr('src', "about:blank");
			    }
			});
			return false;
		    });

		    $('#assessment\\.id').change(function(event) {
		    	getFees();
		    }); 
		    
		    $( "#radioPacket" ).buttonset();
		    $( "#radioPacketDelivery" ).buttonset();
		    $( "#radioPacketDeliveryCourier" ).buttonset();
		    $( "#radioPacketDeliveryPickup" ).buttonset();

		   $("#radioPacketYes").click(function() {
			    hideAll();
			    $('#divPacketCode').show();
			    $('#assessment\\.id').val("9");
		   });		    

		   $("#radioPacketNo").click(function() {
			    hideAll();
			    $('#packetcode').val("");
			    $('#radioPacketDelivery').show();
			    $('#assessment\\.id').val("11");
		   });		    

		   $("#radioPacketCourier").click(function() {
			    $('#radioPacketDeliveryCourier').show();
			    $('#radioPacketDeliveryPickup').hide();   
			    $('#radioPacketDeliveryContactMe').hide();
			    $('#assessment\\.id').val("11");
			    getFees();
		   });		    

		   $("#radioPacketPickup").click(function() {
			    $('#radioPacketDeliveryCourier').hide();
			    $('#radioPacketDeliveryPickup').show();   
			    $('#radioPacketDeliveryContactMe').hide();
			    $('#assessment\\.id').val("10");
			    getFees();
		   });		    

		   $("#radioPacketContactMe").click(function() {
			    $('#radioPacketDeliveryCourier').hide();
			    $('#radioPacketDeliveryPickup').hide();   
			    $('#radioPacketDeliveryContactMe').show();
			    $('#assessment\\.id').val("14");
			    getFees();
		   });		    

		   $("#radioPacketCourierGitaYes").click(function() {
			    $('#assessment\\.id').val("11");
			    getFees();
		   });		    

		   $("#radioPacketCourierGitaNo").click(function() {
			    $('#assessment\\.id').val("12");
			    getFees();
		   });
		   
		   $("#radioPacketPickupGitaYes").click(function() {
			    $('#assessment\\.id').val("10");
			    getFees();
		   });		    

		   $("#radioPacketPickupGitaNo").click(function() {
			    $('#assessment\\.id').val("13");
			    getFees();
		   });
		   
		   function hideAll() {
			  $("#divPacketCode").hide();
			  $("#radioPacketDelivery").hide();
			  $("#radioPacketDeliveryCourier").hide();
			  $("#radioPacketDeliveryPickup").hide();
			  $("#radioPacketDeliveryContactMe").hide();
			  $('#assessment\\.id').val("9");
		   }
		   
		   function getFees() {
		    	var url = "${createLink(action:'createFees')}";
			$.post(url, { aid: $('#assessment\\.id').val(), pin: $('#addressPincode').val()},
			    function(data) {
				$('#calculatedfees').html("Total Fees (including courier charges if any): "+data);
			    }
			);            
		   }
    
	});	
	</script>

    </body>
</html>
