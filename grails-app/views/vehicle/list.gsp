
<%@ page import="ics.Vehicle" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="vehicle.list" default="Vehicle List" /></title>
	<r:require module="grid" />
	<r:require module="dateTimePicker" />
    </head>
    <body>
		<g:render template="/common/sms" />
		<g:render template="/common/email" />

        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list" controller="Trip">Trip List</g:link></span>
        </div>
        <div class="body">
            <div>
			<!-- table tag will hold our grid -->
			<table id="vehicle_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
			<!-- pager will hold our paginator -->
			<div id="vehicle_list_pager" class="scroll" style="text-align:center;"></div>
			<input class="menuButton" type="BUTTON" id="btnSMS_VehicleList" value="SMS" gridName="#vehicle_list" entityName="Vehicle"/>
	    </div>
            <div>
			<!-- table tag will hold our grid -->
			<table id="trip_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
			<!-- pager will hold our paginator -->
			<div id="trip_list_pager" class="scroll" style="text-align:center;"></div>
	    </div>
        </div>

<script>
  $(document).ready(function () {
    var lastsel3; 
    jQuery("#vehicle_list").jqGrid({
      url:'jq_vehicle_list',
      editurl:'jq_edit_vehicle',
      datatype: "json",
      colNames:['RegNum','Model','Type','Capacity','OwnerName','OwnerNumber','DriverName','DriverNumber','Comments','Id'],
      colModel:[
	{name:'regNum', search:true, editable: true, editrules:{required:true}},
	{name:'model', search:true, editable: true, editrules:{required:true}},
	{name:'type', search:true, editable: true, editrules:{required:true}}, 
	{name:'numCapacity', search:true, editable: true, editrules:{required:true,integer:true,minValue:1,maxValue:100}},
	{name:'ownerName', search:true, editable: true},
	{name:'ownerNumber', search:true, editable: true},
	{name:'driverName', search:true, editable: true},
	{name:'driverNumber', search:true, editable: true},
	{name:'comments', search:true, editable: true},
	{name:'id',hidden:true}
     ],
    rowNum:10,
    rowList:[10,20,30,40,50,100,200],
    pager: '#vehicle_list_pager',
    viewrecords: true,
    sortorder: "asc",
    width: 1200,
    height: "100%",
    multiselect: true,
    caption:"Vehicle List",
    onSelectRow: function(ids) { 
    	jQuery("#trip_list").jqGrid('setGridParam',{url:"jq_trip_list?vehicleid="+ids}).trigger('reloadGrid');    	
    	}    
    });
    $("#vehicle_list").jqGrid('filterToolbar',{autosearch:true});
    $("#vehicle_list").jqGrid('navGrid',"#vehicle_list_pager",{edit:false,add:false,del:true,search:false});
    $("#vehicle_list").jqGrid('inlineNav',"#vehicle_list_pager");

    jQuery("#trip_list").jqGrid({
      url:'jq_trip_list',
      editurl:'jq_edit_trip',
      datatype: "json",
      colNames:['FromTime','FromLocation','ToLocation','ToTime','InchargeName','InchargeNumber','DriverName','DriverNumber','Comments','Id'],
      colModel:[
	{name:'departureTime', search:true, editable: true},
	{name:'source', search:true, editable: true},
	{name:'destination', search:true, editable: true},
	{name:'arrivalTime', search:true, editable: true},
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
    sortname: 'departureTime',
    sortorder: "asc",
    width: 1200,
    height: "100%",
    multiselect: false,
    caption:"Vehicle Trip List"
    });
    $("#trip_list").jqGrid('filterToolbar',{autosearch:true});
    $("#trip_list").jqGrid('navGrid',"#trip_list_pager",{edit:false,add:false,del:false,search:false});
    //$("#trip_list").jqGrid('inlineNav',"#trip_list_pager");


    });
</script>


    </body>
</html>
