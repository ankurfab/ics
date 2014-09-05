

<%@ page import="ics.Flags" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'flags.label', default: 'Flags')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${flagsInstance}">
            <div class="errors">
                <g:renderErrors bean="${flagsInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="individualid">Individual</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: flagsInstance, field: 'individualid', 'errors')}">
                                    <!--<g:textField name="individualid" value="${fieldValue(bean: flagsInstance, field: 'individualid')}" />-->
			                <g:hiddenField name="individualid" value="${flagsInstance?.individualid}" />
                                    ${ics.Individual.get(flagsInstance?.individualid)}
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="address"><g:message code="flags.address.label" default="Address" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: flagsInstance, field: 'address', 'errors')}">
                                    <g:checkBox name="address" value="${flagsInstance?.address}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="email"><g:message code="flags.email.label" default="Email" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: flagsInstance, field: 'email', 'errors')}">
                                    <g:checkBox name="email" value="${flagsInstance?.email}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="folk"><g:message code="flags.folk.label" default="Folk" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: flagsInstance, field: 'folk', 'errors')}">
                                    <g:checkBox name="folk" value="${flagsInstance?.folk}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="formSign"><g:message code="flags.formSign.label" default="Form Sign" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: flagsInstance, field: 'formSign', 'errors')}">
                                    <g:checkBox name="formSign" value="${flagsInstance?.formSign}" />
                                </td>
                            </tr>
                        
                            <!--<tr class="prop">
                                <td valign="top" class="name">
                                    <label for="isFormComplete"><g:message code="flags.isFormComplete.label" default="Is Form Complete" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: flagsInstance, field: 'isFormComplete', 'errors')}">
                                    <g:checkBox name="isFormComplete" value="${flagsInstance?.isFormComplete}" />
                                </td>
                            </tr>-->
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="mobileNo"><g:message code="flags.mobileNo.label" default="Mobile No" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: flagsInstance, field: 'mobileNo', 'errors')}">
                                    <g:checkBox name="mobileNo" value="${flagsInstance?.mobileNo}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="panno"><g:message code="flags.panno.label" default="Panno" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: flagsInstance, field: 'panno', 'errors')}">
                                    <g:checkBox name="panno" value="${flagsInstance?.panno}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="photo"><g:message code="flags.photo.label" default="Photo" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: flagsInstance, field: 'photo', 'errors')}">
                                    <g:checkBox name="photo" value="${flagsInstance?.photo}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="printLabelFlag"><g:message code="flags.printLabelFlag.label" default="Print Label Flag" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: flagsInstance, field: 'printLabelFlag', 'errors')}">
                                    <g:checkBox name="printLabelFlag" value="${flagsInstance?.printLabelFlag}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="sevakType"><g:message code="flags.sevakType.label" default="Sevak Type" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: flagsInstance, field: 'sevakType', 'errors')}">
                                    <g:checkBox name="sevakType" value="${flagsInstance?.sevakType}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="telephoneNo"><g:message code="flags.telephoneNo.label" default="Telephone No" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: flagsInstance, field: 'telephoneNo', 'errors')}">
                                    <g:checkBox name="telephoneNo" value="${flagsInstance?.telephoneNo}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="wallName"><g:message code="flags.wallName.label" default="Wall Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: flagsInstance, field: 'wallName', 'errors')}">
                                    <g:checkBox name="wallName" value="${flagsInstance?.wallName}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="nameOnWall"><g:message code="flags.nameOnWall.label" default="Name On Wall" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: flagsInstance, field: 'nameOnWall', 'errors')}">
                                    <g:textField name="nameOnWall" value="${flagsInstance?.nameOnWall}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="nomineeName"><g:message code="flags.nomineeName.label" default="Nominee Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: flagsInstance, field: 'nomineeName', 'errors')}">
                                    <g:textField name="nomineeName" value="${flagsInstance?.nomineeName}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="schemeid"><g:message code="flags.schemeid.label" default="Schemeid" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: flagsInstance, field: 'schemeid', 'errors')}">
                                    <g:select name="schemeid" from="${ics.Scheme.list(sort:'name')}" optionKey="id" value="${flagsInstance?.schemeid}" noSelection="['0': '--Select Scheme--']" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="formstatus"><g:message code="flags.formstatus.label" default="FormStatus" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: flagsInstance, field: 'formstatus', 'errors')}">
                                    <g:select name="formstatus" from="${['Form Complete','Form Incomplete','Form not filled','Form to be corrected']}" value="${flagsInstance?.formstatus}" noSelection="['': '--Select Form Status--']" />
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
