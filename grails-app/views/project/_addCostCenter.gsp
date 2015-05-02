<%@ page import="ics.CostCenter" %>
<div class="allbody"> 
<g:hiddenField name="id" value="${costCenterInstance?.id}" />
<g:hiddenField name="version" value="${costCenterInstance?.version}" />

<!-- name	alias	cg_id	ccat_id	loginid	owner_icsid -->

<fieldset class="form">
<div class="fieldcontain ${hasErrors(bean: costCenterInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="costCenter.name.label" default="Name" />
		
	</label>
	<g:textField name="name" value="${costCenterInstance?.name}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: costCenterInstance, field: 'alias', 'error')} ">
	<label for="alias">
		<g:message code="costCenter.alias.label" default="Alias" />
		
	</label>
	<g:textField name="alias" value="${costCenterInstance?.alias}"/>
</div>

<div>
	<label for="cg_id">Vertical</label>
	<g:select id="cg_id" name='cg_id' value=""
	    from='${ics.CostCenterGroup.list([sort:'name'])}'
	    optionKey="id" optionValue="name"></g:select>
</div>

<div>
	<label for="ccat_id">Cost Category</label>
	<g:select id="ccat_id" name='ccat_id' value=""
	    from='${ics.CostCategory.list([sort:'name'])}'
	    optionKey="id" optionValue="name"></g:select>
</div>

<div>
	<label for="loginid">
		Loginid
		
	</label>
	<g:textField name="loginid" value=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: costCenterInstance, field: 'owner1', 'error')} ">
	<label for="owner1">
		<g:message code="costCenter.owner1.label" default="Owner" />
		
	</label>
	    <g:hiddenField name="owner1.id" value=""/>
	    <input id="ind" size="40" />
	
</div>

</fieldset>

</div>

<script>
$(function() {
	$( "#ind" ).autocomplete({
		source: "${createLink(controller:'individual',action:'allIndividualsAsJSON_JQ')}",//todo take care of data from other departments
		minLength: 3,
		  select: function(event, ui) { // event handler when user selects a company from the list.
		   $(document.getElementById('owner1.id')).val(ui.item.id); // update the hidden field.
		  }
	});
});
</script>
