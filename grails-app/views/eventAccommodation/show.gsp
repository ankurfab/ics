
<%@ page import="ics.EventAccommodation" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="eventAccommodation.show" default="Show EventAccommodation" /></title>
	<r:require module="grid" />
    </head>
    <body onLoad="return tabOrders();">
		<script>
			$(function() {
				$( "#tabs" ).tabs();
			});		
		</script>

        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="eventAccommodation.list" default="EventAccommodation List" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="eventAccommodation.new" default="New EventAccommodation" /></g:link></span>
        </div>
        <div class="body">
            <h1>${eventAccommodationInstance?.name}</h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            	<div id="tabs">
		        <ul>
				<li><a href="#AccommodationDetails">Accommodation Details</a></li>
				<li><a href="#AllotmentDetails">Allotment Details</a></li>
			</ul>
			<div id="AccommodationDetails" class="dialog">
			    <table>
				<tbody>
				
				    <g:if test="${eventAccommodationInstance?.name}">
				    <tr class="prop">
					<td valign="top" class="name"><sec:ifAnyGranted roles="ROLE_VIP_COORDINATOR,ROLE_VIP_ACCOMMODATION">
									   <g:message code="eventAccommodation.name" default="Host Name" />
								      </sec:ifAnyGranted>
								      <sec:ifNotGranted roles="ROLE_VIP_COORDINATOR,ROLE_VIP_ACCOMMODATION">
									   <g:message code="eventAccommodation.name" default="Accommodation Name" />
								      </sec:ifNotGranted>:</td>
					
					<td valign="top" class="value">${fieldValue(bean: eventAccommodationInstance, field: "name")}</td>
					
				    </tr>
				    </g:if>

				    <g:if test="${eventAccommodationInstance?.address}">
				    <tr class="prop">
					<td valign="top" class="name"><g:message code="eventAccommodation.address" default="Address" />:</td>
					
					<td valign="top" class="value">${fieldValue(bean: eventAccommodationInstance, field: "address")}</td>
					
				    </tr>
				    </g:if>

				    <g:if test="${eventAccommodationInstance?.hostMobileNumber}">
				    <tr class="prop">
					<td valign="top" class="name"><g:message code="eventAccommodation.hostMobileNumber" default="Host Mobile Number" />:</td>
					
					<td valign="top" class="value">${fieldValue(bean: eventAccommodationInstance, field: "hostMobileNumber")}</td>
					
				    </tr>
				    </g:if>

				    <g:if test="${eventAccommodationInstance?.hostAlternateMobileNumber}">
				    <tr class="prop">
					<td valign="top" class="name"><g:message code="eventAccommodation.hostAlternateMobileNumber" default="Host Alternate Mobile Number" />:</td>
					
					<td valign="top" class="value">${fieldValue(bean: eventAccommodationInstance, field: "hostAlternateMobileNumber")}</td>
					
				    </tr>
				    </g:if>

				    <g:if test="${eventAccommodationInstance?.hostEmail}">
				    <tr class="prop">
					<td valign="top" class="name"><g:message code="eventAccommodation.hostEmail" default="Host Email" />:</td>
					
					<td valign="top" class="value">${fieldValue(bean: eventAccommodationInstance, field: "hostEmail")}</td>
					
				    </tr>
				    </g:if>

				    <g:if test="${eventAccommodationInstance?.comments}">
				    <tr class="prop">
					<td valign="top" class="name"><g:message code="eventAccommodation.comments" default="Comments" />:</td>
					
					<td valign="top" class="value">${fieldValue(bean: eventAccommodationInstance, field: "comments")}</td>
					
				    </tr>
				    </g:if>
				    
				    <tr class="prop">
					<td valign="top" class="name"><g:message code="eventAccommodation.maxCapacity" default="Max Capacity" />:</td>
					
					<td valign="top" class="value">${fieldValue(bean: eventAccommodationInstance, field: "maxCapacity")}</td>
					
				    </tr>

				    <g:if test="${eventAccommodationInstance?.availableFromDate}">
				    <tr class="prop">
					<td valign="top" class="name"><g:message code="eventAccommodation.availableFromDate" default="Available From Date" />:</td>
					
					<td valign="top" class="value"><g:formatDate format="dd-MM-yyyy HH:mm a" date="${eventAccommodationInstance?.availableFromDate}" /></td>
					
				    </tr>
				    </g:if>
				    
				    <g:if test="${eventAccommodationInstance?.availableTillDate}">
				    <tr class="prop">
					<td valign="top" class="name"><g:message code="eventAccommodation.availableTillDate" default="Available Till Date" />:</td>
					
					<td valign="top" class="value"><g:formatDate format="dd-MM-yyyy HH:mm a" date="${eventAccommodationInstance?.availableTillDate}" /></td>
					
				    </tr>
				    </g:if>
				    
				    <g:if test="${eventAccommodationInstance?.dateofBooking}">
				    <tr class="prop">
					<td valign="top" class="name"><g:message code="eventAccommodation.dateofBooking" default="Date of Booking" />:</td>
					
					<td valign="top" class="value"><g:formatDate format="dd-MM-yyyy" date="${eventAccommodationInstance?.dateofBooking}" /></td>
					
				    </tr>
				    </g:if>

				    <g:if test="${eventAccommodationInstance?.negotiatedRate}">
				    <tr class="prop">
					<td valign="top" class="name"><g:message code="eventAccommodation.negotiatedRate" default="Negotiated Rate" />:</td>
					
					<td valign="top" class="value">${fieldValue(bean: eventAccommodationInstance, field: "negotiatedRate")}</td>
					
				    </tr>
				    </g:if>
				    
				    <g:if test="${eventAccommodationInstance?.advanceGiven}">
				    <tr class="prop">
					<td valign="top" class="name"><g:message code="eventAccommodation.advanceGiven" default="Advance Given" />:</td>
					
					<td valign="top" class="value">${fieldValue(bean: eventAccommodationInstance, field: "advanceGiven")}</td>
					
				    </tr>
				    </g:if>
				    
				    <g:if test="${eventAccommodationInstance?.accommodationInChargeName}">
				    <tr class="prop">
					<td valign="top" class="name">Devotee In Charge Name:</td>
					
					<td valign="top" class="value">${fieldValue(bean: eventAccommodationInstance, field: "accommodationInChargeName")}</td>
					
				    </tr>
				    </g:if>
				    
				    <g:if test="${eventAccommodationInstance?.accommodationInChargeContactNumber}">
				    <tr class="prop">
					<td valign="top" class="name">Devotee In Charge Contact Number:</td>
					
					<td valign="top" class="value">${fieldValue(bean: eventAccommodationInstance, field: "accommodationInChargeContactNumber")}</td>
					
				    </tr>
				    </g:if>
				    
				    <g:if test="${eventAccommodationInstance?.isAccommodationContactSame}">
				    <tr class="prop">
					<td valign="top" class="name"><g:message code="eventAccommodation.isAccommodationContactSame" default="Is Accommodation Contact Same" />:</td>
					
					<td valign="top" class="value"><g:formatBoolean boolean="${eventAccommodationInstance?.isAccommodationContactSame}" true="Yes" false="No"/></td>
					
				    </tr>
				    </g:if>
				    
				    <g:if test="${eventAccommodationInstance?.accommodationContactNumber}">
				    <tr class="prop">
					<td valign="top" class="name"><g:message code="eventAccommodation.accommodationContactNumber" default="Accommodation Contact Number" />:</td>
					
					<td valign="top" class="value">${fieldValue(bean: eventAccommodationInstance, field: "accommodationContactNumber")}</td>
					
				    </tr>
				    </g:if>
				    
				    <g:if test="${eventAccommodationInstance?.accommodationContactPerson}">
				    <tr class="prop">
					<td valign="top" class="name"><g:message code="eventAccommodation.accommodationContactPerson" default="Accommodation Contact Person" />:</td>
					
					<td valign="top" class="value">${fieldValue(bean: eventAccommodationInstance, field: "accommodationContactPerson")}</td>
					
				    </tr>
				    </g:if>
				    
				    <g:if test="${eventAccommodationInstance?.rankOverall}">
				    <tr class="prop">
					<td valign="top" class="name"><g:message code="eventAccommodation.rankOverall" default="Rank Overall" />:</td>
					
					<td valign="top" class="value">${fieldValue(bean: eventAccommodationInstance, field: "rankOverall")}</td>
					
				    </tr>
				    </g:if>

				    <g:if test="${eventAccommodationInstance?.rankNearnesstoNVCC}">
				    <tr class="prop">
					<td valign="top" class="name"><g:message code="eventAccommodation.rankNearnesstoNVCC" default="Rank Nearnessto NVCC" />:</td>
					
					<td valign="top" class="value">${fieldValue(bean: eventAccommodationInstance, field: "rankNearnesstoNVCC")}</td>
					
				    </tr>
				    </g:if>
				    
				    <g:if test="${eventAccommodationInstance?.rankEconomical}">
				    <tr class="prop">
					<td valign="top" class="name"><g:message code="eventAccommodation.rankEconomical" default="Rank Economical" />:</td>
					
					<td valign="top" class="value">${fieldValue(bean: eventAccommodationInstance, field: "rankEconomical")}</td>
					
				    </tr>
				    </g:if>
				    
				    <g:if test="${eventAccommodationInstance?.rankSafety}">
				    <tr class="prop">
					<td valign="top" class="name"><g:message code="eventAccommodation.rankSafety" default="Rank Safety" />:</td>
					
					<td valign="top" class="value">${fieldValue(bean: eventAccommodationInstance, field: "rankSafety")}</td>
					
				    </tr>
				    </g:if>
				    
				    <g:if test="${eventAccommodationInstance?.rankFacilities}">
				    <tr class="prop">
					<td valign="top" class="name"><g:message code="eventAccommodation.rankFacilities" default="Rank Facilities" />:</td>
					
					<td valign="top" class="value">${fieldValue(bean: eventAccommodationInstance, field: "rankFacilities")}</td>
					
				    </tr>
				    </g:if>
				    
				    <g:if test="${eventAccommodationInstance?.rankCleanlinessStandard}">
				    <tr class="prop">
					<td valign="top" class="name"><g:message code="eventAccommodation.rankCleanlinessStandard" default="Rank Cleanliness Standard" />:</td>
					
					<td valign="top" class="value">${fieldValue(bean: eventAccommodationInstance, field: "rankCleanlinessStandard")}</td>
					
				    </tr>
				    </g:if>

				    <g:if test="${eventAccommodationInstance?.rankAttachedTNB}">
				    <tr class="prop">
					<td valign="top" class="name"><g:message code="eventAccommodation.rankAttachedTNB" default="Rank Attached Toilet & Bathroom" />:</td>
					
					<td valign="top" class="value">${fieldValue(bean: eventAccommodationInstance, field: "rankAttachedTNB")}</td>
					
				    </tr>
				    </g:if>

				    <g:if test="${eventAccommodationInstance?.rankElevator}">
				    <tr class="prop">
					<td valign="top" class="name"><g:message code="eventAccommodation.rankElevator" default="Rank Elevator" />:</td>
					
					<td valign="top" class="value">${fieldValue(bean: eventAccommodationInstance, field: "rankElevator")}</td>
					
				    </tr>
				    </g:if>
				    
				    <g:if test="${eventAccommodationInstance?.rankCooking}">
				    <tr class="prop">
					<td valign="top" class="name"><g:message code="eventAccommodation.rankCooking" default="Rank Cooking" />:</td>
					
					<td valign="top" class="value">${fieldValue(bean: eventAccommodationInstance, field: "rankCooking")}</td>
					
				    </tr>
				    </g:if>

				    <g:if test="${eventAccommodationInstance?.distanceFromNVCC}">
				    <tr class="prop">
					<td valign="top" class="name"><g:message code="eventAccommodation.distanceFromNVCC" default="Distance From NVCC" />:</td>
					
					<td valign="top" class="value">${fieldValue(bean: eventAccommodationInstance, field: "distanceFromNVCC")}</td>
					
				    </tr>
				    </g:if>
				    				    
				    <g:if test="${eventAccommodationInstance?.capacityofAllDormitories}">
				    <tr class="prop">
					<td valign="top" class="name"><g:message code="eventAccommodation.capacityofAllDormitories" default="Capacityof All Dormitories" />:</td>
					
					<td valign="top" class="value">${fieldValue(bean: eventAccommodationInstance, field: "capacityofAllDormitories")}</td>
					
				    </tr>
				    </g:if>
				    
				    <g:if test="${eventAccommodationInstance?.numberofToilets}">
				    <tr class="prop">
					<td valign="top" class="name"><g:message code="eventAccommodation.numberofToilets" default="Numberof Toilets" />:</td>
					
					<td valign="top" class="value">${fieldValue(bean: eventAccommodationInstance, field: "numberofToilets")}</td>
					
				    </tr>
				    </g:if>
				    
				    <g:if test="${eventAccommodationInstance?.numberofBathrooms}">
				    <tr class="prop">
					<td valign="top" class="name"><g:message code="eventAccommodation.numberofBathrooms" default="Numberof Bathrooms" />:</td>
					
					<td valign="top" class="value">${fieldValue(bean: eventAccommodationInstance, field: "numberofBathrooms")}</td>
					
				    </tr>
				    </g:if>
				    
				    <g:if test="${eventAccommodationInstance?.numberofRooms}">
				    <tr class="prop">
					<td valign="top" class="name"><g:message code="eventAccommodation.numberofRooms" default="Numberof Rooms" />:</td>
					
					<td valign="top" class="value">${fieldValue(bean: eventAccommodationInstance, field: "numberofRooms")}</td>
					
				    </tr>
				    </g:if>
				    
				    <g:if test="${eventAccommodationInstance?.isGeneratorBackUpAvailable}">
				    <tr class="prop">
					<td valign="top" class="name"><g:message code="eventAccommodation.isGeneratorBackUpAvailable" default="Is Generator Back Up Available" />:</td>
					
					<td valign="top" class="value"><g:formatBoolean boolean="${eventAccommodationInstance.isGeneratorBackUpAvailable}" true="Yes" false="No"/></td>
					
				    </tr>
				    </g:if>
				    
				    <g:if test="${eventAccommodationInstance?.numberofClothesLine}">
				    <tr class="prop">
					<td valign="top" class="name"><g:message code="eventAccommodation.numberofClothesLine" default="Numberof Clothes Line" />:</td>
					
					<td valign="top" class="value">${fieldValue(bean: eventAccommodationInstance, field: "numberofClothesLine")}</td>
					
				    </tr>
				    </g:if>
				    
				    <g:if test="${eventAccommodationInstance?.numberofBuckets}">
				    <tr class="prop">
					<td valign="top" class="name"><g:message code="eventAccommodation.numberofBuckets" default="Numberof Buckets" />:</td>
					
					<td valign="top" class="value">${fieldValue(bean: eventAccommodationInstance, field: "numberofBuckets")}</td>
					
				    </tr>
				    </g:if>

				    <g:if test="${eventAccommodationInstance?.isCookAvailableForGuest}">
				    <tr class="prop">
					<td valign="top" class="name"><g:message code="eventAccommodation.isCookAvailableForGuest" default="Is Cook Available For Guest" />:</td>
					
					<td valign="top" class="value"><g:formatBoolean boolean="${eventAccommodationInstance.isCookAvailableForGuest}" true="Yes" false="No"/></td>
					
				    </tr>
				    </g:if>

				    <g:if test="${eventAccommodationInstance?.areThereChildrensBelow12Years}">
				    <tr class="prop">
					<td valign="top" class="name"><g:message code="eventAccommodation.areThereChildrensBelow12Years" default="Are There Childrens Below 12 Years" />:</td>
					
					<td valign="top" class="value"><g:formatBoolean boolean="${eventAccommodationInstance.areThereChildrensBelow12Years}" true="Yes" false="No"/></td>
					
				    </tr>
				    </g:if>

				    <g:if test="${eventAccommodationInstance?.isInternetFascilityAvailable}">
				    <tr class="prop">
					<td valign="top" class="name"><g:message code="eventAccommodation.isInternetFascilityAvailable" default="Is Internet Facility Available" />:</td>
					
					<td valign="top" class="value"><g:formatBoolean boolean="${eventAccommodationInstance.isInternetFascilityAvailable}" true="Yes" false="No"/></td>
					
				    </tr>
				    </g:if>

				    <g:if test="${eventAccommodationInstance?.isElevatorFascilityAvailable}">
				    <tr class="prop">
					<td valign="top" class="name"><g:message code="eventAccommodation.isElevatorFascilityAvailable" default="Is Elevator Facility Available" />:</td>
					
					<td valign="top" class="value"><g:formatBoolean boolean="${eventAccommodationInstance.isElevatorFascilityAvailable}" true="Yes" false="No"/></td>
					
				    </tr>
				    </g:if>
				    
				    <g:if test="${eventAccommodationInstance?.isCarFacilityAvailable}">
				    <tr class="prop">
					<td valign="top" class="name"><g:message code="eventAccommodation.isCarFacilityAvailable" default="Is Car Facility Available" />:</td>
					
					<td valign="top" class="value"><g:formatBoolean boolean="${eventAccommodationInstance.isCarFacilityAvailable}" true="Yes" false="No"/></td>
					
				    </tr>
				    </g:if>
				    
				    <!--<tr class="prop">
					<td valign="top" class="name">Accommodation Allocation Mode:</td>
					
					<td valign="top" class="value"><g:if test="${eventAccommodationInstance.manualMode}">MANUAL</g:if><g:if test="${eventAccommodationInstance.chart}">AUTO</g:if></td>
					
				    </tr>-->

				</tbody>
			    </table>
			</div>

			<div id="AllotmentDetails">
				<!-- table tag will hold our grid -->
				<table id="summary_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
				<!-- pager will hold our paginator -->
				<div id="summary_list_pager" class="scroll" style="text-align:center;"></div>

				<!-- table tag will hold our grid -->
				<table id="registration_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
				<!-- pager will hold our paginator -->
				<div id="registration_list_pager" class="scroll" style="text-align:center;"></div>

				<!-- table tag will hold our grid -->
				<table id="checkin_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
				<!-- pager will hold our paginator -->
				<div id="checkin_list_pager" class="scroll" style="text-align:center;"></div>

				<div>
				<input class="menuButton" type="BUTTON" id="btnSMS" value="SMS" gridName="#checkin_list" entityName="EventRegistration"/>
				</div>
				<g:render template="/common/sms" />

			</div>
		</div>
	     <g:form>
                <g:hiddenField name="id" value="${eventAccommodationInstance?.id}" />
		<g:hiddenField name="version" value="${eventAccommodationInstance?.version}" />
                <div class="buttons">
			    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'edit', 'default': 'Edit')}" /></span>
			    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'delete', 'default': 'Delete')}" onclick="return confirm('${message(code: 'delete.confirm', 'default': 'Are you sure?')}');" /></span>
                    <!--<g:if test="${eventAccommodationInstance.chart==null}">
			    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'edit', 'default': 'Edit')}" /></span>
			    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'delete', 'default': 'Delete')}" onclick="return confirm('${message(code: 'delete.confirm', 'default': 'Are you sure?')}');" /></span>
			    <g:if test="${!eventAccommodationInstance.manualMode}">
			    <span class="button"><g:actionSubmit class="list" action="prepareChart" value="SetAutoMode" onclick="return confirm('${message(code: 'delete.confirm', 'default': 'Are you sure?')}');" /></span>
			    </g:if>
                    </g:if>
                    <g:if test="${!eventAccommodationInstance.manualMode}">
			    <span class="button"><g:actionSubmit class="list" action="setManualMode" value="SetManualMode" onclick="return confirm('${message(code: 'delete.confirm', 'default': 'Are you sure?')}');" /></span>
                    </g:if>-->
                </div>
            </g:form>
        </div>
	<script language="javascript"> 
		function tabOrders() {
			return true;
		}
	</script>

	<script type="text/javascript">
		  $(document).ready(function () {

			var lastsel;
			jQuery("#registration_list").jqGrid({
				url:'${createLink(controller:'EventAccommodation',action:'jq_registration_list',id:eventAccommodationInstance.id)}',
				datatype: "json",
				colNames:['Guest Name','Phone','Reg Code', 'From', 'Till', 'Total Allotted', 'Prabhujis Allotted','Matajis Allotted','Childrens Allotted','Brahmacharis Allotted','id'],
				colModel:[
				       {name:'GuestName', searchable:true,
					formatter:'showlink', 
					formatoptions:{baseLinkUrl:'${createLink(controller:'AccommodationAllotment',action:'allot')}'}},
					{name:'contactNumber',searchable:true},
					{name:'reg_code',searchable:true},
					{name:'date_from', search:false, edit:false},
					{name:'date_till', search:false, edit:false},
					{name:'number_allotted',search:false, edit:false},
					{name:'numberof_prabhujis_allotted',search:false, edit:false},
					{name:'numberof_matajis_allotted',search:false, edit:false},
					{name:'numberof_children_allotted',search:false, edit:false},
					{name:'numberof_brahmacharis_allotted',search:false, edit:false},
					{name:'id',hidden:true}	
				],
				 rowNum:10,
				 rowList:[10,20,30,40,50,100,200],
				 pager:'#registration_list_pager',
				 viewrecords: true,
				 gridview: true,
				 multisearch: true,
				 sopt:['eq','ne','cn','bw','bn', 'ilike'],
				 sortorder: "asc",
				 width: 1150,
				 height: "100%",
				 onSelectRow: function(id){
					if(id && id!==lastsel){
						jQuery('#registration_list').jqGrid('restoreRow',lastsel);
						jQuery('#registration_list').jqGrid('editRow',id,true);
						lastsel=id;
					}
				},
				editurl:'${createLink(controller:'EventAccommodation',action:'jq_edit_registrations')}',
				caption:"Accommodation Allotment List",
				footerrow : true,
				userDataOnFooter : true				
			});
			 //$("#registration_list").jqGrid('filterToolbar',{autosearch:true});
			 jQuery("#registration_list").jqGrid('navGrid',"#registration_list_pager",{edit:false,add:false,del:false,search:false});

			jQuery("#checkin_list").jqGrid({
				url:'${createLink(controller:'EventAccommodation',action:'jq_checkin_list',id:eventAccommodationInstance.id)}',
				datatype: "json",
				colNames:['Main Group Leader Name','Main Group Leader Contact','Reg Code', 'SubGroup Leader Name','SubGroup Leader Contact','Total Checkedin', 'Prabhujis Checkedin','Matajis Checkedin','Childrens Checkedin','Brahmacharis Checkedin','id'],
				colModel:[
				       {name:'mglname', searchable:false,
					formatter:'showlink', 
					formatoptions:{baseLinkUrl:'${createLink(controller:'AccommodationAllotment',action:'allot')}'}},
					{name:'contactNumber',searchable:false},
					{name:'reg_code',searchable:false},
					{name:'sglname',searchable:false},
					{name:'sglcontact',searchable:false},
					{name:'numberCheckedin',search:false, edit:false},
					{name:'numberofPrabhujisCheckedin',search:false, edit:false},
					{name:'numberofMatajisCheckedin',search:false, edit:false},
					{name:'numberofChildrenCheckedin',search:false, edit:false},
					{name:'numberofBrahmacharisCheckedin',search:false, edit:false},
					{name:'id',hidden:true}	
				],
				 rowNum:10,
				 rowList:[10,20,30,40,50,100,200],
				 pager:'#checkin_list_pager',
				 viewrecords: true,
				 gridview: true,
				 multisearch: true,
				 sopt:['eq','ne','cn','bw','bn', 'ilike'],
				 sortname: "sglname",
				 sortorder: "asc",
				 width: 1150,
				 height: "100%",
				caption:"Accommodation CheckIn List",
				footerrow : true,
				userDataOnFooter : true				
			});
			 //$("#checkin_list").jqGrid('filterToolbar',{autosearch:true});
			 jQuery("#checkin_list").jqGrid('navGrid',"#checkin_list_pager",{edit:false,add:false,del:false,search:false});

			jQuery("#summary_list").jqGrid({
				url:'${createLink(controller:'EventAccommodation',action:'jq_summary_list',id:eventAccommodationInstance.id)}',
				datatype: "json",
				colNames:['','Total','Prabhuji','Mataji','Children','Brahmacharis/Students','id'],
				colModel:[
					{name:'type',sortable:false},	
					{name:'total',sortable:false},	
					{name:'prji',sortable:false},	
					{name:'mataji',sortable:false},	
					{name:'children',sortable:false},	
					{name:'brahmachris',sortable:false},	
					{name:'id',hidden:true}	
				],
				 rowNum:10,
				 rowList:[10],
				 pager:'#summary_list_pager',
				 viewrecords: true,
				 gridview: true,
				 width: 1150,
				 height: "100%",
				caption:"Accommodation Allotment Summary"
			});
			 jQuery("#summary_list").jqGrid('navGrid',"#summary_list_pager",{edit:false,add:false,del:false,search:false});

		  });

		 function afterSubmitEvent(response, postdata) {
			var success = true;

			var json = eval('(' + response.responseText + ')');
			var message = json.message;

			if(json.state == 'FAIL') {
			    success = false;
			} else {
			  $('#message').html(message);
			  $('#message').show().fadeOut(10000);
			}

			var new_id = json.id
			gridReload();
			return [success,message,new_id];
		    }

		function gridReload(){
			var query = "";
			jQuery("#registration_list").jqGrid('setGridParam',{url:"jq_registration_list?q=2"+query}).trigger("reloadGrid");
		}
	
	</script>
    </body>
</html>
