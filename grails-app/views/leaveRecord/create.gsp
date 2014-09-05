
<%@ page import="ics.LeaveRecord" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="leaveRecord.create" default="Create LeaveRecord" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="leaveRecord.list" default="LeaveRecord List" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="leaveRecord.create" default="Create LeaveRecord" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:hasErrors bean="${leaveRecordInstance}">
            <div class="errors">
                <g:renderErrors bean="${leaveRecordInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="dateFrom"><g:message code="leaveRecord.dateFrom" default="Date From" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: leaveRecordInstance, field: 'dateFrom', 'errors')}">
                                    <g:datePicker name="dateFrom" value="${leaveRecordInstance?.dateFrom}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="dateTill"><g:message code="leaveRecord.dateTill" default="Date Till" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: leaveRecordInstance, field: 'dateTill', 'errors')}">
                                    <g:datePicker name="dateTill" value="${leaveRecordInstance?.dateTill}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="status"><g:message code="leaveRecord.status" default="Status" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: leaveRecordInstance, field: 'status', 'errors')}">
                                    <g:textField name="status" value="${fieldValue(bean: leaveRecordInstance, field: 'status')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="comments"><g:message code="leaveRecord.comments" default="Comments" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: leaveRecordInstance, field: 'comments', 'errors')}">
                                    <g:textField name="comments" value="${fieldValue(bean: leaveRecordInstance, field: 'comments')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="dateCreated"><g:message code="leaveRecord.dateCreated" default="Date Created" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: leaveRecordInstance, field: 'dateCreated', 'errors')}">
                                    <g:datePicker name="dateCreated" value="${leaveRecordInstance?.dateCreated}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="creator"><g:message code="leaveRecord.creator" default="Creator" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: leaveRecordInstance, field: 'creator', 'errors')}">
                                    <g:textField name="creator" value="${fieldValue(bean: leaveRecordInstance, field: 'creator')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="lastUpdated"><g:message code="leaveRecord.lastUpdated" default="Last Updated" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: leaveRecordInstance, field: 'lastUpdated', 'errors')}">
                                    <g:datePicker name="lastUpdated" value="${leaveRecordInstance?.lastUpdated}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="updator"><g:message code="leaveRecord.updator" default="Updator" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: leaveRecordInstance, field: 'updator', 'errors')}">
                                    <g:textField name="updator" value="${fieldValue(bean: leaveRecordInstance, field: 'updator')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="indDep"><g:message code="leaveRecord.indDep" default="Ind Dep" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: leaveRecordInstance, field: 'indDep', 'errors')}">
                                    <g:select name="indDep.id" from="${ics.IndividualDepartment.list()}" optionKey="id" value="${leaveRecordInstance?.indDep?.id}"  />

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
