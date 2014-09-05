
<%@ page import="ics.Assessment" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="asmtUserExamLayout" />
    </head>
    <body>
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
        </div>

    <script type="text/javascript">
        $(document).ready(function()
        {
	   $("#divQuestionPanel").hide();
	   $("#subButton").button().button('disable').hide();
	   $("#strtButton").button().click(function() {
		$("#strtButton").button().button('disable').hide();
		var url = "${createLink(controller:'Assessment',action:'userStart')}"+"?iaid=";
		$.getJSON(url, {}, function(data) {
			if(data.error)
				alert(data.error);
			else
				{
			   	alert("Starting the test...All the best! Hare Krishna!!");
				displayQuestion(data);
				$("#subButton").button().button('enable').show();
				}
		    });	
	   	});
	   $("#subButton").button().click(function() {
		var choices=""
		$('#divQuestionPanel').find(':checked').each(function() {
		   choices+=$(this).prop('name')+",";
		});
		var url = "${createLink(controller:'Assessment',action:'userQuestion')}"+"?iaid=&iaqaid="+$("#iaqaid").val()+"&iaqac="+choices;
		$.getJSON(url, {}, function(data) {
			displayQuestion(data);
		    });	
	   	});
	   	
	   function displayQuestion(data) {
		$("#divQuestion").text(data.questionText);
		$("#divChoice1").text(data.choice1);
		$("#divChoice2").text(data.choice2);
		$("#divChoice3").text(data.choice3);
		$("#divChoice4").text(data.choice4);
		$("input[type='checkbox']").attr("checked",false).checkboxradio("refresh");
		$("#iaqaid").val(data.iaqaid);
		$("#divQuestionPanel").show();
	   	if(data.examover)
	   		{
			   $("#subButton").button().button('disable').hide();
		    	  alert("Thanks for the attempt. The test is now over. Your result is "+data.result);
			}
		
	   }

        });

    </script>	

    </body>
</html>
