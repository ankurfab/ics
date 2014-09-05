<%@ page import="ics.*" %>

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
			Matchmaking for?<g:select name="user.company.id"
				  from="${ics.MbProfile.createCriteria().list{eq('workflowStatus','APPROVED')}.collect{it.candidate.id+':'+it.candidate.toString()}.join(';')}"/>
		</div>

			<fieldset>
			<table id="quickSearchTab">
				<tr>
					<td>Gender</td>
					<td>
						<g:select name="gender" from="${['MALE','FEMALE']}" value="'MALE'"/>					
					</td>
					<td>Candidate Name</td>
					<td>
						<g:textField name="candidateName" value="" />					
					</td>
				</tr>
			</table>
			<table id="professionalSearchTab">
				<tr>
					<td>Income</td>
					<td>
						<g:textField name="income" value="" />						
					</td>
					<td>Occupation</td>
					<td>
						<g:textField name="occupation" value="" />					
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
		

<script type="text/javascript">
  $(document).ready(function () {		    

    jQuery("#profile_list").jqGrid({
      url:'jq_mbProfile_list',
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


	 $( "#btnSearch" )
	.button()
	.click(function( event ) {
		event.preventDefault();

			var query = "name="+$('#candidateName').val();
			    
			jQuery("#profile_list").jqGrid('setGridParam',{url:"jq_mbProfile_list?"+query}).trigger("reloadGrid");
		
	});


	function propose() {
		var ids = $('#profile_list').jqGrid('getGridParam','selarrrow');
		if(ids) {
				alert("Proposing "+ids);
		}
		else
			alert("Please select a row!!");
	}
  
  });
</script>


	</body>
</html>
