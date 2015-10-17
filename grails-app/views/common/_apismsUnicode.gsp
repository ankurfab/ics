<!--
Pls copy below snippet in the main gsp page
Incase more than one SMS buttons are required, pls preserve the id naming pattern..maybe something like btnSMS1,btnSMS2 or equivalent..
Also modify the gridName and entityName accordingly
<input class="menuButton" type="BUTTON" id="unicodebtnSMS" value="SMS" gridName="#eventRegistration_list" entityName="EventRegistration" departmentId="${ics.Department.findByName('Guest Reception Department')?.id}"/>
-->

<script type="text/javascript">
  jQuery(document).ready(function () {
		$("[id^='unicodebtnSMS']")
			.button()
			.click(function() {
				var answer = true;
				var idlist = jQuery($(this).attr('gridName')).jqGrid('getGridParam','selarrrow');
				if(idlist=="")	//try for multipleselect=false case
					idlist = jQuery($(this).attr('gridName')).jqGrid('getGridParam','selrow');
				if(!idlist) {
					answer = confirm("Please select any record!!");
				}
				
				if(answer)
					{
					var url = "${createLink(controller:'helper',action:'message')}"+'?via=SMS&entityName='+$(this).attr('entityName')+'&depid='+$(this).attr('departmentId')+'&ids='+idlist;
					var win = window.open(url, '_blank');
					if(win){
					    //Browser has allowed it to be opened
					    win.focus();
					}else{
					    //Broswer has blocked it
					    alert('Please allow popups for this site');
					}					
					}
			});

    });
</script>
