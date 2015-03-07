
<%@ page import="ics.Assessment" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="asmtUserExamLayout" />
	<link rel="stylesheet" href="${resource(dir:'css',file:'timeTo.css')}" />
    </head>
    <body>
       <g:javascript src="jquery.timeTo.min.js" /> 

	<div id="dialogFeedbackForm" title="Feedback" data-role="popup" data-dismissible="false">
		<g:render template="/helper/customForm" />
		<input type="button" id="btnSubmitFeedbackForm" value="Submit" />
	</div>            

	<div id="popupInstructions" title="Instructions" data-role="popup">
		<a href="#" data-rel="back" class="ui-btn ui-corner-all ui-shadow ui-btn-a ui-icon-delete ui-btn-icon-notext ui-btn-right">Close</a>
		<p>${ics.Content.findWhere(course:ia?.assessment?.course,category:'PRE')?.htmlContent}</p>
	</div>            

       <div class="body">
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <button id="strtButton">Start</button>
            <div id="divQuestionPanel">
		    <div id="divQuestion"></div>
		    <label>
			    <input id="userCheckbox1" name="userCheckbox1" type="checkbox"><div id="divChoice1"></div>
		    </label>
		    <label>
			    <input id="userCheckbox2" name="userCheckbox2" type="checkbox"><div id="divChoice2"></div>
		    </label>
		    <label>
			    <input id="userCheckbox3" name="userCheckbox3" type="checkbox"><div id="divChoice3"></div>
		    </label>
		    <label>
			    <input id="userCheckbox4" name="userCheckbox4" type="checkbox"><div id="divChoice4"></div>
		    </label>
		    <div id="divHint"></div>
		    <div id="divInfo"></div>
            </div>
            <button id="subButton">Submit</button>
            <g:hiddenField name="iaqaid" value="" />
            <g:hiddenField name="iaqac" value="" />
            <g:hiddenField name="examover" value="" />
        </div>

    <script type="text/javascript">
        $(document).ready(function()
        {

	   
	   
	   $("#divQuestionPanel").hide();
	   $("#subButton").button().button('disable').hide();
	   $("#strtButton").button().click(function() {
		$("#strtButton").button().button('disable').hide();
		var url = "${createLink(controller:'Assessment',action:'userStart')}"+"?iaid="+${ia?.id}+"&examtype=${examtype}";
		$.getJSON(url, {}, function(data) {
			if(data.error)
				alert(data.error);
			else
				{
			   	alert("Starting the test...All the best! Hare Krishna!!");
			   	$('#timeText').timeTo(data.time, timeOver);
				displayQuestion(data);
				}
		    });	
	   	});
	   $("#subButton").button().click(function() {
		$("#subButton").button().button('disable').hide();		
		var choices=""
		$('#divQuestionPanel').find(':checked').each(function() {
		   choices+=$(this).prop('name')+",";
		});
		var url = "${createLink(controller:'Assessment',action:'userQuestion')}"+"?iaid=&iaqaid="+$("#iaqaid").val()+"&iaqac="+choices+"&examtype=${examtype}";
		$.getJSON(url, {}, function(data) {
			displayQuestion(data);
		    });	
	   	});
	   	
	   function timeOver(){
		$("#subButton").button().button('disable').hide();
		var url = "${createLink(controller:'Assessment',action:'userTimeOver')}"+"?iaid="+${ia?.id};
		$.getJSON(url, {}, function(data) {
			  examOver(data.result);
		    });	
	   }
	   function displayQuestion(data) {
		$("#divQuestion").text(data.questionText);
		$("#divChoice1").text(data.choice1);
		$("#divChoice2").text(data.choice2);
		$("#divChoice3").text(data.choice3);
		$("#divChoice4").text(data.choice4);
		$("#qNumText").text(data.qNum+" Question");
		//$("#timeText").text(data.time+" Remaining");
		$("input[type='checkbox']").attr("checked",false).checkboxradio("refresh");
		$("#iaqaid").val(data.iaqaid);
		$("#divQuestionPanel").show();
	   	if(data.examover)
	   		{
			  blank();
			  $("#examover").val("true");
			  $("#subButton").button().button('disable').hide();
		    	  examOver(data.result);
			}
		$("#subButton").button().button('enable').show();		
	   }
	   
	   function examOver(result) {
		blank();
	   	//alert("Thanks for the attempt. The test is now over. Your result is "+result);
	   	alert("Thanks for your participation in the exam. Result will be published soon.");
	   	$( "#dialogFeedbackForm" ).popup("open");
	   }
	   
	   function blank() {
		$("#divQuestion").text("");
		$("#divChoice1").text("");
		$("#divChoice2").text("");
		$("#divChoice3").text("");
		$("#divChoice4").text("");
		$("#qNumText").text("");
		//$('#timeText').text("");
		$('#timeText').timeTo('stop');
		$("#divQuestionPanel").hide();
	   }
	  $('#btnSubmitFeedbackForm').click(function(event){
	    $('#formCustom').submit();
	    $( "#dialogFeedbackForm" ).popup("close");
	  });

	/*$(document).on('pageinit', '.ui-page',function(event){
	    setTimeout(function () {
		 $( "#popupInstructions" ).popup("open");
	    }, 0);//Note the comment below from @Taifun.
	});*/
	
	$( document ).delegate("#exampage", "pageinit", function() {
	  //$("#vipPopup").popup(); //vip popup
	  $("#qNumText").trigger("click"); //openvipPopup is the id of the anchor for popup
	  //$( "#popupInstructions" ).popup("open");
	});	

	  

        });

    </script>	

    </body>
</html>
