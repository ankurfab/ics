
<%@ page import="ics.EventAccommodation" %>

<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<title>Accommodation</title>
		<r:require module="grid" />
		<r:require module="export"/>
	</head>
	<body>
		<div class="nav">
		    <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
		    <span class="menuButton"><g:link class="create" action="create"><g:message code="eventAccommodation.new" default="New EventAccommodation" /></g:link></span>
		    <span class="menuButton"><g:link class="list" controller="EventRegistration" action="list">Registration List</g:link></span>
		    <!--<span class="menuButton"><g:link class="list" controller="AccommodationAllotment" action="list">Complete Registration Allotment List</g:link></span>-->
		    <span class="menuButton"><g:link class="list" controller="AccommodationAllotment" action="invalidlist">Invalid Allotment List</g:link></span>
		</div>

		<g:if test="${flash.message}">
		    <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
		</g:if>

		<div id='message' class="message" style="display:none;"></div>

		

		<div id="Accommodation">

			<!-- table tag will hold our grid -->
			<table id="accommodation_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
			<!-- pager will hold our paginator -->
			<div id="accommodation_list_pager" class="scroll" style="text-align:center;"></div>
		</div>

		<export:formats formats="['excel']" controller="helper" action="eventAccoReport"/>

		<script type="text/javascript">// <![CDATA[
		  /* when the page has finished loading.. execute the follow */
		  $(document).ready(function () {

			var lastsel;
			jQuery("#accommodation_list").jqGrid({
				url:'jq_accommodation_list?q=2',
				datatype: "json",
				colNames:['Name', 'Address', 'Comments', 'Rank', 'AvailableFrom','AvailableTill','DevInchargeName', 'DevInchargeNumber','Capacity', 'Allotted', 'Available', 'Checkedin', 'Still to checkin', 'id'],
				colModel:[
					{name:'name', searchable:true,
					formatter:'showlink', 
					formatoptions:{baseLinkUrl:'show', addParam: '&category=edit'}},
					{name:'address', search:true, edit:false},
					{name:'comments', search:true, edit:false},
					{name:'rankOverall', search:true, edit:false},
					{name:'availableFromDate', search:false, edit:false},
					{name:'availableTillDate', search:false, edit:false},
					{name:'accommodationInChargeName', search:true, edit:false},
					{name:'accommodationInChargeContactNumber', search:true, edit:false},
					{name:'maxCapacity', search:true, edit:false},
					{name:'totalAllotted', search:false, edit:false,sortable:false},
					{name:'availableCapacity', search:true, editable:false},
					{name:'totalCheckedin', search:true, editable:false},
					{name:'stillToCheckin', search:false, editable:false,sortable:false},
					{name:'id',hidden:true}	
				],
				 rowNum:10,
				 rowList:[10,20,30,40,50,100,200],
				 pager:'#accommodation_list_pager',
				 viewrecords: true,
				 gridview: true,
				 multisearch: true,
				 sopt:['eq','ne','cn','bw','bn', 'ilike'],
				 sortorder: "asc",
				 width: 1250,
				 height: "100%",
				 onSelectRow: function(id){
					if(id && id!==lastsel){
						jQuery('#accommodation_list').jqGrid('restoreRow',lastsel);
						jQuery('#accommodation_list').jqGrid('editRow',id,true);
						lastsel=id;
					}
				},
				editurl:'jq_edit_accommodations',
				caption:"Accommodation List",
				footerrow : true,
				userDataOnFooter : true								
			});
		        $("#accommodation_list").jqGrid('filterToolbar',{autosearch:true});
			jQuery("#accommodation_list").jqGrid('navGrid',"#accommodation_list_pager",{edit:false,add:false,del:false,search: false});

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
			    
			jQuery("#accommodation_list").jqGrid('setGridParam',{url:"jq_accommodation_list?q=2"+query}).trigger("reloadGrid");

		}
		
		// ]]></script>
	</body>
</html>


