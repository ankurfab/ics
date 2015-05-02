
<%@ page import="ics.Person" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'person.label', default: 'Person')}" />
		<title>Contacts</title>

		<link rel="stylesheet" href="${resource(dir:'css',file:'ui.jqgrid.css')}" />
		<link rel="stylesheet" href="${resource(dir:'css/redmond',file:'jquery-ui-1.8.23.custom.css')}" />

		<r:require module="grid" />
		<r:require module="ajaxform"/>

	</head>
	<body>
		<g:render template="/common/mandrillemail" />
		<div class="nav">
		    <span class="menuButton"></span>
		</div>

		<g:if test="${flash.message}">
		<div class="message" role="status">${flash.message}</div>
		</g:if>

		<div id='message' class="message" style="display:none;"></div>

		<!--<g:radio name="filter" value="ALL" onClick="gridReload('ALL')"/>ALL
		<g:radio name="filter" value="MATCHED" onClick="gridReload('MATCHED')"/>LINKED
		<g:radio name="filter" value="UNMATCHED"  onClick="gridReload('UNMATCHED')" checked="true"/>UNLINKED-->
		<!--<g:radio name="filter" value="CONFLICT"  onClick="gridReload('CONFLICT')"/>CONFLICT-->

		<!-- table tag will hold our grid -->
		<table id="person_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
		<!-- pager will hold our paginator -->
		<div id="person_list_pager" class="scroll" style="text-align:center;"></div>

		<sec:ifAnyGranted roles="ROLE_NVCC_ADMIN">
			<input class="menuButton" type="BUTTON" id="btnMatch" value="Match Selected" />
		</sec:ifAnyGranted>

		<sec:ifAnyGranted roles="ROLE_ATITHI_ADMIN">
			<input class="menuButton" type="BUTTON" id="btnEMAIL" value="EMAIL" gridName="#person_list" entityName="Person" departmentId="${ics.Department.findByName('Guest Reception Department')?.id}"/>
		</sec:ifAnyGranted>

		<div>
		Upload contacts in bulk: <br />
		    <g:uploadForm action="upload">
			<input type="file" name="myFile" />
			<input type="submit" value="Upload"/>
		    </g:uploadForm>
		</div>

		<div id="dialogSubscriptionForm" title="Topic Subscription">
			<g:render template="/topic/subscription" />
		</div>
		
		<script type="text/javascript">
		  $(document).ready(function () {

    var editOptions = {
            keys: true,
            successfunc: function () {
                var $self = $(this);
                setTimeout(function () {
                    $self.trigger("reloadGrid");
                }, 50);
            }
    };


		    jQuery("#person_list").jqGrid({
		      url:'jq_person_list?code=UNMATCHED',
		      editurl:'jq_edit_person',
		      datatype: "json",
		      colNames:['Name','Address','Phone','Email','DoB','DoM','Category','Creator','id'],
		      colModel:[
			{name:'name', editable:true,
			formatter:'showlink', 
             		//formatoptions:{baseLinkUrl:'show', addParam: '&category=edit'}
             		formatoptions:{baseLinkUrl:'match'},
             		editrules: {required: true}
			},
			{name:'address', editable:true,editrules: {required: true}},
			{name:'phone', editable:true,editrules: {required: true}},
			{name:'email', editable:true,editrules: {required: false, email: true}},
			{name:'dob', editable:true,editrules: {required: false, date: true},datefmt: 'd-m-Y'},
			{name:'dom', editable:true,editrules: {required: false, date: true}, datefmt: 'd-m-Y'},
			{name:'category'},
			{name:'creator', hidden:true},
			{name:'id',hidden:true}
		     ],
		    multiselect: true,
		    rowNum:10,
		    rowList:[10,20,30,40,50,100,200],
		    pager: '#person_list_pager',
		    viewrecords: true,
		    gridview: true,
		    sortname: "id",
		    sortorder: "desc",
		    width: 1250,
		    height: "100%",
		    caption:"Contact List"
		    });
		   $("#person_list").jqGrid('filterToolbar',{autosearch:true});
		   $("#person_list").jqGrid('navGrid',"#person_list_pager",
			{add:false,edit:false,del:true, search: false}, // which buttons to show?
			{},         // edit options
			{addCaption:'Create New Person',afterSubmit:afterSubmitEvent,savekey:[true,13],closeAfterAdd:true},  // add options
			{}          // delete options
		    );
		    jQuery("#person_list").jqGrid('inlineNav',"#person_list_pager",
				{
				    addParams: {
					addRowParams: editOptions
				    },
				    editParams: editOptions
				}    
			);

		<sec:ifAnyGranted roles="ROLE_ATITHI_ADMIN,ROLE_ATITHI_USER">
		
		    $("#person_list").jqGrid('navGrid',"#person_list_pager").jqGrid('navButtonAdd',"#person_list_pager",{caption:"Subscribe", buttonicon:"ui-icon-note", onClickButton:subscribe, position: "last", title:"Subscribe", cursor: "pointer"});
		    <!--$("#person_list").jqGrid('navGrid',"#person_list_pager").jqGrid('navButtonAdd',"#person_list_pager",{caption:"Email", buttonicon:"ui-icon-mail-closed", onClickButton:email, position: "last", title:"Email", cursor: "pointer"});-->

		</sec:ifAnyGranted>


	function email() {
		var answer = confirm("Are you sure?");
		if (answer){
			var ids = $('#person_list').jqGrid('getGridParam','selarrrow');
			if(ids!="") {
				var url = "${createLink(controller:'person',action:'mail')}"+"?idlist="+ids
				$.getJSON(url, {}, function(data) {
					alert(data.message);
				    });	
			}
			else
				alert("Please select a row!!");
		} else {
		    return false;
		}
	}

	function subscribe() {
		var id = $('#person_list').jqGrid('getGridParam','selrow');
		if(id) {
				$( "#dialogSubscriptionForm" ).dialog( "open" );
		}
		else
			alert("Please select a row!!");
	}


		$( "#dialogSubscriptionForm" ).dialog({
			autoOpen: false,
			height: 350,
			width: 300,
			modal: true,
			buttons: {
				"Submit": function() {
					    $("#personid").val($('#person_list').jqGrid('getGridParam','selrow'));
					    $("#formSubscription").ajaxForm({
						success: function() {
							alert("Subscription successful!!");
							}
					    }).submit();
						
						$( this ).dialog( "close" );
				},
				"Cancel": function() {
					$( this ).dialog( "close" );
				}
			},
			close: function() {
				
			}
		});

		var afterSaveFunc = function (rowId, response) {
		    var data = $.parseJSON(response.responseText);
		    //alert(data.message+" "+data.state+" "+data.id);
		    if (data.state !== "FAIL") {
			    //alert("Setting id");
			    //$("#new_row").attr('id',data.id);
			    //TODO: there should be a more efficient way of getting the id for the new record
			    jQuery("#person_list").jqGrid().trigger('reloadGrid');
			} else {
			    alert("Cant update the id of the newly added record!!"+data.message);
			}
		}

		$("#btnMatch").click(function(){
			var gr = jQuery("#person_list").jqGrid('getGridParam','selrow');
			if( gr != null )
				{
				var grid = jQuery('#person_list');
				var sel_id = grid.jqGrid('getGridParam', 'selrow');
				var url = "${createLink(controller:'person',action:'match',params:['category':session.individualid])}"+"\u0026"+"id="+sel_id;
				window.location = url;
				}
			else
				alert("Please Select Row"); });

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
			
			jQuery("#person_list").jqGrid().trigger("reloadGrid");
			
			return [success,message,new_id];
		    }

		function gridReload(code){
			jQuery("#person_list").jqGrid('setGridParam',{url:"jq_person_list?code="+code}).trigger("reloadGrid");
			}


		</script>



	</body>
</html>
