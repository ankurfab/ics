<%@ page import="ics.Individual" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'individual.label', default: 'Individual')}" />
		<title>Donor List (including family members)</title> 
		<r:require module="grid" />
	</head>
	<body>

		<g:render template="/common/sms" />
		<g:render template="/common/email" />

		<div class="nav">
		<span class="menuButton"><a class="ist"
			href="${createLink(uri: '/')}"><g:message
					code="default.home.label" /></a></span>
		</div>
		              
                <div class="dialog">
                    <table border="0" cellspacing="0" cellpadding="0">
                        <tbody bgcolor="lavender">
                            <tr class="prop">
                                <td valign="top" >
                                    <label for="scheme">DoB</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'scheme', 'errors')}">
					<g:radioGroup name="dobRadioGroup"
						      labels="['Yesterday!','Today!','Tomorrow!','This Week!','Next Week!','This Month!']"
						      values="[-1,0,1,2,3,4]">
					<p>${it.label} ${it.radio}</p>
					</g:radioGroup>
                                </td>
                                <td valign="top" >
                                    <label for="scheme">DoM</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'scheme', 'errors')}">
					<g:radioGroup name="domRadioGroup"
						      labels="['Yesterday!','Today!','Tomorrow!','This Week!','Next Week!','This Month!']"
						      values="[-1,0,1,2,3,4]">
					<p>${it.label} ${it.radio}</p>
					</g:radioGroup>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <table border="0" cellspacing="0" cellpadding="0">
                        <tbody bgcolor="lavender">
                            <tr class="prop">
                                <td valign="top" >
                                    <label for="scheme">DoB</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'scheme', 'errors')}">
					<g:select name="dob_dd" from="${1..31}" noSelection="['':'-Choose day-']"/>
					<g:select name="dob_mm" from="${1..12}" noSelection="['':'-Choose month-']"/>
                                </td>
                                <td valign="top" >
                                    <label for="scheme">DoM</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'scheme', 'errors')}">
					<g:select name="dom_dd" from="${01..31}" noSelection="['':'-Choose day-']"/>
					<g:select name="dom_mm" from="${01..12}" noSelection="['':'-Choose month-']"/>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <g:submitButton name="update" value="Search" onClick='refreshGrid();'/>
                </div>
		<!-- table tag will hold our grid -->
		<table id="donor_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
		<!-- pager will hold our paginator -->
		<div id="donor_list_pager" class="scroll" style="text-align:center;"></div>

		<input class="menuButton" type="BUTTON" id="btnSMS_DonorList" value="SMS" gridName="#donor_list" entityName="Individual"/>
		<input class="menuButton" type="BUTTON" id="btnEMAIL_DonorList" value="EMAIL" gridName="#donor_list" entityName="Individual"/>
		<input class="menuButton" type="BUTTON" id="btnCourier" value="Courier"/>
		
		<br>

		<sec:ifAnyGranted roles="ROLE_DATA_CLEAN">
		<input class="menuButton" type="BUTTON" id="phoneCleanBtn" value="MarkPhoneClean" />
		<input class="menuButton" type="BUTTON" id="emailCleanBtn" value="MarkEmailClean" />
		<input class="menuButton" type="BUTTON" id="addressCleanBtn" value="MarkAddressClean" />
		<input class="menuButton" type="BUTTON" id="recCleanBtn" value="MarkClean" />
		<input class="menuButton" type="BUTTON" id="phoneUnCleanBtn" value="MarkPhoneUnClean" />
		<input class="menuButton" type="BUTTON" id="emailUnCleanBtn" value="MarkEmailUnClean" />
		<input class="menuButton" type="BUTTON" id="addressUnCleanBtn" value="MarkAddressUnClean" />
		<input class="menuButton" type="BUTTON" id="recUnCleanBtn" value="MarkUnClean" />
		</sec:ifAnyGranted>

		<script type="text/javascript">		
		  $(document).ready(function () {
		    jQuery("#donor_list").jqGrid({
		      url:'jq_donor_list?schemeids=',
		      datatype: "local",
		      colNames:['IcsId','LegalName','InitiatedName','DoB','DoM','Address','Phone','Email','IndividualDonation','FamilyDonation','Relationships','IsDevotee','DataCleanStatus','phoneClean','emailClean','addressClean','RecordStatus'],
		      colModel:[
			{name:'icsid', editable:false, search:true},
			{name:'legalName',
			formatter:'showlink', 
             		formatoptions:{baseLinkUrl:'show'}
			},
			{name:'initiatedName', search:false},
			{name:'dob', search:false},
			{name:'dom', search:false},
			{name:'address', editable:false,formatter:
				function iSCleanFormatter(cellvalue, options, rowObject)
				{
				    var color;
				    if (rowObject[15] == 'true')
				    	color = "green";
				    else if (rowObject[15] == 'false')
				    	color = "red";
				    var cellHtml = "<span style='color:" + color + "' >" + cellvalue + "</span>";
				    return cellHtml;
				 }
			},
			{name:'phone', editable:false,formatter:
				function iSCleanFormatter(cellvalue, options, rowObject)
				{
				    var color;
				    if (rowObject[13] == 'true')
				    	color = "green";
				    else if (rowObject[13] == 'false')
				    	color = "red";
				    var cellHtml = "<span style='color:" + color + "' >" + cellvalue + "</span>";
				    return cellHtml;
				 }
			},
			{name:'email', editable:false, search:true,formatter:
				function iSCleanFormatter(cellvalue, options, rowObject)
				{
				    var color;
				    if (rowObject[14] == 'true')
				    	color = "green";
				    else if (rowObject[14] == 'false')
				    	color = "red";
				    var cellHtml = "<span style='color:" + color + "' >" + cellvalue + "</span>";
				    return cellHtml;
				 }
			},
			{name:'individualDonation', editable:false, search:false},
			{name:'familyDonation', editable:false, search:false},
			{name:'relationship', editable:false},
			{name:'isDevotee', editable:false, search:false},
			{name:'formstatus', editable:false, search:false},	
			{name:'phoneClean', editable:false, search:false,hidden:true},
			{name:'emailClean', editable:false, search:false,hidden:true},
			{name:'addressClean', editable:false, search:false,hidden:true},
			{name:'status', editable:false, search:false}			
		     ],
		    rowNum:10,
		    rowList:[10,20,30,40,50,100,150,200],
		    pager: '#donor_list_pager',
		    viewrecords: true,
		    gridview: true,
		    sortorder: "asc",
		    width: 1250,
		    height: "100%",
		    multiselect: true,
		    caption:"Donor List",
		    loadComplete: function () { $("#donor_list").jqGrid().setGridParam({datatype:'json'});},
		    });
		   $("#donor_list").jqGrid('filterToolbar',{autosearch:true});
		   $("#donor_list").jqGrid('navGrid',"#donor_list_pager",
			{edit:false,add:false,del:false,search:false}
		    );
	
	// add custom button to export the detail data to excel	
	jQuery("#donor_list").jqGrid('navGrid',"#donor_list_pager").jqGrid('navButtonAdd',"#donor_list_pager",{caption:"", buttonicon:"ui-icon-disk",title:"Export",
	       onClickButton : function () { 
			var query = formUrl();			
			jQuery("#donor_list").jqGrid('excelExport',{"url":query});
	       }
	       });

	$( "#btnCourier" ).button().click(
		function() {
					var ids = jQuery("#donor_list").jqGrid('getGridParam','selarrrow');
					if(ids!='') {
							var msg = "Courier sent for DoB/DoM wishes!!"
							var url = "${createLink(controller:'followup',action:'bulkMessage')}"+"?category=PatronCare&msg="+msg+"&idList="+ids
							$.getJSON(url, {}, function(data) {
								//alert(data.message);
							    });	
					}
					else
						alert("Please select rows!!");
			}
	);
	$( "#phoneCleanBtn" ).button().click(
		function() {
					var ids = jQuery("#donor_list").jqGrid('getGridParam','selarrrow');
					if(ids!='') {
							var url = "${createLink(controller:'flags',action:'markRecords')}"+"?attr=phone&val=clean&idList="+ids
							$.getJSON(url, {}, function(data) {
								//alert(data.message);
							    });	
					}
					else
						alert("Please select rows!!");
			}
	);
	$( "#emailCleanBtn" ).button().click(
		function() {
					var ids = jQuery("#donor_list").jqGrid('getGridParam','selarrrow');
					if(ids!='') {
							var url = "${createLink(controller:'flags',action:'markRecords')}"+"?attr=email&val=clean&idList="+ids
							$.getJSON(url, {}, function(data) {
								//alert(data.message);
							    });	
					}
					else
						alert("Please select rows!!");
			}
	);
	$( "#addressCleanBtn" ).button().click(
		function() {
					var ids = jQuery("#donor_list").jqGrid('getGridParam','selarrrow');
					if(ids!='') {
							var url = "${createLink(controller:'flags',action:'markRecords')}"+"?attr=address&val=clean&idList="+ids
							$.getJSON(url, {}, function(data) {
								//alert(data.message);
							    });	
					}
					else
						alert("Please select rows!!");
			}
	);
	$( "#recCleanBtn" ).button().click(
		function() {
					var ids = jQuery("#donor_list").jqGrid('getGridParam','selarrrow');
					if(ids!='') {
							var url = "${createLink(controller:'flags',action:'markRecords')}"+"?attr=rec&val=clean&idList="+ids
							$.getJSON(url, {}, function(data) {
								//alert(data.message);
							    });	
					}
					else
						alert("Please select rows!!");
			}
	);
	$( "#phoneUnCleanBtn" ).button().click(
		function() {
					var ids = jQuery("#donor_list").jqGrid('getGridParam','selarrrow');
					if(ids!='') {
							var url = "${createLink(controller:'flags',action:'markRecords')}"+"?attr=phone&val=unclean&idList="+ids
							$.getJSON(url, {}, function(data) {
								//alert(data.message);
							    });	
					}
					else
						alert("Please select rows!!");
			}
	);
	$( "#emailUnCleanBtn" ).button().click(
		function() {
					var ids = jQuery("#donor_list").jqGrid('getGridParam','selarrrow');
					if(ids!='') {
							var url = "${createLink(controller:'flags',action:'markRecords')}"+"?attr=email&val=unclean&idList="+ids
							$.getJSON(url, {}, function(data) {
								//alert(data.message);
							    });	
					}
					else
						alert("Please select rows!!");
			}
	);
	$( "#addressUnCleanBtn" ).button().click(
		function() {
					var ids = jQuery("#donor_list").jqGrid('getGridParam','selarrrow');
					if(ids!='') {
							var url = "${createLink(controller:'flags',action:'markRecords')}"+"?attr=address&val=unclean&idList="+ids
							$.getJSON(url, {}, function(data) {
								//alert(data.message);
							    });	
					}
					else
						alert("Please select rows!!");
			}
	);
	$( "#recUnCleanBtn" ).button().click(
		function() {
					var ids = jQuery("#donor_list").jqGrid('getGridParam','selarrrow');
					if(ids!='') {
							var url = "${createLink(controller:'flags',action:'markRecords')}"+"?attr=rec&val=unclean&idList="+ids
							$.getJSON(url, {}, function(data) {
								//alert(data.message);
							    });	
					}
					else
						alert("Please select rows!!");
			}
	);
	});
		    
		function setURL(){
			jQuery("#donor_list").jqGrid('setGridParam',{url:"jq_donor_list"+"?schemeids="+$('#schemeids').val()});
			}
			
		function refreshGrid() {
			var query = formUrl();
						
			$("#donor_list").jqGrid('setGridParam',{url:query});
			$("#donor_list").jqGrid().trigger("reloadGrid");
		}
		
		function markRecords(attr,val) {
			var ids = jQuery("#donor_list").jqGrid('getGridParam','selarrrow');
			if(ids) {
					var url = "${createLink(controller:'flags',action:'markRecords')}"+"?attr="+attr+"&val="+val+"&idList="+ids
					$.getJSON(url, {}, function(data) {
						//alert(data.message);
					    });	
			}
			else
				alert("Please select rows!!");
		}

		function download() {
					var url = "${createLink(controller:'flags',action:'markRecords')}"+"?attr="+attr+"&val="+val+"&idList="+ids
					$.getJSON(url, {}, function(data) {
						//alert(data.message);
					    });	
		}
		
		function formUrl() {
			var query = "jq_donor_list?schemeids="+$('#schemeids').val()
			if ($("input:radio[name='dobRadioGroup']:checked").val()) {
				query = query.concat("&dobRadioGroup="+$("input:radio[name='dobRadioGroup']:checked").val());
			}
			if ($("input:radio[name='domRadioGroup']:checked").val()) {
				query = query.concat("&domRadioGroup="+$("input:radio[name='domRadioGroup']:checked").val());
			}
			if ($("input:radio[name='dotRadioGroup']:checked").val()) {
				query = query.concat("&dotRadioGroup="+$("input:radio[name='dotRadioGroup']:checked").val());
			}
			if ($('#dob_dd').val()) {
				query = query.concat("&dob_dd="+$('#dob_dd').val());
			}
			if ($('#dob_mm').val()) {
				query = query.concat("&dob_mm="+$('#dob_mm').val());
			}
			if ($('#dom_dd').val()) {
				query = query.concat("&dom_dd="+$('#dom_dd').val());
			}
			if ($('#dom_mm').val()) {
				query = query.concat("&dom_mm="+$('#dom_mm').val());
			}
			if ($('#minAmount').val()) {
				query = query.concat("&minAmount="+$('#minAmount').val());
			}
			if ($('#maxAmount').val()) {
				query = query.concat("&maxAmount="+$('#maxAmount').val());
			}
			if ($('#filteredAmt').val()) {
				query = query.concat("&filteredAmt="+$('#filteredAmt').val());
			}	
			return query;
		}
		    
		</script>



	</body>
</html>
