
<%@ page import="ics.District" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="district.edit" default="Edit District" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="district.list" default="District List" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="district.new" default="New District" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="district.edit" default="Edit District" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:hasErrors bean="${districtInstance}">
            <div class="errors">
                <g:renderErrors bean="${districtInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${districtInstance?.id}" />
                <g:hiddenField name="version" value="${districtInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="name"><g:message code="district.name" default="Name" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: districtInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" value="${fieldValue(bean: districtInstance, field: 'name')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="talukas"><g:message code="district.talukas" default="Talukas" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: districtInstance, field: 'talukas', 'errors')}">
                                    
<ul>
<g:each in="${districtInstance?.talukas}" var="talukaInstance">
    <li><g:link controller="taluka" action="show" id="${talukaInstance.id}">${talukaInstance?.encodeAsHTML()}</g:link></li>
</g:each>
</ul>
<g:link controller="taluka" params="['district.id': districtInstance?.id]" action="create"><g:message code="taluka.new" default="New Taluka" /></g:link>


                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'update', 'default': 'Update')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'delete', 'default': 'Delete')}" onclick="return confirm('${message(code: 'delete.confirm', 'default': 'Are you sure?')}');" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
