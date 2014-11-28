
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
		<g:render template="/common/mandrillemail" />

        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
        </div>
        <div class="body">
            <div>
			<!-- table tag will hold our grid -->
			<table id="registration_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
			<!-- pager will hold our paginator -->
			<div id="registration_list_pager" class="scroll" style="text-align:center;"></div>
			<input class="menuButton" type="BUTTON" id="btnSMS_RegistrationList" value="SMS" gridName="#registration_list" entityName="EventRegistration"/>
			<input class="menuButton" type="BUTTON" id="btnEMAIL_RegistrationList" value="EMAIL" gridName="#registration_list" entityName="EventRegistration" departmentId="${ics.Department.findByName('GPL')?.id}"/>
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
	{name:'name', search:true,formatter:showIndividualAssessment,editable: true},
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
	{name:'connectedIskconCenter', search:true,editable: true,},
	{name:'year', search:false,editable: true,},
	{name:'idproofType', search:false,editable: true,},
	{name:'idProofId', search:false,editable: true,},
	{name:'assessment', search:true,editable: true,
		edittype:"select",editoptions:{value:"${ics.Assessment.list([sort:"name"])?.collect{it.name+':'+it.name}.join(';')}"},
		formatter:'select',stype:'select', searchoptions: { value: "${':ALL;'+(ics.Assessment.list([sort:"name"])?.collect{it.name+':'+it.name}.join(';'))}"}
	},
	{name:'otherGuestType', search:true,editable: true,
		edittype:"select",editoptions:{value:"${'English:English;Hindi:Hindi;Marathi:Marathi'}"},
		formatter:'select',stype:'select', searchoptions: { value: ':ALL;English:English;Hindi:Hindi;Marathi:Marathi'}
	},
	{name:'comments', search:true,editable: true,},
	{name:'paymentReference', search:true,editable: false,},
	{name:'arrivalDate', search:true},
	{name:'iaid',hidden:true},
	{name:'id',hidden:true}
     ],
    rowNum:15,
    rowList:[10,15,20,30,40,50,100,200],
    pager: '#registration_list_pager',
    viewrecords: true,
    sortname: 'arrivalDate',
    sortorder: "desc",
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
