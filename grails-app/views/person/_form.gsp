<%@ page import="ics.Person" %>

<table>
<tr>
<div class="fieldcontain ${hasErrors(bean: personInstance, field: 'name', 'error')} ">
	<td>
	<label for="name">
		<g:message code="person.name.label" default="Name" />
		
	</label>
	</td>
	<td>
	<g:textField name="name" value="${personInstance?.name}"/>
	</td>
</div>
</tr>
<tr>
<div class="fieldcontain ${hasErrors(bean: personInstance, field: 'address', 'error')} ">
	<td>
	<label for="address">
		<g:message code="person.address.label" default="Address" />
		
	</label>
	</td>
	<td>
	<g:textField name="address" value="${personInstance?.address}"/>
	</td>
</div>
</tr>
<tr>
<div class="fieldcontain ${hasErrors(bean: personInstance, field: 'officeAddress', 'error')} ">
	<td>
	<label for="officeAddress">
		<g:message code="person.officeAddress.label" default="Office Address" />
		
	</label>
	</td>
	<td>
	<g:textField name="officeAddress" value="${personInstance?.officeAddress}"/>
	</td>
</div>
</tr>
<tr>
<div class="fieldcontain ${hasErrors(bean: personInstance, field: 'locality', 'error')} ">
	<td>
	<label for="locality">
		<g:message code="person.locality.label" default="Locality" />
		
	</label>
	</td>
	<td>
	<g:textField name="locality" value="${personInstance?.locality}"/>
	</td>
</div>
</tr>
<tr>
<div class="fieldcontain ${hasErrors(bean: personInstance, field: 'phone', 'error')} ">
	<td>	
	<label for="phone">
		<g:message code="person.phone.label" default="Phone" />
		
	</label>
	</td>
	<td>
	<g:textField name="phone" value="${personInstance?.phone}"/>
	</td>
</div>
</tr>
<tr>
<div class="fieldcontain ${hasErrors(bean: personInstance, field: 'email', 'error')} ">
	<td>
	<label for="email">
		<g:message code="person.email.label" default="Email" />
		
	</label>
	</td>
	<td>
	<g:textField name="email" value="${personInstance?.email}"/>
	</td>
</div>
</tr>
<tr>
<div class="fieldcontain ${hasErrors(bean: personInstance, field: 'lmno', 'error')} ">
	<td>
	<label for="lmno">
		<g:message code="person.lmno.label" default="Lmno" />
		
	</label>
	</td>
	<td>
	<g:textField name="lmno" value="${personInstance?.lmno}"/>
	</td>
</div>
</tr>
<tr>
<div class="fieldcontain ${hasErrors(bean: personInstance, field: 'panno', 'error')} ">
	<td>
	<label for="panno">
		<g:message code="person.panno.label" default="Panno" />
		
	</label>
	</td>
	<td>
	<g:textField name="panno" value="${personInstance?.panno}"/>
	</td>
</div>
</tr>
<tr>
<div class="fieldcontain ${hasErrors(bean: personInstance, field: 'dob', 'error')} ">
	<td>
	<label for="dob">
		<g:message code="person.dob.label" default="Dob" />
		
	</label>
	</td>
	<td>
	<!--<g:datePicker name="dob" precision="day"  value="${personInstance?.dob}" default="none" noSelection="['': '']" />-->
		<g:textField name="dob" value="${personInstance?.dob?.format('dd-MM-yyyy')}" size="8" />

	</td>
</div>
</tr>
<tr>
<div class="fieldcontain ${hasErrors(bean: personInstance, field: 'dom', 'error')} ">
	<td>
	<label for="dom">
		<g:message code="person.dom.label" default="Dom" />
		
	</label>
	</td>
	<td>
	<!--<g:datePicker name="dom" precision="day"  value="${personInstance?.dom}" default="none" noSelection="['': '']" />-->
		<g:textField name="dom" value="${personInstance?.dom?.format('dd-MM-yyyy')}" size="8" />
	
	</td>
</div>
</tr>
<tr>
<div class="fieldcontain ${hasErrors(bean: personInstance, field: 'isDonor', 'error')} ">
	<td>
	<label for="isDonor">
		<g:message code="person.isDonor.label" default="Is Donor" />
		
	</label>
	</td>
	<td>
	<g:checkBox name="isDonor" value="${personInstance?.isDonor}" />
	</td>
</div>
</tr>
<tr>
<div class="fieldcontain ${hasErrors(bean: personInstance, field: 'comments', 'error')} ">
	<td>
	<label for="comments">
		<g:message code="person.comments.label" default="Comments" />
		
	</label>
	</td>
	<td>
	<g:textField name="comments" value="${personInstance?.comments}"/>
	</td>
</div>
</tr>
</table>