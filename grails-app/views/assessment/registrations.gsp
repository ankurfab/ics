
<%@ page import="ics.Assessment" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Registration List</title>
	<r:require module="grid" />
	<r:require module="dateTimePicker" />
	<r:require module="ajaxform"/>
	<r:require module="printarea" />

		<style>
			.bgLightBlue{
			   background: none repeat scroll 0 0 lightblue !important;
			  }
			.bgGreen{
			   background: none repeat scroll 0 0 green !important;
			  }
			.bgLightGreen{
			   background: none repeat scroll 0 0 lightgreen !important;
			  }
			.bgOrange{
			   background: none repeat scroll 0 0 orange !important;
			  }
			.bgRed{
			   background: none repeat scroll 0 0 red !important;
			  }
			.bgYellow{
			   background: none repeat scroll 0 0 yellow !important;
			  }
		</style>		


    </head>
    <body>
		<g:javascript src="tinymce/tinymce.min.js" />    
		<g:render template="/common/apisms" />
		<g:render template="/common/mandrillemail" />

        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
        </div>
        <div class="body">
            Event:<g:select id="event" name="event" from="${events}" optionValue="title" optionKey="id" value="${event?.id}"  onchange="reloadGrid()"/>
            <div>
			<!-- table tag will hold our grid -->
			<table id="registration_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
			<!-- pager will hold our paginator -->
			<div id="registration_list_pager" class="scroll" style="text-align:center;"></div>
			<input class="menuButton" type="BUTTON" id="btnSMS_RegistrationList" value="SMS" gridName="#registration_list" entityName="EventRegistration"/>
			<input class="menuButton" type="BUTTON" id="btnEMAIL_RegistrationList" value="EMAIL" gridName="#registration_list" entityName="EventRegistration"/>
	    </div>

	<div>
		<table>
			<tr>
				<td style="background:yellow">User not created!!</td>
				<td style="background:orange">User locked!!</td>
				<td style="background:red">Code verification failed!!</td>
				<td style="background:lightgreen">Code verified. Ready to take exam!!</td>
				<td style="background:lightblue">Exam taken!!</td>
			</tr>
		</table>
	</div>


	    <sec:ifAnyGranted roles="ROLE_ASMT_ADMIN">
		<div>
		Upload registrations in bulk: <br />
		    <g:uploadForm controller="Assessment" action="uploadbulkregistration">
			<g:select name='bulkUploadAssessmentId' 
			    from='${ics.Assessment.findAllByCourse(events[0]?.course,[sort:'name'])}'
			    optionKey="id" optionValue="name"></g:select>
			<input type="file" name="myFile" />
			<input type="submit" value="Upload"/>
			<g:hiddenField name="bulkUploadEventId" value="${events[0]?.id}" />
		    </g:uploadForm>
		</div>
	    </sec:ifAnyGranted>


		<div id="dialogPayForm" title="Payment Reference">
			<g:render template="/paymentReference/paymentReferenceAssessment" />
		</div>

		<div id="dialogPrintResult" title="QA Sheet">
			<div id="divToPrintResult"></div>
		</div>

		<div id="dialogPrintFeedback" title="Print Feedback">
			<div id="divToPrintFeedback"></div>
		</div>

        </div>

<script>
  $(document).ready(function () {
    var lastsel3; 
    jQuery("#registration_list").jqGrid({
      url:'jq_registration_list?eid='+$('#event').val(),
      editurl:'jq_edit_registration',
      datatype: "json",
      colNames:['Name','DoB','Gender','Mobile','Email','Address','Pin','From','City','Year','IdType','IdNo','Assessment','Language','Comments','PaymentReference','User','Code','Result','RegistrationCode(Date)','IAid','indid','Id'],
      colModel:[
	{name:'name', search:true,editable: true},
	{name:'dob', search:false,editable: true,
		editoptions:{ 
				  dataInit:function(el){ 
					$(el).datepicker({dateFormat:'dd-mm-yy',defaultDate: new Date()}); 
				  }}
	},
	{name:'isMale', search:true,editable: true,
		edittype:"select",editoptions:{value:"${'Male:Male;Female:Female'}"},
		formatter:'select',stype:'select', searchoptions: { value: ':ALL;Male:Male;Female:Female'}
	},
	{name:'contactNumber', search:true,editable: true,},
	{name:'email', search:true,editable: true,},
	{name:'address', search:true,editable: true,},
	{name:'addressPincode', search:true,editable: true,},
	{name:'connectedIskconCenter', search:true,editable: true,},
	{name:'centerLocation', search:true,editable: true,},
	{name:'year', search:false,editable: true,},
	{name:'idproofType', search:false,editable: true,},
	{name:'idProofId', search:false,editable: true,},
	{name:'assessment', search:true,editable: true,
		edittype:"select",editoptions:{value:"${ics.Assessment.findAllByStatusNotEqual('CANCELLED',[sort:"name"])?.collect{it.name+':'+it.name}.join(';')}"},
		formatter:'select',stype:'select', searchoptions: { value: "${':ALL;'+(ics.Assessment.findAllByStatusNotEqual('CANCELLED',[sort:"name"])?.collect{it.name+':'+it.name}.join(';'))}"}
	},
	{name:'otherGuestType', search:true,editable: true,
		edittype:"select",editoptions:{value:"${'English:English;Hindi:Hindi;Marathi:Marathi;Telugu:Telugu'}"},
		formatter:'select',stype:'select', searchoptions: { value: ':ALL;English:English;Hindi:Hindi;Marathi:Marathi;Telugu:Telugu'}
	},
	{name:'comments', search:true,editable: true,},
	{name:'paymentReference', search:true,editable: false,},
	{name:'user', search:true,editable: false,},
	{name:'code', search:true,editable: false,},
	{name:'result', search:false,editable: false,},
	{name:'arrivalDate', search:true},
	{name:'iaid',hidden:true},
	{name:'indid',hidden:true},
	{name:'id',hidden:true}
     ],
    rowNum:15,
    rowList:[10,15,20,30,40,50,100,200],
    pager: '#registration_list_pager',
    viewrecords: true,
    sortname: 'arrivalDate',
    sortorder: "desc",
    rowattr: function (rd) {
	    if (rd.result!= null && rd.result.length>0) {
		return {"class": "bgLightBlue"};
		}
	    if (rd.user== null ) {
		return {"class": "bgYellow"};
		}
	    if (rd.user!= null && rd.user.indexOf("LOCKED") > -1 ) {
		return {"class": "bgOrange"};
		}
	    if (rd.code!= null && rd.code.indexOf("LOCKED") > -1) {
		return {"class": "bgRed"};
		}
	    if (rd.code!= null && rd.code.length>0) {
		return {"class": "bgLightGreen"};
		}
	    },		        
    width: 1200,
    height: "100%",
    multiselect: true,
    caption:"Registration List"
    });
    $("#registration_list").jqGrid('filterToolbar',{autosearch:true});
    $("#registration_list").jqGrid('navGrid',"#registration_list_pager",{edit:false,add:false,del:true,search:false});
    $("#registration_list").jqGrid('inlineNav',"#registration_list_pager",
	    { 
	       edit: true,
	       add: false,
	       save: true,
	       cancel: true,
	    }
    );
    $("#registration_list").jqGrid('navGrid',"#registration_list_pager").jqGrid('navButtonAdd',"#registration_list_pager",{caption:"Pay", buttonicon:"ui-icon-calculator", onClickButton:pay, position: "last", title:"Pay", cursor: "pointer"});
    <!--$("#registration_list").jqGrid('navGrid',"#registration_list_pager").jqGrid('navButtonAdd',"#registration_list_pager",{caption:"Setup", buttonicon:"ui-icon-gear", onClickButton:setup, position: "last", title:"Setup", cursor: "pointer"});-->
    <sec:ifAnyGranted roles="ROLE_ASMT_ADMIN">
	    $("#registration_list").jqGrid('navGrid',"#registration_list_pager").jqGrid('navButtonAdd',"#registration_list_pager",{caption:"User", buttonicon:"ui-icon-unlocked", onClickButton:unlockUser, position: "last", title:"UnlockUser", cursor: "pointer"});
	    $("#registration_list").jqGrid('navGrid',"#registration_list_pager").jqGrid('navButtonAdd',"#registration_list_pager",{caption:"Code", buttonicon:"ui-icon-unlocked", onClickButton:unlockCode, position: "last", title:"UnlockCode", cursor: "pointer"});
	    $("#registration_list").jqGrid('navGrid',"#registration_list_pager").jqGrid('navButtonAdd',"#registration_list_pager",{caption:"ReTest", buttonicon:"ui-icon-unlocked", onClickButton:retest, position: "last", title:"ReTest", cursor: "pointer"});
	    $("#registration_list").jqGrid('navGrid',"#registration_list_pager").jqGrid('navButtonAdd',"#registration_list_pager",{caption:"QASheet", buttonicon:"ui-icon-script", onClickButton:qasheet, position: "last", title:"QASheet", cursor: "pointer"});
	    $("#registration_list").jqGrid('navGrid',"#registration_list_pager").jqGrid('navButtonAdd',"#registration_list_pager",{caption:"Feedback", buttonicon:"ui-icon-comment", onClickButton:feedback, position: "last", title:"Feedback", cursor: "pointer"});
	// add custom button to export the detail data to excel	
	jQuery("#registration_list").jqGrid('navGrid',"#registration_list_pager").jqGrid('navButtonAdd',"#registration_list_pager",{caption:"Export", buttonicon:"ui-icon-disk",title:"Export",
	       onClickButton : function () { 
			var query = 'jq_registration_list?eid='+$('#event').val();			
			jQuery("#registration_list").jqGrid('excelExport',{"url":query});
	       }
	       });
     </sec:ifAnyGranted>      

	function pay() {
		var id = $('#registration_list').jqGrid('getGridParam','selrow');
		if(id) {
				$( "#dialogPayForm" ).dialog( "open" );
		}
		else
			alert("Please select a row!!");
	}

	function setup() {
		var answer = confirm("Are you sure?");
		if (answer){
			var idlist = $('#registration_list').jqGrid('getGridParam','selarrrow');
			if(idlist) {
				var url = "${createLink(controller:'assessment',action:'setup')}"+"?idlist="+idlist
				$.getJSON(url, {}, function(data) {
					alert(data.message);
					jQuery("#registration_list").jqGrid().trigger("reloadGrid");
				    });	
			}
			else
				alert("Please select a row!!");
		} else {
		    return false;
		}
	}

	function unlockUser() {
		var answer = confirm("Are you sure?");
		if (answer){
			var idlist = $('#registration_list').jqGrid('getGridParam','selarrrow');
			if(idlist) {
				var url = "${createLink(controller:'assessment',action:'unlockAndResetUser')}"+"?idlist="+idlist
				$.getJSON(url, {}, function(data) {
					alert(data.message);
					jQuery("#registration_list").jqGrid().trigger("reloadGrid");
				    });	
			}
			else
				alert("Please select a row!!");
		} else {
		    return false;
		}
	}

	function unlockCode() {
		var answer = confirm("Are you sure?");
		if (answer){
			var idlist = $('#registration_list').jqGrid('getGridParam','selarrrow');
			if(idlist) {
				var url = "${createLink(controller:'assessment',action:'unlockCodeVerification')}"+"?idlist="+idlist
				$.getJSON(url, {}, function(data) {
					alert(data.message);
					jQuery("#registration_list").jqGrid().trigger("reloadGrid");
				    });	
			}
			else
				alert("Please select a row!!");
		} else {
		    return false;
		}
	}

	function retest() {
		var answer = confirm("Are you sure?");
		if (answer){
			var idlist = $('#registration_list').jqGrid('getGridParam','selarrrow');
			if(idlist) {
				var url = "${createLink(controller:'assessment',action:'retest')}"+"?idlist="+idlist
				$.getJSON(url, {}, function(data) {
					alert(data.message);
					jQuery("#registration_list").jqGrid().trigger("reloadGrid");
				    });	
			}
			else
				alert("Please select a row!!");
		} else {
		    return false;
		}
	}
		$( "#dialogPayForm" ).dialog({
			autoOpen: false,
			height: 350,
			width: 300,
			modal: true,
			buttons: {
				"Submit": function() {
					    $("#erid").val($('#registration_list').jqGrid('getGridParam','selrow'));
					    $("#formPaymentReference").ajaxForm({
						success: function() {
							alert("Payment reference submitted");
							jQuery("#registration_list").jqGrid().trigger("reloadGrid");
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

        function showIndividualAssessment(cellValue, options, rowdata, action)
        {
            var url = "${createLink(controller:'IndividualAssessment',action:'show')}"+"?id="+rowdata[20];
            if(rowdata[20])
            	return "<a href='"+url+"' target='_new'>"+cellValue+"</a>";
            else if(rowdata[21])
            	return "<a href='' target='_new'>"+cellValue+"</a>";
            else
            	return cellValue
        }

	$('#event').change(function(event) {
		var eid = $('#event').val();
		$("#registration_list").jqGrid('setGridParam',{url:'jq_registration_list?eid='+eid}).trigger('reloadGrid');    	
	    });

	 $( "#dialogPrintResult" ).dialog({
		autoOpen: false,
		 width:900,
		 height:500,
		modal: true,
		buttons: {
		"Print": function() {
		$('#divToPrintResult').printArea();
		$( this ).dialog( "close" );
		},
		Cancel: function() {
		$( this ).dialog( "close" );
		}
		}
	});
    
	function qasheet() {
		var id = $('#registration_list').jqGrid('getGridParam','selrow');
		if(id) {
				var url = "${createLink(controller:'Assessment',action:'qasheet')}"+"?erid="+id;
				$( "#divToPrintResult" ).val("");
				$( "#divToPrintResult" ).load( url, function(responseTxt,statusTxt,xhr){
				    if(statusTxt=="success")
				    {
					$( "#dialogPrintResult" ).dialog( "open" );	
				    }
				    if(statusTxt=="error")
				      alert("Error: "+xhr.status+": "+xhr.statusText);
				  });
		}
		else
			alert("Please select a row!!");	
	}

	function feedback() {
	      var url = "${createLink(controller:'Assessment',action:'feedback')}";
	      
	      // gather the form data
	      var data="eventid=${events[0]?.id}";
	      // post data
	      $.post(url, data , function(returnData){
			  $('#divToPrintFeedback').html( returnData);
			  $( "#dialogPrintFeedback" ).dialog( "open" );
			  
	      });
	}

	 $( "#dialogPrintFeedback" ).dialog({
		autoOpen: false,
		 width:800,
		 height:600,
		modal: true,
		buttons: {
		"Print": function() {
		$('#divToPrintFeedback').printArea();
		$( this ).dialog( "close" );
		},
		Cancel: function() {
		$( this ).dialog( "close" );
		}
		}
	});
    
    });

    function reloadGrid(){
    $("#registration_list").trigger("reloadGrid");  
    }

</script>


    </body>
</html>
