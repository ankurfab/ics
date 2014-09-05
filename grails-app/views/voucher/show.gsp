
<%@ page import="ics.Voucher" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="voucher.show" default="Show Voucher" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="voucher.list" default="Voucher List" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="voucher.new" default="New Voucher" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="voucher.show" default="Show Voucher" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:form>
                <g:hiddenField name="id" value="${voucherInstance?.id}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="voucher.id" default="Id" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: voucherInstance, field: "id")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="voucher.voucherDate" default="Voucher Date" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate format="dd-MM-yyyy" date="${voucherInstance?.voucherDate}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="voucher.departmentCode" default="Department Code" />:</td>
                                
                                <td valign="top" class="value"><g:link controller="costCenter" action="show" id="${voucherInstance?.departmentCode?.id}">${voucherInstance?.departmentCode?.encodeAsHTML()}</g:link></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="voucher.voucherNo" default="Voucher No" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: voucherInstance, field: "voucherNo")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="voucher.description" default="Description" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: voucherInstance, field: "description")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name">Withdrawal Amount &#8377;:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: voucherInstance, field: "amount")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name">Deposit Amount &#8377;:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: voucherInstance, field: "amountSettled")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="voucher.dateCreated" default="Date Created" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${voucherInstance?.dateCreated}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="voucher.creator" default="Creator" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: voucherInstance, field: "creator")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="voucher.lastUpdated" default="Last Updated" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${voucherInstance?.lastUpdated}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="voucher.updator" default="Updator" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: voucherInstance, field: "updator")}</td>
                                
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
