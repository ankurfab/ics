<%@ page import="ics.Individual" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'individual.label', default: 'Individual')}" />
        <title>Add Profile</title>
    </head>
  
  <body>
  <div class="nav">
              <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
        </div>
    <g:if test="${flash.message}">
    <div class="message">${flash.message}</div>
    </g:if>
   <div>
  <g:form action="saveTempProfile" method="post" onsubmit="return validate();" enctype="multipart/form-data">
  <g:hiddenField name="type" value="${type}" />
  <table border="0" cellspacing="0" cellpadding="0">
	<tbody bgcolor="lavender">

	<tr>
	    <td valign="top" width="10%">
	    <label for="legalName"><b><g:message code="individual.legalName.label" default="Legal Name" /></b></label>*
	    </td>

	    <td valign="top" class="value ${hasErrors(bean: individualInstance, field: 'legalName', 'errors')}" width="60%">
		<g:textField name="legalName" size="110" maxlength="127" value="${individualInstance?.legalName}" required="required"/>
	    </td>
	</tr>
	<tr>
		<td valign="top" width="10%">
		    <label for="initiatedName"><b><g:message code="individual.initiatedName.label" default="Initiated Name" /></b></label>
		    </td>

		    <td valign="top" class="value ${hasErrors(bean: individualInstance, field: 'initiatedName', 'errors')}" width="60%">
			<g:textField name="initiatedName" size="110" maxlength="127" value="${individualInstance?.initiatedName}" />
		</td>
	</tr>
	<tr>
		<td valign="top" width="10%">
		    <b>Phone</b>*
		    </td>

		    <td valign="top" class="value" width="60%">
			<g:textField name="phone" size="10" maxlength="10" value="" pattern="[0-9]{10,10}" required="required"/>
		</td>
	</tr>
	</tbody>
  </table>
  <div class="buttons">
  					<span class="button"><g:submitButton name="create" class="save" value="Add" /></span>
				</div>
  </g:form>
  </div>
  
  </body>
  
  
  </html>