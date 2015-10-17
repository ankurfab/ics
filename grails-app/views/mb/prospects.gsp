<%@ page import="ics.*" %>

<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<title>MB Prospects</title>
		<r:require module="grid" />
		<r:require module="printarea" />
		
		<style>
			.bgLightGreen{
			   background: none repeat scroll 0 0 #BBDDAA !important;
			  }
			.bgRed{
			   background: none repeat scroll 0 0 #FF6666 !important;
			  }
			.bgYellow{
			   background: none repeat scroll 0 0 #FFFFCC !important;
			  }
            .legendBox{
                width: 8px;
                height: 8px;
                float: left;
                border: 1px solid black;
                margin: 2px 10px;
            }
            .ui-jqgrid .ui-state-highlight { background: #FFFF99 !important; }
            .ui-jqgrid tr.jqgrow td {
                white-space: normal !important;
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

		<div id='dialogMessage' title="Information">
            <strong><span class="dialogMsgContent"></span></strong>
        </div>

		<div id="dialogcandidateReason" title="Reason">
            <span> If you decline a particular prospect suggestion you will not be able to proceed with this profile at all. Please specify a valid reason for Declining.</span>
            <br><br>
            <strong>Reason: </strong>
			<g:textArea name="candidateReason" value="" rows="5" cols="50"/>
		</div>
        <div id="dialoglimitedProfile" title="Limited Profile for Horoscope Match">
            <div id="divlimitedProfile"></div>
		</div>
        <div>
            <div class="bgYellow legendBox"></div><div style="font-size: 13px;margin: 5px 10px"> - The Proceed request is still not approved by marriage board.</div>
            <div class="bgRed legendBox"></div><div style="font-size: 13px;margin: 5px 10px"> - Proposal Declined by either marriage board/candidate/prospect.</div>
            <div class="bgLightGreen legendBox"></div><div style="font-size: 13px;margin: 5px 10px"> - Request Approved.</div>
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
		    return '<img height="70" width="70" src="${createLink(controller:'Mb',action:'showImage')}?imgType=closePrim&entity=mbProfile&entityId='+rowObject[0]+'"/>';
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
            if (rd.candidateStatus == 'DECLINED') {
                return {"class": "bgRed"};
            }
		    if (rd.mbStatus != rd.candidateStatus) {
			    return {"class": "bgYellow"};
			}
            if((rd.mbStatus == rd.candidateStatus && rd.candidateStatus!= 'LIMITED PROFILE')|| (rd.mbStatus == 'PROPOSAL AGREED' || rd.mbStatus == 'ANNOUNCE')) {
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
    $("#prospect_list").jqGrid('navGrid',"#prospect_list_pager",{edit:false,add:false,del:false,search:false,refresh:true});
    $("#prospect_list").jqGrid('inlineNav',"#prospect_list_pager",
	    { 
	       edit: false,
	       add: false,
	       save: false,
	       cancel: false
	    });
    $("#prospect_list").jqGrid('navGrid',"#prospect_list_pager").jqGrid('navButtonAdd',"#prospect_list_pager",{caption:"Proceed", buttonicon:"ui-icon-check", onClickButton:proceed, position: "last", title:"Proceed", cursor: "pointer"});
    $("#prospect_list").jqGrid('navGrid',"#prospect_list_pager").jqGrid('navButtonAdd',"#prospect_list_pager",{caption:"Decline", buttonicon:"ui-icon-cancel", onClickButton:decline, position: "last", title:"Not Suitable", cursor: "pointer"});
    $("#prospect_list").jqGrid('navGrid',"#prospect_list_pager").jqGrid('navButtonAdd',"#prospect_list_pager",{caption:"View Profile", buttonicon:"ui-icon-person", onClickButton:viewProfile, position: "last", title:"View Profile", cursor: "pointer"});

    function viewProfile(){
        var id = $('#prospect_list').jqGrid('getGridParam','selrow');
          if(id) {
              var url = "${createLink(controller:'Mb',action:'getProfileByStage')}"+"?matchid="+id;
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
              $('.dialogMsgContent').html("Please select a profile by clicking on the candidate's photo") && $( "#dialogMessage" ).dialog('open');
      };

	function decline(id) {
			var id = $('#prospect_list').jqGrid('getGridParam','selrow');
			if(id) {
				$( "#dialogcandidateReason" ).dialog( "open" );
			}
			else
                $('.dialogMsgContent').html("Please select a profile by clicking on the candidate's photo!!") && $( "#dialogMessage" ).dialog('open');
	}

	function proceed() {
		var answer = confirm("Are you sure?");
		if (answer){
			var id = $('#prospect_list').jqGrid('getGridParam','selrow');
			if(id) {
				var url = "${createLink(controller:'mb',action:'prospectsNextStep')}"+"?matchid="+id;
                $.ajax({
                    url: url,
                    method: "POST",
                    dataType: "json",
                    success: function(data) {
                        !!data.status && $('.dialogMsgContent').html(data.status) && $( "#dialogMessage" ).dialog('open');
                        jQuery("#prospect_list").trigger( 'reloadGrid' );
                    }
                });
                jQuery("#prospect_list").jqGrid().trigger("reloadGrid");
			}
			else
                $('.dialogMsgContent').html("Please select a profile by clicking on the candidate's photo") && $( "#dialogMessage" ).dialog('open');
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
                var url = "${createLink(controller:'mb',action:'decline')}";
                $.ajax({
                    url: url,
                    method: "POST",
                    dataType: "json",
                    data: {
                        matchid: id,
                        origin: 'candidate',
                        reason: $("#candidateReason").val()
                      }
                    }).success(function(data) {
                        $( "#dialogcandidateReason" ).dialog( "close" );
                        !!data.status && alert(data.status);
                        jQuery("#prospect_list").trigger( 'reloadGrid' );
                    });
                },
            "Cancel": function() {
                $( "#candidateReason" ).val( '' );
                $( this ).dialog( "close" );
            }
        },
        close: function() {
        }
    });
      $( "#dialogMessage" ).dialog({
          autoOpen: false,
          height: 300,
          width: 350,
          modal: true,
          buttons: {
              "Ok": function(){
                  $( "#dialogMessage").dialog('close');
              },
              "Cancel": function(){
                  $( "#dialogMessage").dialog('close');
              }
            }
          });
      });
</script>


	</body>
</html>
