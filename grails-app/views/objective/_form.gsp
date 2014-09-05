<%@ page import="ics.Objective" %>



<div class="fieldcontain ${hasErrors(bean: objectiveInstance, field: 'assignedBy', 'error')} ">
	<label for="assignedBy">
		<g:message code="objective.assignedBy.label" default="Assigned By" />
	</label>
	<g:hiddenField name="assignedBy.id" value="" />
	<div style="width: 300px">
		<gui:autoComplete
		id="acassignedBy"
		width="300px"
		controller="individual"
		action="allIndividualsExceptDummyDonorAsJSON"
		useShadow="true"
		queryDelay="0.5" minQueryLength='3'
		/>
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: objectiveInstance, field: 'assignedTo', 'error')} ">
	<label for="assignedTo">
		<g:message code="objective.assignedTo.label" default="Assigned To" />
	</label>
	<g:hiddenField name="assignedTo.id" value="" />
	<div style="width: 300px">
		<gui:autoComplete
		id="acassignedTo"
		width="300px"
		controller="individual"
		action="allIndividualsExceptDummyDonorAsJSON"
		useShadow="true"
		queryDelay="0.5" minQueryLength='3'
		/>
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: objectiveInstance, field: 'category', 'error')} ">
	<label for="category">
		<g:message code="objective.category.label" default="Category" />
		
	</label>
	<g:textField name="category" value="${objectiveInstance?.category}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: objectiveInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="objective.name.label" default="Name" />
		
	</label>
	<g:textField name="name" value="${objectiveInstance?.name}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: objectiveInstance, field: 'description', 'error')} ">
	<label for="description">
		<g:message code="objective.description.label" default="Description" />
		
	</label>
	<g:textField name="description" value="${objectiveInstance?.description}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: objectiveInstance, field: 'objFrom', 'error')} required">
	<label for="objFrom">
		<g:message code="objective.objFrom.label" default="Obj From" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="objFrom" value="${(objectiveInstance?.objFrom)}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: objectiveInstance, field: 'objTo', 'error')} required">
	<label for="objTo">
		<g:message code="objective.objTo.label" default="Obj To" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="objTo" value="${(objectiveInstance?.objTo)}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: objectiveInstance, field: 'comments', 'error')} ">
	<label for="comments">
		<g:message code="objective.comments.label" default="Comments" />
		
	</label>
	<g:textField name="comments" value="${objectiveInstance?.comments}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: objectiveInstance, field: 'creator', 'error')} ">
	<label for="creator">
		<g:message code="objective.creator.label" default="Creator" />
		
	</label>
	<g:textField name="creator" value="${objectiveInstance?.creator}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: objectiveInstance, field: 'updator', 'error')} ">
	<label for="updator">
		<g:message code="objective.updator.label" default="Updator" />
		
	</label>
	<g:textField name="updator" value="${objectiveInstance?.updator}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: objectiveInstance, field: 'isComplete', 'error')} ">
	<label for="isComplete">
		<g:message code="objective.isComplete.label" default="Is Complete" />
		
	</label>
	<g:checkBox name="isComplete" value="${objectiveInstance?.isComplete}" />
</div>

