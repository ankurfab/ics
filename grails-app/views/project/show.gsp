
<%@ page import="ics.Project" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="project.show" default="Show Project" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="project.list" default="Project List" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="project.new" default="New Project" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="project.show" default="Show Project" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:form>
                <g:hiddenField name="id" value="${projectInstance?.id}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="project.id" default="Id" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: projectInstance, field: "id")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="project.centre" default="Centre" />:</td>
                                
                                <td valign="top" class="value"><g:link controller="centre" action="show" id="${projectInstance?.centre?.id}">${projectInstance?.centre?.encodeAsHTML()}</g:link></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="project.department" default="Department" />:</td>
                                
                                <td valign="top" class="value"><g:link controller="department" action="show" id="${projectInstance?.department?.id}">${projectInstance?.department?.encodeAsHTML()}</g:link></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="project.costCenter" default="Cost Center" />:</td>
                                
                                <td valign="top" class="value"><g:link controller="costCenter" action="show" id="${projectInstance?.costCenter?.id}">${projectInstance?.costCenter?.encodeAsHTML()}</g:link></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="project.category" default="Category" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: projectInstance, field: "category")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="project.type" default="Type" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: projectInstance, field: "type")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="project.name" default="Name" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: projectInstance, field: "name")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="project.description" default="Description" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: projectInstance, field: "description")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="project.comments" default="Comments" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: projectInstance, field: "comments")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="project.status" default="Status" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: projectInstance, field: "status")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="project.amount" default="Amount" />:</td>
                                
                                <td valign="top" class="value"><g:formatNumber number="${projectInstance?.amount}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="project.ref" default="Ref" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: projectInstance, field: "ref")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="project.submitter" default="Submitter" />:</td>
                                
                                <td valign="top" class="value"><g:link controller="individual" action="show" id="${projectInstance?.submitter?.id}">${projectInstance?.submitter?.encodeAsHTML()}</g:link></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="project.submitDate" default="Submit Date" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${projectInstance?.submitDate}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="project.submitComments" default="Submit Comments" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: projectInstance, field: "submitComments")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="project.submitStatus" default="Submit Status" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: projectInstance, field: "submitStatus")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="project.submittedAmount" default="Submitted Amount" />:</td>
                                
                                <td valign="top" class="value"><g:formatNumber number="${projectInstance?.submittedAmount}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="project.reviewer1" default="Reviewer1" />:</td>
                                
                                <td valign="top" class="value"><g:link controller="individual" action="show" id="${projectInstance?.reviewer1?.id}">${projectInstance?.reviewer1?.encodeAsHTML()}</g:link></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="project.review1Date" default="Review1 Date" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${projectInstance?.review1Date}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="project.review1Comments" default="Review1 Comments" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: projectInstance, field: "review1Comments")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="project.review1Status" default="Review1 Status" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: projectInstance, field: "review1Status")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="project.reviewer1Amount" default="Reviewer1 Amount" />:</td>
                                
                                <td valign="top" class="value"><g:formatNumber number="${projectInstance?.reviewer1Amount}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="project.reviewer2" default="Reviewer2" />:</td>
                                
                                <td valign="top" class="value"><g:link controller="individual" action="show" id="${projectInstance?.reviewer2?.id}">${projectInstance?.reviewer2?.encodeAsHTML()}</g:link></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="project.review2Date" default="Review2 Date" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${projectInstance?.review2Date}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="project.review2Comments" default="Review2 Comments" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: projectInstance, field: "review2Comments")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="project.review2Status" default="Review2 Status" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: projectInstance, field: "review2Status")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="project.reviewer2Amount" default="Reviewer2 Amount" />:</td>
                                
                                <td valign="top" class="value"><g:formatNumber number="${projectInstance?.reviewer2Amount}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="project.reviewer3" default="Reviewer3" />:</td>
                                
                                <td valign="top" class="value"><g:link controller="individual" action="show" id="${projectInstance?.reviewer3?.id}">${projectInstance?.reviewer3?.encodeAsHTML()}</g:link></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="project.review3Date" default="Review3 Date" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${projectInstance?.review3Date}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="project.review3Comments" default="Review3 Comments" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: projectInstance, field: "review3Comments")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="project.review3Status" default="Review3 Status" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: projectInstance, field: "review3Status")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="project.reviewer3Amount" default="Reviewer3 Amount" />:</td>
                                
                                <td valign="top" class="value"><g:formatNumber number="${projectInstance?.reviewer3Amount}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="project.dateCreated" default="Date Created" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${projectInstance?.dateCreated}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="project.creator" default="Creator" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: projectInstance, field: "creator")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="project.lastUpdated" default="Last Updated" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${projectInstance?.lastUpdated}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="project.updator" default="Updator" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: projectInstance, field: "updator")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="project.subProjects" default="Sub Projects" />:</td>
                                
                                <td  valign="top" style="text-align: left;" class="value">
                                    <ul>
                                    <g:each in="${projectInstance?.subProjects}" var="projectInstance">
                                        <li><g:link controller="project" action="show" id="${projectInstance.id}">${projectInstance.encodeAsHTML()}</g:link></li>
                                    </g:each>
                                    </ul>
                                </td>
                                
                            </tr>
                            
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'edit', 'default': 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'delete', 'default': 'Delete')}" onclick="return confirm('${message(code: 'delete.confirm', 'default': 'Are you sure?')}');" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
