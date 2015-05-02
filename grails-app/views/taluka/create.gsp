
<%@ page import="ics.Taluka" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="taluka.create" default="Create Taluka" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="taluka.list" default="Taluka List" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="taluka.create" default="Create Taluka" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:hasErrors bean="${talukaInstance}">
            <div class="errors">
                <g:renderErrors bean="${talukaInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
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
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'create', 'default': 'Create')}" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
