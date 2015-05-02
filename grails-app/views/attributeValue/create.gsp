
<%@ page import="ics.AttributeValue" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="attributeValue.create" default="Create AttributeValue" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="attributeValue.list" default="AttributeValue List" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="attributeValue.create" default="Create AttributeValue" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:hasErrors bean="${attributeValueInstance}">
            <div class="errors">
                <g:renderErrors bean="${attributeValueInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="attribute"><g:message code="attributeValue.attribute" default="Attribute" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: attributeValueInstance, field: 'attribute', 'errors')}">
                                    <g:select name="attribute.id" from="${ics.Attribute.list()}" optionKey="id" value="${attributeValueInstance?.attribute?.id}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="creator"><g:message code="attributeValue.creator" default="Creator" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: attributeValueInstance, field: 'creator', 'errors')}">
                                    <g:textField name="creator" value="${fieldValue(bean: attributeValueInstance, field: 'creator')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="dateCreated"><g:message code="attributeValue.dateCreated" default="Date Created" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: attributeValueInstance, field: 'dateCreated', 'errors')}">
                                    <g:datePicker name="dateCreated" value="${attributeValueInstance?.dateCreated}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="lastUpdated"><g:message code="attributeValue.lastUpdated" default="Last Updated" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: attributeValueInstance, field: 'lastUpdated', 'errors')}">
                                    <g:datePicker name="lastUpdated" value="${attributeValueInstance?.lastUpdated}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="objectClassName"><g:message code="attributeValue.objectClassName" default="Object Class Name" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: attributeValueInstance, field: 'objectClassName', 'errors')}">
                                    <g:textField name="objectClassName" value="${fieldValue(bean: attributeValueInstance, field: 'objectClassName')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="objectId"><g:message code="attributeValue.objectId" default="Object Id" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: attributeValueInstance, field: 'objectId', 'errors')}">
                                    <g:textField name="objectId" value="${fieldValue(bean: attributeValueInstance, field: 'objectId')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="updator"><g:message code="attributeValue.updator" default="Updator" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: attributeValueInstance, field: 'updator', 'errors')}">
                                    <g:textField name="updator" value="${fieldValue(bean: attributeValueInstance, field: 'updator')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="value"><g:message code="attributeValue.value" default="Value" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: attributeValueInstance, field: 'value', 'errors')}">
                                    <g:textField name="value" value="${fieldValue(bean: attributeValueInstance, field: 'value')}" />

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
