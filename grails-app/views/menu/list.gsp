
<%@ page import="ics.Menu" %>
<!doctype html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'menu.label', default: 'Menu')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
		<r:require module="calendar" />
	</head>
	<body>

	<script>
		$(document).ready(function() {
		var date = new Date();
		var d = date.getDate();
		var m = date.getMonth();
		var y = date.getFullYear();
		
		var calendar = $("#calendar").fullCalendar({
			dayClick: function (dateSelected, allDay, jsEvent, view) {
			    $("#eventToAdd").dialog(
			    {
				title: "Add event",
				modal: true,
				buttons: {
				    "Add": function () {
				       //event adding logic goes here                
					    var event = new Object(), eventToSave = new Object(); ;
					    eventToSave.EventID = event.id = Math.floor(200 * Math.random());
					    event.start = new Date($("#eventToAdd #eventStartDate").val());
					    eventToSave.StartDate = $("#eventToAdd #eventStartDate").val();
					    if ($("#eventToAdd #eventEndDate").val() == "") {
						event.end = event.start;
						eventToSave.EndDate = eventToSave.StartDate;
					    }
					    else {
						event.end = new Date($("#eventToAdd #eventEndDate").val());
						eventToSave.EndDate = $("#eventToAdd #eventEndDate").val();
					    }
					    eventToSave.EventName = event.title = $("#eventToAdd #eventName").val();

					    $("#eventToAdd input").val("");
					    $.ajax({
						type: "POST",
						contentType: "application/json",
						data: "{eventdata:" + JSON.stringify(eventToSave) + "}",
						url: "addJSON",
						dataType: "json",
						success: function (data) {
						    $('div[id*=fullcal]').fullCalendar('renderEvent', event, true);
						    $("#eventToAdd").dialog("close");
						},
						error: function (XMLHttpRequest, textStatus, errorThrown) {
						    debugger;
						}
					    });
				    }
				}
			    });
			},
			selectable: true,
			selectHelper: true,
			select: function(start, end, allDay) {
				var title = prompt('Event Title:');
				if (title) {
					calendar.fullCalendar('renderEvent',
						{
							title: title,
							start: start,
							end: end,
							allDay: allDay
						},
						true // make the event "stick"
					);
				};
				calendar.fullCalendar('unselect');
			},
			editable: true,
			events: {
				url:'list.json',
				ignoreTimezone: false
				},
			header: {
			    left: 'prev,next today',
			    center: 'title',
			    right: 'month,agendaWeek,agendaDay'
			},
			eventRender: function(event, element) {
			    $(element).addClass(event.cssClass);

			    var occurrenceStart = event.occurrenceStart;
			    var occurrenceEnd = event.occurrenceEnd;

			    var data = {id: event.id, occurrenceStart: occurrenceStart, occurrenceEnd: occurrenceEnd};

			    /*$(element).qtip({
				content: {
				    text: 'Loading....',
				    ajax: {
					url: "show",
					type: "GET",
					data: data
				    }
				},
				show: {
				    event: 'click mouseenter',
				    solo: true
				},
				hide: {
				    event: 'unfocus'
				},
				position: {
				    my: 'bottom middle',
				    at: 'top middle',
				    viewport: true
				}
			    });*/
			},
			eventMouseover: function(event, jsEvent, view) {
			    $(this).addClass("active");
			},
			eventMouseout: function(event, jsEvent, view) {
			   $(this).removeClass("active");
			}
		    })
	    });


	</script>

	<div class="nav" role="navigation">
		<ul>
			<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
			<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
		</ul>
	</div>

       <div id='calendar' style="width: 900px;"></div>

	<div id="eventToAdd" style="display: none; font-size: 12px;">
	    Event name:
	    <input id="eventName" type="text" />

	    Event start date:
	    <input id="eventStartDate" type="text" />(MM-dd-yyyy)

	    Event end date:
	    <input id="eventEndDate" type="text" />(MM-dd-yyyy)

	</div>
	
	</body>
</html>
