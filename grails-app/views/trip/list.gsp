
<%@ page import="ics.Trip" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="trip.list" default="Trip List" /></title>
	<r:require module="grid" />
	<r:require module="dateTimePicker" />
	<r:require module="export"/>
    </head>
    <body>
		<g:render template="/common/sms" />
		<g:render template="/common/email" />

        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list" controller="Vehicle">Vehicle List</g:link></span>
        </div>
        <div class="body">
            <div>
			<!-- table tag will hold our grid -->
			<table id="arr_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
			<!-- pager will hold our paginator -->
			<div id="arr_list_pager" class="scroll" style="text-align:center;"></div>
			<div>
			  <input class="menuButton" type="BUTTON" id="allottArrTripBtn" value="Allott" />
			  <export:formats formats="['excel']" controller="helper" action="eventArrivalReport"/>
			</div>
	    </div>
            <div>
			<!-- table tag will hold our grid -->
			<table id="dep_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
			<!-- pager will hold our paginator -->
			<div id="dep_list_pager" class="scroll" style="text-align:center;"></div>
			<div>
			  <table>
			  	<tr>
			  		<td><input class="menuButton" type="BUTTON" id="allottDepTripBtn" value="Allott" /></td>
			  		<td>Projected Departures<export:formats formats="['excel']" controller="helper" action="eventDepartureReport"/></td>
			  		<td>Actual Departures (as per runtime)<export:formats formats="['excel']" controller="helper" action="eventDepartureActualReport"/></td>
			  	</tr>
			  </table>
			</div>
	    </div>
            <div>
			<!-- table tag will hold our grid -->
			<table id="trip_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
			<!-- pager will hold our paginator -->
			<div id="trip_list_pager" class="scroll" style="text-align:center;"></div>
			<div>
			  <export:formats formats="['excel']" controller="helper" action="eventVehicleReport"/>
			</div>
	    </div>

            <div>
			<!-- Trip Allotted-->
			<!-- table tag will hold our grid -->
			<table id="trip_allotted_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
			<!-- pager will hold our paginator -->
			<div id="trip_allotted_list_pager" class="scroll" style="text-align:center;"></div>
			<div>
			  <input class="menuButton" type="BUTTON" id="unallottTripBtn" value="UnAllott" />
			  <input class="menuButton" type="BUTTON" id="btnSMS_TripAllotmentList" value="SMS" gridName="#trip_allotted_list" entityName="EventRegistration"/>
			  <input class="menuButton" type="BUTTON" id="btnEMAIL_TripAllotmentList" value="EMAIL" gridName="#trip_allotted_list" entityName="EventRegistration"/>
			  <export:formats formats="['excel']" controller="helper" action="eventTripReport"/>
			</div>
	    </div>

        </div>


<script>
  $(document).ready(function () {
    jQuery("#trip_list").jqGrid({
      url:'jq_trip_list',
      editurl:'jq_edit_trip',
      datatype: "json",
      colNames:['Vehicle','FromLocation','FromTime','ToLocation','ToTime','InchargeName','InchargeNumber','DriverName','DriverNumber','Comments','Id'],
      colModel:[
	{name:'vehicle.id', formatter:'showlink', 
             		formatoptions:{baseLinkUrl:'${createLink(controller:'Vehicle',action:'show')}',addParam:'&domainid=Trip'},
        search:true, editable: true,
        editrules:{required:true},edittype:"select",
	<sec:ifAnyGranted roles="ROLE_VIP_COORDINATOR,ROLE_VIP_TRANSPORTATION">
        	editoptions:{value:"${':--Please Select Vehicle--;'+(ics.Vehicle.findAllByVipExclusive(true,'[sort:"regNum"]')?.collect{it.id+':'+it.toString()}.join(';'))}"}
        </sec:ifAnyGranted>
	<sec:ifNotGranted roles="ROLE_VIP_COORDINATOR,ROLE_VIP_TRANSPORTATION">
        	editoptions:{value:"${':--Please Select Vehicle--;'+(ics.Vehicle.findAllByVipExclusive(false,'[sort:"regNum"]')?.collect{it.id+':'+it.toString()}.join(';'))}"}
        </sec:ifNotGranted>
	},
	{name:'source', search:true, editable: true,edittype:"select",
	<sec:ifAnyGranted roles="ROLE_VIP_COORDINATOR,ROLE_VIP_TRANSPORTATION">
		editoptions:{value:":--Please Select Starting Location--;NVCC:NVCC;Camp:Camp;PuneStation:PuneStation;ShivajiNagar:ShivajiNagar;Swargate:Swargate;PuneAirport:PuneAirport;MumbaiCST:MumbaiCST;MumbaiCentral:MumbaiCentral;BandraTerminus:BandraTerminus;MumbaiDomesticAirport:MumbaiDomesticAirport;MumbaiInternationalAirport:MumbaiInternationalAirport;Juhu:Juhu"}
        </sec:ifAnyGranted>
	<sec:ifNotGranted roles="ROLE_VIP_COORDINATOR,ROLE_VIP_TRANSPORTATION">
		editoptions:{value:":--Please Select Starting Location--;NVCC:NVCC;Camp:Camp;PuneStation:PuneStation;ShivajiNagar:ShivajiNagar;Swargate:Swargate;PuneAirport:PuneAirport"}
        </sec:ifNotGranted>
	},
	{name:'departureTime', search:true, editable: true,
		editoptions:{ 
				  dataInit:function(el){ 
					$(el).datetimepicker({dateFormat:'dd-mm-yy'}); 
				  }}
	},
	{name:'destination', search:true, editable: true,edittype:"select",
	<sec:ifAnyGranted roles="ROLE_VIP_COORDINATOR,ROLE_VIP_TRANSPORTATION">
		editoptions:{value:":--Please Select Terminating Location--;NVCC:NVCC;Camp:Camp;PuneStation:PuneStation;ShivajiNagar:ShivajiNagar;Swargate:Swargate;PuneAirport:PuneAirport;MumbaiCST:MumbaiCST;MumbaiCentral:MumbaiCentral;BandraTerminus:BandraTerminus;MumbaiDomesticAirport:MumbaiDomesticAirport;MumbaiInternationalAirport:MumbaiInternationalAirport;Juhu:Juhu"}
        </sec:ifAnyGranted>
	<sec:ifNotGranted roles="ROLE_VIP_COORDINATOR,ROLE_VIP_TRANSPORTATION">
		editoptions:{value:":--Please Select Terminating Location--;NVCC:NVCC;Camp:Camp;PuneStation:PuneStation;ShivajiNagar:ShivajiNagar;Swargate:Swargate;PuneAirport:PuneAirport"}
        </sec:ifNotGranted>
	},
	{name:'arrivalTime', search:true, editable: true,
		editoptions:{ 
				  dataInit:function(el){ 
					$(el).datetimepicker({dateFormat:'dd-mm-yy'}); 
				  }}	
	},
	{name:'inchargeName', search:true, editable: true},
	{name:'inchargeNumber', search:true, editable: true},
	{name:'driverName', search:true, editable: true},
	{name:'driverNumber', search:true, editable: true},
	{name:'comments', search:true, editable: true},
	{name:'id',hidden:true}
     ],
    rowNum:10,
    rowList:[10,20,30,40,50,100,200],
    pager: '#trip_list_pager',
    viewrecords: true,
    sortorder: "asc",
    width: 1200,
    height: "100%",
    multiselect: true,
    caption:"Trip List",
    onSelectRow: function(ids) { 
    	jQuery("#trip_allotted_list").jqGrid('setGridParam',{url:"jq_trip_allotted_list?tripid="+ids}).trigger('reloadGrid');
    	}    
    });
    $("#trip_list").jqGrid('filterToolbar',{autosearch:true});
    $("#trip_list").jqGrid('navGrid',"#trip_list_pager",{edit:false,add:false,del:true,search:false});
    $("#trip_list").jqGrid('inlineNav',"#trip_list_pager",{
		    		addParams: {
					    successfunc: function( response ) {
						refresh; 
						return true;
					    	},
					    addRowParams : {successfunc: function( response ) {
						refresh; 
						return true;
					    	}}
					    },
				editParams: {
					    successfunc: function( response ) {
						refresh; 
						return true;
					    	}
		    			},
		    	add:true,edit:true,del:true});

    jQuery("#arr_list").jqGrid({
      url:'jq_arr_list',
      datatype: "json",
      colNames:['DateTime','Location','GroupLeaderName','Contact','RegCode','Mode','Number','Name','Details','Total','Id'],
      colModel:[
	{name:'arrivalDate'},
	{name:'arrivalPoint'},
	{name:'name'},
	{name:'contactNumber'},
	{name:'regCode', formatter:'showlink', 
             		formatoptions:{baseLinkUrl:'${createLink(controller:'EventRegistration',action:'show')}'}
	},
	{name:'arrivalTransportMode'},
	{name:'arrivalNumber'},
	{name:'arrivalName'},
	{name:'arrivalTravelingDetails'},
	{name:'total',search:false},
	{name:'id',hidden:true}
     ],
    rowNum:10,
    rowList:[10,20,30,40,50,100,200],
    pager: '#arr_list_pager',
    viewrecords: true,
    sortname:'arrivalDate',
    sortorder: "asc",
    width: 1200,
    height: "100%",
    multiselect: true,
    caption:"Arrival List"
    });
    $("#arr_list").jqGrid('filterToolbar',{autosearch:true});
    $("#arr_list").jqGrid('navGrid',"#arr_list_pager",{edit:false,add:false,del:false,search:false});

    jQuery("#dep_list").jqGrid({
      url:'jq_dep_list',
      datatype: "json",
      colNames:['DateTime','Location','GroupLeaderName','Contact','RegCode','Mode','Number','Name','Details','Total','Id'],
      colModel:[
	{name:'departureDate'},
	{name:'departurePoint'},
	{name:'name'},
	{name:'contactNumber'},
	{name:'regCode', formatter:'showlink', 
             		formatoptions:{baseLinkUrl:'${createLink(controller:'EventRegistration',action:'show')}'}
	},
	{name:'departureTransportMode'},
	{name:'departureNumber'},
	{name:'departureName'},
	{name:'departureTravelingDetails'},
	{name:'total',search:false,sortable:false},
	{name:'id',hidden:true}
     ],
    rowNum:10,
    rowList:[10,20,30,40,50,100,200],
    pager: '#dep_list_pager',
    viewrecords: true,
    sortname:'departureDate',
    sortorder: "asc",
    width: 1200,
    height: "100%",
    multiselect: true,
    caption:"Departure List"
    });
    $("#dep_list").jqGrid('filterToolbar',{autosearch:true});
    $("#dep_list").jqGrid('navGrid',"#dep_list_pager",{edit:false,add:false,del:false,search:false});


    jQuery("#trip_allotted_list").jqGrid({
      url:'jq_trip_allotted_list',
      datatype: "json",
      colNames:['Name','RegCode','Centre','Phone','Arrival', 'Departure','Total Prji Registered','Total Mataji Registered','Total Children Registered','Total Brahmachari/Student Registered','Id'],
      colModel:[
	{name:'name', editable:false,
			formatter:'showlink', 
             		formattriptions:{baseLinkUrl:'${createLink(controller:'EventRegistration',action:'show')}'}
	},
	{name:'regCode', editable:false},
	{name:'connectedIskconCenter', editable:false},
	{name:'contactNumber', editable:false},
	{name:'arrivalDate', editable:false,search:false},
	{name:'departureDate', editable:false,search:false},
	{name:'numberofPrabhujis', editable:false,search:false},
	{name:'numberofMatajis', editable:false,search:false},
	{name:'numberofChildren', editable:false,search:false},
	{name:'numberofBrahmacharis', editable:false,search:false},
	{name:'id',hidden:true}
     ],
    rowNum:10,
    rowList:[10,20,30,40,50,100,200],
    pager: '#trip_allotted_list_pager',
    viewrecords: true,
    multiselect: true,
    sortorder: "asc",
    width: 1200,
    height: "100%",
    caption:"Trip Allotment List"
    });
    $("#trip_allotted_list").jqGrid('filterToolbar',{autosearch:true});
    $("#trip_allotted_list").jqGrid('navGrid',"#trip_allotted_list_pager",{edit:false,add:false,del:false,search:false});

	$( "#allottArrTripBtn" )
		.button()
		.click(function() {
			var tripid = jQuery("#trip_list").jqGrid('getGridParam','selrow');
			var idlist = jQuery("#arr_list").jqGrid('getGridParam','selarrrow');
			
			if(tripid && idlist!="")
				{
					var url = "allotTrip?tripid="+tripid+'&idlist='+idlist
					$.getJSON(url, function(data) {
					    if(data.status=="FAIL")
						{
						alert(data.message);
						}
						else
							{
							$("#trip_allotted_list").jqGrid().trigger('reloadGrid');
							}
					    });
				}
			else
				alert("Please select the trip and guest(s)!!");
		});

	$( "#allottDepTripBtn" )
		.button()
		.click(function() {
			var tripid = jQuery("#trip_list").jqGrid('getGridParam','selrow');
			var idlist = jQuery("#dep_list").jqGrid('getGridParam','selarrrow');
			
			if(tripid && idlist!="")
				{
					var url = "allotTrip?tripid="+tripid+'&idlist='+idlist
					$.getJSON(url, function(data) {
					    if(data.status=="FAIL")
						{
						alert(data.message);
						}
						else
							{
							$("#trip_allotted_list").jqGrid().trigger('reloadGrid');
							}
					    });
				}
			else
				alert("Please select the trip and guest(s)!!");
		});


	$( "#unallottTripBtn" )
		.button()
		.click(function() {
			var idlist = jQuery("#trip_allotted_list").jqGrid('getGridParam','selarrrow');
			
			if(idlist!="")
				{
					var url = "unallotTrip?idlist="+idlist
					$.getJSON(url, function(data) {
					    if(data.status=="FAIL")
						{
						alert(data.message);
						}
						else
							{
							$("#trip_allotted_list").jqGrid().trigger('reloadGrid');
							}
					    });
				}
			else
				alert("Please select a row!!");
		});

    });

		 function refresh() {
		 	jQuery('#trip_list').trigger('reloadGrid');
		 }

</script>


    </body>
</html>
