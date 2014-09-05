
<%@ page import="ics.Topic" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="topic.edit" default="Edit Topic" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="topic.list" default="Topic List" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="topic.new" default="New Topic" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="topic.edit" default="Edit Topic" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:hasErrors bean="${topicInstance}">
            <div class="errors">
                <g:renderErrors bean="${topicInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${topicInstance?.id}" />
                <g:hiddenField name="version" value="${topicInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="name"><g:message code="topic.name" default="Name" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: topicInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" value="${fieldValue(bean: topicInstance, field: 'name')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="frequency"><g:message code="topic.frequency" default="Frequency" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: topicInstance, field: 'frequency', 'errors')}">
                                    <g:select name="frequency" from="${topicInstance.constraints.frequency.inList}" value="${topicInstance.frequency}" valueMessagePrefix="topic.frequency"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="viaEmail"><g:message code="topic.viaEmail" default="Via Email" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: topicInstance, field: 'viaEmail', 'errors')}">
                                    <g:checkBox name="viaEmail" value="${topicInstance?.viaEmail}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="viaSMS"><g:message code="topic.viaSMS" default="Via SMS" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: topicInstance, field: 'viaSMS', 'errors')}">
                                    <g:checkBox name="viaSMS" value="${topicInstance?.viaSMS}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="viaPost"><g:message code="topic.viaPost" default="Via Post" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: topicInstance, field: 'viaPost', 'errors')}">
                                    <g:checkBox name="viaPost" value="${topicInstance?.viaPost}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="comments"><g:message code="topic.comments" default="Comments" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: topicInstance, field: 'comments', 'errors')}">
                                    <g:textField name="comments" value="${fieldValue(bean: topicInstance, field: 'comments')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="status"><g:message code="topic.status" default="Status" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: topicInstance, field: 'status', 'errors')}">
                                    <g:select name="status" from="${topicInstance.constraints.status.inList}" value="${topicInstance.status}" valueMessagePrefix="topic.status"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="subscribers"><g:message code="topic.subscribers" default="Subscribers" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: topicInstance, field: 'subscribers', 'errors')}">
                                    
<ul>
<g:each in="${topicInstance?.subscribers}" var="topicSubscriptionInstance">
    <li><g:link controller="topicSubscription" action="show" id="${topicSubscriptionInstance.id}">${topicSubscriptionInstance?.encodeAsHTML()}</g:link></li>
</g:each>
</ul>
<g:link controller="topicSubscription" params="['topic.id': topicInstance?.id]" action="create"><g:message code="topicSubscription.new" default="New TopicSubscription" /></g:link>


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
