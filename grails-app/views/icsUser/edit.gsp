
<%@ page import="com.krishna.IcsUser" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'icsUser.label', default: 'IcsUser')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${icsUserInstance}">
            <div class="errors">
                <g:renderErrors bean="${icsUserInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post">
                <g:hiddenField name="id" value="${icsUserInstance?.id}" />
                <g:hiddenField name="version" value="${icsUserInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="username"><g:message code="icsUser.username.label" default="Username" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: icsUserInstance, field: 'username', 'errors')}">
                                    <!--<g:textField name="username" value="${icsUserInstance?.username}" />-->
                                    ${icsUserInstance?.username}
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="linkedid">Linked Individual</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: icsUserInstance, field: 'username', 'errors')}">
                                    <!--<g:textField name="linkedid" value="${linkedid}" />-->
                                    ${linkedIndividual}
                                </td>
                            </tr>
                        
                            <!--<tr class="prop">
                                <td valign="top" class="name">
                                  <label for="password"><g:message code="icsUser.password.label" default="Password" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: icsUserInstance, field: 'password', 'errors')}">
                                    <g:passwordField  name="password" value="${icsUserInstance?.password}" />
                                </td>
                            </tr>-->
                        
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
                                  <label for="authorities"><g:message code="icsUser.authorities.label" default="Ics Role" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: icsUserInstance, field: 'authorities', 'errors')}">
                                    <sec:ifNotGranted roles="ROLE_EVENTADMIN">
					<g:select multiple="multiple" name="roles" from="${com.krishna.IcsRole.list(sort:'authority')}" optionKey="id" value="${roleidList}"  size="10"/>
                                    </sec:ifNotGranted>
                                    <sec:ifAnyGranted roles="ROLE_EVENTADMIN">
					<g:select multiple="multiple" name="roles" from="${com.krishna.IcsRole.findAllByAuthorityLike('%EVENT%',[sort:'authority']) + com.krishna.IcsRole.findAllByAuthorityLike('%COORDINATOR%',[sort:'authority']) + com.krishna.IcsRole.findAllByAuthorityLike('%VIP%',[sort:'authority'])}" optionKey="id" value="${roleidList}"  size="15"/>
                                    </sec:ifAnyGranted>
				</td>
                            </tr>

                        
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
