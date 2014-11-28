<%@ page import="ics.*" %>
<%@ page import="org.codehaus.groovy.grails.commons.DefaultGrailsDomainClass" %>

<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<title>MB Profile Search</title>
		<r:require module="grid" />
	</head>
	<body>
		<div class="nav">
		    <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
		</div>

            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>

		<div id='message' class="message" style="display:none;"></div>
		
		<div>
			Matchmaking for?<g:select name="mbprofileid"
				  from="${ics.MbProfile.createCriteria().list{'in'('workflowStatus',['APPROVED','INPROGRESS']) candidate{order('legalName', 'asc')}}}"
                  noSelection="${['null':'Select One...']}"
                  optionKey="id" optionValue="candidate"
            />
		</div>

<g:set var="mbclass" value="${new DefaultGrailsDomainClass(ics.MbProfile.class)}" />
<g:set var="mbproperties" value="${mbclass.persistentProperties}" />

	<fieldset>
            <table id="genericSearchTab">
                <tr>
                    <td>Attribute</td>
                    <td>
                        <g:select name="attrName"
                                  from="${mbproperties*.name}"
                                  value=""/>
                    </td>
                    <td>Value</td>
                    <td>
			<g:textField name="attrValue" value="" placeholder="Please enter value to search"/>
		    </td>
		  </tr>
		</table>
	</fieldset>



			<fieldset>
            <table id="expectationsTab">
                <tr>
                    <td>Chanting Preference</td>
                    <td>
                        <g:select name="prefChanting"
                                  from="${['No specific choice', 'Not Chanting', 'Sometimes', 'Upto 4 rounds', 'Between 5 to 8 rounds', 'Between 9 to 12 rounds', 'Between 13 to 15 rounds', '16 rounds', 'Above 16 rounds', 'Others']}"
                                  value=""/>
                    </td>
                    <td>Category Preference</td>
                    <td>
                        <g:select name="prefCategory"
                                  from="${['Open', 'Backward Class', 'Other Backward Class', 'Scheduled Caste', 'Scheduled Tribe', 'Nomadic Tribes', 'Others']}"
                                  value=""/>
                    </td>
                    <td>Income Preference</td>
                    <td>
                        <g:select name="prefCandIncome"
                                  from="${['No Specific Choice', 'Receiving Stipend', 'Above 1 lakh', 'Above 2 lakhs', 'Above 3 lakhs', 'Above 4 lakhs', 'Above 5 lakhs', 'Above 6 lakhs', 'Above 7 lakhs', 'Above 8 lakhs', 'Above 9 lakhs', 'Above 10 lakhs', 'Above 11 lakhs', 'Above 12 lakhs', 'Above 13 lakhs', 'Above 14 lakhs', 'Above 15 lakhs', 'Above 16 lakhs', 'Others']}"
                                  value=""/>
                    </td>
                    <td>Manglik Preference</td>
                    <td>
                        <g:select name="Manglik" from="${['Not Manglik', 'Low', 'Medium', 'High', 'No Specific Choice']}"
                                  value=""/>
                    </td>
                </tr>
                <tr>
                    <td>
                        <input id="btnSearch" type="submit" value="Search">
                    </td>
                    <td></td>
                </tr>
            </table>
			</fieldset>
		
            <div>
			<!-- table tag will hold our grid -->
			<table id="profile_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
			<!-- pager will hold our paginator -->
			<div id="profile_list_pager" class="scroll" style="text-align:center;"></div>
	    </div>
            <div>
			<!-- table tag will hold our grid -->
			<table id="prospect_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
			<!-- pager will hold our paginator -->
			<div id="prospect_list_pager" class="scroll" style="text-align:center;"></div>
	    </div>
		

<script type="text/javascript">
  $(document).ready(function () {		    

    jQuery("#profile_list").jqGrid({
      url:'jq_mbProfile_list',
      postData:{
      	'mbProfile.id':function(){return $('#mbprofileid').val();},
      	attrName:function(){return $('#attrName').val();},
      	attrValue:function(){return $('#attrValue').val();},
      	},
      datatype: "json",
      colNames:['Name','DoB','Id'],
      colModel:[
	{name:'name'},
	{name:'dob'},
	{name:'id',hidden:true}
     ],
    rowNum:10,
    rowList:[10,20,30,40,50,100,200],
    pager: '#profile_list_pager',
    viewrecords: true,
    sortname: 'id',
    sortorder: "asc",
    width: 1200,
    height: "100%",
    multiselect: true,
    caption:"Profile Search Result"
    });
    $("#profile_list").jqGrid('filterToolbar',{autosearch:true});
    $("#profile_list").jqGrid('navGrid',"#profile_list_pager",{edit:false,add:false,del:true,search:false});
    $("#profile_list").jqGrid('inlineNav',"#profile_list_pager",
	    { 
	       edit: false,
	       add: false,
	       save: false,
	       cancel: false,
	    });
    $("#profile_list").jqGrid('navGrid',"#profile_list_pager").jqGrid('navButtonAdd',"#profile_list_pager",{caption:"Propose", buttonicon:"ui-icon-person", onClickButton:propose, position: "last", title:"Propose", cursor: "pointer"});

    jQuery("#prospect_list").jqGrid({
      url:'jq_mbProspect_list',
      postData:{
      	candidateid:function(){return $('#mbprofileid').val();},
      	},
      datatype: "json",
      colNames:['Name','DoB','CandidateStatus','CandidateReason','MbStatus','MbReason','Id'],
      colModel:[
	{name:'name'},
	{name:'dob'},
	{name:'candidateStatus'},
	{name:'candidateReason'},
	{name:'mbStatus'},
	{name:'mbReason'},
	{name:'id',hidden:true}
     ],
    rowNum:10,
    rowList:[10,20,30,40,50,100,200],
    pager: '#prospect_list_pager',
    viewrecords: true,
    sortname: 'id',
    sortorder: "asc",
    width: 1200,
    height: "100%",
    multiselect: true,
    caption:"Prospect List"
    });
    $("#prospect_list").jqGrid('filterToolbar',{autosearch:true});
    $("#prospect_list").jqGrid('navGrid',"#prospect_list_pager",{edit:false,add:false,del:true,search:false});
    $("#prospect_list").jqGrid('inlineNav',"#prospect_list_pager",
	    { 
	       edit: false,
	       add: false,
	       save: false,
	       cancel: false,
	    });



	 $( "#btnSearch" )
	.button()
	.click(function( event ) {
		event.preventDefault();
		jQuery("#profile_list").jqGrid().trigger("reloadGrid");
		jQuery("#prospect_list").jqGrid().trigger("reloadGrid");
	});


	function propose() {
		var answer = confirm("Are you sure?");
		if (answer){
			var ids = $('#profile_list').jqGrid('getGridParam','selarrrow');
			if(ids) {
				var url = "${createLink(controller:'mb',action:'propose')}"+"?candidateid="+$('#mbprofileid').val()+"&prospects="+ids;
				$.getJSON(url, {}, function(data) {
					alert(data.status);
					jQuery("#profile_list").jqGrid().trigger("reloadGrid");
					jQuery("#prospect_list").jqGrid().trigger("reloadGrid");
				    });	
			}
			else
				alert("Please select one or more profiles!!");
		} else {
		    return false;
		}
	}
  
  });
</script>


	</body>
</html>
