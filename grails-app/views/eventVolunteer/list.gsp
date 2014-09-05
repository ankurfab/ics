
<%@ page import="ics.EventVolunteer" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="eventVolunteer.list" default="EventVolunteer List" /></title>
	<r:require module="grid" />
	<r:require module="export"/>
    </head>
    <body>
        <div class="nav">
            Download SSRKB BhaktaSamaj Registrations
	    <export:formats formats="['excel']" controller="helper" action="eventRegLocalReport"/>
        </div>
        <div class="body">
            <h1><g:message code="eventVolunteer.list" default="EventVolunteer List" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>

		<!-- table tag will hold our grid -->
		<table id="op_volunteer_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
		<!-- pager will hold our paginator -->
		<div id="op_volunteer_list_pager" class="scroll" style="text-align:center;"></div>


		<!-- table tag will hold our grid -->
		<table id="volunteer_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
		<!-- pager will hold our paginator -->
		<div id="volunteer_list_pager" class="scroll" style="text-align:center;"></div>

		<input class="menuButton" type="BUTTON" id="allottBtn" value="Allott" />

		<div id="allottDlg" title="Allott">
			<form>
			<fieldset>
				<label for="numPrjiAllotted">Number of Prji</label>
				<g:textField name="numPrjiAllotted" id="numPrjiAllotted"/>
				<label for="numMatajiAllotted">Number of Mataji</label>
				<g:textField name="numMatajiAllotted" id="numMatajiAllotted"/>
				<g:hiddenField name="id" id="evid"/>
			</fieldset>
			</form>
		</div>

        </div>
<script>
  $(document).ready(function () {
    jQuery("#volunteer_list").jqGrid({
      url:'jq_volunteer_list',
      editurl:'jq_edit_volunteer',
      datatype: "json",
      colNames:['Service','From', 'Till','Total Prji Volunteer Needed','Total Mataji Volunteer Needed','Current Prji Volunteer Allotted','Current Mataji Volunteer Allotted','EditedOn','EditedBy','CreatedOn','CreatedBy','Id'],
      colModel:[
	{name:'seva', editable:true,
			formatter:'showlink', 
             		formatoptions:{baseLinkUrl:'show'}
	},
	{name:'requiredFrom', editable:true},
	{name:'requiredTill', editable:true},
	{name:'numPrjiRequired', editable:true,search:false},
	{name:'numMatajiRequired', editable:true,search:false},
	{name:'numPrjiAllotted', editable:true,search:false},
	{name:'numMatajiAllotted', editable:true,search:false},
	{name:'updator', editable:false},
	{name:'lastUpdated', editable:false},
	{name:'creator', editable:false},
	{name:'dateCreated', editable:false},
	{name:'id',hidden:true}
     ],
    rowNum:10,
    rowList:[10,20,30,40,50,100,200],
    pager: '#volunteer_list_pager',
    viewrecords: true,
    sortorder: "asc",
    width: 1200,
    height: "100%",
    caption:"Volunteer List"
    });

    $("#volunteer_list").jqGrid('navGrid',"#volunteer_list_pager",{edit:false,add:false,del:false});
    $("#volunteer_list").jqGrid('inlineNav',"#volunteer_list_pager");

	$( "#allottBtn" )
		.button()
		.click(function() {
			var id = jQuery("#volunteer_list").jqGrid('getGridParam','selrow');
			if(id)
				$( "#allottDlg" ).dialog( "open" );
			else
				alert("Please select a row!!");
		});

	$( "#allottDlg" ).dialog({
		autoOpen: false,
		modal: true,
		buttons: {
			"Allott": function() {
				var numP = $('#numPrjiAllotted').val();
				var numM = $('#numMatajiAllotted').val();
				$("#evid").val(jQuery("#volunteer_list").jqGrid('getGridParam','selrow'));
				var url = "${createLink(controller:'eventVolunteer',action:'save')}";
				$.post(url, $("#allottDlg").serialize());
				$("#volunteer_list").jqGrid().trigger("reloadGrid");
				$( this ).dialog( "close" );
			},
			Cancel: function() {
				$( this ).dialog( "close" );
			}
		},
		close: function() {
		}
	});

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
    sortorder: "asc",
    width: 1200,
    height: "100%",
    caption:"Outside Pune Volunteer List"
    });
    $("#op_volunteer_list").jqGrid('filterToolbar',{autosearch:true});
    $("#op_volunteer_list").jqGrid('navGrid',"#op_volunteer_list_pager",{edit:false,add:false,del:false,search:false});

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

</script>

    </body>
</html>
