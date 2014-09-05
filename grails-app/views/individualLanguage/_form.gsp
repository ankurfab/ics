<%@ page import="ics.IndividualLanguage" %>



<div class="fieldcontain ${hasErrors(bean: individualLanguageInstance, field: 'creator', 'error')} ">
	<label for="creator">
		<g:message code="individualLanguage.creator.label" default="Creator" />
		
	</label>
	<g:textField name="creator" value="${individualLanguageInstance?.creator}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: individualLanguageInstance, field: 'individual', 'error')} required">
	<label for="individual">
		<g:message code="individualLanguage.individual.label" default="Individual" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="individual" name="individual.id" from="${ics.Individual.list()}" optionKey="id" required="" value="${individualLanguageInstance?.individual?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: individualLanguageInstance, field: 'language', 'error')} required">
	<label for="language">
		<g:message code="individualLanguage.language.label" default="Language" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="language" name="language.id" from="${ics.Language.list()}" optionKey="id" required="" value="${individualLanguageInstance?.language?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: individualLanguageInstance, field: 'motherTongue', 'error')} ">
	<label for="motherTongue">
		<g:message code="individualLanguage.motherTongue.label" default="Mother Tongue" />
		
	</label>
	<g:checkBox name="motherTongue" value="${individualLanguageInstance?.motherTongue}" />
</div>

<div class="fieldcontain ${hasErrors(bean: individualLanguageInstance, field: 'readFluency', 'error')} required">
	<label for="readFluency">
		<g:message code="individualLanguage.readFluency.label" default="Read Fluency" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="readFluency" required="" value="${fieldValue(bean: individualLanguageInstance, field: 'readFluency')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: individualLanguageInstance, field: 'updator', 'error')} ">
	<label for="updator">
		<g:message code="individualLanguage.updator.label" default="Updator" />
		
	</label>
	<g:textField name="updator" value="${individualLanguageInstance?.updator}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: individualLanguageInstance, field: 'writeFluency', 'error')} required">
	<label for="writeFluency">
		<g:message code="individualLanguage.writeFluency.label" default="Write Fluency" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="number" name="writeFluency" required="" value="${fieldValue(bean: individualLanguageInstance, field: 'writeFluency')}"/>
</div>

