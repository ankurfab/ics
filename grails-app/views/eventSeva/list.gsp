
<%@ page import="ics.EventSeva" %>
<%@ page import="ics.Event" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="eventSeva.list" default="EventSeva List" /></title>
	<r:require module="grid" />
	<r:require module="export"/>
    </head>
    <body>
        <div class="nav">
            <!--<table>
		    <tr>
			    <td>Download SSRKB BhaktaSamaj Registrations<export:formats formats="['excel']" controller="helper" action="eventRegLocalReport"/></td>
			    <td>Download SSRKB BhaktaSamaj Service Allotments<export:formats formats="['excel']" controller="helper" action="eventServiceAllotmentReport"/></td>
			    <td>Download Outside Pune Service Allotments<export:formats formats="['excel']" controller="helper" action="eventServiceAllotmentOPReport"/></td>
		    </tr>
	    </table>-->
        </div>
        <div class="body">

		<g:render template="/common/sms" />
		<g:render template="/common/email" />

		<div id="dialogChooseIndividualForm" title="Choose Individual">
			<g:render template="/individual/chooseIndividual" />
		</div>            

		<div id="dialogChangeService" title="Change Service">
			<form>
			<fieldset>
				<label for="newservice">New Service</label>
				<g:select id="newservice" name='eventSeva.id' noSelection="${['null':'Select One...']}"
				    from='${EventSeva.findAllByEvent(Event.findByTitle("RVTO"),[sort: "seva.name"])}'
				    optionKey="id" optionValue="seva"></g:select>
    			</fieldset>
			</form>
		</div>

		<div id="dialogAssignService" title="Assign Service">
			<form>
			<fieldset>
				<label for="serviceassigned">New Service</label>
				<g:select id="serviceassigned" name='eventSeva.id' noSelection="${['':'Select One...']}"
				    from='${EventSeva.findAllByEvent(Event.findByTitle("RVTO"),[sort: "seva.name"])}'
				    optionKey="id" optionValue="seva"></g:select>
    			</fieldset>
			</form>
		</div>

		<!-- table tag will hold our grid -->
		<table id="seva_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
		<!-- pager will hold our paginator -->
		<div id="seva_list_pager" class="scroll" style="text-align:center;"></div>
		<!-- table tag will hold our grid -->
		<table id="eventSeva_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
		<!-- pager will hold our paginator -->
		<div id="eventSeva_list_pager" class="scroll" style="text-align:center;"></div>
		<div>
		  <input class="menuButton" type="BUTTON" id="btnSMS_SevaList" value="SMS" gridName="#eventSeva_list" entityName="EventSeva"/>
		  <input class="menuButton" type="BUTTON" id="btnEMAIL_SevaList" value="EMAIL" gridName="#eventSeva_list" entityName="EventSeva"/>
		</div>

		<div id="tabs" style="width: 1200px;">
			<ul>
				<li><a href="#PuneVolunteersSummary">Pune Volunteers Summary</a></li>
				<li><a href="#PuneVolunteers">Pune Volunteers</a></li>
				<li><a href="#OutsidePuneVolunteers">Outside Pune Volunteers</a></li>
			</ul>

		<div id="PuneVolunteersSummary">
			<!-- table tag will hold our grid -->
			<table id="summary_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
			<!-- pager will hold our paginator -->
			<div id="summary_list_pager" class="scroll" style="text-align:center;"></div>
			<div>
			  <input class="menuButton" type="BUTTON" id="assignServiceBtn" value="AssignService" />
			  <input class="menuButton" type="BUTTON" id="btnSMS_SummaryList" value="SMS" gridName="#summary_list" entityName="Person"/>
			</div>
		</div>

		<div id="PuneVolunteers">
			<!-- eventSevaAllotment -->
			<!-- table tag will hold our grid -->
			<table id="eventSevaAllotment_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
			<!-- pager will hold our paginator -->
			<div id="eventSevaAllotment_list_pager" class="scroll" style="text-align:center;"></div>
			<div>
			  <input class="menuButton" type="BUTTON" id="unallottBtn" value="UnAllott" />
			  <input class="menuButton" type="BUTTON" id="changeServiceBtn" value="ChangeService" />
			  <input class="menuButton" type="BUTTON" id="btnSMS_SevaAllotmentList" value="SMS" gridName="#eventSevaAllotment_list" entityName="EventSevaAllotment"/>
			</div>

			<!-- Preference -->
			<!-- table tag will hold our grid -->
			<table id="preference_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
			<!-- pager will hold our paginator -->
			<div id="preference_list_pager" class="scroll" style="text-align:center;"></div>
			<div>
			  <input class="menuButton" type="BUTTON" id="allottFromPreferenceBtn" value="AllottFromPreference" />
			  <input class="menuButton" type="BUTTON" id="moveToPoolBtn" value="MoveToPool" />
			  <input class="menuButton" type="BUTTON" id="btnSMS_SevaPreferenceList" value="SMS" gridName="#preference_list" entityName="Person"/>
			</div>

			<!-- pool -->
			<!-- table tag will hold our grid -->
			<table id="pool_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
			<!-- pager will hold our paginator -->
			<div id="pool_list_pager" class="scroll" style="text-align:center;"></div>
			<div>
			  <input class="menuButton" type="BUTTON" id="allottFromPoolBtn" value="AllottFromPool" />
			  <input class="menuButton" type="BUTTON" id="btnSMS_SevaPoolList" value="SMS" gridName="#pool_list" entityName="Person"/>
			</div>
		
		</div>

		<div id="OutsidePuneVolunteers">
			<!-- Allotted-->
			<!-- table tag will hold our grid -->
			<table id="op_allotted_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
			<!-- pager will hold our paginator -->
			<div id="op_allotted_list_pager" class="scroll" style="text-align:center;"></div>
			<div>
			  <input class="menuButton" type="BUTTON" id="unallottOPBtn" value="UnAllott" />
			  <input class="menuButton" type="BUTTON" id="btnSMS_SevaGroupAllotmentList" value="SMS" gridName="#op_allotted_list" entityName="EventSevaGroupAllotment"/>
			  <input class="menuButton" type="BUTTON" id="btnEMAIL_SevaGroupAllotmentList" value="EMAIL" gridName="#op_allotted_list" entityName="EventSevaGroupAllotment"/>
			</div>

			<!-- UnAllotted-->
			<!-- table tag will hold our grid -->
			<table id="op_volunteer_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
			<!-- pager will hold our paginator -->
			<div id="op_volunteer_list_pager" class="scroll" style="text-align:center;"></div>
			<div>
			  <input class="menuButton" type="BUTTON" id="allottOPBtn" value="Allott" />
			  <input class="menuButton" type="BUTTON" id="btnSMS_SevaOPVolunteerList" value="SMS" gridName="#op_volunteer_list" entityName="EventRegistration"/>
			  <input class="menuButton" type="BUTTON" id="btnEMAIL_SevaOPVolunteerList" value="EMAIL" gridName="#op_volunteer_list" entityName="EventRegistration"/>
			</div>

			<!-- Allocations-->
			<!-- table tag will hold our grid -->
			<!--<table id="op_allocation_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>-->
			<!-- pager will hold our paginator -->
			<!--<div id="op_allocation_list_pager" class="scroll" style="text-align:center;"></div>-->
		</div>

        </div>
<script>
	//TODO sevaid is actually eventSevaid
  $(document).ready(function () {
    $( "#tabs" ).tabs();

		    jQuery("#seva_list").jqGrid({
		      url:'${createLink(controller:'Seva',action:'jq_seva_list')}',
		      editurl:'${createLink(controller:'Seva',action:'jq_edit_seva')}',
		      datatype: "json",
		      colNames:['Name','Description','Type','Category','Incharge','id'],
		      colModel:[
			{name:'name', editable:true},
			{name:'description', editable:true},
			{name:'type', editable:true},
			{name:'category', editable:true,
				    /*'edittype'    : 'custom',
				    'editoptions' : {
				      'custom_element' : autocomplete_element,
				      'custom_value'   : autocomplete_value
   					 }*/
			},
			{name:'incharge', editable:false},
			{name:'id',hidden:true}
		     ],
		    rowNum:5,
		    rowList:[5,10,20,30,50,100],
		    pager: '#seva_list_pager',
		    viewrecords: true,
		    gridview: true,
		    sortname: 'name',
		    sortorder: "asc",
		    width: 1200,
		    height: "100%",
		    caption:"Service Master List",
			onSelectRow: function(ids) {
						var selSevaName = jQuery('#seva_list').jqGrid('getCell', ids, 'name');
						jQuery("#eventSeva_list").jqGrid('setGridParam',{url:"${createLink(controller:'eventSeva',action:'jq_eventSeva_list',params:['seva.id':''])}"+ids,page:1});
						jQuery("#eventSeva_list").jqGrid('setGridParam',{editurl:"${createLink(controller:'eventSeva',action:'jq_edit_eventSeva',params:['seva.id':''])}"+ids});
						jQuery("#eventSeva_list").jqGrid('setCaption',"EventSeva List for Seva: "+selSevaName) .trigger('reloadGrid');
					}
		    });
		   $("#seva_list").jqGrid('navGrid',"#seva_list_pager",
			{add:true,edit:true,del:true}, // which buttons to show?
			{},         // edit options
			{addCaption:'Create New Seva',afterSubmit:afterSubmitEvent,savekey:[true,13],closeAfterAdd:true},  // add options
			{}          // delete options
		    );
		   $("#seva_list").jqGrid('filterToolbar',{autosearch:true});
		   
    jQuery("#eventSeva_list").jqGrid({
      url:'jq_eventSeva_list',
      editurl:'jq_edit_eventSeva',
      datatype: "json",
      colNames:['Event','Service','Incharge', 'Incharge Contact','Incharge Email','Comments'/*,'Total Volunteer Needed','Maximum Prji Volunteer Needed','Maximum Mataji Volunteer Needed','Maximum Bramhachari Volunteer Needed','Current Volunteer Allotted','Current Prji Volunteer Allotted','Current Mataji Volunteer Allotted','Current Bramhachari Volunteer Allotted'*/,'Id'],
      colModel:[
	{name:'event.id', formatter:'showlink', 
             		formatoptions:{baseLinkUrl:'${createLink(controller:'Event',action:'show')}',addParam:'&domainid=Trip'},
        	search:true, editable: true,
        	editrules:{required:false},edittype:"select",
        	editoptions:{value:"${':--Please Select Event--;'+(ics.Event.list([sort:'startDate',order:'desc'])?.collect{it.id+':'+it.toString()}.join(';'))}"},
		stype:'select', searchoptions: { value: "${':ALL;'+(ics.Event.list([sort:'startDate',order:'desc'])?.collect{it.id+':'+it.toString()}.join(';'))}"}        	
	},
	{name:'seva.name', editable:true,editrules:{required:false},sortable:true},
	{name:'inchargeName', editable:false, editrules:{required:true}},
	{name:'inchargeContact', editable:false, editrules:{required:true, integer:true, minValue:0, maxValue:9999999999}},
	{name:'inchargeEmail', editable:false, editrules:{required:true, email:true}},
	{name:'comments', editable:true},
	/*{name:'maxRequired', editable:true,search:false},
	{name:'maxPrjiRequired', editable:true,search:false},
	{name:'maxMatajiRequired', editable:true,search:false},
	{name:'maxBrahmachariRequired', editable:true,search:false},
	{name:'totalAllotted', editable:false,search:false},
	{name:'prjiAllotted', editable:false,search:false},
	{name:'matajiAllotted', editable:false,search:false},
	{name:'brahmachariAllotted', editable:false,search:false},*/
	{name:'id',hidden:true}
     ],
    rowNum:10,
    rowList:[10,20,30,40,50,100,200],
    pager: '#eventSeva_list_pager',
    viewrecords: true,
    sortorder: "asc",
    width: 1200,
    height: "100%",
    caption:"Service List for Events",
    multiselect: true,
    onSelectRow: function(ids) { 
    	jQuery("#eventSevaAllotment_list").jqGrid('setGridParam',{url:"jq_eventSevaAllotment_list?sevaid="+ids}).trigger('reloadGrid');
    	jQuery("#preference_list").jqGrid('setGridParam',{url:"jq_preference_list?sevaid="+ids}).trigger('reloadGrid');
    	jQuery("#op_allotted_list").jqGrid('setGridParam',{url:"jq_op_allotted_list?sevaid="+ids}).trigger('reloadGrid');
    	
    	}    
    });
    $("#eventSeva_list").jqGrid('filterToolbar',{autosearch:true});
    $("#eventSeva_list").jqGrid('navGrid',"#eventSeva_list_pager",{edit:false,add:false,del:true,search:false});
    $("#eventSeva_list").jqGrid('inlineNav',"#eventSeva_list_pager");
    $("#eventSeva_list").jqGrid('navGrid',"#eventSeva_list_pager").jqGrid('navButtonAdd',"#eventSeva_list_pager",{caption:"SetIncharge", buttonicon:"ui-icon-person", onClickButton:setIncharge, position: "last", title:"SetIncharge", cursor: "pointer"});


	function setIncharge() {
		var ids = $('#eventSeva_list').jqGrid('getGridParam','selarrrow');
		if(ids) {
				$( "#dialogChooseIndividualForm" ).dialog( "open" );
		}
		else
			alert("Please select a row!!");
	}

		$( "#dialogChooseIndividualForm" ).dialog({
			autoOpen: false,
			height: 200,
			width: 350,
			modal: true,
			buttons: {
				"Submit": function() {
				      var url = "${createLink(controller:'EventSeva',action:'setIncharge')}?indid="+$('#linkedid').val()+"&idlist="+$('#eventSeva_list').jqGrid('getGridParam','selarrrow');
				      // post data
				      $.post(url, '' , function(returnData){
						  $('#linkedid').val('');
						  $('#indname').val('');
						  $('#ind').val('');

						  jQuery("#eventSeva_list").jqGrid().trigger("reloadGrid");
					      })
						
						$( this ).dialog( "close" );
				},
				"Cancel": function() {
					  $('#linkedid').val('');
					  $('#indname').val('');
					  $('#ind').val('');
					$( this ).dialog( "close" );
				}
			},
			close: function() {
				
			}
		});


    jQuery("#summary_list").jqGrid({
      url:'jq_summary_list',
      editurl:'jq_edit_summary',
      datatype: "json",
      colNames:['Name','Category','Contact','Counselor','PreferredService','AllottedService','Id'],
      colModel:[
	{name:'name'},
	{name:'category'},
	{name:'phone'},
	{name:'counselor'},
	{name:'preferredService'},
	{name:'allottedService'},
	{name:'id',hidden:true}
     ],
    rowNum:10,
    rowList:[10,20,30,40,50,100,200],
    pager: '#summary_list_pager',
    viewrecords: true,
    multiselect: true,
    sortorder: "asc",
    width: 1150,
    height: "100%",
    caption:"Service Allocation List"
    });
    $("#summary_list").jqGrid('filterToolbar',{autosearch:true});
    $("#summary_list").jqGrid('navGrid',"#summary_list_pager",{edit:false,add:false,del:false,search:false});


    jQuery("#eventSevaAllotment_list").jqGrid({
      url:'jq_eventSevaAllotment_list',
      editurl:'jq_edit_eventSevaAllotment',
      datatype: "json",
      colNames:['Name','Category','Contact','Counselor','Service','Id'],
      colModel:[
	{name:'name'},
	{name:'category'},
	{name:'phone'},
	{name:'relation'},
	{name:'seva.name'},
	{name:'id',hidden:true}
     ],
    rowNum:10,
    rowList:[10,20,30,40,50,100,200],
    pager: '#eventSevaAllotment_list_pager',
    viewrecords: true,
    multiselect: true,
    sortorder: "asc",
    width: 1150,
    height: "100%",
    caption:"Allotted List"
    });
    $("#eventSevaAllotment_list").jqGrid('filterToolbar',{autosearch:true});
    $("#eventSevaAllotment_list").jqGrid('navGrid',"#eventSevaAllotment_list_pager",{edit:false,add:false,del:false,search:false});

    jQuery("#preference_list").jqGrid({
      url:'jq_preference_list',
      datatype: "json",
      colNames:['Name','Category','Contact','Counselor','Service','Id'],
      colModel:[
	{name:'name'},
	{name:'category'},
	{name:'phone'},
	{name:'relation'},
	{name:'seva.name'},
	{name:'id',hidden:true}
     ],
    rowNum:10,
    rowList:[10,20,30,40,50,100,200],
    pager: '#preference_list_pager',
    viewrecords: true,
    multiselect:true,
    sortorder: "asc",
    width: 1150,
    height: "100%",
    caption:"Preference List(Unallotted)"
    });
    $("#preference_list").jqGrid('filterToolbar',{autosearch:true});
    $("#preference_list").jqGrid('navGrid',"#preference_list_pager",{edit:false,add:false,del:false,search:false});

    jQuery("#pool_list").jqGrid({
      url:'jq_pool_list',
      datatype: "json",
      colNames:['Name','Category','Contact','Counselor','Id'],
      colModel:[
	{name:'name'},
	{name:'category'},
	{name:'phone'},
	{name:'relation'},
	{name:'id',hidden:true}
     ],
    rowNum:10,
    rowList:[10,20,30,40,50,100,200],
    pager: '#pool_list_pager',
    viewrecords: true,
    multiselect: true,
    sortorder: "asc",
    width: 1150,
    height: "100%",
    caption:"Volunteer Pool"
    });
    $("#pool_list").jqGrid('filterToolbar',{autosearch:true});
    $("#pool_list").jqGrid('navGrid',"#pool_list_pager",{edit:false,add:false,del:false,search:false});

    jQuery("#op_volunteer_list").jqGrid({
      url:'jq_op_volunteer_list',
      datatype: "json",
      colNames:['Name','RegCode','Centre','Phone','Arrival', 'Departure','Total Prji Volunteer','Total Mataji Volunteer','Total Brahmachari/Student Volunteer','Id'],
      colModel:[
	{name:'name', editable:false,
			formatter:'showlink', 
             		formatoptions:{baseLinkUrl:'${createLink(controller:'EventRegistration',action:'show')}'}
	},
	{name:'regCode', editable:false},
	{name:'connectedIskconCenter', editable:false},
	{name:'contactNumber', editable:false},
	{name:'arrivalDate', editable:false,search:false},
	{name:'departureDate', editable:false,search:false},
	{name:'numPrjiVolunteer', editable:false,search:false},
	{name:'numMatajiVolunteer', editable:false,search:false},
	{name:'numBrahmacharisVolunteer', editable:false,search:false},
	{name:'id',hidden:true}
     ],
    rowNum:10,
    rowList:[10,20,30,40,50,100,200],
    pager: '#op_volunteer_list_pager',
    viewrecords: true,
    multiselect: true,
    sortorder: "asc",
    width: 1150,
    height: "100%",
    caption:"Outside Pune Volunteer List",
    /*onSelectRow: function(ids) { 
    	jQuery("#op_allocation_list").jqGrid('setGridParam',{url:"jq_op_allocation_list?erid="+ids}).trigger('reloadGrid');
    	}*/    
    });
    $("#op_volunteer_list").jqGrid('filterToolbar',{autosearch:true});
    $("#op_volunteer_list").jqGrid('navGrid',"#op_volunteer_list_pager",{edit:false,add:false,del:false,search:false});

    jQuery("#op_allotted_list").jqGrid({
      url:'jq_op_allotted_list',
      datatype: "json",
      colNames:['Name','RegCode','Centre','Phone','Arrival', 'Departure','Total Prji Volunteer','Total Mataji Volunteer','Total Brahmachari/Student Volunteer','Id'],
      colModel:[
	{name:'name', editable:false,
			formatter:'showlink', 
             		formatoptions:{baseLinkUrl:'${createLink(controller:'EventRegistration',action:'show')}'}
	},
	{name:'regCode', editable:false},
	{name:'connectedIskconCenter', editable:false},
	{name:'contactNumber', editable:false},
	{name:'arrivalDate', editable:false,search:false},
	{name:'departureDate', editable:false,search:false},
	{name:'numPrjiVolunteer', editable:false,search:false},
	{name:'numMatajiVolunteer', editable:false,search:false},
	{name:'numBrahmacharisVolunteer', editable:false,search:false},
	{name:'id',hidden:true}
     ],
    rowNum:10,
    rowList:[10,20,30,40,50,100,200],
    pager: '#op_allotted_list_pager',
    viewrecords: true,
    multiselect: true,
    sortorder: "asc",
    width: 1150,
    height: "100%",
    caption:"Outside Pune Allotted List"
    });
    $("#op_allotted_list").jqGrid('filterToolbar',{autosearch:true});
    $("#op_allotted_list").jqGrid('navGrid',"#op_allotted_list_pager",{edit:false,add:false,del:false,search:false});

    /*jQuery("#op_allocation_list").jqGrid({
      url:'jq_op_allocation_list',
      datatype: "json",
      colNames:['Service','Name','RegCode','Centre','Phone','Arrival', 'Departure','Id'],
      colModel:[
	{name:'seva', editable:false},
	{name:'name', editable:false,
			formatter:'showlink', 
             		formatoptions:{baseLinkUrl:'${createLink(controller:'EventRegistration',action:'show')}'}
	},
	{name:'regCode', editable:false},
	{name:'connectedIskconCenter', editable:false},
	{name:'contactNumber', editable:false},
	{name:'arrivalDate', editable:false,search:false},
	{name:'departureDate', editable:false,search:false},
	{name:'id',hidden:true}
     ],
    rowNum:10,
    rowList:[10,20,30,40,50,100,200],
    pager: '#op_allocation_list_pager',
    viewrecords: true,
    sortorder: "asc",
    width: 1150,
    height: "100%",
    caption:"Outside Pune Allocation List"
    });
    $("#op_allocation_list").jqGrid('filterToolbar',{autosearch:true});
    $("#op_allocation_list").jqGrid('navGrid',"#op_allocation_list_pager",{edit:false,add:false,del:false,search:false});*/

	$( "#allottFromPoolBtn" )
		.button()
		.click(function() {
			var sevaid = jQuery("#eventSeva_list").jqGrid('getGridParam','selrow');
			var idlist = jQuery("#pool_list").jqGrid('getGridParam','selarrrow');
			
			if(sevaid && idlist!="")
				{
					var url = "allot?sevaid="+sevaid+'&idlist='+idlist
					$.getJSON(url, function(data) {
					    if(data.status=="FAIL")
						{
						alert(data.message);
						}
						else
							{
							$("#pool_list").jqGrid().trigger('reloadGrid');
							$("#eventSevaAllotment_list").jqGrid().trigger('reloadGrid');
							}
					    });
				}
			else
				alert("Please select a row!!");
		});
		
	$( "#allottFromPreferenceBtn" )
		.button()
		.click(function() {
			var sevaid = jQuery("#eventSeva_list").jqGrid('getGridParam','selrow');
			var idlist = jQuery("#preference_list").jqGrid('getGridParam','selarrrow');
			
			if(sevaid && idlist!="")
				{
					var url = "allot?sevaid="+sevaid+'&idlist='+idlist
					$.getJSON(url, function(data) {
					    if(data.status=="FAIL")
						{
						alert(data.message);
						}
						else
							{
							$("#preference_list").jqGrid().trigger('reloadGrid');
							$("#eventSevaAllotment_list").jqGrid().trigger('reloadGrid');
							}
					    });
				}
			else
				alert("Please select a row!!");
		});

	$( "#unallottBtn" )
		.button()
		.click(function() {
			var sevaid = jQuery("#eventSeva_list").jqGrid('getGridParam','selrow');
			var idlist = jQuery("#eventSevaAllotment_list").jqGrid('getGridParam','selarrrow');
			
			if(sevaid && idlist!="")
				{
					var url = "unallot?sevaid="+sevaid+'&idlist='+idlist
					$.getJSON(url, function(data) {
					    if(data.status=="FAIL")
						{
						alert(data.message);
						}
						else
							{
							$("#pool_list").jqGrid().trigger('reloadGrid');
							$("#eventSevaAllotment_list").jqGrid().trigger('reloadGrid');
							}
					    });
				}
			else
				alert("Please select a row!!");
		});

	$( "#changeServiceBtn" )
		.button()
		.click(function() {
			$( "#dialogChangeService" ).dialog( "open" );
		});

	$( "#assignServiceBtn" )
		.button()
		.click(function() {
			$( "#dialogAssignService" ).dialog( "open" );
		});

	$( "#moveToPoolBtn" )
		.button()
		.click(function() {
			var sevaid = jQuery("#eventSeva_list").jqGrid('getGridParam','selrow');
			var idlist = jQuery("#preference_list").jqGrid('getGridParam','selarrrow');
			
			if(sevaid && idlist!="")
				{
					var url = "move?sevaid="+sevaid+'&idlist='+idlist
					$.getJSON(url, function(data) {
					    if(data.status=="FAIL")
						{
						alert(data.message);
						}
						else
							{
							$("#pool_list").jqGrid().trigger('reloadGrid');
							$("#preference_list").jqGrid().trigger('reloadGrid');
							}
					    });
				}
			else
				alert("Please select a row!!");
		});

	$( "#allottOPBtn" )
		.button()
		.click(function() {
			var sevaid = jQuery("#eventSeva_list").jqGrid('getGridParam','selrow');
			var idlist = jQuery("#op_volunteer_list").jqGrid('getGridParam','selarrrow');
			
			if(sevaid && idlist!="")
				{
					var url = "allotOP?sevaid="+sevaid+'&idlist='+idlist
					$.getJSON(url, function(data) {
					    if(data.status=="FAIL")
						{
						alert(data.message);
						}
						else
							{
							$("#op_allotted_list").jqGrid().trigger('reloadGrid');
							$("#op_volunteer_list").jqGrid().trigger('reloadGrid');
							}
					    });
				}
			else
				alert("Please select a row!!");
		});

	$( "#unallottOPBtn" )
		.button()
		.click(function() {
			var sevaid = jQuery("#eventSeva_list").jqGrid('getGridParam','selrow');
			var idlist = jQuery("#op_allotted_list").jqGrid('getGridParam','selarrrow');
			
			if(sevaid && idlist!="")
				{
					var url = "unallotOP?sevaid="+sevaid+'&idlist='+idlist
					$.getJSON(url, function(data) {
					    if(data.status=="FAIL")
						{
						alert(data.message);
						}
						else
							{
							$("#op_allotted_list").jqGrid().trigger('reloadGrid');
							$("#op_volunteer_list").jqGrid().trigger('reloadGrid');
							}
					    });
				}
			else
				alert("Please select a row!!");
		});

		$( "#dialogChangeService" ).dialog({
			autoOpen: false,
			height: 300,
			width: 350,
			modal: true,
			buttons: {
				"Change": function() {
					var newEventSevaId = jQuery("#newservice").val();
					var idlist = jQuery("#eventSevaAllotment_list").jqGrid('getGridParam','selarrrow');

					if(newEventSevaId && idlist!="")
						{
							var url = "change?eventsevaid="+newEventSevaId+'&idlist='+idlist
							$.getJSON(url, function(data) {
							    if(data.status=="FAIL")
								{
								alert(data.message);
								}
								else
									{
									$("#eventSevaAllotment_list").jqGrid().trigger('reloadGrid');
									}
							    });
							    $( this ).dialog( "close" );
						}
					else
						alert("Please select a row!!");
						},
						Cancel: function() {
							jQuery("#newservice").val('');
							$( this ).dialog( "close" );
						}
			},
			close: function() {
				jQuery("#newservice").val('');
			}
		});
		$( "#dialogAssignService" ).dialog({
			autoOpen: false,
			height: 300,
			width: 350,
			modal: true,
			buttons: {
				"Assign": function() {
					var newEventSevaId = jQuery("#serviceassigned").val();
					var idlist = jQuery("#summary_list").jqGrid('getGridParam','selarrrow');

					if(idlist!="")
						{
							var url = "assign?eventsevaid="+newEventSevaId+'&idlist='+idlist
							$.getJSON(url, function(data) {
							    if(data.status=="FAIL")
								{
								alert(data.message);
								}
								else
									{
									$("#summary_list").jqGrid().trigger('reloadGrid');
									}
							    });
							    $( this ).dialog( "close" );
						}
					else
						alert("Please select a row!!");
						},
						Cancel: function() {
							jQuery("#serviceassigned").val('');
							$( this ).dialog( "close" );
						}
			},
			close: function() {
				jQuery("#serviceassigned").val('');
			}
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
			return [success,message,new_id];
		    }

		function autocomplete_element(value, options) {
		  // creating input element
		  var $ac = $('<input type="text"/>');
		  // setting value to the one passed from jqGrid
		  $ac.val(value);
		  // creating autocomplete
		  $ac.autocomplete({source: "${createLink(controller:'item',action:'list')}"+".json"});
		  // returning element back to jqGrid
		  return $ac;
		}

		function autocomplete_value(elem, op, value) {
			alert(elem) 
			alert(op) 
			alert(value)
		  if (op == "set") {
		    $(elem).val(value);
		  }
		  return $(elem).val();
		}


    });

</script>
    </body>
</html>
