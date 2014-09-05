<%@ page import="ics.Topic" %>



<div class="fieldcontain ${hasErrors(bean: topicInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="topic.name.label" default="Name" />
		
	</label>
	<g:textField name="name" value="${fieldValue(bean: topicInstance, field: 'name')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: topicInstance, field: 'frequency', 'error')} ">
	<label for="frequency">
		<g:message code="topic.frequency.label" default="Frequency" />
		
	</label>
	<g:select name="frequency" from="${topicInstance.constraints.frequency.inList}" value="${topicInstance.frequency}" valueMessagePrefix="topic.frequency"  />

</div>

<div class="fieldcontain ${hasErrors(bean: topicInstance, field: 'viaEmail', 'error')} ">
	<label for="viaEmail">
		<g:message code="topic.viaEmail.label" default="Via Email" />
		
	</label>
	<g:checkBox name="viaEmail" value="${topicInstance?.viaEmail}" />

</div>

<div class="fieldcontain ${hasErrors(bean: topicInstance, field: 'viaSMS', 'error')} ">
	<label for="viaSMS">
		<g:message code="topic.viaSMS.label" default="Via SMS" />
		
	</label>
	<g:checkBox name="viaSMS" value="${topicInstance?.viaSMS}" />

</div>

<div class="fieldcontain ${hasErrors(bean: topicInstance, field: 'viaPost', 'error')} ">
	<label for="viaPost">
		<g:message code="topic.viaPost.label" default="Via Post" />
		
	</label>
	<g:checkBox name="viaPost" value="${topicInstance?.viaPost}" />

</div>

<div class="fieldcontain ${hasErrors(bean: topicInstance, field: 'comments', 'error')} ">
	<label for="comments">
		<g:message code="topic.comments.label" default="Comments" />
		
	</label>
	<g:textField name="comments" value="${fieldValue(bean: topicInstance, field: 'comments')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: topicInstance, field: 'status', 'error')} ">
	<label for="status">
		<g:message code="topic.status.label" default="Status" />
		
	</label>
	<g:select name="status" from="${topicInstance.constraints.status.inList}" value="${topicInstance.status}" valueMessagePrefix="topic.status"  />

</div>

<div class="fieldcontain ${hasErrors(bean: topicInstance, field: 'subscribers', 'error')} ">
	<label for="subscribers">
		<g:message code="topic.subscribers.label" default="Subscribers" />
		
	</label>
	
<ul>
<g:each in="${topicInstance?.subscribers}" var="topicSubscriptionInstance">
    <li><g:link controller="topicSubscription" action="show" id="${topicSubscriptionInstance.id}">${topicSubscriptionInstance?.encodeAsHTML()}</g:link></li>
</g:each>
</ul>
<g:link controller="topicSubscription" params="['topic.id': topicInstance?.id]" action="create"><g:message code="topicSubscription.new" default="New TopicSubscription" /></g:link>


</div>

