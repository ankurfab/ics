<%@ page import="ics.CostCenterGroup" %>
<div class="allbody"> 
<g:hiddenField name="id" value="${costCenterGroupInstance?.id}" />
<g:hiddenField name="version" value="${costCenterGroupInstance?.version}" />

<fieldset class="form">

<div class="fieldcontain ${hasErrors(bean: costCenterGroupInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="costCenterGroup.name.label" default="Name" />
		
	</label>
	<g:textField name="name" value="${costCenterGroupInstance?.name}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: costCenterGroupInstance, field: 'description', 'error')} ">
	<label for="description">
		<g:message code="costCenterGroup.description.label" default="Description" />
		
	</label>
	<g:textField name="description" value="${costCenterGroupInstance?.description}"/>
</div>

<div>
	<label for="loginid">
		Loginid
		
	</label>
	<g:textField name="loginid" value=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: costCenterGroupInstance, field: 'owner1', 'error')} ">
	<label for="owner1">
		<g:message code="costCenterGroup.owner1.label" default="Owner" />
		
	</label>
	    <g:hiddenField name="owner1.id" value=""/>
	    <input id="ind1" size="40" />
	
</div>


</fieldset>

</div>

<script>
$(function() {
	$( "#ind1" ).autocomplete({
		source: "${createLink(controller:'individual',action:'allIndividualsAsJSON_JQ')}",//todo take care of data from other departments
		minLength: 3,
		  select: function(event, ui) { // event handler when user selects a company from the list.
		   $(document.getElementById('owner1.id')).val(ui.item.id); // update the hidden field.
		  }
	});
});
</script>
