
<%@ page import="ics.Assessment" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Registration List</title>
	<r:require module="grid" />
	<r:require module="dateTimePicker" />
	<r:require module="ajaxform"/>
    </head>
    <body>
		<g:render template="/common/sms" />
		<g:render template="/common/email" />

        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
        </div>
        <div class="body">
            <div>
			<!-- table tag will hold our grid -->
			<table id="registration_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
			<!-- pager will hold our paginator -->
			<div id="registration_list_pager" class="scroll" style="text-align:center;"></div>
			<!--<input class="menuButton" type="BUTTON" id="btnSMS_RegistrationList" value="SMS" gridName="#registration_list" entityName="EventRegistration"/>
			<input class="menuButton" type="BUTTON" id="btnEMAIL_RegistrationList" value="EMAIL" gridName="#registration_list" entityName="EventRegistration"/>-->
	    </div>

		<div id="dialogPayForm" title="Payment Reference">
			<g:render template="/paymentReference/paymentReferenceAssessment" />
		</div>

        </div>

<script>
  $(document).ready(function () {
    var lastsel3; 
    jQuery("#registration_list").jqGrid({
      url:'jq_registration_list?eid=2',
      editurl:'jq_edit_registration',
      datatype: "json",
      colNames:['Name','DoB','Gender','Mobile','Email','Address','From','Year','IdType','IdNo','Assessment','Language','Comments','PaymentReference','RegistrationCode(Date)','IAid','Id'],
      colModel:[
	{name:'name', search:true,formatter:showIndividualAssessment},
	{name:'dob', search:false},
	{name:'isMale', search:true},
	{name:'contactNumber', search:true},
	{name:'email', search:true},
	{name:'address', search:true},
	{name:'connectedIskconCenter', search:true},
	{name:'year', search:false},
	{name:'idproofType', search:false},
	{name:'idProofId', search:false},
	{name:'assessment', search:false},
	{name:'otherGuestType', search:true},
	{name:'comments', search:false},
	{name:'paymentReference', search:false},
	{name:'arrivalDate', search:true},
	{name:'iaid',hidden:true},
	{name:'id',hidden:true}
     ],
    rowNum:50,
    rowList:[10,20,30,40,50,100,200],
    pager: '#registration_list_pager',
    viewrecords: true,
    sortname: 'arrivalDate',
    sortorder: "desc",
    width: 1200,
    height: "100%",
    multiselect: false,
    caption:"Registration List"
    });
    $("#registration_list").jqGrid('filterToolbar',{autosearch:true});
    $("#registration_list").jqGrid('navGrid',"#registration_list_pager",{edit:false,add:false,del:true,search:false});
    $("#registration_list").jqGrid('inlineNav',"#registration_list_pager",
	    { 
	       edit: false,
	       add: false,
	       save: false,
	       cancel: false,
	    }
    );
    $("#registration_list").jqGrid('navGrid',"#registration_list_pager").jqGrid('navButtonAdd',"#registration_list_pager",{caption:"Pay", buttonicon:"ui-icon-calculator", onClickButton:pay, position: "last", title:"Pay", cursor: "pointer"});
    $("#registration_list").jqGrid('navGrid',"#registration_list_pager").jqGrid('navButtonAdd',"#registration_list_pager",{caption:"Setup", buttonicon:"ui-icon-gear", onClickButton:setup, position: "last", title:"Setup", cursor: "pointer"});

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
			var id = $('#registration_list').jqGrid('getGridParam','selrow');
			if(id) {
				var url = "${createLink(controller:'assessment',action:'setup')}"+"?id="+id
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
            var url = "${createLink(controller:'IndividualAssessment',action:'show')}"+"?id="+rowdata[15];
            if(rowdata[15])
            	return "<a href='"+url+"' target='_new'>"+cellValue+"</a>";
            else
            	return cellValue
        }


    });
</script>


    </body>
</html>
