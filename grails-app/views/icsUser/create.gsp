
<%@ page import="com.krishna.IcsUser" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'icsUser.label', default: 'IcsUser')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
	<r:require module="jqui" />
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">

	<script>
	$(function() {
		$( "#ind" ).autocomplete({
			source: "${createLink(controller:'individual',action:'allIndividualsWithNoLoginIdAsJSON_JQ')}",//todo take care of data from other departments
			minLength: 0,
			  select: function(event, ui) { // event handler when user selects a company from the list.
			   $("#linkedid").val(ui.item.id); // update the hidden field.
			  }
		});
	});
	</script>

            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${icsUserInstance}">
            <div class="errors">
                <g:renderErrors bean="${icsUserInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" onsubmit="return validate();">

                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="linkedIndividual">Linked Individual</label>*
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: icsUserInstance, field: 'linkedIndividual', 'errors')}">
                                    <g:hiddenField name="linkedid" value=""/>
                                    <g:hiddenField name="indname" value=""/>
                                    <input id="ind" size="40" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="username"><g:message code="icsUser.username.label" default="Username" /></label>*
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: icsUserInstance, field: 'username', 'errors')}">
                                    <g:textField name="username" id="username" value="${icsUserInstance?.username}" />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="password"><g:message code="icsUser.password.label" default="Password" /></label>*
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: icsUserInstance, field: 'password', 'errors')}">
                                    <g:passwordField  name="password" value="${icsUserInstance?.password}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="enabled"><g:message code="icsUser.enabled.label" default="Enabled" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: icsUserInstance, field: 'enabled', 'errors')}">
                                    <g:checkBox name="enabled" value="${icsUserInstance?.enabled}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="passwordExpired"><g:message code="icsUser.passwordExpired.label" default="Password Expired" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: icsUserInstance, field: 'passwordExpired', 'errors')}">
                                    <g:checkBox name="passwordExpired" value="${icsUserInstance?.passwordExpired}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="accountExpired"><g:message code="icsUser.accountExpired.label" default="Account Expired" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: icsUserInstance, field: 'accountExpired', 'errors')}">
                                    <g:checkBox name="accountExpired" value="${icsUserInstance?.accountExpired}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="accountLocked"><g:message code="icsUser.accountLocked.label" default="Account Locked" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: icsUserInstance, field: 'accountLocked', 'errors')}">
                                    <g:checkBox name="accountLocked" value="${icsUserInstance?.accountLocked}" />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="icsRole"><g:message code="icsUserIcsRole.icsRole.label" default="Ics Role" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: icsUserIcsRoleInstance, field: 'icsRole', 'errors')}">
                                    <sec:ifNotGranted roles="ROLE_EVENTADMIN">
                                    	<g:select multiple="multiple" name="roles" from="${com.krishna.IcsRole.list(sort:'authority')}" optionKey="id" value="${icsUserIcsRoleInstance?.icsRole?.id}"  size="10"/>
                                    </sec:ifNotGranted>
                                    <sec:ifAnyGranted roles="ROLE_EVENTADMIN">
                                    	<g:select multiple="multiple" name="roles" from="${com.krishna.IcsRole.findAllByAuthorityLike('%EVENT%',[sort:'authority']) + com.krishna.IcsRole.findAllByAuthorityLike('%COORDINATOR%',[sort:'authority']) + com.krishna.IcsRole.findAllByAuthorityLike('%VIP%',[sort:'authority']) + com.krishna.IcsRole.findAllByAuthorityLike('%RVTO%',[sort:'authority'])+ com.krishna.IcsRole.findAllByAuthorityLike('%INCHARGE%',[sort:'authority'])}" optionKey="id" value="${icsUserIcsRoleInstance?.icsRole?.id}"  size="15"/>
                                    </sec:ifAnyGranted>
                                </td>
                            </tr>

                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
            </g:form>
            <script language="javascript"> 
				function validate() {  
				
					if (document.getElementByName('username').value=="")
					{
						alert("Please provide User Name!!");
						document.getElementById('username').focus();
						return false;
					}

					if (document.getElementById("acLinkedIndividual").value=='')
					{
						alert("Please provide Linked Individual Name!!");
						document.getElementById('acLinkedIndividual').focus();
						return false;
					}

					if (document.getElementById("password").value=='')
					{
						alert("Please provide Password!!");
						document.getElementById('password').focus();
						return false;
					}
					return true;
				}
            </script>
        </div>
    </body>
</html>
