<%@ page import="ics.IndividualSkill" %>



<div class="fieldcontain ${hasErrors(bean: individualSkillInstance, field: 'individual', 'error')} required">
	<label for="individual">
		<g:message code="individualSkill.individual.label" default="Individual" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="individual" name="individual.id" from="${ics.Individual.list()}" optionKey="id" required="" value="${individualSkillInstance?.individual?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: individualSkillInstance, field: 'skill', 'error')} required">
	<label for="skill">
		<g:message code="individualSkill.skill.label" default="Skill" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="skill" name="skill.id" from="${ics.Skill.list()}" optionKey="id" required="" value="${individualSkillInstance?.skill?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: individualSkillInstance, field: 'status', 'error')} ">
	<label for="status">
		<g:message code="individualSkill.status.label" default="Status" />
		
	</label>
	<g:textField name="status" value="${individualSkillInstance?.status}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: individualSkillInstance, field: 'comments', 'error')} ">
	<label for="comments">
		<g:message code="individualSkill.comments.label" default="Comments" />
		
	</label>
	<g:textField name="comments" value="${individualSkillInstance?.comments}"/>
</div>

