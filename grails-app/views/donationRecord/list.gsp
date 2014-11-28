
<%@ page import="ics.DonationRecord" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="donationRecord.list" default="DonationRecord List" /></title>
	<r:require module="qtip" />
        <r:require module="grid" />
        <r:require module="export"/>   
        <r:require module="printarea"/>   
        <export:resource /> 
    </head>
    <body>

	<style>
		.lex {
		    color: green;
		    text-decoration: underline;
		}	
	</style>

	<script>
	function qTip(node) {
	    var url = node.attr("href");
	    node.qtip({
		content: {
		    text: "loading...",
		    ajax: {
			url: url,
			type: 'post',
			data: { html: 'test' }
		    }
		},
		show: {
		            ready: true // Show it immediately
        }
	    });
	}
	/*$(document).ready(function() {
	    $('a').on('mouseover', function() {
		alert("mouseover");
		var _self = $(this);
		qTip(_self);
	    });
	})*/
	</script>

        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
             <sec:ifAnyGranted roles="ROLE_DONATION_EXECUTIVE">
                <span class="menuButton"><g:link class="create" action="uploadpaymentdata"><g:message code="donationRecord.upload" default="DonationRecord Upload" /></g:link></span>

                <span class="menuButton"><g:link class="create" action="createzeropaymentrecords"><g:message code="donationRecord.createzeropaymentrecords" default="Create Zero Payment Records" /></g:link></span>
            </sec:ifAnyGranted>
        </div>

        <div class="body">
            <h1><g:message code="donationRecord.list" default="DonationRecord List" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.message}" /></div>
            </g:if>
            <sec:ifAnyGranted roles="ROLE_NVCC_ADMIN">
            ReceiptStatus:<g:select id="rcptStatus" name="rcptStatus" from="${['NOTGENERATED','GENERATED']}" value="NOTGENERATED" onchange="reloadGrid()"/>&nbsp;
            </sec:ifAnyGranted>
            <sec:ifAnyGranted roles="ROLE_DONATION_EXECUTIVE,ROLE_NVCC_ADMIN,ROLE_DUMMY">
            Center:<g:select id="selectedcenter" name="selectedcenter" from="${ics.Centre.list()}" optionKey="name" value="${selectedcenter}"  noSelection="[ALL: 'ALL']" onchange="reloadGrid()"/>&nbsp;
            Donation Date(All records in this month) :<g:textField id="donationDate" name="donationDate" value="${donationDate}" onchange="reloadGrid()" />   <br/>
            </sec:ifAnyGranted>
            <sec:ifAnyGranted roles="ROLE_DONATION_EXECUTIVE">

               Export Data(If donation Date not specified then current month will be taken):<g:select id="exportType" name="exportType" from="${['Full Data','Summary Report']}" keys="${['Full Data','Summary Report']}" value="${exportType}"  />&nbsp;
               For Summary Report to Include :<g:select id="numberofmonths" name="numberofmonths" from="${['1','2','3','4']}" keys="${['1','2','3','4']}" value="${numberofmonths}"  /> Months Also
               <br/>
                Note:For Summary Report only Centre and Donation Date is considered. &nbsp;<br/>
               <export:formats formats="['excel','csv','pdf','rtf']" controller="donationRecord" action="donationRecordDataExportAsCVS"/>

            </sec:ifAnyGranted>


            <!-- table tag will hold our grid -->
        <table id="donationRecord_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
        <!-- pager will hold our paginator -->
        <div id="donationRecord_list_pager" class="scroll" style="text-align:center;"></div>
        
        <sec:ifAnyGranted roles="ROLE_NVCC_ADMIN,ROLE_DUMMY">
		<input class="menuButton" type="BUTTON" id="receiptBtn" value="CreateDonationReceipt" />
	</sec:ifAnyGranted>


	<div id="divToPrint"></div>
        
<script type="text/javascript">

  jQuery(document).ready(function () {
   $("#donationDate").datepicker({yearRange: "-100:+0",changeMonth: true,
                changeYear: true,
                dateFormat: 'dd-mm-yy'});

      $(".export .menuButton a").click(function(){

                var target= this.href + "&selectedcenter="+$("#selectedcenter").val()+"&donationDate="+$("#donationDate").val()+"&exportType="+$("#exportType").val()+"&member="+$("#gs_member").val()+"&amount="+$("#gs_amount").val()+"&mode="+$("#gs_mode").val()+"&comments="+$("#gs_comments").val()+"&paymentDetails="+$("#gs_paymentDetails").val()+"&transactionId="+$("#gs_transactionId").val()+"&numberofmonths="+$("#numberofmonths").val();
                window.location.href = target;
                return false;
            });


    jQuery("#donationRecord_list").jqGrid({
      url:'${createLink(controller:'donationRecord',action:'jq_alldonationrecord_list')}',      
      postData:{
      	selectedcenter:function(){return $("#selectedcenter").val();},
      	donation_date:function(){return $("#donationDate").val();}
      	<sec:ifAnyGranted roles="ROLE_NVCC_ADMIN">
		,
		receiptReceivedStatus:function(){return $("#rcptStatus").val();}
      	</sec:ifAnyGranted>
      	},
      datatype: "json",
      colNames:['Scheme','Member','Amount','Mode','Donation Date','Comments','Payment Details','Transaction Id', 'Center', 'ReceiptReceivedStatus','Creator','RBNO','RNO','LinkedDonation','id'],
      colModel:[
    {name:'scheme',search:false},
    {name:'member',search:true,formatter:'showlink',
    formatoptions:{baseLinkUrl:'${createLink(controller:'donationRecord',action:'show')}',target:'_blank'}
    },
    {name:'amount',search:true},
    {name:'mode',search:true},
    {name:'donationDate',search:false},
    {name:'comments',search:true},
    {name:'paymentDetails',search:true},
    {name:'transactionId',search:true},
    {name:'centre',search:false},
    {name:'receiptReceivedStatus',search:true},
    {name:'creator',search:true},
    {name:'rbno',search:true},
    {name:'rno',search:true},
    {name:'donation',search:false},
    {name:'id',hidden:true}
     ],
    rowNum:10,
    rowList:[10,20,30,40,50,100],
    pager: '#donationRecord_list_pager',
    viewrecords: true,
    gridview: true,
    sortname: 'id',
    sortorder: "desc",
    width: 1200,
    height: "100%",
    multiselect: true,
    caption:"Donation Record List"
    });
    $("#donationRecord_list").jqGrid('filterToolbar',{autosearch:true});
    $("#donationRecord_list").jqGrid('navGrid',"#donationRecord_list_pager",{edit:false,add:false,del:false,search:false});
    //$("#donationRecord_list").jqGrid('inlineNav',"#donationRecord_list_pager");

	$( "#receiptBtn" )
		.button()
		.click(function() {
			var ids = jQuery("#donationRecord_list").jqGrid('getGridParam','selarrrow');
			if(ids) {
					var url = "${createLink(controller:'donation',action:'createFromRecord')}"+"?idList="+ids
					$.getJSON(url, {}, function(data) {
						$('#divToPrint').html(data.message).printArea();
					    });	
			}
			else
				alert("Please select rows!!");
		});
				    
    });

    function reloadGrid(){
    $("#donationRecord_list").trigger("reloadGrid");  
    }

    </script>




        </div>
    </body>
</html>
