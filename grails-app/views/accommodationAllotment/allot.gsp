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
		    <span class="menuButton"><g:link class="list" controller="EventRegistration" action="list">Registration List</g:link></span>
		</div>
		<g:if test="${flash.message}">
		    <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
		</g:if>

		<div id='message' class="message" style="display:none;"></div>
		<div id="dialogACS" title="Accommodation Confirmation Slip">
			<p id="acsText">Loading.....<img src="${resource(dir:'images',file:'spinner.gif')}"/></p>
		</div>
		
		<g:form name="regCodeForm" action="allot">
		Registration Code <g:textField name="regCode" />
		<g:submitButton name="search" value="Search" />
		</g:form>
		
		<!-- Allocation summary -->
		<div>
			<!-- table tag will hold our grid -->
			<table id="summary_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
			<!-- pager will hold our paginator -->
			<div id="summary_list_pager" class="scroll" style="text-align:center;"></div>
		</div>
		
		<div id="tabs">
			<ul>
				<li><a href="#AccommodationChart">Allocation</a></li>
				<li><a href="#RegistrationAllotment">Current Allocations</a></li>
			</ul>

		<div id="AccommodationChart">
			<table>
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
			<table id="availability_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
			<!-- pager will hold our paginator -->
			<div id="availability_list_pager" class="scroll" style="text-align:center;"></div>

			<input class="menuButton" type="BUTTON" id="allotBtn" value="Allot" />

		</div>
		<div id="RegistrationAllotment">
			<!-- table tag will hold our grid -->
			<table id="registration_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
			<!-- pager will hold our paginator -->
			<div id="registration_list_pager" class="scroll" style="text-align:center;"></div>

			<input class="menuButton" type="BUTTON" id="checkinBtn" value="CheckIn!!" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>
			<input class="menuButton" type="BUTTON" id="btnACS" value="ACS" /></div>

		</div>

		</div>

		<div id="dialog-form" title="Allotment Details">
			<form>
			<fieldset>
				<table>
				<tr>
					<td>Number of Prjis</td>
					<td><g:textField name="numPreq" value="0" /></td>
				</tr>
				<tr>
					<td>Number of Matajis</td>
					<td><g:textField name="numMreq" value="0" /></td>
				</tr>
				<tr>
					<td>Number of Children</td>
					<td><g:textField name="numCreq" value="0" /></td>
				</tr>
				<tr>
					<td>Number of Brahmacharis/Students</td>
					<td><g:textField name="numBreq" value="0" /></td>
				</tr>
				</table>				
			</fieldset>
			</form>
		</div>


		<script language="javascript"> 
			function tabOrders() {
				return true;
			}
		</script>

		<script type="text/javascript">// <![CDATA[
		  /* when the page has finished loading.. execute the follow */
		  $(document).ready(function () {

			//$( "#allotBtn").hide();
			$('#fromDate').datetimepicker({dateFormat:'dd-mm-yy'});
			$('#toDate').datetimepicker({dateFormat:'dd-mm-yy'});
			$( "#searchBtn" )
				.button()
				.click(function() {
					if(($('#numP').val()+$('#numM').val()+$('#numC').val()+$('#numB').val())>0)
						{
						var url = '${createLink(controller:'AccommodationAllotment',action:'jq_availability_list')}'+'?numP='+$('#numP').val()+'&numM='+$('#numM').val()+'&numC='+$('#numC').val()+'&numB='+$('#numB').val()
						//alert("url: "+url)
						$("#availability_list").jqGrid('setGridParam',{url:url});
						$("#availability_list").jqGrid('setGridParam',{datatype:'json'}).trigger('reloadGrid');
						//$( "#allotBtn" ).show();
						}
				});

			$( "#allotBtn" )
				.button()
				.click(function() {
					var id = jQuery("#availability_list").jqGrid('getGridParam','selrow');
					if(id)
						{
						$('#numPreq').val($('#numP').val());
						$('#numMreq').val($('#numM').val());
						$('#numCreq').val($('#numC').val());
						$('#numBreq').val($('#numB').val());						
						$( "#dialog-form" ).dialog( "open" );
						}
					else
						alert("Please select a row!!");
				});


			$( "#checkinBtn" )
				.button()
				.click(function() {
					var erid = jQuery("#summary_list").jqGrid('getGridParam','selrow');
					if(!erid)
						{
						alert("Please select the sub-group from the summary grid!!");
						return;
						}
					var aaid = jQuery("#registration_list").jqGrid('getGridParam','selrow');
					if(!aaid)
						{
						alert("Please select the accommodation from the current allocations grid!!");
						return;
						}

					$.getJSON("${createLink(controller:'AccommodationAllotment',action:'checkin')}"+"?erid="+erid+"&aaid="+aaid, function(data) {
					    if(data.count>0)
						{
						jQuery("#summary_list").jqGrid().trigger('reloadGrid');
						jQuery("#registration_list").jqGrid().trigger('reloadGrid');
						var url = "${createLink(controller:'helper',action:'eventGenACS')}"+"?idlist="+data.count
						$('#acsText').load(url)
						$( "#dialogACS" ).dialog("open");
						}
					    else
					    	if(data.message.length>0)
					    		{
					    		alert(data.message);
					    		return;
					    		}
					    });
				});
			$( "#dialogACS" ).dialog({
				autoOpen: false,
				//height: 600,
				width: 800,
				modal: true,
				buttons: {
					"Print": function() {
						PrintDiv('acsText');
					},
					Cancel: function() {
						$('#acsText').text('')
						$( this ).dialog( "close" );
					}
				},
				close: function() {

				}
			});

			jQuery("#availability_list").jqGrid({
				datatype: "json",
				url: '${createLink(controller:'AccommodationAllotment',action:'jq_availability_list')}'+'?numP='+$('#numP').val()+'&numM='+$('#numM').val()+'&numC='+$('#numC').val()+'&numB='+$('#numB').val(),
				colNames:['Name','Address','Rank','Comments','AvailableCapacity','TotalCapacity','id'],
				colModel:[
					{name:'name',editable:false,
					//formatter:'showlink', 
					//formatoptions:{baseLinkUrl:'${createLink(controller:'EventAccommodation',action:'show')}'}
					},
					{name:'address',editable:false},
					{name:'rankOverall',editable:false},
					{name:'comments',editable:false},
					{name:'availableCapacity',sortable:true,editable:false},
					{name:'maxCapacity',sortable:true,editable:false},
					{name:'id',hidden:true}	
				],
				 rowNum:10,
				 rowList:[10,20,30,40,50,100,200],
				 pager:'#availability_list_pager',
				 viewrecords: true,
				 gridview: true,
				 sortname: 'rankOverall',
				 sortorder: "desc",
				 width: 1230,
				 height: "100%",
				caption:"Accommodation Availability for Group Leader ",
				/*loadonce:true,
				gridComplete: function(){ 
				  $("#availability_list").setGridParam({datatype: 'local'}); 
				}*/
			});
			var url = '${createLink(controller:'AccommodationAllotment',action:'jq_availability_list')}'+'?numP='+$('#numP').val()+'&numM='+$('#numM').val()+'&numC='+$('#numC').val()+'&numB='+$('#numB').val()
			
			$("#availability_list").jqGrid('filterToolbar',{autosearch:true});
			jQuery("#availability_list").jqGrid('navGrid',"#availability_list_pager",{edit:false,add:false,del:false,search:false,refresh:false});

			jQuery("#registration_list").jqGrid({
				url:'${createLink(controller:'AccommodationAllotment',action:'jq_allotment_list',id:eventRegistrationInstance.id)}',
				datatype: "json",
				colNames:['Accommodation Name','Address', 'Comments', 'Total Allotted', 'Prabhujis Allotted','Matajis Allotted','Childrens Allotted','Brahmacharis Allotted','SubGroup', 'Total Checkedin', 'Prabhujis Checkedin','Matajis Checkedin','Childrens Checkedin','Brahmacharis Checkedin','id'],
				colModel:[
					{name:'name', searchable:true, sortable:false,
					//formatter:'showlink', 
					//formatoptions:{baseLinkUrl:'${createLink(controller:'EventAccommodation',action:'show')}',addParam:'&domainId=AA'}
					},
					{name:'address', search:false, edit:false, sortable:false},
					{name:'comments', search:false, edit:false, sortable:false},
					{name:'numberAllotted', sortable:false,editable:false},
					{name:'numberofPrabhujisAllotted', sortable:false,editable:true},
					{name:'numberofMatajisAllotted', sortable:false,editable:true},
					{name:'numberofChildrenAllotted', sortable:false,editable:true},
					{name:'numberofBrahmacharisAllotted', sortable:false,editable:true},
					{name:'subgroup', sortable:false,editable:false},
					{name:'numberCheckedin', sortable:false,editable:false},
					{name:'numberofPrabhujisCheckedin', sortable:false,editable:true},
					{name:'numberofMatajisCheckedin', sortable:false,editable:true},
					{name:'numberofChildrenCheckedin', sortable:false,editable:true},
					{name:'numberofBrahmacharisCheckedin', sortable:false,editable:true},
					{name:'id',hidden:true}	
				],
				 rowNum:10,
				 rowList:[10,20,30,40,50,100,200],
				 pager:'#registration_list_pager',
				 viewrecords: true,
				 gridview: true,
				 multiselect: false,
				 multisearch: true,
				 sopt:['eq','ne','cn','bw','bn', 'ilike'],
				 sortorder: "asc",
				 width: 1230,
				 height: "100%",
				editurl:'${createLink(controller:'AccommodationAllotment',action:'jq_edit_allotment')}',
				caption:"Registration Allotment List",
				footerrow : true,
				userDataOnFooter : true												
			});
			$("#accommodation_list").jqGrid('filterToolbar',{autosearch:true});
			jQuery("#registration_list").jqGrid('navGrid',"#registration_list_pager",{edit:true,add:false,del:true,search:false},{closeAfterEdit:true});

			jQuery("#summary_list").jqGrid({
				url:'${createLink(controller:'AccommodationAllotment',action:'jq_allocation_summary',id:eventRegistrationInstance?.id)}',
				datatype: "json",
				colNames:['','Name','Phone','RegCode','Arrival','Departure','TotalAlloted/TotalRegistered','PrjiAlloted/PrjiRegistered','MatajiAlloted/MatajiRegistered','ChildrenAlloted/ChildrenRegistered','Brahmacharis(Students)Alloted/Registered','id'],
				colModel:[
					{name:'desc',sortable:false,search:false},	
					{name:'name',sortable:false,search:false,
						//formatter:'showlink', 
						//formatoptions:{baseLinkUrl:'${createLink(controller:'EventRegistration',action:'show')}'}
					},
					{name:'contactNumber',sortable:false,search:false},
					{name:'regcode',sortable:false,search:true},
					{name:'arrival',sortable:false,search:false},
					{name:'departure',sortable:false,search:false},
					{name:'total',sortable:false,search:false},					
					{name:'prji',sortable:false,search:false},					
					{name:'mataji',sortable:false,search:false},					
					{name:'children',sortable:false,search:false},					
					{name:'brahmacharis',sortable:false,search:false},					
					{name:'id',hidden:true}	
				],
				 rowNum:10,
				 rowList:[10],
				 viewrecords: true,
				 gridview: true,
				 pager:'#summary_list_pager',
				 width: 1230,
				 height: "100%",
				caption:"Allotment Summary",
				footerrow : true,
				userDataOnFooter : true				
			});
			jQuery("#summary_list").jqGrid('navGrid',"#summary_list_pager",{edit:false,add:false,del:false,search:false},{},{},{},{closeAfterSearch:true,searchOnEnter:true});

		$( "#dialog-form" ).dialog({
			autoOpen: false,
			height: 300,
			width: 350,
			modal: true,
			buttons: {
				"Submit": function() {
					var id = jQuery("#availability_list").jqGrid('getGridParam','selrow');
					//$("#message").load("${createLink(controller:'EventAccommodation',action:'allot')}"+"?id="+id+'&erid=${eventRegistrationInstance.id}&'+'&numPreq='+$('#numPreq').val()+'&numMreq='+$('#numMreq').val()+'&numCreq='+$('#numCreq').val()+'&numBreq='+$('#numBreq').val());					
					//todo error handling
					var url = "${createLink(controller:'EventAccommodation',action:'allot')}"+"?id="+id+'&erid=${eventRegistrationInstance.id}&'+'&numPreq='+$('#numPreq').val()+'&numMreq='+$('#numMreq').val()+'&numCreq='+$('#numCreq').val()+'&numBreq='+$('#numBreq').val();
					$.getJSON(url, function(data) {
						alert(data.message);
					    if(data.status!="FAIL")
							{
							$("#summary_list").jqGrid().trigger('reloadGrid');
							$("#registration_list").jqGrid().trigger('reloadGrid');
							}
					    });
					
					$( this ).dialog( "close" );
				},
				Cancel: function() {
					$( this ).dialog( "close" );
				}
			},
			close: function() {
				//update the nos
				var tmp = eval($('#numP').val() - $('#numPreq').val());
				//alert(tmp+":"+$('#numP').val()+":"+$('#numPreq').val());
				$('#numP').val(tmp);
				//alert($('#numP').val());
				$('#numM').val(eval($('#numM').val() - $('#numMreq').val()));
				$('#numC').val(eval($('#numC').val() - $('#numCreq').val()));
				$('#numB').val(eval($('#numB').val() - $('#numBreq').val()));
				$('#numPreq').val('0');
				$('#numMreq').val('0');
				$('#numCreq').val('0');
				$('#numBreq').val('0');
			}
			});

			var aCaption = "Accommodation Availability for Group Leader : ${eventRegistrationInstance.name} (${eventRegistrationInstance.regCode})";
			jQuery("#availability_list").jqGrid('setCaption',aCaption);
			jQuery("#registration_list").jqGrid('setCaption',"Registration Allotment List for Group Leader : ${eventRegistrationInstance.name} (${eventRegistrationInstance.regCode})");

		$( "#btnACS" )
			.button()
			.click(function() {
				var idlist = jQuery("#registration_list").jqGrid('getGridParam','selrow');
				
				if(idlist!='')
					{
					var url = "${createLink(controller:'helper',action:'eventGenACS')}"+"?type=aa&idlist="+idlist
					$('#acsText').load(url)
					$( "#dialogACS" ).dialog("open");
					}
				else
					alert("Select a record for generating ACS!!");
			});

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
		function PrintDiv(divName) {    
		   var divToPrint = document.getElementById(divName);
		   var popupWin = window.open('', '_blank', 'width=600,height=300');
		   popupWin.document.open();
		   popupWin.document.write('<html><body onload="window.print()">' + divToPrint.innerHTML + '</html>');
		    popupWin.document.close();
                }
		
		// ]]></script>
	</body>
</html>


