
<%@ page import="ics.Project" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="project.edit" default="Edit Project" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="project.list" default="Project List" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="project.new" default="New Project" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="project.edit" default="Edit Project" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:hasErrors bean="${projectInstance}">
            <div class="errors">
                <g:renderErrors bean="${projectInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${projectInstance?.id}" />
                <g:hiddenField name="version" value="${projectInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="centre"><g:message code="project.centre" default="Centre" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projectInstance, field: 'centre', 'errors')}">
                                    <g:select name="centre.id" from="${ics.Centre.list()}" optionKey="id" value="${projectInstance?.centre?.id}" noSelection="['null': '']" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="department"><g:message code="project.department" default="Department" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projectInstance, field: 'department', 'errors')}">
                                    <g:select name="department.id" from="${ics.Department.list()}" optionKey="id" value="${projectInstance?.department?.id}" noSelection="['null': '']" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="costCenter"><g:message code="project.costCenter" default="Cost Center" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projectInstance, field: 'costCenter', 'errors')}">
                                    <g:select name="costCenter.id" from="${ics.CostCenter.findAllByStatusIsNull()}" optionKey="id" value="${projectInstance?.costCenter?.id}" noSelection="['null': '']" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="category"><g:message code="project.category" default="Category" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projectInstance, field: 'category', 'errors')}">
                                    <g:textField name="category" value="${fieldValue(bean: projectInstance, field: 'category')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="type"><g:message code="project.type" default="Type" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projectInstance, field: 'type', 'errors')}">
                                    <g:textField name="type" value="${fieldValue(bean: projectInstance, field: 'type')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="name"><g:message code="project.name" default="Name" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projectInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" value="${fieldValue(bean: projectInstance, field: 'name')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="description"><g:message code="project.description" default="Description" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projectInstance, field: 'description', 'errors')}">
                                    <g:textArea name="description" rows="5" cols="40" value="${fieldValue(bean: projectInstance, field: 'description')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="comments"><g:message code="project.comments" default="Comments" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projectInstance, field: 'comments', 'errors')}">
                                    <g:textArea name="comments" rows="5" cols="40" value="${fieldValue(bean: projectInstance, field: 'comments')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="status"><g:message code="project.status" default="Status" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projectInstance, field: 'status', 'errors')}">
                                    <g:textField name="status" value="${fieldValue(bean: projectInstance, field: 'status')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="amount"><g:message code="project.amount" default="Amount" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projectInstance, field: 'amount', 'errors')}">
                                    <g:textField name="amount" value="${fieldValue(bean: projectInstance, field: 'amount')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="ref"><g:message code="project.ref" default="Ref" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projectInstance, field: 'ref', 'errors')}">
                                    <g:textField name="ref" value="${fieldValue(bean: projectInstance, field: 'ref')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="submitter"><g:message code="project.submitter" default="Submitter" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projectInstance, field: 'submitter', 'errors')}">
                                    <g:select name="submitter.id" from="${ics.Individual.findAllByCategory('ACCPILOT')}" optionKey="id" value="${projectInstance?.submitter?.id}" noSelection="['null': '']" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="submitDate"><g:message code="project.submitDate" default="Submit Date" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projectInstance, field: 'submitDate', 'errors')}">
                                    <g:datePicker name="submitDate" value="${projectInstance?.submitDate}" noSelection="['': '']" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="submitComments"><g:message code="project.submitComments" default="Submit Comments" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projectInstance, field: 'submitComments', 'errors')}">
                                    <g:textArea name="submitComments" rows="5" cols="40" value="${fieldValue(bean: projectInstance, field: 'submitComments')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="submitStatus"><g:message code="project.submitStatus" default="Submit Status" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projectInstance, field: 'submitStatus', 'errors')}">
                                    <g:textField name="submitStatus" value="${fieldValue(bean: projectInstance, field: 'submitStatus')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="submittedAmount"><g:message code="project.submittedAmount" default="Submitted Amount" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projectInstance, field: 'submittedAmount', 'errors')}">
                                    <g:textField name="submittedAmount" value="${fieldValue(bean: projectInstance, field: 'submittedAmount')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="reviewer1"><g:message code="project.reviewer1" default="Reviewer1" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projectInstance, field: 'reviewer1', 'errors')}">
                                    <g:select name="reviewer1.id" from="${ics.Individual.findAllByCategory('ACCPILOT')}" optionKey="id" value="${projectInstance?.reviewer1?.id}" noSelection="['null': '']" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="review1Date"><g:message code="project.review1Date" default="Review1 Date" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projectInstance, field: 'review1Date', 'errors')}">
                                    <g:datePicker name="review1Date" value="${projectInstance?.review1Date}" noSelection="['': '']" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="review1Comments"><g:message code="project.review1Comments" default="Review1 Comments" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projectInstance, field: 'review1Comments', 'errors')}">
                                    <g:textArea name="review1Comments" rows="5" cols="40" value="${fieldValue(bean: projectInstance, field: 'review1Comments')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="review1Status"><g:message code="project.review1Status" default="Review1 Status" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projectInstance, field: 'review1Status', 'errors')}">
                                    <g:textField name="review1Status" value="${fieldValue(bean: projectInstance, field: 'review1Status')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="reviewer1Amount"><g:message code="project.reviewer1Amount" default="Reviewer1 Amount" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projectInstance, field: 'reviewer1Amount', 'errors')}">
                                    <g:textField name="reviewer1Amount" value="${fieldValue(bean: projectInstance, field: 'reviewer1Amount')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="reviewer2"><g:message code="project.reviewer2" default="Reviewer2" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projectInstance, field: 'reviewer2', 'errors')}">
                                    <g:select name="reviewer2.id" from="${ics.Individual.findAllByCategory('ACCPILOT')}" optionKey="id" value="${projectInstance?.reviewer2?.id}" noSelection="['null': '']" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="review2Date"><g:message code="project.review2Date" default="Review2 Date" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projectInstance, field: 'review2Date', 'errors')}">
                                    <g:datePicker name="review2Date" value="${projectInstance?.review2Date}" noSelection="['': '']" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="review2Comments"><g:message code="project.review2Comments" default="Review2 Comments" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projectInstance, field: 'review2Comments', 'errors')}">
                                    <g:textArea name="review2Comments" rows="5" cols="40" value="${fieldValue(bean: projectInstance, field: 'review2Comments')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="review2Status"><g:message code="project.review2Status" default="Review2 Status" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projectInstance, field: 'review2Status', 'errors')}">
                                    <g:textField name="review2Status" value="${fieldValue(bean: projectInstance, field: 'review2Status')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="reviewer2Amount"><g:message code="project.reviewer2Amount" default="Reviewer2 Amount" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projectInstance, field: 'reviewer2Amount', 'errors')}">
                                    <g:textField name="reviewer2Amount" value="${fieldValue(bean: projectInstance, field: 'reviewer2Amount')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="reviewer3"><g:message code="project.reviewer3" default="Reviewer3" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projectInstance, field: 'reviewer3', 'errors')}">
                                    <g:select name="reviewer3.id" from="${ics.Individual.findAllByCategory('ACCPILOT')}" optionKey="id" value="${projectInstance?.reviewer3?.id}" noSelection="['null': '']" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="review3Date"><g:message code="project.review3Date" default="Review3 Date" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projectInstance, field: 'review3Date', 'errors')}">
                                    <g:datePicker name="review3Date" value="${projectInstance?.review3Date}" noSelection="['': '']" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="review3Comments"><g:message code="project.review3Comments" default="Review3 Comments" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projectInstance, field: 'review3Comments', 'errors')}">
                                    <g:textArea name="review3Comments" rows="5" cols="40" value="${fieldValue(bean: projectInstance, field: 'review3Comments')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="review3Status"><g:message code="project.review3Status" default="Review3 Status" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projectInstance, field: 'review3Status', 'errors')}">
                                    <g:textField name="review3Status" value="${fieldValue(bean: projectInstance, field: 'review3Status')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="reviewer3Amount"><g:message code="project.reviewer3Amount" default="Reviewer3 Amount" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projectInstance, field: 'reviewer3Amount', 'errors')}">
                                    <g:textField name="reviewer3Amount" value="${fieldValue(bean: projectInstance, field: 'reviewer3Amount')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="dateCreated"><g:message code="project.dateCreated" default="Date Created" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projectInstance, field: 'dateCreated', 'errors')}">
                                    <g:datePicker name="dateCreated" value="${projectInstance?.dateCreated}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="creator"><g:message code="project.creator" default="Creator" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projectInstance, field: 'creator', 'errors')}">
                                    <g:textField name="creator" value="${fieldValue(bean: projectInstance, field: 'creator')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="lastUpdated"><g:message code="project.lastUpdated" default="Last Updated" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projectInstance, field: 'lastUpdated', 'errors')}">
                                    <g:datePicker name="lastUpdated" value="${projectInstance?.lastUpdated}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="updator"><g:message code="project.updator" default="Updator" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projectInstance, field: 'updator', 'errors')}">
                                    <g:textField name="updator" value="${fieldValue(bean: projectInstance, field: 'updator')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="subProjects"><g:message code="project.subProjects" default="Sub Projects" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: projectInstance, field: 'subProjects', 'errors')}">
                                    

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
