<%@ page import="ics.EventRegistration" %>
<%@ page import="ics.VerificationStatus" %>
<%@ page import="ics.AccommodationAllotmentStatus" %>

<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'eventRegistration.label', default: 'Registration Details')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
		<r:require module="grid" />
	</head>
	<body>
		<div class="nav" role="navigation">
			<ul>
				<span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
				<sec:ifAnyGranted roles="ROLE_VIP_COORDINATOR,ROLE_VIP_REGISTRATION,ROLE_REGISTRATION_COORDINATOR,ROLE_EVENTADMIN">				    
					<span class="menuButton"><g:link class="create" action="create">New Registration</g:link></span>
					<span class="menuButton"><g:link class="list" action="list">Registration List</g:link></span>
					<g:if test="${eventRegistrationInstance?.verificationStatus == VerificationStatus.VERIFIED}">
						<span class="menuButton"><g:link class="create" action="register" params="[id: eventRegistrationInstance.id]">Confirm Registration</g:link></span>
					</g:if>
				</sec:ifAnyGranted>
				<sec:ifAnyGranted roles="ROLE_VIP_COORDINATOR,ROLE_EVENTADMIN,ROLE_ACCOMMODATION_COORDINATOR,ROLE_VIP_ACCOMMODATION">				    
					<g:if test="${eventRegistrationInstance?.verificationStatus == VerificationStatus.VERIFIED && eventRegistrationInstance?.isAccommodationRequired && eventRegistrationInstance?.accommodationAllotmentStatus != AccommodationAllotmentStatus.ALLOTEMENT_REJECTED}">
						<span class="menuButton"><g:link class="list" controller="AccommodationAllotment" action="allot" params="[id: eventRegistrationInstance.id]">Accommodation</g:link></span>
					</g:if>
				</sec:ifAnyGranted>
			</ul>
		</div>
		<div id="show-eventRegistration" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list eventRegistration">
				
				<div class="collection_group">

					<div class="dialog"><table><tbody>

						<tr class="prop"><div class="caption_title">General Information</div></tr>

						<!-- Event -->

						<g:if test="${eventRegistrationInstance?.event}">
						<tr class="prop" style="display:none">
							<td class="name">
								<g:message code="eventRegistration.event.label" default="Event" />
							</td>
							<td class="value">
								<g:fieldValue bean="${eventRegistrationInstance}" field="event"/>
							</td>
						</tr>
						</g:if>

						<!-- Registration Code -->

						<g:if test="${eventRegistrationInstance?.regCode}">
						<tr class="prop">
							<td class="name">
								<g:message code="eventRegistration.regCode.label" default="Registration Code" />
							</td>
							<td class="value">
								<g:fieldValue bean="${eventRegistrationInstance}" field="regCode"/>
							</td>
						</tr>
						</g:if>

						<!-- Name -->

						<g:if test="${eventRegistrationInstance?.name}">
						<tr class="prop">
							<td class="name">
								<g:message code="eventRegistration.name.label" default="Name" />
							</td>
							<td class="value">
								<g:fieldValue bean="${eventRegistrationInstance}" field="name"/>
							</td>
						</tr>
						</g:if>

						<!-- Associated Center -->

						<g:if test="${eventRegistrationInstance?.connectedIskconCenter}">
						<tr class="prop">
							<td class="name">
								<g:message code="eventRegistration.connectedIskconCenter.label" default="Connected Iskcon Temple/Center" />
							</td>
							<td class="value">
								<g:fieldValue bean="${eventRegistrationInstance}" field="connectedIskconCenter"/>
							</td>
						</tr>
						</g:if>


						<sec:ifAnyGranted roles="ROLE_VIP_COORDINATOR,ROLE_VIP_REGISTRATION">	
							<g:if test="${eventRegistrationInstance?.guestType}">
							<tr class="prop">
								<td class="name">
									<g:message code="eventRegistration.guestType.label" default="Guest Type" />
								</td>
								<td class="value">
									<g:fieldValue bean="${eventRegistrationInstance}" field="guestType.displayName"/>
								</td>
							</tr>
							</g:if>

							<g:if test="${eventRegistrationInstance?.otherGuestType}">
							<tr class="prop">
								<td class="name">
									<g:message code="eventRegistration.otherGuestType.label" default="Other(Guest Type)" />
								</td>
								<td class="value">
									<g:fieldValue bean="${eventRegistrationInstance}" field="otherGuestType"/>
								</td>
							</tr>
							</g:if>

						</sec:ifAnyGranted>	
						
						<sec:ifNotGranted roles="ROLE_VIP_COORDINATOR,ROLE_VIP_REGISTRATION,ROLE_EVENTPARTICIPANT">				    
							<!-- Verification Status -->

							<g:if test="${eventRegistrationInstance?.verificationStatus}">
							<tr class="prop">
								<td class="name">
									<g:message code="eventRegistration.verificationStatus.label" default="Verification Status" />
								</td>
								<td class="value">
									<g:fieldValue bean="${eventRegistrationInstance}" field="verificationStatus.displayName"/>
								</td>
							</tr>
							</g:if>

						</sec:ifNotGranted>

						<sec:ifAnyGranted roles="ROLE_VIP_COORDINATOR,ROLE_VIP_REGISTRATION">				    
							<!-- Verification Status -->
								 
							<g:if test="${eventRegistrationInstance?.verificationStatus}">
							<tr class="prop">
								<td class="name">
									<g:message code="eventRegistration.verificationStatus.label" default="Registration Status" />
								</td>
								<td class="value">
									<g:fieldValue bean="${eventRegistrationInstance}" field="verificationStatus.vipDisplayName"/>
								</td>
							</tr>
							</g:if>

						</sec:ifAnyGranted>

							<!-- Accommodation Status -->
								 
							<g:if test="${eventRegistrationInstance?.accommodationAllotmentStatus}">
							<tr class="prop">
								<td class="name">
									Accommodation Allotment Status
								</td>
								<td class="value">
									<g:fieldValue bean="${eventRegistrationInstance}" field="accommodationAllotmentStatus"/>
								</td>
							</tr>
							</g:if>


					</tbody></table></div>

				</div>

				<div class="collection_group">

					<div class="dialog"><table><tbody>

						<tr class="prop"><div class="caption_title">Contact Information</div></tr>

						<!-- Country -->

						<g:if test="${eventRegistrationInstance?.country}">
						<tr class="prop">
							<td class="name">
								<g:message code="eventRegistration.country.label" default="Country" />
							</td>
							<td class="value">
								<g:fieldValue bean="${eventRegistrationInstance}" field="country"/>
							</td>
						</tr>
						</g:if>

						<!-- Contact Number -->

						<g:if test="${eventRegistrationInstance?.contactNumber}">
						<tr class="prop">
							<td class="name">
								<g:message code="eventRegistration.contactNumber.label" default="Contact Number" />
							</td>
							<td class="value">
								<g:fieldValue bean="${eventRegistrationInstance}" field="contactNumber"/>
							</td>
						</tr>
						</g:if>

						<!-- Alternet Contact Number -->

						<g:if test="${eventRegistrationInstance?.alternateContactNumber}">
						<tr class="prop">
							<td class="name">
								<g:message code="eventRegistration.alternateContactNumber.label" default="Alternet Contact Number" />
							</td>
							<td class="value">
								<g:fieldValue bean="${eventRegistrationInstance}" field="alternateContactNumber"/>
							</td>
						</tr>
						</g:if>

						<!-- Email Address -->

						<g:if test="${eventRegistrationInstance?.email}">
						<tr class="prop">
							<td class="name">
								<g:message code="eventRegistration.email.label" default="Email Address" />
							</td>
							<td class="value">
								<g:fieldValue bean="${eventRegistrationInstance}" field="email"/>
							</td>
						</tr>
						</g:if>
						
					</tbody></table></div>

				</div>

				<g:if test="${eventRegistrationInstance?.isGroupLeader || eventRegistrationInstance?.numberofPrabhujis || eventRegistrationInstance?.numberofMatajis || eventRegistrationInstance?.numberofChildren || eventRegistrationInstance?.numberofBrahmacharis}">
				
				<div class="collection_group">

					<div class="dialog"><table><tbody>

						<tr class="prop"><div class="caption_title">Accompanying Information</div></tr>

						<!-- Is Group Leader -->

						<g:if test="${eventRegistrationInstance?.isGroupLeader}">
						<tr class="prop">
							<td class="name">
								<g:message code="eventRegistration.isGroupLeader.label" default="Is Group Leader" />
							</td>
							<td class="value">
								<g:formatBoolean boolean="${eventRegistrationInstance.isGroupLeader}" true="Yes" false="No"/>
							</td>
						</tr>
						</g:if>

						<!-- No Of Brahmacharis/Students Coming -->

						<g:if test="${eventRegistrationInstance?.numberofBrahmacharis}">
						<tr class="prop">
							<td class="name">
								<g:message code="eventRegistration.numberofBrahmacharis.label" default="Accompanying Brahmacharis/Students" />
							</td>
							<td class="value">
								<g:fieldValue bean="${eventRegistrationInstance}" field="numberofBrahmacharis"/>
							</td>
						</tr>
						</g:if>

						<!-- No Of Prabhujies Coming -->

						<g:if test="${eventRegistrationInstance?.numberofPrabhujis}">
						<tr class="prop">
							<td class="name">
								<g:message code="eventRegistration.numberofPrabhujis.label" default="No Of Prabhujies Coming" />
							</td>
							<td class="value">
								<g:fieldValue bean="${eventRegistrationInstance}" field="numberofPrabhujis"/>
							</td>
						</tr>
						</g:if>

						<!-- No Of Matajis Coming -->

						<g:if test="${eventRegistrationInstance?.numberofMatajis}">
						<tr class="prop">
							<td class="name">
								<g:message code="eventRegistration.numberofMatajis.label" default="No Of Matajis Coming" />
							</td>
							<td class="value">
								<g:fieldValue bean="${eventRegistrationInstance}" field="numberofMatajis"/>
							</td>
						</tr>
						</g:if>

						<!-- No Of Childrens Coming -->

						<g:if test="${eventRegistrationInstance?.numberofChildren}">
						<tr class="prop">
							<td class="name">
								<g:message code="eventRegistration.numberofChildren.label" default="No Of Childrens Coming" />
							</td>
							<td class="value">
								<g:fieldValue bean="${eventRegistrationInstance}" field="numberofChildren"/>
							</td>
						</tr>
						</g:if>

						<!-- No Of Brahmacharis Volunteer -->

						<g:if test="${eventRegistrationInstance?.numBrahmacharisVolunteer}">
						<tr class="prop">
							<td class="name">
								<g:message code="eventRegistration.numBrahmacharisVolunteer.label" default="No Of Brahmacharis Volunteer" />
							</td>
							<td class="value">
								<g:fieldValue bean="${eventRegistrationInstance}" field="numBrahmacharisVolunteer"/>
							</td>
						</tr>
						</g:if>

						<!-- No Of Prabhuji Volunteer -->

						<g:if test="${eventRegistrationInstance?.numPrjiVolunteer}">
						<tr class="prop">
							<td class="name">
								<g:message code="eventRegistration.numPrjiVolunteer.label" default="No Of Prabhuji Volunteer" />
							</td>
							<td class="value">
								<g:fieldValue bean="${eventRegistrationInstance}" field="numPrjiVolunteer"/>
							</td>
						</tr>
						</g:if>

						<!-- No Of Mataji Volunteer -->

						<g:if test="${eventRegistrationInstance?.numMatajiVolunteer}">
						<tr class="prop">
							<td class="name">
								<g:message code="eventRegistration.numMatajiVolunteer.label" default="No Of Mataji Volunteer" />
							</td>
							<td class="value">
								<g:fieldValue bean="${eventRegistrationInstance}" field="numMatajiVolunteer"/>
							</td>
						</tr>
						</g:if>

						
						<!-- Is Accommodation Required -->

						<g:if test="${eventRegistrationInstance?.isAccommodationRequired}">
						<tr class="prop">
							<td class="name">
								<g:message code="eventRegistration.isAccommodationRequired.label" default="Is Accommodation Required" />
							</td>
							<td class="value">
								<g:formatBoolean boolean="${eventRegistrationInstance.isAccommodationRequired}" true="Yes" false="No"/>
							</td>
						</tr>
						</g:if>
						
					</tbody></table></div>

				</div>
				</g:if>

				<sec:ifAnyGranted roles="ROLE_VIP_COORDINATOR,ROLE_VIP_REGISTRATION"><div class="collection_group">

					<div class="dialog"><table><tbody>

						<tr class="prop"><div class="caption_title">VIP Devotee Information</div></tr>

						<!-- Is VIP Devotee -->

						<g:if test="${eventRegistrationInstance?.isVipDevotee}">
						<tr class="prop">
							<td class="name">
								<g:message code="eventRegistration.isVipDevotee.label" default="Is VIP Devotee" />
							</td>
							<td class="value">
								<g:formatBoolean boolean="${eventRegistrationInstance.isVipDevotee}" true="Yes" false="No"/>
							</td>
						</tr>
						</g:if>

						<!-- Special Instructions -->

						<g:if test="${eventRegistrationInstance?.specialInstructions}">
						<tr class="prop">
							<td class="name">
								<g:message code="eventRegistration.specialInstructions.label" default="Special Instructions" />
							</td>
							<td class="value">
								<g:fieldValue bean="${eventRegistrationInstance}" field="specialInstructions"/>
							</td>
						</tr>
						</g:if>
						
					</tbody></table></div>

				</div></sec:ifAnyGranted>

				<div class="collection_group">

					<div class="dialog"><table><tbody>

						<tr class="prop"><div class="caption_title">Arival Information</div><tr>

						<!-- Arrival Date -->

						<g:if test="${eventRegistrationInstance?.arrivalDate}">
						<tr class="prop">
							<td class="name">
								<g:message code="eventRegistration.arrivalDate.label" default="Arrival Date" />
							</td>
							<td class="value">
								${eventRegistrationInstance?.arrivalDate?.format("dd-MM-yy HH:mm")}
							</td>
						</tr>
						</g:if>

						<!-- Pick Up Required -->

						<g:if test="${eventRegistrationInstance?.pickUpRequired}">
						<tr class="prop">
							<td class="name">
								<g:message code="eventRegistration.pickUpRequired.label" default="Pick Up Required" />
							</td>
							<td class="value">
								<g:formatBoolean boolean="${eventRegistrationInstance.pickUpRequired}" true="Yes" false="No"/>
							</td>
						</tr>
						</g:if>
						
						<!-- Arrival Transport Mode -->

						<g:if test="${eventRegistrationInstance?.arrivalTransportMode}">
						<tr class="prop">
							<td class="name">
								<g:message code="eventRegistration.arrivalTransportMode.label" default="Arrival Transport Mode" />
							</td>
							<td class="value">
								<g:fieldValue bean="${eventRegistrationInstance}" field="arrivalTransportMode.displayName"/>
							</td>
						</tr>
						</g:if>

						<!-- Arrival Bus Station -->

						<g:if test="${eventRegistrationInstance?.arrivalBusStation}">
						<tr class="prop">
							<td class="name">
								<g:message code="eventRegistration.arrivalBusStation.label" default="Arrival Bus Station" />
							</td>
							<td class="value">
								<g:fieldValue bean="${eventRegistrationInstance}" field="arrivalBusStation"/>
							</td>
						</tr>
						</g:if>

						<!-- Arrival Bus Number -->

						<g:if test="${eventRegistrationInstance?.arrivalBusNumber}">
						<tr class="prop">
							<td class="name">
								<g:message code="eventRegistration.arrivalBusNumber.label" default="Arrival Bus Number" />
							</td>
							<td class="value">
								<g:fieldValue bean="${eventRegistrationInstance}" field="arrivalBusNumber"/>
							</td>
						</tr>
						</g:if>

						<sec:ifAnyGranted roles="ROLE_VIP_COORDINATOR,ROLE_VIP_REGISTRATION">	
						
						<g:if test="${eventRegistrationInstance?.arrivalFlightPickUpPoint}">
						<tr class="prop">
							<td class="name">
								<g:message code="eventRegistration.arrivalFlightPickUpPoint.label" default="Arrival Airport" />
							</td>
							<td class="value">
								<g:fieldValue bean="${eventRegistrationInstance}" field="arrivalFlightPickUpPoint.displayName"/>
							</td>
						</tr>
						</g:if>

						</sec:ifAnyGranted>	

						<!-- Arrival Flight Carrier -->

						<g:if test="${eventRegistrationInstance?.arrivalFlightCarrier}">
						<tr class="prop">
							<td class="name">
								<g:message code="eventRegistration.arrivalFlightCarrier.label" default="Arrival Flight Carrier" />
							</td>
							<td class="value">
								<g:fieldValue bean="${eventRegistrationInstance}" field="arrivalFlightCarrier"/>
							</td>
						</tr>
						</g:if>

						<!-- Arrival Flight Number -->

						<g:if test="${eventRegistrationInstance?.arrivalFlightNumber}">
						<tr class="prop">
							<td class="name">
								<g:message code="eventRegistration.arrivalFlightNumber.label" default="Arrival Flight Number" />
							</td>
							<td class="value">
								<g:fieldValue bean="${eventRegistrationInstance}" field="arrivalFlightNumber"/>
							</td>
						</tr>
						</g:if>

						<sec:ifAnyGranted roles="ROLE_VIP_COORDINATOR,ROLE_VIP_REGISTRATION">	
						
						<g:if test="${eventRegistrationInstance?.arrivalTrainPickUpPoint}">
						<tr class="prop">
							<td class="name">
								<g:message code="eventRegistration.arrivalTrainPickUpPoint.label" default="Arrival Ralway Station" />
							</td>
							<td class="value">
								<g:fieldValue bean="${eventRegistrationInstance}" field="arrivalTrainPickUpPoint.displayName"/>
							</td>
						</tr>
						</g:if>

						</sec:ifAnyGranted>
						
						
						<!-- Arrival Train Name -->

						<g:if test="${eventRegistrationInstance?.arrivalTrainName}">
						<tr class="prop">
							<td class="name">
								<g:message code="eventRegistration.arrivalTrainName.label" default="Arrival Train Name" />
							</td>
							<td class="value">
								<g:fieldValue bean="${eventRegistrationInstance}" field="arrivalTrainName"/>
							</td>
						</tr>
						</g:if>

						<!-- Arrival Train Number -->

						<g:if test="${eventRegistrationInstance?.arrivalTrainNumber}">
						<tr class="prop">
							<td class="name">
								<g:message code="eventRegistration.arrivalTrainNumber.label" default="Arrival Train Number" />
							</td>
							<td class="value">
								<g:fieldValue bean="${eventRegistrationInstance}" field="arrivalTrainNumber"/>
							</td>
						</tr>
						</g:if>

						<!-- Arrival Travelling Details -->

						<g:if test="${eventRegistrationInstance?.arrivalTravelingDetails}">
						<tr class="prop">
							<td class="name">
								<g:message code="eventRegistration.arrivalTravelingDetails.label" default="Arrival Travelling Details" />
							</td>
							<td class="value">
								<g:fieldValue bean="${eventRegistrationInstance}" field="arrivalTravelingDetails"/>
							</td>
						</tr>
						</g:if>

					</tbody></table></div>

			       </div>

			       <div class="collection_group">

					<div class="dialog"><table><tbody>

						<tr class="prop"><div class="caption_title">Departure Information</div><tr>

						<!-- Departure Date -->

						<g:if test="${eventRegistrationInstance?.departureDate}">
						<tr class="prop">
							<td class="name">
								<g:message code="eventRegistration.departureDate.label" default="Departure Date" />
							</td>
							<td class="value">
								${eventRegistrationInstance?.departureDate?.format("dd-MM-yy HH:mm")}
							</td>
						</tr>
						</g:if>

						<!-- Drop Required -->

						<g:if test="${eventRegistrationInstance?.dropRequired}">
						<tr class="prop">
							<td class="name">
								<g:message code="eventRegistration.dropRequired.label" default="Drop Required" />
							</td>
							<td class="value">
								<g:formatBoolean boolean="${eventRegistrationInstance.dropRequired}" true="Yes" false="No"/>
							</td>
						</tr>
						</g:if>
						
						<!-- Departure Transport Mode -->

						<g:if test="${eventRegistrationInstance?.departureTransportMode}">
						<tr class="prop">
							<td class="name">
								<g:message code="eventRegistration.departureTransportMode.label" default="Departure Transport Mode" />
							</td>
							<td class="value">
								<g:fieldValue bean="${eventRegistrationInstance}" field="departureTransportMode.displayName"/>
							</td>
						</tr>
						</g:if>

						<!-- Departure Bus Station -->

						<g:if test="${eventRegistrationInstance?.departureBusStation}">
						<tr class="prop">
							<td class="name">
								<g:message code="eventRegistration.departureBusStation.label" default="Departure Bus Station" />
							</td>
							<td class="value">
								<g:fieldValue bean="${eventRegistrationInstance}" field="departureBusStation"/>
							</td>
						</tr>
						</g:if>

						<!-- Departure Bus Number -->

						<g:if test="${eventRegistrationInstance?.departureBusNumber}">
						<tr class="prop">
							<td class="name">
								<g:message code="eventRegistration.departureBusNumber.label" default="Departure Bus Number" />
							</td>
							<td class="value">
								<g:fieldValue bean="${eventRegistrationInstance}" field="departureBusNumber"/>
							</td>
						</tr>
						</g:if>

						<sec:ifAnyGranted roles="ROLE_VIP_COORDINATOR,ROLE_VIP_REGISTRATION">	
						
						<g:if test="${eventRegistrationInstance?.departureFlightDropPoint}">
						<tr class="prop">
							<td class="name">
								<g:message code="eventRegistration.departureFlightDropPoint.label" default="Departure Airport" />
							</td>
							<td class="value">
								<g:fieldValue bean="${eventRegistrationInstance}" field="departureFlightDropPoint.displayName"/>
							</td>
						</tr>
						</g:if>

						</sec:ifAnyGranted>	
						
						<!-- Departure Flight Carrier -->

						<g:if test="${eventRegistrationInstance?.departureFlightCarrier}">
						<tr class="prop">
							<td class="name">
								<g:message code="eventRegistration.departureFlightCarrier.label" default="Departure Flight Carrier" />
							</td>
							<td class="value">
								<g:fieldValue bean="${eventRegistrationInstance}" field="departureFlightCarrier"/>
							</td>
						</tr>
						</g:if>

						<!-- Departure Flight Number -->

						<g:if test="${eventRegistrationInstance?.departureFlightNumber}">
						<tr class="prop">
							<td class="name">
								<g:message code="eventRegistration.departureFlightNumber.label" default="Departure Flight Number" />
							</td>
							<td class="value">
								<g:fieldValue bean="${eventRegistrationInstance}" field="departureFlightNumber"/>
							</td>
						</tr>
						</g:if>

						<sec:ifAnyGranted roles="ROLE_VIP_COORDINATOR,ROLE_VIP_REGISTRATION">	
						
						<g:if test="${eventRegistrationInstance?.departureTrainDropPoint}">
						<tr class="prop">
							<td class="name">
								<g:message code="eventRegistration.departureTrainDropPoint.label" default="Departure Ralway Station" />
							</td>
							<td class="value">
								<g:fieldValue bean="${eventRegistrationInstance}" field="departureTrainDropPoint.displayName"/>
							</td>
						</tr>
						</g:if>

						</sec:ifAnyGranted>

						<!-- Departure Train Name -->

						<g:if test="${eventRegistrationInstance?.departureTrainName}">
						<tr class="prop">
							<td class="name">
								<g:message code="eventRegistration.departureTrainName.label" default="Departure Train Name" />
							</td>
							<td class="value">
								<g:fieldValue bean="${eventRegistrationInstance}" field="departureTrainName"/>
							</td>
						</tr>
						</g:if>

						<!-- Departure Train Number -->

						<g:if test="${eventRegistrationInstance?.departureTrainNumber}">
						<tr class="prop">
							<td class="name">
								<g:message code="eventRegistration.departureTrainNumber.label" default="Departure Train Number" />
							</td>
							<td class="value">
								<g:fieldValue bean="${eventRegistrationInstance}" field="departureTrainNumber"/>
							</td>
						</tr>
						</g:if>

						<!-- Departure Travelling Details -->

						<g:if test="${eventRegistrationInstance?.departureTravelingDetails}">
						<tr class="prop">
							<td class="name">
								<g:message code="eventRegistration.departureTravelingDetails.label" default="Departure Travelling Details" />
							</td>
							<td class="value">
								<g:fieldValue bean="${eventRegistrationInstance}" field="departureTravelingDetails"/>
							</td>
						</tr>
						</g:if>

					</tbody></table></div>

			       </div>

			       <g:if test="${eventRegistrationInstance?.isTravelingPrasadRequired}">

			       <div class="collection_group">

					<div class="dialog"><table><tbody>

						<tr class="prop"><div class="caption_title">Travelling Prasad Information</div></tr>

						<!-- Prasad in Travelling -->

						<g:if test="${eventRegistrationInstance?.isTravelingPrasadRequired}">
						<tr class="prop">
							<td class="name">
								<g:message code="eventRegistration.isTravelingPrasadRequired.label" default="Is Traveling Prasad Required" />
							</td>
							<td class="value">
								<g:formatBoolean boolean="${eventRegistrationInstance.isTravelingPrasadRequired}" true="Yes" false="No"/>
							</td>
						</tr>
						</g:if>

						<!-- No Of Breakfasts -->

						<g:if test="${eventRegistrationInstance?.noofBreakfasts}">
						<tr class="prop">
							<td class="name">
								<g:message code="eventRegistration.noofBreakfasts.label" default="No Of Breakfasts" />
							</td>
							<td class="value">
								<g:fieldValue bean="${eventRegistrationInstance}" field="noofBreakfasts"/>
							</td>
						</tr>
						</g:if>

						<!-- No Of Lunches -->

						<g:if test="${eventRegistrationInstance?.noofLunches}">
						<tr class="prop">
							<td class="name">
								<g:message code="eventRegistration.noofLunches.label" default="No Of Lunches" />
							</td>
							<td class="value">
								<g:fieldValue bean="${eventRegistrationInstance}" field="noofLunches"/>
							</td>
						</tr>
						</g:if>

						<!-- No Of Dinners -->

						<g:if test="${eventRegistrationInstance?.noofDinners}">
						<tr class="prop">
							<td class="name">
								<g:message code="eventRegistration.noofDinners.label" default="No Of Dinners" />
							</td>
							<td class="value">
								<g:fieldValue bean="${eventRegistrationInstance}" field="noofDinners"/>
							</td>
						</tr>
						</g:if>
						
					</tbody></table></div>

				</div>
				</g:if>

				<sec:ifAnyGranted roles="ROLE_VIP_COORDINATOR,ROLE_VIP_REGISTRATION,ROLE_COMMUNICATION_COORDINATOR,ROLE_REGISTRATION_COORDINATOR,ROLE_EVENTMANAGER,ROLE_EVENTADMIN,ROLE_NVCC_ADMIN">
				<g:if test="${eventRegistrationInstance?.verificationComments}">
			        <div class="collection_group">

					<div class="dialog"><table><tbody>

						<tr class="prop"><div class="caption_title">Verification Comments</div></tr>

						<!-- Verification Comments -->

						<g:if test="${eventRegistrationInstance?.verificationComments}">
						<tr class="prop">
							<td class="name">
								<g:message code="eventRegistration.verificationComments.label" default="Verification Comments" />
							</td>
							<td class="value">
								<g:fieldValue bean="${eventRegistrationInstance}" field="verificationComments"/>
							</td>
						</tr>
						</g:if>
						
					</tbody></table></div>

				</div>
				</g:if>
				</sec:ifAnyGranted>
			
			</ol>
			<sec:ifAnyGranted roles="ROLE_VIP_COORDINATOR,ROLE_VIP_REGISTRATION,ROLE_REGISTRATION_COORDINATOR,ROLE_EVENTADMIN,ROLE_EVENTPARTICIPANT,ROLE_ACCOMMODATION_COORDINATOR,ROLE_VIP_ACCOMMODATION">
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${eventRegistrationInstance?.id}" />
					<g:hiddenField name="version" value="${eventRegistrationInstance?.version}" />
					<div class="registrationOperations">
					<table><tbody>
						<tr class="prop">
							<td valign="top">
							    
							    <sec:ifAnyGranted roles="ROLE_EVENTPARTICIPANT">
								    <div class="buttons" style="width:80px;">
								    <span class="button">
									<g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" />
								    </span>
								    </div>
							    </sec:ifAnyGranted>
							    <sec:ifAnyGranted roles="ROLE_REGISTRATION_COORDINATOR,ROLE_EVENTADMIN">
								    <div class="buttons" style="width:410px;">
								    <span class="button">
									<g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" />
									<g:actionSubmit class="save" action="verified" value="${message(code: 'default.button.verified.label', default: 'Verified')}" />
									<g:actionSubmit class="save" action="underVerification" value="${message(code: 'default.button.underVerification.label', default: 'Under Verification')}" />
									<input class="delete" type="BUTTON" id="reject" value="${message(code: 'default.button.rejected.label', default: 'Rejected')}" />
								    </span>
								    </div>
							    </sec:ifAnyGranted>
							    <sec:ifAnyGranted roles="ROLE_VIP_COORDINATOR,ROLE_VIP_REGISTRATION">
								    <div class="buttons" style="width:410px;">
								    <span class="button">
									<g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" />
									<g:actionSubmit class="save" action="verified" value="${message(code: 'default.button.verified.label', default: 'Confirmed')}" />
									<g:actionSubmit class="save" action="underVerification" value="${message(code: 'default.button.underVerification.label', default: 'Under Process')}" />
									<input class="delete" type="BUTTON" id="reject" value="${message(code: 'default.button.rejected.label', default: 'Not Confirmed')}" />
								    </span>
								    </div>
							    </sec:ifAnyGranted>
							    <sec:ifAnyGranted roles="ROLE_ACCOMMODATION_COORDINATOR,ROLE_EVENTADMIN,ROLE_VIP_COORDINATOR,ROLE_VIP_ACCOMMODATION">
								    <g:if test="${eventRegistrationInstance?.isAccommodationRequired}">
								    <div class="buttons" style="width:410px;">
								    <span class="button">
									<g:actionSubmit class="save" action="rejectAcco" value="AccommodationRejected" />
									<g:actionSubmit class="save" action="rejectAcco" value="AccommodationReset" />
								    </span>
								    </div>
								    </g:if>
							    </sec:ifAnyGranted>
							</td>
						</tr>
					</tbody></table>
					</div>
				</fieldset>
			</g:form>
			</sec:ifAnyGranted>
		</div>

		<div class="dialog" id="commentsDiv" title="Rejection Comments">
		    <form>
		   	<g:hiddenField name="id" value="${eventRegistrationInstance?.id}" />
			<g:hiddenField name="version" value="${eventRegistrationInstance?.version}" />
			<tbody>
			    <tr>
			    <label for="verificationComments">
				<g:message code="eventRegistration.verificationComments" default="Verification Comments" />
			    </label>
			    </tr>
			    <tr>
			    <g:textArea name="verificationComments" value="${eventRegistrationInstance?.verificationComments}"/>
			    </tr>
			    <tr>
				<g:actionSubmit class="save" action="rejected" value="${message(code: 'default.button.rejected.label', default: 'Rejected')}" />
			    </tr>
			</tbody>
		    </form>
		</div>
	
	<script>
	  $(document).ready(function () {
	     
	     $( "#reject" )
			.button()
			.click(function() {
				$( "#commentsDiv" ).dialog( "open" );
			});

		$( "#commentsDiv" ).dialog({
			autoOpen: false,
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
