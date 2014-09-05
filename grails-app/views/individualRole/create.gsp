
<%@ page import="ics.IndividualRole" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'individualRole.label', default: 'IndividualRole')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>

	<gui:resources components="['autoComplete']"/>
	<style>
	.yui-skin-sam .yui-ac-content {
	  width: 350px !important;
	</style>

    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">Home</a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" controller="helper" action="searchIndividualByRole">SearchByRole</g:link></span>            
        </div>
        <div class="body">
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${individualRoleInstance}">
            <div class="errors">
                <g:renderErrors bean="${individualRoleInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="individual"><g:message code="individualRole.individual.label" default="Individual" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: individualRoleInstance, field: 'individual', 'errors')}">
                                    <g:hiddenField  name="individual.id"/>
				       <div style="width: 300px">
					<gui:autoComplete
					    id="acIndividual"
					    width="200px"
					    controller="individual"
					    action="allIndividualsAsJSON"
					    useShadow="true"
					    queryDelay="0.5" minQueryLength='3'
					    />
					    ${individualRoleInstance?.individual}
					    </div>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="role"><g:message code="individualRole.role.label" default="Role" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: individualRoleInstance, field: 'role', 'errors')}">
                                    <g:select name="role.id" from="${ics.Role.list(sort:'name')}"  optionKey="id" value="${individualRoleInstance?.role?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="centre"><g:message code="individualRole.centre.label" default="Centre" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: individualRoleInstance, field: 'centre', 'errors')}">
                                    <g:select name="centre.id" from="${ics.Centre.list(sort:'name')}"  optionKey="id" value="${individualRoleInstance?.centre?.id}"   noSelection="['':'-Choose Centre-']" />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="department"><g:message code="individualRole.department.label" default="Department" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: individualRoleInstance, field: 'department', 'errors')}">
                                    <g:select name="department.id" from="${ics.Department.list(sort:'name')}"  optionKey="id" value="${individualRoleInstance?.department?.id}"  noSelection="['':'-Choose Department-']"/>
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
