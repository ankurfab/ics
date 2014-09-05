<%@ page import="ics.CommsProvider" %>



<div class="fieldcontain ${hasErrors(bean: commsProviderInstance, field: 'type', 'error')} ">
	<label for="type">
		<g:message code="commsProvider.type.label" default="Type" />
		
	</label>
	<g:textField name="type" value="${fieldValue(bean: commsProviderInstance, field: 'type')}" />

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

<div class="fieldcontain ${hasErrors(bean: commsProviderInstance, field: 'apikey', 'error')} ">
	<label for="apikey">
		<g:message code="commsProvider.apikey.label" default="Apikey" />
		
	</label>
	<g:textField name="apikey" value="${fieldValue(bean: commsProviderInstance, field: 'apikey')}" />

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

