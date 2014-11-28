<%@ page import="ics.*" %>

<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<title>MB Prospects</title>
		<r:require module="grid" />
		<style>
			.bgGreen{
			   background: none repeat scroll 0 0 green !important;
			  }
			.bgLightGreen{
			   background: none repeat scroll 0 0 lightgreen !important;
			  }
			.bgSkyBlue{
			   background: none repeat scroll 0 0 skyblue !important;
			  }
			.bgSteelBlue{
			   background: none repeat scroll 0 0 steelblue !important;
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
		<div class="nav">
		    <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
		</div>

            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>

		<div id='message' class="message" style="display:none;"></div>

		<div id="dialogcandidateReason" title="Reason">
			<g:textArea name="candidateReason" value="" rows="5" cols="40"/>
		</div>            

		
            <div>
			<!-- table tag will hold our grid -->
			<table id="prospect_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
			<!-- pager will hold our paginator -->
			<div id="prospect_list_pager" class="scroll" style="text-align:center;"></div>
	    </div>
		

<script type="text/javascript">
  $(document).ready(function () {		    


    jQuery("#prospect_list").jqGrid({
      url:'jq_prospects_list',
      datatype: "json",
      colNames:['LegalName','InitiatedName','DoB','PlaceofBirth','TimeofBirth','Centre','Counselor','OriginState','Varna','Category','Caste','SubCaste','Height(cms)','MotherTongue','Income','Education','Qualification','FourRegulativePrinciples','Rounds','SixteenRoundsSince','candidateStatus','Id'],
      colModel:[
	{name:'legalName'},
	{name:'initiatedName'},
	{name:'dob'},
	{name:'pob'},
	{name:'tob'},
	{name:'centre'},
	{name:'counselor'},
	{name:'originState'},
	{name:'varna'},
	{name:'category'},
	{name:'caste'},
	{name:'subCaste'},
	{name:'height'},
	{name:'motherTongue'},
	{name:'candidateIncome'},
	{name:'educationCategory'},
	{name:'qualification'},
	{name:'4regprin'},
	{name:'currentRounds'},
	{name:'chanting16Since'},
	{name:'candidateStatus',hidden:true},
	{name:'id',hidden:true}
     ],
	    rowattr: function (rd) {
		    if (rd.candidateStatus == 'PROCEED') {
			return {"class": "bgLightGreen"};
			}
		    },		         
    rowNum:10,
    rowList:[10],
    pager: '#prospect_list_pager',
    viewrecords: true,
    sortname: 'id',
    sortorder: "asc",
    width: 1250,
    height: "100%",
    multiselect: false,
    caption:"Prospect List"
    });
    //$("#prospect_list").jqGrid('filterToolbar',{autosearch:true});
    $("#prospect_list").jqGrid('navGrid',"#prospect_list_pager",{edit:false,add:false,del:false,search:false,refresh:false});
    $("#prospect_list").jqGrid('inlineNav',"#prospect_list_pager",
	    { 
	       edit: false,
	       add: false,
	       save: false,
	       cancel: false,
	    });
    $("#prospect_list").jqGrid('navGrid',"#prospect_list_pager").jqGrid('navButtonAdd',"#prospect_list_pager",{caption:"NotSuitable", buttonicon:"ui-icon-cancel", onClickButton:decline, position: "last", title:"NotSuitable", cursor: "pointer"});
    $("#prospect_list").jqGrid('navGrid',"#prospect_list_pager").jqGrid('navButtonAdd',"#prospect_list_pager",{caption:"Proceed", buttonicon:"ui-icon-check", onClickButton:proceed, position: "last", title:"Proceed", cursor: "pointer"});


	function decline() {
			var id = $('#prospect_list').jqGrid('getGridParam','selrow');
			if(id) {
				$( "#dialogcandidateReason" ).dialog( "open" );
			}
			else
				alert("Please select the profile!!");
	}

	function proceed() {
		var answer = confirm("Are you sure?");
		if (answer){
			var id = $('#prospect_list').jqGrid('getGridParam','selrow');
			if(id) {
				var url = "${createLink(controller:'mb',action:'prospectsNextStep')}"+"?matchid="+id+"&status=PROCEED";
				$.getJSON(url, {}, function(data) {
					alert(data.status);
				    });	
			}
			else
				alert("Please select the profile!!");
		} else {
		    return false;
		}
	}
	
		$( "#dialogcandidateReason" ).dialog({
			autoOpen: false,
			height: 300,
			width: 350,
			modal: true,
			buttons: {
				"Submit": function() {
					var id = $('#prospect_list').jqGrid('getGridParam','selrow');
					var url = "${createLink(controller:'mb',action:'prospectsNextStep')}"+"?matchid="+id+"&status=DECLINE"+"&reason="+$( "#candidateReason" ).val();
					$.getJSON(url, {}, function(data) {
						alert(data.status);
						jQuery("#prospect_list").jqGrid().trigger("reloadGrid");
					    });	
						
						$( "#candidateReason" ).val( '' );
						$( this ).dialog( "close" );
				},
				"Cancel": function() {
					$( "#candidateReason" ).val( '' );
					$( this ).dialog( "close" );
				}
			},
			close: function() {
				
			}
		});
	
  
  });
</script>


	</body>
</html>
