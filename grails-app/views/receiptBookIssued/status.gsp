
<%@ page import="ics.ReceiptBookIssued" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Receipt Book Status</title>
	<r:require module="grid" />
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
        </div>
        <div class="body">
            <div>
			<!-- table tag will hold our grid -->
			<table id="status_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
			<!-- pager will hold our paginator -->
			<div id="status_list_pager" class="scroll" style="text-align:center;"></div>
	    </div>

        </div>

<script>
  $(document).ready(function () {
    jQuery("#status_list").jqGrid({
      url:'jq_status_list',
      datatype: "json",
      colNames:['BookSeries','BookNo','IssuedTo','NumDonations','DonationAmount','BookStatus','Id'],
      colModel:[
	{name:'bookSeries', search:true},
	{name:'bookSerialNumber', search:true},
	{name:'issuedto', search:true},
	{name:'numdonations', search:true},
	{name:'donationamount', search:true},
	{name:'status', search:true},
	{name:'id',hidden:true}
     ],
    rowNum:50,
    rowList:[10,20,30,40,50,100,200],
    pager: '#status_list_pager',
    viewrecords: true,
    sortname: 'id',
    sortorder: "desc",
    width: 1200,
    height: "100%",
    multiselect: false,
    caption:"Receipt Book Issued Status"
    });
    $("#status_list").jqGrid('filterToolbar',{autosearch:true});
    $("#status_list").jqGrid('navGrid',"#status_list_pager",{edit:false,add:false,del:false,search:false});
    $("#status_list").jqGrid('inlineNav',"#status_list_pager",
	    { 
	       edit: false,
	       add: false,
	       save: false,
	       cancel: false,
	    }
    );

    });
</script>


    </body>
</html>
