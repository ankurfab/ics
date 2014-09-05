<%@ page import="ics.IndividualCentre" %>

	<script>
	$(function() {
		$( "#ind" ).autocomplete({
			source: "${createLink(controller:'individual',action:'allIndividualsAsJSON_JQ')}",//todo take care of data from other departments
			minLength: 0,
			  select: function(event, ui) { // event handler when user selects a company from the list.
			   $("#individual\\.id").val(ui.item.id); // update the hidden field.
			  }
		});
	});
	</script>


<div class="fieldcontain ${hasErrors(bean: individualCentreInstance, field: 'individual', 'error')} required">
	<label for="individual">
		<g:message code="individualCentre.individual.label" default="Individual" />
		<span class="required-indicator">*</span>
	</label>
                                    <g:hiddenField name="individual.id" value="${individualCentreInstance?.individual?.id}"/>
                                    <input id="ind" value="${individualCentreInstance?.individual}"/>
	
</div>

<div class="fieldcontain ${hasErrors(bean: individualCentreInstance, field: 'centre', 'error')} required">
	<label for="centre">
		<g:message code="individualCentre.centre.label" default="Centre" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="centre" name="centre.id" from="${ics.Centre.list(sort: "name")}" optionKey="id" required="" value="${individualCentreInstance?.centre?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: individualCentreInstance, field: 'status', 'error')} ">
	<label for="status">
		<g:message code="individualCentre.status.label" default="Status" />
		
	</label>
	<g:textField name="status" value="${individualCentreInstance?.status}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: individualCentreInstance, field: 'comments', 'error')} ">
	<label for="comments">
		<g:message code="individualCentre.comments.label" default="Comments" />
		
	</label>
	<g:textField name="comments" value="${individualCentreInstance?.comments}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: individualCentreInstance, field: 'creator', 'error')} ">
	<label for="creator">
		<g:message code="individualCentre.creator.label" default="Creator" />
		
	</label>
	<g:textField name="creator" value="${individualCentreInstance?.creator}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: individualCentreInstance, field: 'updator', 'error')} ">
	<label for="updator">
		<g:message code="individualCentre.updator.label" default="Updator" />
		
	</label>
	<g:textField name="updator" value="${individualCentreInstance?.updator}"/>
</div>

