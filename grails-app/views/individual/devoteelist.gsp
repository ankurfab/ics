
<%@ page import="ics.Individual" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'individual.label', default: 'Individual')}" />
		<title>List of Devotees</title>
 
		<r:require module="grid" />
		<r:require module="dateTimePicker" />
	</head>
	<body>
		<div class="nav">
		    <span class="menuButton"></span>
	            <span class="menuButton"></span>
		</div>

		<div id='message' class="message" style="display:none;"></div>

		<!-- table tag will hold our grid -->
		<table id="devotee_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
		<!-- pager will hold our paginator -->
		<div id="devotee_list_pager" class="scroll" style="text-align:center;"></div>

		<sec:ifAnyGranted roles="ROLE_PATRONCARE,ROLE_PATRONCARE_USER">
			<input class="menuButton" type="BUTTON" id="btnMatch" value="Birthday" />
			<input class="menuButton" type="BUTTON" id="btnMatchMAnniv" value="MarriageAnniversary" />
			<!--<a href="javascript:void(0)" id="m1">Followup</a>-->
		</sec:ifAnyGranted>
		<sec:ifAnyGranted roles="ROLE_PATRONCARE,ROLE_PATRONCARE_USER,ROLE_EVENTADMIN,ROLE_EVENTMANAGER">
			<input class="menuButton" type="BUTTON" id="btnMatchDonation" value="Donation" />
			<!--<a href="javascript:void(0)" id="m2">Invite</a>-->
			<input class="menuButton" type="BUTTON" id="create-user" value="FollowupDialog" />
		</sec:ifAnyGranted>
		

		<div id="dialogDoB" title="DoB">
			<form>
			<fieldset>
				<label for="From">Range</nlabel>
				<input type="text" id="RangeDoB" style="border:0; color:#f6931f; font-weight:bold;" size="30"/>
				<br>
				<div id="slider-range-dob"></div>
			
				<!--<label for="dobFrom">Date From</nlabel>
				<g:textField name="dobFrom" value=""/><br>				
				<label for="dobTo">Date To</nlabel>
				<g:textField name="dobTo" value=""/>-->				
			</fieldset>
			</form>
		
		</div>

		<div id="dialogMarriageAnniversary" title="MarriageAnniversary">
			<form>
			<fieldset>
				<label for="From">Range</nlabel>
				<input type="text" id="RangeMA" style="border:0; color:#f6931f; font-weight:bold;" size="30"/>
				<br>
				<div id="slider-range-ma"></div>
			
				<!--<label for="marriageAnniversaryFrom">Date From</nlabel>
				<g:textField name="marriageAnniversaryFrom" value=""/><br>				
				<label for="marriageAnniversaryTo">Date To</nlabel>
				<g:textField name="marriageAnniversaryTo" value=""/>-->				
			</fieldset>
			</form>
		
		</div>

		<div id="dialog-form" title="Followup">
			<form>
			<fieldset>
				<label for="desc">Comments</nlabel>
				<textarea rows="2" cols="20" name="description" id="desc" class="text ui-widget-content ui-corner-all"></textarea> 
				
			</fieldset>
			</form>
		</div>
		
		<div id="dialogDonation" title="Donation">
			<form>
			<fieldset>
				<label for="From">Range</nlabel>
				<input type="text" id="Range" style="border:0; color:#f6931f; font-weight:bold;" size="30"/>
				<br>
				<div id="slider-range-donation"></div>
				
			</fieldset>
			</form>
		
		</div>

		
		<script type="text/javascript">
		  $(document).ready(function () {
		  
		  $("#dobFrom").datepicker({yearRange: "-100:+0",changeMonth: true,changeYear: true,
				dateFormat: 'dd-mm-yy'});
		  $("#dobTo").datepicker({yearRange: "-100:+0",changeMonth: true,changeYear: true,
				dateFormat: 'dd-mm-yy'});
		  $("#marriageAnniversaryFrom").datepicker({yearRange: "-100:+0",changeMonth: true,
				changeYear: true,
				dateFormat: 'dd-mm-yy'});
		  $("#marriageAnniversaryTo").datepicker({yearRange: "-100:+0",changeMonth: true,
				changeYear: true,
				dateFormat: 'dd-mm-yy'});
		  
		$( "#slider-range-donation" ).slider({
			animate: true,
			step: 100,
			range: true,
			min: 0,
			max: 15000000,
			values: [5000000, 10000000],
			slide: function( event, ui ) {
				$( "#Range" ).val( "Rs." + ui.values[ 0 ] + " - Rs." + ui.values[ 1 ] );
			},
		        change: function(event, ui) {
		           $('#hRange').attr('value', ui.value);
			}
		});
		$( "#Range" ).val( "Rs." + $( "#slider-range-donation" ).slider( "values", 0 ) + " - Rs." + $( "#slider-range-donation" ).slider( "values", 1 ) );
		$( "#Range" ).slider( "option", "step", 100 );
		$( "#Range" ).slider( "option", "animate", true);
		  
		$( "#slider-range-dob" ).slider({
			animate: true,
			step: 1,
			range: true,
			min: 1,
			max: 31,
			values: [10, 20],
			slide: function( event, ui ) {
				$( "#RangeDoB" ).val( ui.values[ 0 ] + " - " + ui.values[ 1 ] );
			},
		        change: function(event, ui) {
		           $('#hRange').attr('value', ui.value);
			}
		});
		$( "#RangeDoB" ).val( $( "#slider-range-dob" ).slider( "values", 0 ) + " - " + $( "#slider-range-dob" ).slider( "values", 1 ) );
		$( "#RangeDoB" ).slider( "option", "step", 1 );
		$( "#RangeDoB" ).slider( "option", "animate", true);

		$( "#slider-range-ma" ).slider({
			animate: true,
			step: 1,
			range: true,
			min: 1,
			max: 31,
			values: [10, 20],
			slide: function( event, ui ) {
				$( "#RangeMA" ).val( ui.values[ 0 ] + " - " + ui.values[ 1 ] );
			},
		        change: function(event, ui) {
		           $('#hRange').attr('value', ui.value);
			}
		});
		$( "#RangeMA" ).val( $( "#slider-range-ma" ).slider( "values", 0 ) + " - " + $( "#slider-range-ma" ).slider( "values", 1 ) );
		$( "#RangeMA" ).slider( "option", "step", 1 );
		$( "#RangeMA" ).slider( "option", "animate", true);

		    jQuery("#devotee_list").jqGrid({
		      url:'jq_devotee_list',
		      editurl:'jq_edit_devotee',
		      datatype: "json",
		      colNames:['LegalName','InitiatedName','DoB','Address','Phone','Email','Counselor','Guru'],
		      colModel:[
			{name:'legalname',
			formatter:'showlink', 
             		formatoptions:{baseLinkUrl:'show', addParam: '&category=edit'}
			},
			{name:'initiatedname', editable:false},
			{name:'dob', editable:false},
			{name:'address', editable:false},
			{name:'phone', editable:false},
			{name:'email', editable:false, search:true},
			{name:'counsellor', editable:false},
			{name:'guru', editable:false}
		     ],
		    rowNum:10,
		    rowList:[10,20,30,40,50,100,200],
		    pager: '#devotee_list_pager',
		    viewrecords: true,
		    gridview: true,
		    sortorder: "asc",
		    width: 1250,
		    height: "100%",
		    multiselect: true,
		    caption:"Devotee List"
		    });
		   $("#devotee_list").jqGrid('filterToolbar',{autosearch:true});
		   $("#devotee_list").jqGrid('navGrid',"#devotee_list_pager",
			{add:false,edit:false,del:false, search: false}, // which buttons to show?
			{},         // edit options
			{addCaption:'Create New Individual',afterSubmit:afterSubmitEvent,savekey:[true,13],closeAfterAdd:true},  // add options
			{}          // delete options
		    );

		/*$("#btnMatch").click(function(){
			jQuery("#individual_list").jqGrid('setGridParam',{url:"jq_individual_list?dobFlag=1&dayRange=6"}).trigger("reloadGrid");
		 });
		$("#btnMatchMAnniv").click(function(){
			jQuery("#individual_list").jqGrid('setGridParam',{url:"jq_individual_list?maFlag=1&dayRange=6"}).trigger("reloadGrid");
		 });
		 

		 jQuery("#m1").click( function() {
			var url = "${createLink(controller:'followup',action:'create',params:['individualid':session.individualid,'ids':''])}"+jQuery("#individual_list").jqGrid('getGridParam','selarrrow');
			window.location = url;
			});
		 jQuery("#m2").click( function() {
			var url = "${createLink(controller:'eventParticipant',action:'inviteForEvent',params:['event.id':1,'ids':''])}"+jQuery("#individual_list").jqGrid('getGridParam','selarrrow');
			window.location = url;
			});*/

		$( "#dialog-form" ).dialog({
			autoOpen: false,
			height: 300,
			width: 350,
			modal: true,
			buttons: {
				"Followup": function() {
					var description = $('#desc').val();
					var idlist = jQuery("#individual_list").jqGrid('getGridParam','selarrrow')
					//alert(description);
					//alert("clicked:"+idlist);	// & -> "\u0026"
					
					var url = "${createLink(controller:'followup',action:'save')}"
					//alert(url);
					$('#dialog-form').load(url,{'ids':""+idlist,'comments':description})
					
						$( this ).dialog( "close" );
				},
				Cancel: function() {
					$( this ).dialog( "close" );
				}
			},
			close: function() {
				
			}
		});
/////////////////////////////////////////////////////////
		$( "#dialogDonation" ).dialog({
			autoOpen: false,
			height: 150,
			width: 1250,
			modal: true,
			buttons: {
				"Submit": function() {
					
					$( this ).dialog( "close" );
					jQuery("#individual_list").jqGrid('setGridParam',{url:"jq_individual_list?donationFlag=1&minAmt="+$( "#slider-range-donation" ).slider( "values", 0 )+"&maxAmt="+$( "#slider-range-donation" ).slider( "values", 1 )}).trigger("reloadGrid");
					
				},
				Cancel: function() {
					$( this ).dialog( "close" );
				}
			},
			close: function() {
				
			}
		});

		$( "#dialogDoB" ).dialog({
			autoOpen: false,
			height: 150,
			width: 350,
			modal: true,
			buttons: {
				"Submit": function() {
					//alert($( "#slider-range-dob" ).slider( "values", 0 ));
					//alert($( "#slider-range-dob" ).slider( "values", 1 ));
					$( this ).dialog( "close" );
					jQuery("#individual_list").jqGrid('setGridParam',{url:"jq_individual_list?dobFlag=1&dayFrom="+$( "#slider-range-dob" ).slider( "values", 0 )+"&dayTo="+$( "#slider-range-dob" ).slider( "values", 1 )}).trigger("reloadGrid");
				},
				Cancel: function() {
					$( this ).dialog( "close" );
				}
			},
			close: function() {
				
			}
		});

		$( "#dialogMarriageAnniversary" ).dialog({
			autoOpen: false,
			height: 150,
			width: 350,
			modal: true,
			buttons: {
				"Submit": function() {
					//alert("MarriageAnniversary");					
					$( this ).dialog( "close" );
					jQuery("#individual_list").jqGrid('setGridParam',{url:"jq_individual_list?maFlag=1&dayFrom="+$( "#slider-range-ma" ).slider( "values", 0 )+"&dayTo="+$( "#slider-range-ma" ).slider( "values", 1 )}).trigger("reloadGrid");
				},
				Cancel: function() {
					$( this ).dialog( "close" );
				}
			},
			close: function() {
				
			}
		});
		$( "#create-user" )
			.button()
			.click(function() {
				var idlist = jQuery("#individual_list").jqGrid('getGridParam','selarrrow');
				
				if(idlist!='')
					$( "#dialog-form" ).dialog( "open" );
				else
					alert("Select at least 1 devotee to follow up!!");
			});


		$( "#btnMatchDonation" )
			.button()
			.click(function() {
				$( "#dialogDonation" ).dialog( "open" );
			});

		$( "#btnMatch" )
			.button()
			.click(function() {
				$( "#dialogDoB" ).dialog( "open" );
			});

		$( "#btnMatchMAnniv" )
			.button()
			.click(function() {
				$( "#dialogMarriageAnniversary" ).dialog( "open" );
			});
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
