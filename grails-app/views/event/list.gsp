
<%@ page import="ics.Event" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'event.label', default: 'Event')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
	<r:require module="fullCalendar" />
	<r:require module="qtip" />
    </head>
    <body>
	<script>
		$(document).ready(function() {
		    $("#calendar").fullCalendar({
			
			events: {
				url:'list.json',
				ignoreTimezone: false
				},
			header: {
			    left: 'prev,next today',
			    center: 'title',
			    right: 'year,month,agendaWeek,agendaDay'
			},
			eventRender: function(event, element) {
			    $(element).addClass(event.cssClass);

			    var occurrenceStart = event.occurrenceStart;
			    var occurrenceEnd = event.occurrenceEnd;

			    var data = {id: event.id, occurrenceStart: occurrenceStart, occurrenceEnd: occurrenceEnd};

			    $(element).qtip({
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
			    });
			},
			eventMouseover: function(event, jsEvent, view) {
			    $(this).addClass("active");
			},
			eventMouseout: function(event, jsEvent, view) {
			   $(this).removeClass("active");
			}
		    });

		$( "#btn_createEvent" )
			.click(function() {
					$( "#dialogCreateEvent" ).dialog( "open" );
			});
		$( "#dialogCreateEvent" ).dialog({
			autoOpen: false,
			height: 300,
			width: 350,
			modal: true,
			buttons: {
				"Followup": function() {
					var description = $('#desc').val();
					var idlist = jQuery("#individual_list").jqGrid('getGridParam','selarrrow')
					//alert(description);
					//alert("clicked:"+idlist);	// & -> "\u0026"
					
					var url = "${createLink(controller:'followup',action:'save')}"
					//alert(url);
					$('#dialog-form').load(url,{'ids':""+idlist,'comments':description})
					
						$( this ).dialog( "close" );
				},
				Cancel: function() {
					$( this ).dialog( "close" );
				}
			},
			close: function() {
				
			}
		});
		    
	    });


	</script>
        <div class="nav">
	    <sec:ifAnyGranted roles="ROLE_ADMIN,ROLE_COUNSELLOR,ROLE_EVENTADMIN,ROLE_EVENT_MGR,ROLE_KITCHEN_ADMIN,ROLE_NVCC_ADMIN,ROLE_TMC,ROLE_VOICE_ADMIN">
            	<!--<input class="menuButton" type="BUTTON" id="btn_createEvent" value="New Event" />-->
                <span class="menuButton"><g:link class="list" action="gridlist">GridView</g:link></span>
            	<span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
            </sec:ifAnyGranted>
        </div>
        <div class="body">
            
            <div id='calendar'></div>

		<div id="dialogCreateEvent" title="Create Event">
			<form>
			<fieldset>
				<label for="desc">Comments</nlabel>
				<textarea rows="2" cols="20" name="description" id="desc" class="text ui-widget-content ui-corner-all"></textarea> 
				
			</fieldset>
			</form>
		</div>
            
    </body>
</html>
