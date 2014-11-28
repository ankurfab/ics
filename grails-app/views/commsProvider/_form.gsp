<%@ page import="ics.CommsProvider" %>



<div class="fieldcontain ${hasErrors(bean: commsProviderInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="commsProvider.name.label" default="Name" />
		
	</label>
	<g:textField name="name" value="${fieldValue(bean: commsProviderInstance, field: 'name')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: commsProviderInstance, field: 'type', 'error')} ">
	<label for="type">
		<g:message code="commsProvider.type.label" default="Type" />
		
	</label>
	<g:textField name="type" value="${fieldValue(bean: commsProviderInstance, field: 'type')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: commsProviderInstance, field: 'baseUrl', 'error')} ">
	<label for="baseUrl">
		<g:message code="commsProvider.baseUrl.label" default="Base Url" />
		
	</label>
	<g:textField name="baseUrl" value="${fieldValue(bean: commsProviderInstance, field: 'baseUrl')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: commsProviderInstance, field: 'path', 'error')} ">
	<label for="path">
		<g:message code="commsProvider.path.label" default="Path" />
		
	</label>
	<g:textField name="path" value="${fieldValue(bean: commsProviderInstance, field: 'path')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: commsProviderInstance, field: 'query', 'error')} ">
	<label for="query">
		<g:message code="commsProvider.query.label" default="Query" />
		
	</label>
	<g:textField name="query" value="${fieldValue(bean: commsProviderInstance, field: 'query')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: commsProviderInstance, field: 'apikey', 'error')} ">
	<label for="apikey">
		<g:message code="commsProvider.apikey.label" default="Apikey" />
		
	</label>
	<g:textField name="apikey" value="${fieldValue(bean: commsProviderInstance, field: 'apikey')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: commsProviderInstance, field: 'uri', 'error')} ">
	<label for="uri">
		<g:message code="commsProvider.uri.label" default="Uri" />
		
	</label>
	<g:textField name="uri" value="${fieldValue(bean: commsProviderInstance, field: 'uri')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: commsProviderInstance, field: 'user', 'error')} ">
	<label for="user">
		<g:message code="commsProvider.user.label" default="User" />
		
	</label>
	<g:textField name="user" value="${fieldValue(bean: commsProviderInstance, field: 'user')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: commsProviderInstance, field: 'pwd', 'error')} ">
	<label for="pwd">
		<g:message code="commsProvider.pwd.label" default="Pwd" />
		
	</label>
	<g:textField name="pwd" value="${fieldValue(bean: commsProviderInstance, field: 'pwd')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: commsProviderInstance, field: 'host', 'error')} ">
	<label for="host">
		<g:message code="commsProvider.host.label" default="Host" />
		
	</label>
	<g:textField name="host" value="${fieldValue(bean: commsProviderInstance, field: 'host')}" />

</div>

<div class="fieldcontain ${hasErrors(bean: commsProviderInstance, field: 'port', 'error')} ">
	<label for="port">
		<g:message code="commsProvider.port.label" default="Port" />
		
	</label>
	<g:textField name="port" value="${fieldValue(bean: commsProviderInstance, field: 'port')}" />

</div>

