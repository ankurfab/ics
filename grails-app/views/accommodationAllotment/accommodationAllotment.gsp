
<%@ page import="ics.AccommodationAllotment" %>
<%@ page import="ics.EventRegistration" %>
<%@ page import="ics.EventAccommodation" %>
<%@ page import="ics.AccommodationAllotmentStatus" %>

<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<title>Accommodation Allotment</title>
		<r:require module="grid" />
		<r:require module="dateTimePicker" />
	</head>
	<body onLoad="return tabOrders();">
		<script>
			$(function() {
				$( "#tabs" ).tabs();
			});		
		</script>

		

		<div class="nav">
		    <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
		</div>
		<g:if test="${flash.message}">
		    <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
		</g:if>

		<div id='message' class="message" style="display:none;"></div>

		<g:form name="registrationInfoTab">
			<table class="searchForm" id="registrationInfoTab">
				<tr>
					<td class="searchLabel"><label>Guest Name:</label></td>
					<td><g:fieldValue bean="${eventRegistrationInstance}" field="name"/></td>
					<td class="searchLabel"><label>Registration Code:</label></td>
					<td><g:fieldValue bean="${eventRegistrationInstance}" field="regCode"/></td>
				</tr>
				<tr>
					<td class=searchLabel><label>Arrival Date:</label></td>
					<td>${eventRegistrationInstance?.arrivalDate?.format('dd-MM-yyyy HH:mm')}</td>
					<td class=searchLabel><label>Departure Date:</label></td>
					<td>${eventRegistrationInstance?.departureDate?.format('dd-MM-yyyy HH:mm')}</td>
				</tr>
				<tr>
					<td class="searchLabel"><label>Total Registered:</label></td>
					<td>${eventRegistrationInstance.numberofPrabhujis+eventRegistrationInstance.numberofMatajis+eventRegistrationInstance.numberofChildren+eventRegistrationInstance.numberofBrahmacharis}</td>
					<td class="searchLabel"><label>Total Allotted:</label></td>
					<td id="aNumA">${numA}</td>
				</tr>
				<tr>
					<td class="searchLabel"><label>Registered No of Prabhujis:</label></td>
					<td><g:fieldValue bean="${eventRegistrationInstance}" field="numberofPrabhujis"/></td>
					<td class="searchLabel"><label>Allotted No of Prabhujis:</label></td>
					<td id="aNumP">${numPA}</td>
				</tr>
				<tr>
					<td class="searchLabel"><label>Registered No of Matajis:</label></td>
					<td><g:fieldValue bean="${eventRegistrationInstance}" field="numberofMatajis"/></td>
					<td class="searchLabel"><label>Allotted No of Matajis:</label></td>
					<td id="aNumM">${numMA}</td>
				</tr>
				<tr>
					<td class="searchLabel"><label>Registered No of Childrens:</label></td>
					<td><g:fieldValue bean="${eventRegistrationInstance}" field="numberofChildren"/></td>
					<td class="searchLabel"><label>Allotted No of Childrens:</label></td>
					<td id="aNumC">${numCA}</td>
				</tr>
				<tr>
					<td class="searchLabel"><label>Registered No of Brahmacharis/students:</label></td>
					<td><g:fieldValue bean="${eventRegistrationInstance}" field="numberofBrahmacharis"/></td>
					<td class="searchLabel"><label>Allotted No of Brahmacharis/students:</label></td>
					<td id="aNumB">${numBA}</td>
				</tr>
			    </table>
		</g:form>

		<div id="tabs">
			<ul>
				<li><a href="#AccommodationChart">Auto Allocation</a></li>
				<li><a href="#AccommodationAllotment">Manual Allocation</a></li>
				<li><a href="#RegistrationAllotment">Current Allocations</a></li>
			</ul>

		<div id="AccommodationChart">
			<table>
			<tr>
				<td><label for="fromDate">Date From</label></td>
				<td><g:textField name="fromDate" value="${eventRegistrationInstance?.arrivalDate?.format('dd-MM-yyyy HH:mm')}"/><br>	</td>
				<td><label for="toDate">Date To</label></td>
				<td><g:textField name="toDate" value="${eventRegistrationInstance?.departureDate?.format('dd-MM-yyyy HH:mm')}"/></td>
				<td></td>
				<td></td>
				<!--<td>Requirement</td>
				<td><g:field name="numR" type="number" value="${((eventRegistrationInstance.numberofBrahmacharis?:0)+(eventRegistrationInstance.numberofPrabhujis?:0)+(eventRegistrationInstance.numberofMatajis?:0)+(eventRegistrationInstance.numberofChildren?:0))-numA}"/></td>-->
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td>Num Prji</td>
				<td><g:field name="numP" type="number" value="${eventRegistrationInstance.numberofPrabhujis-numPA}"/></td>
				<td>Num Mataji</td>
				<td><g:field name="numM" type="number" value="${eventRegistrationInstance.numberofMatajis-numMA}"/></td>
				<td>Num Children</td>
				<td><g:field name="numC" type="number" value="${eventRegistrationInstance.numberofChildren-numCA}"/></td>
				<td>Num Brahmachari/Student</td>
				<td><g:field name="numB" type="number" value="${eventRegistrationInstance.numberofBrahmacharis-numBA}"/></td>

				<!--<td>Num Prji</td>
				<td><g:field name="numP" type="number" value="0"/></td>
				<td>Num Mataji</td>
				<td><g:field name="numM" type="number" value="0"/></td>
				<td>Num Children</td>
				<td><g:field name="numC" type="number" value="0"/></td>
				<td>Num Brahmachari/Student</td>
				<td><g:field name="numB" type="number" value="0"/></td>-->
			</tr>
			</table>
			<input class="menuButton" type="BUTTON" id="searchBtn" value="Search" />

			<!-- table tag will hold our grid -->
			<table id="chart_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
			<!-- pager will hold our paginator -->
			<div id="chart_list_pager" class="scroll" style="text-align:center;"></div>

			<input class="menuButton" type="BUTTON" id="allotBtn" value="Allot" />

		</div>

		<div id="AccommodationAllotment">

			<!-- table tag will hold our grid -->
			<table id="accommodation_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
			<!-- pager will hold our paginator -->
			<div id="accommodation_list_pager" class="scroll" style="text-align:center;"></div>
		</div>

		<div id="RegistrationAllotment">
			<!-- table tag will hold our grid -->
			<table id="registration_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
			<!-- pager will hold our paginator -->
			<div id="registration_list_pager" class="scroll" style="text-align:center;"></div>
		</div>

		</div>


		<script language="javascript"> 
			function tabOrders() {
				return true;
			}
		</script>

		<script type="text/javascript">// <![CDATA[
		  /* when the page has finished loading.. execute the follow */
		  $(document).ready(function () {

			$( "#allotBtn").hide();
			$('#fromDate').datetimepicker({dateFormat:'dd-mm-yy'});
			$('#toDate').datetimepicker({dateFormat:'dd-mm-yy'});
			$( "#searchBtn" )
				.button()
				.click(function() {
					if(($('#numP').val()+$('#numM').val()+$('#numC').val()+$('#numB').val())>0)
						{
						var url = '${createLink(controller:'AccommodationAllotment',action:'jq_chart_list')}'+'?fromDate='+$('#fromDate').val()+'&toDate='+$('#toDate').val()+'&numR='+$('#numR').val()+'&numP='+$('#numP').val()+'&numM='+$('#numM').val()+'&numC='+$('#numC').val()+'&numB='+$('#numB').val()
						//alert("url: "+url)
						$("#chart_list").jqGrid('setGridParam',{url:url});
						$("#chart_list").jqGrid('setGridParam',{datatype:'json'}).trigger('reloadGrid');
						$( "#allotBtn" ).show();
						}
				});

			$( "#allotBtn" )
				.button()
				.click(function() {
					var id = jQuery("#chart_list").jqGrid('getGridParam','selrow');
					if(id)
						{
						$("#message").load("${createLink(controller:'EventAccommodation',action:'allot')}"+"?id="+id+'&erid=${eventRegistrationInstance.id}&'+'fromDate='+$('#fromDate').val()+'&toDate='+$('#toDate').val()+'&numR='+$('#numR').val()+'&numP='+$('#numP').val()+'&numM='+$('#numM').val()+'&numC='+$('#numC').val()+'&numB='+$('#numB').val());
						}
					else
						alert("Please select a row!!");
				});

			jQuery("#chart_list").jqGrid({
				datatype: "local",
				colNames:['Name','Address','Rank','MaxCapacity','AvailableCapacity','id'],
				colModel:[
					{name:'acconame',
					formatter:'showlink', 
					//formatoptions:{baseLinkUrl:'${createLink(controller:'EventAccommodation',action:'allot')}', addParam: '&erid=${eventRegistrationInstance.id}&'+'fromDate='+$('#fromDate').val()+'&toDate='+$('#toDate').val()+'&numR='+$('#numR').val()+'&numP='+$('#numP').val()+'&numM='+$('#numM').val()+'&numC='+$('#numC').val()+'&numB='+$('#numB').val()}
					formatoptions:{baseLinkUrl:'${createLink(controller:'EventAccommodation',action:'show')}'}
					},
					{name:'address'},
					{name:'rank'},
					{name:'maxCapacity'},
					{name:'availableCapacity'},					
					{name:'id',hidden:true}	
				],
				 rowNum:10,
				 rowList:[10,20,30,40,50,100,200],
				 pager:'#chart_list_pager',
				 viewrecords: true,
				 gridview: true,
				 sortorder: "asc",
				 width: 1230,
				 height: "100%",
				  loadonce:true,
				caption:"Accommodation Availability",
				gridComplete: function(){ 
				  $("#chart_list").setGridParam({datatype: 'local'}); 
				}
			});
			jQuery("#chart_list").jqGrid('navGrid',"#chart_list_pager",{edit:false,add:false,del:false,search:false,refresh:false});

			
			var lastsel;
			var lastsel2;
			jQuery("#accommodation_list").jqGrid({
				url:'${createLink(controller:'AccommodationAllotment',action:'jq_accommodation_list')}'+'?erid=${eventRegistrationInstance.id}',
				datatype: "json",
				colNames:['Name','Rank','From', 'Till', 'Capacity', 'MaxP','MaxM','MaxC','MaxB','Avail','AvailP','AvailM','AvailC','AvailB','Allot','AllotP','AllotM','AllotC','AllotB','erid','id'],
				colModel:[
					{name:'name', searchable:true,
					formatter:'showlink', 
					formatoptions:{baseLinkUrl:'${createLink(controller:'EventAccommodation',action:'show')}'}},
					{name:'rankOverall', edit:false},
					{name:'availableFromDate', search:false, edit:false},
					{name:'availableTillDate', search:false, edit:false},
					{name:'maxCapacity', search:false, edit:false},
					{name:'maxPrabhujis', search:false, edit:false},
					{name:'maxMatajis', search:false, editable:false},
					{name:'maxChildrens', search:false, editable:false},
					{name:'maxBrahmacharis', search:false, editable:false},
					{name:'availableCapacity', search:false, editable:false},
					{name:'availablePrabhujis', search:false, editable:false},
					{name:'availableMatajis', search:false, edit:false},
					{name:'availableChildrens', search:false, edit:false},
					{name:'availableBrahmacharis', search:false, edit:false},
					{name:'numberAllotted', sortable:false,editable:true},
					{name:'numberofPrabhujisAllotted', sortable:false,editable:true},
					{name:'numberofMatajisAllotted', sortable:false,editable:true},
					{name:'numberofChildrenAllotted', sortable:false,editable:true},
					{name:'numberofBrahmacharisAllotted', sortable:false,editable:true},
					{name:'erid',hidden:true,editable:true},	
					{name:'id',hidden:true}	
				],
				 rowNum:10,
				 rowList:[10,20,30,40,50,100,200],
				 pager:'#accommodation_list_pager',
				 viewrecords: true,
				 gridview: true,
				 sortorder: "asc",
				 width: 1230,
				 height: "100%",
				 onSelectRow: function(id){
					if(id && id!==lastsel){
						jQuery('#accommodation_list').jqGrid('restoreRow',lastsel);
						jQuery('#accommodation_list').jqGrid('editRow',id,true);
						lastsel=id;
					}
				},
				editurl:'${createLink(controller:'AccommodationAllotment',action:'jq_edit_accommodations')}',
				caption:"Accommodation List"
			});
			//$("#accommodation_list").jqGrid('filterToolbar',{autosearch:true});
			jQuery("#accommodation_list").jqGrid('navGrid',"#accommodation_list_pager",{edit:false,add:false,del:false,search:false});

			
			jQuery("#registration_list").jqGrid({
				url:'${createLink(controller:'AccommodationAllotment',action:'jq_registration_list',id:eventRegistrationInstance.id)}',
				datatype: "json",
				colNames:['Accommodation Name','Available From', 'Available Till', 'Total Allotted', 'Prabhujis Allotted','Matajis Allotted','Childrens Allotted','Brahmacharis Allotted','id'],
				colModel:[
					{name:'name', searchable:true,
					formatter:'showlink', 
					formatoptions:{baseLinkUrl:'${createLink(controller:'EventAccommodation',action:'show')}'}},
					{name:'availableFromDate', search:false, edit:false},
					{name:'availableTillDate', search:false, edit:false},
					{name:'totalAllotted', sortable:false,editable:true},
					{name:'prabhujisAllotted', sortable:false,editable:true},
					{name:'matajisAllotted', sortable:false,editable:true},
					{name:'childrensAllotted', sortable:false,editable:true},
					{name:'brahmacharisAllotted', sortable:false,editable:true},
					{name:'id',hidden:true}	
				],
				 rowNum:10,
				 rowList:[10,20,30,40,50,100,200],
				 pager:'#registration_list_pager',
				 viewrecords: true,
				 gridview: true,
				 multisearch: true,
				 sopt:['eq','ne','cn','bw','bn', 'ilike'],
				 sortorder: "asc",
				 width: 1230,
				 height: "100%",
				 onSelectRow: function(id){
					if(id && id!==lastsel2){
						jQuery('#registration_list').jqGrid('restoreRow',lastsel2);
						jQuery('#registration_list').jqGrid('editRow',id,true);
						lastsel2=id;
					}
				},
				editurl:'${createLink(controller:'AccommodationAllotment',action:'jq_edit_registrations')}',
				caption:"Registration Allotment List"
			});
			$("#accommodation_list").jqGrid('filterToolbar',{autosearch:true});
			jQuery("#registration_list").jqGrid('navGrid',"#registration_list_pager",{edit:false,add:false,del:false});


		  });

		 function afterSubmitEvent(response, postdata) {
			var success = true;

			var json = eval('(' + response.responseText + ')');
			var message = json.message;

			if(json.state == 'FAIL') {
			    success = false;
			} else {
			  $('#message').html(message);
			  $('#message').show().fadeOut(10000);
			}

			var new_id = json.id
			gridReload();
			return [success,message,new_id];
		    }

		function gridReload(){
			var query = "";
			    
			jQuery("#registration_list").jqGrid('setGridParam',{url:"jq_registration_list?q=2"+query}).trigger("reloadGrid");
			jQuery("#accommodation_list").jqGrid('setGridParam',{url:"jq_accommodation_list?q=2"+query}).trigger("reloadGrid");

		}
		
		// ]]></script>
	</body>
</html>


