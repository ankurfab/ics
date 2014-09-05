
<%@ page import="ics.Donation" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<title>Master List of All Donors</title>
 
		<r:require module="grid" />
	</head>
	<body>

	<script>
	$(function() {
		$( "#ind" ).autocomplete({
			source: "${createLink(controller:'individual',action:'allIndividualsAsJSON_JQ')}",//todo take care of data from other departments
			minLength: 3,
			  select: function(event, ui) { // event handler when user selects a company from the list.
			   $("#linkedid").val(ui.item.id); // update the hidden field.
			  }
		});
		
		  $("#fromDate").datepicker({changeMonth: true,changeYear: true,dateFormat: 'dd-mm-yy'});
		  $("#toDate").datepicker({changeMonth: true,changeYear: true,dateFormat: 'dd-mm-yy'});
		
	});
	</script>

		<div class="nav">
		<span class="menuButton"><a class="ist"
			href="${createLink(uri: '/')}"><g:message
					code="default.home.label" /></a></span>
		</div>
			Min Amount: <g:textField name="minAmt" value="" />
			Max Amount: <g:textField name="maxAmt" value="" />
			Locality: <g:textField name="locality" value="" placeholder="Location"/>
			FromDate: <g:textField name="fromDate" value="" />
			ToDate: <g:textField name="toDate" value="" />
                    	<g:submitButton name="update" value="Search" onClick='refreshGrid();'/>

		<!-- table tag will hold our grid -->
		<table id="donation_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
		<!-- pager will hold our paginator -->
		<div id="donation_list_pager" class="scroll" style="text-align:center;"></div>

		 <input class="menuButton" type="BUTTON" id="cultivatorBtn" value="SetCultivator" />

		<div id="dialogCultivator" title="Set Cultivator">
			<form>
			<fieldset>
				<div class="dialog">
				    <table>
					<tbody>

					    <tr class="prop">
						<td valign="top" class="name">
						    <label for="cultivator">Cultivator</label>*
						</td>
						<td valign="top" class="value">
						    <g:hiddenField name="linkedid" value=""/>
						    <g:hiddenField name="indname" value=""/>
						    <input id="ind" size="50" />
						</td>
					    </tr>
					</tbody>
				    </table>
				</div>
			</fieldset>
			</form>
		
		</div>

		<script type="text/javascript">		
		  $(document).ready(function () {
		    jQuery("#donation_list").jqGrid({
		      url:'jq_donor_list',
		      datatype: "local",
		      colNames:['Donor','Amount','Scheme','Address','Phone','Email','Cultivator','Collector','Counsellor'],
		      colModel:[
			{name:'donor',
			formatter:'showlink', 
             		formatoptions:{baseLinkUrl:'${createLink(controller:'Individual',action:'show')}',target:'_new'}
			},
			{name:'amount', search:false},
			{name:'scheme', search:false},
			{name:'address', editable:false},
			{name:'phone', editable:false},
			{name:'email', editable:false, search:true},
			{name:'cultivator', editable:false},
			{name:'collector', editable:false, search:false},			
			{name:'counsellor', editable:false, search:false}		
		     ],
		    rowNum:100,
		    rowList:[10,20,30,40,50,100],
		    pager: '#donation_list_pager',
		    viewrecords: true,
		    gridview: true,
		    sortname: "amount",
		    sortorder: "desc",
		    width: 1250,
		    height: "100%",
		    multiselect: true,
		    caption:"Master Donor List",
		    loadComplete: function () { $("#donation_list").jqGrid().setGridParam({datatype:'json'});}
		    });
		   //$("#donation_list").jqGrid('filterToolbar',{autosearch:false});
		   $("#donation_list").jqGrid('navGrid',"#donation_list_pager",
			{edit:false,add:false,del:false,search:false}
		    );
	// add custom button to export the detail data to excel	
	jQuery("#donation_list").jqGrid('navGrid',"#donation_list_pager").jqGrid('navButtonAdd',"#donation_list_pager",{caption:"Donors", buttonicon:"ui-icon-disk",title:"Export",
	       onClickButton : function () { 
			jQuery("#donation_list").jqGrid('excelExport',{"url":'jq_donor_list'});
	       }
	       });
		    
	$( "#cultivatorBtn" )
		.button()
		.click(function() {
			$( "#dialogCultivator" ).dialog("open")});


		$( "#dialogCultivator" ).dialog({
			autoOpen: false,
			height: 200,
			width: 550,
			modal: true,
			buttons: {
				"Set": function() {
					var idlist = jQuery("#donation_list").jqGrid('getGridParam','selarrrow')
					var url = "${createLink(controller:'helper',action:'setCultivator')}"+"?indid="+$('#linkedid').val()+"&idList="+idlist
					$.getJSON(url, {}, function(data) {
						alert(data.message);
					    });	
					
						$( this ).dialog( "close" );
				},
				Cancel: function() {
					$( this ).dialog( "close" );
				}
			},
			close: function() {
				
			}
		});

		});


		function refreshGrid() {
			var query = formUrl();
			$("#donation_list").jqGrid('setGridParam',{datatype:'json'});
			$("#donation_list").jqGrid('setGridParam',{url:query});
			$("#donation_list").jqGrid().trigger("reloadGrid");
		}

		function formUrl() {
			var query = "jq_donor_list?minAmt="+$('#minAmt').val()+"&maxAmt="+$('#maxAmt').val()+"&locality="+$('#locality').val()+"&fromDate="+$('#fromDate').val()+"&toDate="+$('#toDate').val()
			return query;
		}
		
		    
		</script>



	</body>
</html>
