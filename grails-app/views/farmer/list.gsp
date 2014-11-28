
<%@ page import="ics.Farmer" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="farmer.list" default="Farmer List" /></title>
	<r:require module="grid" />
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="farmer.new" default="New Farmer" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="farmer.list" default="Farmer List" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <div>
			<!-- table tag will hold our grid -->
			<table id="farmer_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
			<!-- pager will hold our paginator -->
			<div id="farmer_list_pager" class="scroll" style="text-align:center;"></div>
	    </div>

		<div id="dialogSmsForm" title="SMS" gridName="" entityName="">
			<fieldset>
				<table>
					<tr>
						<td><label for="smstext">Text</label></td>
						<td><textarea rows="3" cols="40" maxlength="160" name="smstext" id="smstext" class="text ui-widget-content ui-corner-all"></textarea></td>
					</tr>
				</table>
			</fieldset>
		</div>

        </div>

<script>
  $(document).ready(function () {
    jQuery("#farmer_list").jqGrid({
      url:'jq_farmer_list',
      editurl:'jq_edit_farmer',
      datatype: "json",
      colNames:['FirstName','MiddleName','LastName','Village','Taluka','District','Post','Pincode','Caste','MobileNo','ShareAmount','ShareCertificateNo','IrrigatedLand','NonIrrigatedLand','TotalLand','DesiCows','HybridCows','OtherBusinessDetails','Drip','Sprinkler','IrrigationType','FarmingProcess','Crops','Category','ReceiptBookNo','ReceiptNo','Id'],
      colModel:[
	{name:'firstName', search:true, formatter:'showlink', 
             		formatoptions:{baseLinkUrl:'${createLink(controller:'farmer',action:'show',target:'#')}'}
	},
	{name:'middleName', search:true},
	{name:'lastName', search:true},
	{name:'village', search:true},
	{name:'taluka', search:true},
	{name:'district', search:true},
	{name:'post', search:true},
	{name:'pincode', search:true},
	{name:'caste', search:true},
	{name:'mobileNo', search:true},
	{name:'shareAmount', search:true},
	{name:'shareCertificateNo', search:true},
	{name:'areaOfIrrigatedLand', search:true},
	{name:'areaOfNonIrrigatedLand', search:true},
	{name:'areaOfTotalLand', search:true},
	{name:'numDesiCows', search:true},
	{name:'numHybridCows', search:true},
	{name:'otherBusinessDetails', search:true},
	{name:'areaUnderDrip', search:true},
	{name:'areaUnderSprinkler', search:true},
	{name:'irrigationType', search:true,
		stype:'select', searchoptions: { value: ':ALL;None:None;Well:Well; Bore-Well:Bore-Well;Canal:Canal;Lift:Lift'}
	},
	{name:'farmingProcess', search:true,
		stype:'select', searchoptions: { value: ':ALL;None:None;Organic:Organic; Non-Organic:Non-Organic;Both:Both'}
	},
	{name:'crops', search:true,
		stype:'select', searchoptions: {value:"${':ALL;'+(ics.Crop.list([sort:"name"])?.collect{it.name+':'+it.name}.join(';'))}"}	
	},
	{name:'category', search:true,
		stype:'select', searchoptions: { value: ':ALL;General:General;Coordinator:Coordinator; Spokesperson:Spokesperson;VIP:VIP'}
	},
	{name:'receiptBookNo', search:true},
	{name:'receiptNo', search:true},
	{name:'id',hidden:true}
     ],
    rowNum:15,
    rowList:[10,15,20,30,40,50,100,200],
    pager: '#farmer_list_pager',
    viewrecords: true,
    sortname: "id",
    sortorder: "desc",
    width: 1200,
    height: "100%",
    multiselect: false,
    caption:"Farmer List",
    onSelectRow: function(ids) { 
    	}    
    });
    $("#farmer_list").jqGrid('filterToolbar',{autosearch:true});
    $("#farmer_list").jqGrid('navGrid',"#farmer_list_pager",{edit:false,add:false,del:true,search:false});
    $("#farmer_list").jqGrid('inlineNav',"#farmer_list_pager",
	    { 
	       edit: false,
	       add: false,
	       save: false,
	       cancel: false,
	    });
    $("#farmer_list").jqGrid('navGrid',"#farmer_list_pager").jqGrid('navButtonAdd',"#farmer_list_pager",{caption:"SMS", buttonicon:"ui-icon-mail-closed", onClickButton:sms, position: "last", title:"SMS", cursor: "pointer"});


	function sms() {
		$( "#dialogSmsForm" ).dialog( "open" );
	}
	    
		$( "#dialogSmsForm" ).dialog({
			autoOpen: false,
			height: 350,
			width: 400,
			modal: true,
			buttons: {
				"Submit": function() {
						var url = "${createLink(controller:'farmer',action:'jq_farmer_list')}"
						var postData = jQuery('#farmer_list').jqGrid('getGridParam','postData');
						postData.rows = 100000;
						postData.smstext = $('#smstext').val();
						
						  $.post(url,postData,function(result){
						    alert("SMS: "+result.smstext+" sent to "+result.count+" recipients with phone nos "+result.phoneNos);
  							});
  						$('#smstext').val('');
						$( this ).dialog( "close" );
				},
				"Cancel": function() {
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
