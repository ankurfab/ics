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

<div class="fieldcontain ${hasErrors(bean: costCenterGroupInstance, field: 'owner', 'error')} ">
	<label for="owner">
		<g:message code="costCenterGroup.owner.label" default="Owner" />
		
	</label>
	    <g:hiddenField name="owner.id" value=""/>
	    <input id="ind" size="40" />
	
</div>

<div>
	<label for="ccids">
		Cost Centers		
	</label>
	<g:select name="ccids"
          from="${ics.CostCenter.findAllByCostCenterGroupIsNull([sort:'name'])}"
	  noSelection="${['null':'Select departments...']}"
          optionKey="id"
          optionValue="name"
          multiple="true" size="25"/>	
</div>


</fieldset>

</div>

	<script>
	$(function() {
		$( "#ind" ).autocomplete({
			source: "${createLink(controller:'individual',action:'allIndividualsAsJSON_JQ')}",//todo take care of data from other departments
			minLength: 3,
			  select: function(event, ui) { // event handler when user selects a company from the list.
			   $(document.getElementById('owner.id')).val(ui.item.id); // update the hidden field.
			  }
		});
	});
	</script>
