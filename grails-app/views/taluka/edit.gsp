
<%@ page import="ics.Taluka" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="taluka.edit" default="Edit Taluka" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="taluka.list" default="Taluka List" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="taluka.new" default="New Taluka" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="taluka.edit" default="Edit Taluka" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:hasErrors bean="${talukaInstance}">
            <div class="errors">
                <g:renderErrors bean="${talukaInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${talukaInstance?.id}" />
                <g:hiddenField name="version" value="${talukaInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="name"><g:message code="taluka.name" default="Name" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: talukaInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" value="${fieldValue(bean: talukaInstance, field: 'name')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="district"><g:message code="taluka.district" default="District" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: talukaInstance, field: 'district', 'errors')}">
                                    <g:select name="district.id" from="${ics.District.list()}" optionKey="id" value="${talukaInstance?.district?.id}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="villages"><g:message code="taluka.villages" default="Villages" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: talukaInstance, field: 'villages', 'errors')}">
                                    
<ul>
<g:each in="${talukaInstance?.villages}" var="villageInstance">
    <li><g:link controller="village" action="show" id="${villageInstance.id}">${villageInstance?.encodeAsHTML()}</g:link></li>
</g:each>
</ul>
<g:link controller="village" params="['taluka.id': talukaInstance?.id]" action="create"><g:message code="village.new" default="New Village" /></g:link>


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
