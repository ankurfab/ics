<%@ page import="ics.Book" %>



<div class="fieldcontain ${hasErrors(bean: bookInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="book.name.label" default="Name" />
		
	</label>
	<g:textField name="name" value="${bookInstance?.name}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: bookInstance, field: 'author', 'error')} ">
	<label for="author">
		<g:message code="book.author.label" default="Author" />
		
	</label>
	<g:textField name="author" value="${bookInstance?.author}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: bookInstance, field: 'category', 'error')} ">
	<label for="category">
		<g:message code="book.category.label" default="Category" />
		
	</label>
	<g:textField name="category" value="${bookInstance?.category}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: bookInstance, field: 'creator', 'error')} ">
	<label for="creator">
		<g:message code="book.creator.label" default="Creator" />
		
	</label>
	<g:textField name="creator" value="${bookInstance?.creator}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: bookInstance, field: 'updator', 'error')} ">
	<label for="updator">
		<g:message code="book.updator.label" default="Updator" />
		
	</label>
	<g:textField name="updator" value="${bookInstance?.updator}"/>
</div>

