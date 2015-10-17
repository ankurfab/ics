<div>
<!-- table tag will hold our grid -->
<table id="prospect_list" class="scroll jqTable" cellpadding="0" cellspacing="0"></table>
<!-- pager will hold our paginator -->
<div id="prospect_list_pager" class="scroll" style="text-align:center;"></div>
</div>

<script type="text/javascript">
  $(document).ready(function () {		    


    jQuery("#prospect_list").jqGrid({
      url:'jq_prospects_list',
      datatype: "json",
      colNames:['Photo','Stage','Status','LegalName','DoB','PoB','ToB','Caste','Height(cms)','income','candidateStatus','mbStatus','Id'],
      colModel:[
	{
	name: 'photo',
	formatter: function (cellvalue, options, rowObject) {
		    return '<img height="70" width="70" src="${createLink(controller:'Mb',action:'showImage')}?imgType=closePrim&entity=mbProfile&entityId='+rowObject[0]+'"/>';
		}
	},				
	{name:'candidateStatus'},
	{name:'workflowStatus'},
	{name:'legalName'},
	{name:'dob'},
	{name:'pob'},
	{name:'tob'},
	{name:'caste'},
	{name:'height'},
    {name:'income'},
	{name:'candidateStatus',hidden:true},
	{name:'mbStatus',hidden:true},
	{name:'id',hidden:true}
     ],
	    rowattr: function (rd) {
		    if (rd.mbStatus == 'FULLPROFILE') {
			return {"class": "bgSteelBlue"};
			}
		    if (rd.candidateStatus == 'DECLINE') {
			return {"class": "bgRed"};
			}
		    if (rd.candidateStatus == 'PROCEED') {
			return {"class": "bgSkyBlue"};
			}
		    if (rd.candidateStatus == 'MEET_PROSPECT') {
			return {"class": "bgYellow"};
			}
		    if (rd.candidateStatus == 'MEET_PARENT') {
			return {"class": "bgLightGreen"};
			}
		    },		         
    rowNum:10,
    rowList:[10],
    pager: '#prospect_list_pager',
    viewrecords: true,
    sortname: 'id',
    sortorder: "asc",
    height: "100%",
    autowidth: true,  // set 'true' here
    shrinkToFit: true, // well, it's 'true' by default
    multiselect: false,
    caption:"Prospect List"
    });
    //$("#prospect_list").jqGrid('filterToolbar',{autosearch:true});
    $("#prospect_list").jqGrid('navGrid',"#prospect_list_pager",{edit:false,add:false,del:false,search:false,refresh:false});
    $("#prospect_list").jqGrid('inlineNav',"#prospect_list_pager",
	    { 
	       edit: false,
	       add: false,
	       save: false,
	       cancel: false,
	    });	
  
  });
</script>