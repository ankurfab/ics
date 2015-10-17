
<%@ page import="ics.SchemeMember" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="schemeMember.list" default="SchemeMember List" /></title>
	<r:require module="grid" />
    <r:require module="export"/>    
        <export:resource />
    </head>
    <body>
    <script type="text/javascript">

         $(document).ready(function()
            {
            <sec:ifAnyGranted roles ="ROLE_DONATION_EXECUTIVE,ROLE_DONATION_COORDINATOR">
            <g:if test="${showpopup}">
                $( "#firsttimenotificationdiv" ).dialog({
                                height: 140,
                                width:700,
                                modal: true,
                                autoOpen:true
                                });

            </g:if>
            </sec:ifAnyGranted>

            $(".export .menuButton a").click(function(){

                var target= this.href + "&memberstatus="+$("#memberstatus").val()+"&selectedcenter="+$("#selectedcenter").val()+"&giftchannel="+$("#giftchannel").val()+"&exportType="+$("#exportType").val()+"&member="+$("#gs_member").val()+"&isProfileComplete="+$("#isProfileComplete").val()+"&giftPrefferedLanguage="+$("#giftPrefferedLanguage").val()+"&toBeCommunicated="+$("#toBeCommunicated").val() +"&committedmode="+$("#committedmode").val()+"&rankvalue="+$("#rankvalue").val()+"&toBeSMS="+$("#toBeSMS").val();
                window.location.href = target;
                return false;
            });
            });
    </script>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <sec:ifAnyGranted roles="ROLE_DONATION_EXECUTIVE">
                <span class="menuButton"><g:link class="list" controller="donationRecord" action="list"  target="_blank"><g:message code="donationRecord.list" default="DonationRecord List"/></g:link></span> 

                <span class="menuButton"><g:link class="list" controller="schemeMember" action="actions" target="_blank"><g:message code="giftRecord.list" default="Executive Action" /></g:link></span> 

            </sec:ifAnyGranted>
            <span class="menuButton"><g:link class="list" controller="schemeMember" action="listreminders" target="_blank"><g:message code="reminders.list" default="Reminders List"  /></g:link></span>                
        </div>
        <div class="body">
            <h1><g:message code="schemeMember.list" default="SchemeMember List" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
		<div>
        <sec:ifAnyGranted roles="ROLE_DONATION_EXECUTIVE">
                                        Center:<g:select id="selectedcenter" name="selectedcenter" from="${ics.Centre.list()}" optionKey="id" value="${selectedcenter}"  noSelection="[0: 'ALL']" onchange="reloadGrid()"/>
        </sec:ifAnyGranted>

         &nbsp;Creation Period:<g:select id="selectedperiod" name="selectedperiod" from="${['ALL','This Month','Six Month','One Year']}" keys="${['ALL','This_Month','Six_Month','One_Year']}" value="${selectedperiod}"   onchange="reloadGrid()"/>&nbsp;

          Gift Channel:<g:select id="giftchannel" name="giftchannel" from="${['ALL','In Person','By Counsellor','By Another Devotee','By Courier','Any Other']}" keys="${['ALL','In Person','By Counsellor','By Another Devotee','By Courier','Any Other']}" value="${giftchannel}" onchange="reloadGrid()" />&nbsp;

          Status:<g:select id="memberstatus" name="memberstatus" from="${['ALL','ACTIVE','IRREGULAR','INACTIVE','RESUMED','SUSPENDED','PROSPECT','NOTINTERESTED']}" keys="${['ALL','ACTIVE','IRREGULAR','INACTIVE','RESUMED','SUSPENDED','PROSPECT','NOTINTERESTED']}" value="${memberstatus}" onchange="reloadGrid()" />&nbsp;

           ProfileComplete:<g:select id="isProfileComplete" name="isProfileComplete" from="${['ALL','Yes','No']}" keys="${['ALL','Yes','No']}" value="${isProfileComplete}" onchange="reloadGrid()" />&nbsp;

           To Be Communicated:<g:select id="toBeCommunicated" name="toBeCommunicated" from="${['ALL','Yes','No']}" keys="${['ALL','Yes','No']}" value="${toBeCommunicated}" onchange="reloadGrid()" />&nbsp; <br/>

        <sec:ifAnyGranted roles="ROLE_DONATION_EXECUTIVE">

           Gift Preferred Language:<g:select id="giftPrefferedLanguage" name="giftPrefferedLanguage"  from="${ics.Language.list()}" optionKey="id" noSelection="[0: 'ALL']" value="${giftPrefferedLanguage}" onchange="reloadGrid()" />&nbsp;

            Commited Mode:<g:select id="committedmode" name="committedmode"  from="${['ECS','E-PAYMENT','CASH','PDC']}" keys="${['ECS','E-PAYMENT','CASH','PDC']}" noSelection="[0: 'ALL']" value="${giftPrefferedLanguage}" onchange="reloadGrid()" />&nbsp;

            Rank:<g:select id="rankvalue" name="rankvalue" from="${['ALL','0','1','2','3','4']}" keys="${['ALL','0','1','2','3','4']}" value="${rankvalue}" onchange="reloadGrid()" />&nbsp;

            To Be Sent SMS:<g:select id="toBeSMS" name="toBeSMS" from="${['ALL','Yes','No']}" keys="${['ALL','Yes','No']}" value="${toBeSMS}" onchange="reloadGrid()" />&nbsp;

           <br/>
           <br/>
        </sec:ifAnyGranted>

           <sec:ifAnyGranted roles="ROLE_DONATION_EXECUTIVE">

               Export Data:<g:select id="exportType" name="exportType" from="${['Only Address','Only Contact Data','Full Data']}" keys="${['Only Address','Only Contact Data','Full Data']}" value="${selectedperiod}"  />&nbsp;

               <export:formats formats="['excel','csv','pdf','rtf']" controller="schemeMember" action="schemeMemberDataExportAsCVS"/>

            </sec:ifAnyGranted>


		<!-- table tag will hold our grid -->
		<table id="schemeMember_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
		<!-- pager will hold our paginator -->
		<div id="schemeMember_list_pager" class="scroll" style="text-align:center;"></div>
		</div>
        </div>
        <div id="summary" style="float:left;padding:10px 10px;margin:10px 50px;border:1px solid;">
            <g:message code="schemeMember.summarydetails" default="Summary Details" />
            <hr>
            <g:each in="${summary}" var="item">
            <span id="summaryrow" style="margin:5px;border:1px none">
             ${item[0]} are  ${item[1]}
             </span>
            
            </g:each>
        </div>

<script type="text/javascript">

  jQuery(document).ready(function () {
    jQuery("#schemeMember_list").jqGrid({
      url:'${createLink(controller:'schemeMember',action:'jq_allschemeMember_list')}',
      postData:{selectedCenter:function(){return $("#selectedcenter").val();}, selectedperiod:function(){return $("#selectedperiod").val();},giftchannel:function(){return $("#giftchannel").val();},memberstatus:function(){return $("#memberstatus").val();},isProfileComplete:function(){return $("#isProfileComplete").val();}, giftPrefferedLanguage:function(){return $("#giftPrefferedLanguage").val()}, toBeCommunicated:function(){return $("#toBeCommunicated").val()} , committedmode: function(){return $("#committedmode").val()} , toBeSMS:function(){return $("#toBeSMS").val()}, rankvalue:function(){return $("#rankvalue").val()}},
      datatype: "json",
      colNames:['Scheme','Member','Legal Name', 'Rank' ,'Status', 'Commited Mode','Commited Amount','Current Actual Amount','Comments','Recent Communication','Concern To Address','Center','Second Center Deduction','Profile Complete','To Be Communicated','id'],
      colModel:[
	{name:'scheme',search:false},
	{name:'member',search:true,formatter:'showlink',
	formatoptions:{baseLinkUrl:'${createLink(controller:'schemeMember',action:'show')}',target:'_blank'}
	},
  {name:'legalname',search:true},
  {name:'star', search:false},
	{name:'status',search:true},
  {name:'committedMode',search:true},
  {name:'committedAmount',search:false},
  {name:'actualCurrentAmount',search:false},
	{name:'comments',search:false},
	{name:'recentCommunication',search:false},
    {name:'addressTheConcern',search:false},
    {name:'center',search:true},
    {name:'PercentageDeduction',search:true},
    {name:'isProfileComplete',search:false},
    {name:'toBeCommunicated',search:false},
	{name:'id',hidden:true}
     ],
    rowNum:10,
    rowList:[10,20,30,40,50,100],
    pager: '#schemeMember_list_pager',
    viewrecords: true,
    gridview: true,
    sortname: 'member',
    sortorder: "asc",
    width: 1200,
    height: "100%",
    caption:"SchemeMembership List"
    });
    $("#schemeMember_list").jqGrid('filterToolbar',{autosearch:true});
    $("#schemeMember_list").jqGrid('navGrid',"#vehicle_list_pager",{edit:false,add:false,del:false,search:false});
    $("#schemeMember_list").jqGrid('inlineNav',"#vehicle_list_pager");
    
    });

 function reloadGrid(){
    $("#schemeMember_list").trigger("reloadGrid");    
    }
</script>

      <div id="firsttimenotificationdiv" title="Reminders For You" style="display:none">
        <p>Make Sure to Check your Reminders by clicking on Link below.</p>
        <g:link class="link red" controller="schemeMember" action="listreminders">Click Here For Reminders</g:link>
      </div>
        
    </body>
</html>
