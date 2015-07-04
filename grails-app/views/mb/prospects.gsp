<%@ page import="ics.*" %>

<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<title>MB Prospects</title>
		<r:require module="grid" />
		<r:require module="printarea" />
		
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
		    <span class="menuButton"><a class="home" href="${createLink(controller:'Mb',action:'home')}"><g:message code="default.home.label"/></a></span>
		</div>

            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>

		<div id='message' class="message" style="display:none;"></div>

		<div id="dialogcandidateReason" title="Reason">
			<g:textArea name="candidateReason" value="" rows="5" cols="40"/>
		</div>
        <div id="dialoglimitedProfile" title="Limited Profile for Horoscope Match">
            <div id="divlimitedProfile"></div>
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
      colNames:['Photo','Stage','Status','LegalName','DoB','PoB','ToB','Caste','Height(cms)','income','candidateStatus','mbStatus','Id'],
      colModel:[
	{
	name: 'photo',
	formatter: function (cellvalue, options, rowObject) {
		    return '<img height="70" width="70" src="${createLink(controller:'Mb',action:'showImage')}?id='+rowObject[0]+ '"/>'; 
		}
	},				
	{name:'candidateStatus'},
	{name:'workflowStatus'},
	{name:'legalName'},
	{name:'dob'},
	{name:'pob'},
	{name:'tob'},
	{name:'caste'},
	{name:'height'},
    {name:'income'},
	{name:'candidateStatus',hidden:true},
	{name:'mbStatus',hidden:true},
	{name:'id',hidden:true}
     ],
	    rowattr: function (rd) {
		    if (rd.mbStatus == 'FULLPROFILE') {
			return {"class": "bgSteelBlue"};
			}
		    if (rd.candidateStatus == 'DECLINE') {
			return {"class": "bgRed"};
			}
		    if (rd.candidateStatus == 'PROCEED') {
			return {"class": "bgSkyBlue"};
			}
		    if (rd.candidateStatus == 'MEET_PROSPECT') {
			return {"class": "bgYellow"};
			}
		    if (rd.candidateStatus == 'MEET_PARENT') {
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
    $("#prospect_list").jqGrid('navGrid',"#prospect_list_pager").jqGrid('navButtonAdd',"#prospect_list_pager",{caption:"Not Suitable", buttonicon:"ui-icon-cancel", onClickButton:decline, position: "last", title:"NotSuitable", cursor: "pointer"});
    $("#prospect_list").jqGrid('navGrid',"#prospect_list_pager").jqGrid('navButtonAdd',"#prospect_list_pager",{caption:"Proceed", buttonicon:"ui-icon-check", onClickButton:proceed, position: "last", title:"Proceed", cursor: "pointer"});
    $("#prospect_list").jqGrid('navGrid',"#prospect_list_pager").jqGrid('navButtonAdd',"#prospect_list_pager",{caption:"Limited Profile", buttonicon:"ui-icon-script", onClickButton:limitedProfile, position: "last", title:"Limited Profile", cursor: "pointer"});
    $("#prospect_list").jqGrid('navGrid',"#prospect_list_pager").jqGrid('navButtonAdd',"#prospect_list_pager",{caption:"Full Profile", buttonicon:"ui-icon-script", onClickButton:fullProfile, position: "last", title:"Full Profile", cursor: "pointer"});
    $("#prospect_list").jqGrid('navGrid',"#prospect_list_pager").jqGrid('navButtonAdd',"#prospect_list_pager",{caption:"Meet Prospect", buttonicon:"ui-icon-transferthick-e-w", onClickButton:meetProspect, position: "last", title:"Meet Prospect", cursor: "pointer"});
    $("#prospect_list").jqGrid('navGrid',"#prospect_list_pager").jqGrid('navButtonAdd',"#prospect_list_pager",{caption:"Meet Parents", buttonicon:"ui-icon-arrow-4-diag", onClickButton:meetParent, position: "last", title:"Meet Parents", cursor: "pointer"});
    $("#prospect_list").jqGrid('navGrid',"#prospect_list_pager").jqGrid('navButtonAdd',"#prospect_list_pager",{caption:"Agree Proposal", buttonicon:"ui-icon-heart", onClickButton:agreeProposal, position: "last", title:"Agree Proposal", cursor: "pointer"});


	function fullProfile() {
		var id = $('#prospect_list').jqGrid('getGridParam','selrow');
		if(id) {
        var url = "${createLink(controller:'Mb',action:'fullProfile')}"+"?matchid="+id;
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
			alert("Please select the profile!!");
	}
      $( "#dialoglimitedProfile" ).dialog({
          autoOpen: false,
          width:800,
          height:500,
          modal: true,
          buttons: {
              "Print": function() {
                  $('#divlimitedProfile').printArea();
                  $( this ).dialog( "close" );
              },
              Cancel: function() {
                  $( this ).dialog( "close" );
              }
          }
      });

      function limitedProfile() {
        var id = $('#prospect_list').jqGrid('getGridParam','selrow');
          if(id) {
          var url = "${createLink(controller:'Mb',action:'limitedProfile')}"+"?matchid="+id;
          $( "#divlimitedProfile" ).val("");
          $( "#divlimitedProfile" ).load( url, function(responseTxt,statusTxt,xhr){
            if(statusTxt=="success")
            {
              $( "#dialoglimitedProfile" ).dialog( "open" );
            }
            if(statusTxt=="error")
              alert("Error: "+xhr.status+": "+xhr.statusText);
            });
          }
          else
            alert("Please select the profile!!");
        }

	function decline() {
			var id = $('#prospect_list').jqGrid('getGridParam','selrow');
			if(id) {
				$( "#dialogcandidateReason" ).dialog( "open" );
			}
			else
				alert("Please select the profile!!");
	}

	function meetProspect() {
		var answer = confirm("Are you sure?");
		if (answer){
			var id = $('#prospect_list').jqGrid('getGridParam','selrow');
			if(id) {
				var url = "${createLink(controller:'mb',action:'prospectsNextStep')}"+"?matchid="+id+"&status=MEET_PROSPECT";
				$.getJSON(url, {}, function(data) {
					alert(data.status);
					jQuery("#prospect_list").jqGrid().trigger("reloadGrid");
				    });	
			}
			else
				alert("Please select the profile!!");
		} else {
		    return false;
		}
	}

	function meetParent() {
		var answer = confirm("Are you sure?");
		if (answer){
			var id = $('#prospect_list').jqGrid('getGridParam','selrow');
			if(id) {
				var url = "${createLink(controller:'mb',action:'prospectsNextStep')}"+"?matchid="+id+"&status=MEET_PARENT";
				$.getJSON(url, {}, function(data) {
					alert(data.status);
					jQuery("#prospect_list").jqGrid().trigger("reloadGrid");
				    });	
			}
			else
				alert("Please select the profile!!");
		} else {
		    return false;
		}
	}

	function agreeProposal() {
		var answer = confirm("Are you sure?");
		if (answer){
			var id = $('#prospect_list').jqGrid('getGridParam','selrow');
			if(id) {
				var url = "${createLink(controller:'mb',action:'prospectsNextStep')}"+"?matchid="+id+"&status=AGREE_PROPOSAL";
				$.getJSON(url, {}, function(data) {
					alert(data.status);
					jQuery("#prospect_list").jqGrid().trigger("reloadGrid");
				    });	
			}
			else
				alert("Please select the profile!!");
		} else {
		    return false;
		}
	}

	function proceed() {
		var answer = confirm("Are you sure?");
		if (answer){
			var id = $('#prospect_list').jqGrid('getGridParam','selrow');
			if(id) {
				var url = "${createLink(controller:'mb',action:'prospectsNextStep')}"+"?matchid="+id+"&status=PROCEED";
				$.getJSON(url, {}, function(data) {
					alert(data.status);
					jQuery("#prospect_list").jqGrid().trigger("reloadGrid");
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
