<%@ page import="ics.BookRead" %>



<div class="fieldcontain ${hasErrors(bean: bookReadInstance, field: 'individual', 'error')} required">
	<label for="individual">
		<g:message code="bookRead.individual.label" default="Individual" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="individual" name="individual.id" from="${ics.Individual.list()}" optionKey="id" required="" value="${bookReadInstance?.individual?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: bookReadInstance, field: 'book', 'error')} required">
	<label for="book">
		<g:message code="bookRead.book.label" default="Book" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="book" name="book.id" from="${ics.Book.list()}" optionKey="id" required="" value="${bookReadInstance?.book?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: bookReadInstance, field: 'creator', 'error')} ">
	<label for="creator">
		<g:message code="bookRead.creator.label" default="Creator" />
		
	</label>
	<g:textField name="creator" value="${bookReadInstance?.creator}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: bookReadInstance, field: 'updator', 'error')} ">
	<label for="updator">
		<g:message code="bookRead.updator.label" default="Updator" />
		
	</label>
	<g:textField name="updator" value="${bookReadInstance?.updator}"/>
</div>

