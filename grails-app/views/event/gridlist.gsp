
<%@ page import="ics.Event" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="event.list" default="Event List" /></title>
	<r:require module="grid" />
	<r:require module="dateTimePicker" />
	<r:require module="printarea" />
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list" controller="Event">CalendarView</g:link></span>
        </div>
        <div class="body">
		<g:render template="/common/apisms" />
		<g:render template="/common/mandrillemail" />
            <div>
			<!-- table tag will hold our grid -->
			<table id="event_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
			<!-- pager will hold our paginator -->
			<div id="event_list_pager" class="scroll" style="text-align:center;"></div>
			<input class="menuButton" type="BUTTON" id="btnSMS_EventList" value="SMS_ALL" gridName="#event_list" entityName="Event"  departmentId=""/>
			<input class="menuButton" type="BUTTON" id="btnEMAIL_EventList" value="EMAIL_ALL" gridName="#event_list" entityName="Event" departmentId=""/>
	    </div>
            <div>
			<!-- table tag will hold our grid -->
			<table id="participant_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
			<!-- pager will hold our paginator -->
			<div id="participant_list_pager" class="scroll" style="text-align:center;"></div>
			<input class="menuButton" type="BUTTON" id="btnSMS_ParticipantList" value="SMS" gridName="#participant_list" entityName="EventParticipant"  departmentId=""/>
			<input class="menuButton" type="BUTTON" id="btnEMAIL_ParticipantList" value="EMAIL" gridName="#participant_list" entityName="EventParticipant" departmentId=""/>
	    </div>
            <div>
			<!-- table tag will hold our grid -->
			<table id="detail_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
			<!-- pager will hold our paginator -->
			<div id="detail_list_pager" class="scroll" style="text-align:center;"></div>
	    </div>

		<div id="dialogBulkUploadForm" title="Bulk Upload Paticipants">
			<g:form name="formBulkUploadParticipants" controller="Event" action="bulkUploadParticipants" method="post" >
			<g:hiddenField name="eventId" value="" />
			<div class="dialog">
			    <table>
				<tbody>
				    <tr class="prop">
					<td valign="top" class="name">
					    <label for="mode">ICS Ids</label>
					</td>
					<td valign="top" class="value">
					    <g:textArea name="icsidlist"/>
					</td>
				    </tr>
				</tbody>
			    </table>
			</div>
			</g:form>			
		</div>            	    

		<div id="dialogRoleForm" title="Invite Paticipants by Role">
			<g:form name="formRoleParticipants" controller="Event" action="inviteByRole" method="post" >
			<g:hiddenField name="eventIdForRole" value="" />
			<div class="dialog">
			    <table>
				<tbody>
				    <tr class="prop">
					<td valign="top" class="name">
					    <label for="mode">Role(s)</label>
					</td>
					<td valign="top" class="value">
						<g:select id="roles" name='roles'
						    noSelection="${['':'Select Roles...']}"
						    from='${ics.Role.list([sort:'name'])}'
						    optionKey="id" optionValue="name" multiple="multiple"></g:select>
					</td>
				    </tr>
				    <tr class="prop">
					<td valign="top" class="name">
					    <label for="mode">Invite all counsellees</label>
					</td>
					<td valign="top" class="value">
						<g:checkBox name="inviteAllClees" value="${false}" />
					</td>
				    </tr>
				</tbody>
			    </table>
			</div>
			</g:form>			
		</div>            	    

		<div id="dialogCommentsForm" title="Update Comments for Paticipants">
			<g:form name="formCommentsParticipants" controller="EventParticipant" action="updateComments" method="post" >
			<g:hiddenField name="epids" value="" />
			<div class="dialog">
			    <table>
				<tbody>
				    <tr class="prop">
					<td valign="top" class="name">
					    <label for="mode">Comments</label>
					</td>
					<td valign="top" class="value">
					    <g:textArea name="comments"/>
					</td>
				    </tr>
				</tbody>
			    </table>
			</div>
			</g:form>			
		</div>            	    


		<div id="dialogPrintSheet" title="Attendance Sheet">
			<div id="divToPrintSheet"></div>
		</div>

		<div id="dialogUploadSheet" title="Upload Attendance">
			<g:form name="formUploadSheet" controller="Event" action="uploadSheet" method="post" >
			<g:hiddenField name="sheeteventId" value="" />
			<div class="dialog">
			    <table>
				<tbody>
				    <tr class="prop">
					<td valign="top" class="name">
					    <label for="mode">ICS Ids</label>
					</td>
					<td valign="top" class="value">
					    <g:textArea name="icsidlist"/>
					</td>
				    </tr>
				</tbody>
			    </table>
			</div>
			</g:form>			
		</div>            	    

		<div id="dialogStats" title="Event Statistics">
			<div id="divStats"></div>
		</div>

        </div>

<script>
  $(document).ready(function () {
    jQuery("#event_list").jqGrid({
      url:'jq_event_list',
      editurl:'jq_edit_event',
      datatype: "json",
      colNames:['Title','Description','Venue','ContactPerson','StartDate','EndDate','Comments','Category','Type','phyAtt','virtAtt','Course','Instructor','RegistrationMode','Status','Id'],
      colModel:[
	{name:'title', search:true, editable: true, editrules:{required:true}},
	{name:'description', search:true, editable: true, editrules:{required:true}},
	{name:'venue', search:true, editable: false},
	{name:'contactPerson', search:true, editable: false},
	{name:'startDate', search:true, editable: false},
	{name:'endDate', search:true, editable: false},
	{name:'comments', search:true, editable: false},
	{name:'category', search:true, editable: false,
		stype:'select', searchoptions: { value: "${':ALL;'+(ics.Event.createCriteria().list{projections{distinct('category')}}?.collect{it+':'+it}.join(';'))}"}
	},
	{name:'type', search:true, editable: false,
		stype:'select', searchoptions: { value: "${':ALL;'+(ics.Event.createCriteria().list{projections{distinct('type')}}?.collect{it+':'+it}.join(';'))}"}
	},
	{name:'physicalAttendance', search:true, editable: false},
	{name:'virtualAttendance', search:false, editable: false},
	{name:'course', search:true, editable: false},
	{name:'instructor', search:true, editable: false},
	{name:'registrationMode', search:true, editable: false},
	{name:'status', search:true, editable: false},
	{name:'id',hidden:true}
     ],
    rowNum:10,
    rowList:[10,20,30,40,50,100,200],
    pager: '#event_list_pager',
    viewrecords: true,
    sortorder: "asc",
    width: 1200,
    height: "100%",
    multiselect: false,
    caption:"Event List",
    onSelectRow: function(ids) { 
    	var selName = jQuery('#event_list').jqGrid('getCell', ids, 'title');
    	jQuery("#participant_list").jqGrid('setCaption',"Participant list for Event: "+selName);   	
    	jQuery("#detail_list").jqGrid('setCaption',"Details for Event: "+selName);   	
    	jQuery("#participant_list").jqGrid('setGridParam',{url:"jq_participant_list?eventid="+ids}).trigger('reloadGrid');    	
    	jQuery("#detail_list").jqGrid('setGridParam',{url:"jq_detail_list?eventid="+ids}).trigger('reloadGrid');    	
    	jQuery("#detail_list").jqGrid('setGridParam',{editurl:"jq_edit_detail?eventid="+ids});    	
    	}    
    });
    $("#event_list").jqGrid('filterToolbar',{autosearch:true});
    $("#event_list").jqGrid('navGrid',"#event_list_pager",{edit:false,add:false,del:true,search:false});
    $("#event_list").jqGrid('inlineNav',"#event_list_pager");
    $("#event_list").jqGrid('navGrid',"#event_list_pager").jqGrid('navButtonAdd',"#event_list_pager",{caption:"D/L-AttPairSheet", buttonicon:"ui-icon-arrowthick-1-s", onClickButton:downloadPairSheet, position: "last", title:"DownloadAttendanceSheet", cursor: "pointer"});
    $("#event_list").jqGrid('navGrid',"#event_list_pager").jqGrid('navButtonAdd',"#event_list_pager",{caption:"D/L-AttSheet", buttonicon:"ui-icon-arrowthick-1-s", onClickButton:downloadSheet, position: "last", title:"DownloadAttendanceSheet", cursor: "pointer"});
    $("#event_list").jqGrid('navGrid',"#event_list_pager").jqGrid('navButtonAdd',"#event_list_pager",{caption:"U/L-AttSheet", buttonicon:"ui-icon-arrowthick-1-n", onClickButton:uploadSheet, position: "last", title:"UploadSheet", cursor: "pointer"});
    $("#event_list").jqGrid('navGrid',"#event_list_pager").jqGrid('navButtonAdd',"#event_list_pager",{caption:"Stats", buttonicon:"ui-icon-tag", onClickButton:stats, position: "last", title:"Stats", cursor: "pointer"});
    
    jQuery("#participant_list").jqGrid({
      url:'jq_participant_list',
      editurl:'jq_edit_participant',
      datatype: "json",
      colNames:['Name','Gender','DoB','Family','Counsellor','Invited','Confirmed','Attended','Comments','RegCode','Role','RCS','Id'],
      colModel:[
	{name:'name', search:true, editable: false},
	{name:'gender', search:true, editable: false},
	{name:'dob', search:true, editable: false},
	{name:'family', search:true, editable: false},
	{name:'counsellor', search:true, editable: false},
	{name:'invited', search:true, editable: false},
	{name:'confirmed', search:true, editable: false},
	{name:'attended', search:true, editable: false},
	{name:'comments', search:true, editable: false},
	{name:'regCode', search:true, editable: false},
	{name:'role', search:true, editable: false},
	{name:'flgAddressPrinted', search:true, editable: false},
	{name:'id',hidden:true}
     ],
    rowNum:10,
    rowList:[10,20,30,40,50,100,200,300,500],
    pager: '#participant_list_pager',
    viewrecords: true,
    sortname: 'id',
    sortorder: "desc",
    width: 1200,
    height: "100%",
    multiselect: true,
    caption:"Event Participant List"
    });
    $("#participant_list").jqGrid('filterToolbar',{autosearch:true});
    $("#participant_list").jqGrid('navGrid',"#participant_list_pager",{edit:false,add:false,del:true,search:false});
    //$("#participant_list").jqGrid('inlineNav',"#participant_list_pager");
    $("#participant_list").jqGrid('navGrid',"#participant_list_pager").jqGrid('navButtonAdd',"#participant_list_pager",{caption:"ByIcsid", buttonicon:"ui-icon-script", onClickButton:bulkupload, position: "last", title:"BulkUpload", cursor: "pointer"});
    $("#participant_list").jqGrid('navGrid',"#participant_list_pager").jqGrid('navButtonAdd',"#participant_list_pager",{caption:"ByRole", buttonicon:"ui-icon-person", onClickButton:inviteByRole, position: "last", title:"InviteByRole", cursor: "pointer"});
    $("#participant_list").jqGrid('navGrid',"#participant_list_pager").jqGrid('navButtonAdd',"#participant_list_pager",{caption:"Invited", buttonicon:"ui-icon-mail-closed", onClickButton:markInvited, position: "last", title:"MarkInvited", cursor: "pointer"});
    $("#participant_list").jqGrid('navGrid',"#participant_list_pager").jqGrid('navButtonAdd',"#participant_list_pager",{caption:"Confirmed", buttonicon:"ui-icon-mail-open", onClickButton:markConfirmed, position: "last", title:"MarkConfirmed", cursor: "pointer"});
    $("#participant_list").jqGrid('navGrid',"#participant_list_pager").jqGrid('navButtonAdd',"#participant_list_pager",{caption:"Attended", buttonicon:"ui-icon-check", onClickButton:markAttended, position: "last", title:"MarkAttended", cursor: "pointer"});
    $("#participant_list").jqGrid('navGrid',"#participant_list_pager").jqGrid('navButtonAdd',"#participant_list_pager",{caption:"Comments", buttonicon:"ui-icon-comment", onClickButton:updateComments, position: "last", title:"UpdateComments", cursor: "pointer"});
	// add custom button to export the detail data to excel	
	jQuery("#participant_list").jqGrid('navGrid',"#participant_list_pager").jqGrid('navButtonAdd',"#participant_list_pager",{caption:"Export", buttonicon:"ui-icon-disk",title:"Export",
	       onClickButton : function () { 
			var query = 'jq_participant_list?eventid='+$('#event_list').jqGrid('getGridParam','selrow');
			//alert(query);
			jQuery("#participant_list").jqGrid('excelExport',{"url":query});
	       }
	       });

    jQuery("#detail_list").jqGrid({
      url:'jq_detail_list',
      editurl:'jq_edit_detail',
      datatype: "json",
      colNames:['Category','Type','Details','Id'],
      colModel:[
	{name:'category', search:true, editable: true},
	{name:'type', search:true, editable: true},
	{name:'details', search:true, editable: true},
	{name:'id',hidden:true}
     ],
    rowNum:5,
    rowList:[5,10,20],
    pager: '#detail_list_pager',
    viewrecords: true,
    sortname: 'id',
    sortorder: "desc",
    width: 1200,
    height: "100%",
    multiselect: true,
    caption:"Event Detail List"
    });
    $("#detail_list").jqGrid('filterToolbar',{autosearch:true});
    $("#detail_list").jqGrid('navGrid',"#detail_list_pager",{edit:false,add:false,del:true,search:false});
    $("#detail_list").jqGrid('inlineNav',"#detail_list_pager");
	
	function bulkupload() {
		var id = $('#event_list').jqGrid('getGridParam','selrow');
		if(id) {
				$( "#dialogBulkUploadForm" ).dialog( "open" );
		}
		else
			alert("Please select an event!!");	
	}

		$( "#dialogBulkUploadForm" ).dialog({
			autoOpen: false,
			height: 300,
			width: 400,
			modal: true,
			buttons: {
				"Submit": function() {
					    $("#eventId").val($('#event_list').jqGrid('getGridParam','selrow'));
					    $("#formBulkUploadParticipants").submit();					    
						
						$( this ).dialog( "close" );
				},
				"Cancel": function() {
					$( this ).dialog( "close" );
				}
			},
			close: function() {
				
			}
		});

	$('#formBulkUploadParticipants').submit(function(){

	      var url = "${createLink(controller:'Event',action:'bulkUploadParticipants')}";
	      
	      // gather the form data
	      var data=$(this).serialize();
	      // post data
	      $.post(url, data , function(returnData){
			  $('#icsidlist').val('');
			  jQuery("#participant_list").jqGrid().trigger("reloadGrid");
	      });

	      return false; // stops browser from doing default submit process
	});

	function markInvited() {
		var answer = confirm("Are you sure?");
		if (answer){
			var idlist = $('#participant_list').jqGrid('getGridParam','selarrrow');
			if(idlist) {
				var url = "${createLink(controller:'eventParticipant',action:'markInvited')}"+"?idlist="+idlist
				$.getJSON(url, {}, function(data) {
					alert(data.message);
					jQuery("#participant_list").jqGrid().trigger("reloadGrid");
				    });	
			}
			else
				alert("Please select a row!!");
		} else {
		    return false;
		}
	}

	function markConfirmed() {
		var answer = confirm("Are you sure?");
		if (answer){
			var idlist = $('#participant_list').jqGrid('getGridParam','selarrrow');
			if(idlist) {
				var url = "${createLink(controller:'eventParticipant',action:'markConfirmed')}"+"?idlist="+idlist
				$.getJSON(url, {}, function(data) {
					alert(data.message);
					jQuery("#participant_list").jqGrid().trigger("reloadGrid");
				    });	
			}
			else
				alert("Please select a row!!");
		} else {
		    return false;
		}
	}

	function markAttended() {
		var answer = confirm("Are you sure?");
		if (answer){
			var idlist = $('#participant_list').jqGrid('getGridParam','selarrrow');
			if(idlist) {
				var url = "${createLink(controller:'eventParticipant',action:'markAttended')}"+"?idlist="+idlist
				$.getJSON(url, {}, function(data) {
					alert(data.message);
					jQuery("#participant_list").jqGrid().trigger("reloadGrid");
				    });	
			}
			else
				alert("Please select a row!!");
		} else {
		    return false;
		}
	}

	function inviteByRole() {
		var id = $('#event_list').jqGrid('getGridParam','selrow');
		if(id) {
				$( "#dialogRoleForm" ).dialog( "open" );
		}
		else
			alert("Please select an event!!");	
	}

		$( "#dialogRoleForm" ).dialog({
			autoOpen: false,
			height: 300,
			width: 400,
			modal: true,
			buttons: {
				"Submit": function() {
					    $("#eventIdForRole").val($('#event_list').jqGrid('getGridParam','selrow'));
					    $("#formRoleParticipants").submit();					    
						
						$( this ).dialog( "close" );
				},
				"Cancel": function() {
					$( this ).dialog( "close" );
				}
			},
			close: function() {
				
			}
		});

	$('#formRoleParticipants').submit(function(){

	      var url = "${createLink(controller:'Event',action:'inviteByRole')}";
	      
	      // gather the form data
	      var data=$(this).serialize();
	      // post data
	      $.post(url, data , function(returnData){
			  jQuery("#participant_list").jqGrid().trigger("reloadGrid");
	      });

	      return false; // stops browser from doing default submit process
	});


	function updateComments() {
		var idlist = $('#participant_list').jqGrid('getGridParam','selarrrow');
		if(idlist) {
				$( "#dialogCommentsForm" ).dialog( "open" );
		}
		else
			alert("Please select an participants!!");	
	}

		$( "#dialogCommentsForm" ).dialog({
			autoOpen: false,
			height: 300,
			width: 400,
			modal: true,
			buttons: {
				"Submit": function() {
					    $("#epids").val($('#participant_list').jqGrid('getGridParam','selarrrow'));
					    $("#formCommentsParticipants").submit();					    
						
						$( this ).dialog( "close" );
				},
				"Cancel": function() {
					$( this ).dialog( "close" );
				}
			},
			close: function() {
				
			}
		});

	$('#formCommentsParticipants').submit(function(){

	      var url = "${createLink(controller:'EventParticipant',action:'updateComments')}";
	      
	      // gather the form data
	      var data=$(this).serialize();
	      // post data
	      $.post(url, data , function(returnData){
			  jQuery("#participant_list").jqGrid().trigger("reloadGrid");
	      });

	      return false; // stops browser from doing default submit process
	});

	function downloadPairSheet() {
		var id = $('#event_list').jqGrid('getGridParam','selrow');
		if(id) {
				/*var url = "${createLink(controller:'Event',action:'sheet')}"+"?eventid="+id+"&pair=true";
				$( "#divToPrintSheet" ).val("");
				$( "#divToPrintSheet" ).load( url, function(responseTxt,statusTxt,xhr){
				    if(statusTxt=="success")
				    {
					$( "#dialogPrintSheet" ).dialog( "open" );	
				    }
				    if(statusTxt=="error")
				      alert("Error: "+xhr.status+": "+xhr.statusText);
				  });*/
				  
				//@TODO: HARDCODED for cboard
				var url = "${createLink(controller:'Role',action:'pairs')}"+"?eid="+id+"&roleids=51,64";
				var win = window.open(url, '_blank');
				if(win){
				    //Browser has allowed it to be opened
				    win.focus();
				}else{
				    //Broswer has blocked it
				    alert('Please allow popups for this site');
				}			
				  
		}
		else
			alert("Please select a row!!");
	}

	function downloadSheet() {
		var id = $('#event_list').jqGrid('getGridParam','selrow');
		if(id) {
				var url = "${createLink(controller:'Event',action:'sheet')}"+"?eventid="+id;
				$( "#divToPrintSheet" ).val("");
				$( "#divToPrintSheet" ).load( url, function(responseTxt,statusTxt,xhr){
				    if(statusTxt=="success")
				    {
					$( "#dialogPrintSheet" ).dialog( "open" );	
				    }
				    if(statusTxt=="error")
				      alert("Error: "+xhr.status+": "+xhr.statusText);
				  });
		}
		else
			alert("Please select a row!!");
	}

	 $( "#dialogPrintSheet" ).dialog({
		autoOpen: false,
		 width:800,
		 height:500,
		modal: true,
		buttons: {
		"Print": function() {
		$('#divToPrintSheet').printArea();
		$( this ).dialog( "close" );
		},
		Cancel: function() {
		$( this ).dialog( "close" );
		}
		}
	});

	function uploadSheet() {
		var id = $('#event_list').jqGrid('getGridParam','selrow');
		if(id) {
				$( "#dialogUploadSheet" ).dialog( "open" );
		}
		else
			alert("Please select an event!!");	
	}

		$( "#dialogUploadSheet" ).dialog({
			autoOpen: false,
			height: 300,
			width: 400,
			modal: true,
			buttons: {
				"Submit": function() {
					    $("#sheeteventId").val($('#event_list').jqGrid('getGridParam','selrow'));
					    $("#formUploadSheet").submit();					    
						
						$( this ).dialog( "close" );
				},
				"Cancel": function() {
					$( this ).dialog( "close" );
				}
			},
			close: function() {
				
			}
		});

	$('#formUploadSheet').submit(function(){

	      var url = "${createLink(controller:'Event',action:'uploadSheet')}";
	      
	      // gather the form data
	      var data=$(this).serialize();
	      // post data
	      $.post(url, data , function(returnData){
			  $('#icsidlist').val('');
			  jQuery("#participant_list").jqGrid().trigger("reloadGrid");
	      });

	      return false; // stops browser from doing default submit process
	});

	function stats() {
		var id = $('#event_list').jqGrid('getGridParam','selrow');
		if(id) {
				var url = "${createLink(controller:'Event',action:'stats')}"+"?eventid="+id;
				$( "#divStats" ).val("");
				$( "#divStats" ).load( url, function(responseTxt,statusTxt,xhr){
				    if(statusTxt=="success")
				    {
					$( "#dialogStats" ).dialog( "open" );	
				    }
				    if(statusTxt=="error")
				      alert("Error: "+xhr.status+": "+xhr.statusText);
				  });
		}
		else
			alert("Please select a row!!");
	}

	 $( "#dialogStats" ).dialog({
		autoOpen: false,
		 width:800,
		 height:500,
		modal: true,
		buttons: {
		Cancel: function() {
		$( this ).dialog( "close" );
		}
		}
	});

    });
</script>


    </body>
</html>
