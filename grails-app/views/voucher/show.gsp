
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
                                <td valign="top" class="name"><g:message code="voucher.amount" default="Amount" />:</td>
                                
                                <td valign="top" class="value"><g:formatNumber number="${voucherInstance?.amount}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="voucher.description" default="Description" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: voucherInstance, field: "description")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="voucher.amountSettled" default="Amount Settled" />:</td>
                                
                                <td valign="top" class="value"><g:formatNumber number="${voucherInstance?.amountSettled}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="voucher.type" default="Type" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: voucherInstance, field: "type")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="voucher.refNo" default="Ref No" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: voucherInstance, field: "refNo")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="voucher.debit" default="Debit" />:</td>
                                
                                <td valign="top" class="value"><g:formatBoolean boolean="${voucherInstance?.debit}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="voucher.mode" default="Mode" />:</td>
                                
                                <td valign="top" class="value"><g:link controller="paymentMode" action="show" id="${voucherInstance?.mode?.id}">${voucherInstance?.mode?.encodeAsHTML()}</g:link></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="voucher.anotherDepartmentCode" default="Another Department Code" />:</td>
                                
                                <td valign="top" class="value"><g:link controller="costCenter" action="show" id="${voucherInstance?.anotherDepartmentCode?.id}">${voucherInstance?.anotherDepartmentCode?.encodeAsHTML()}</g:link></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="voucher.anotherDescription" default="Another Description" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: voucherInstance, field: "anotherDescription")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="voucher.individual" default="Individual" />:</td>
                                
                                <td valign="top" class="value"><g:link controller="individual" action="show" id="${voucherInstance?.individual?.id}">${voucherInstance?.individual?.encodeAsHTML()}</g:link></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="voucher.anotherIndividual" default="Another Individual" />:</td>
                                
                                <td valign="top" class="value"><g:link controller="individual" action="show" id="${voucherInstance?.anotherIndividual?.id}">${voucherInstance?.anotherIndividual?.encodeAsHTML()}</g:link></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="voucher.ledger" default="Ledger" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: voucherInstance, field: "ledger")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="voucher.anotherLedger" default="Another Ledger" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: voucherInstance, field: "anotherLedger")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="voucher.ledgerHead" default="Ledger Head" />:</td>
                                
                                <td valign="top" class="value"><g:link controller="ledgerHead" action="show" id="${voucherInstance?.ledgerHead?.id}">${voucherInstance?.ledgerHead?.encodeAsHTML()}</g:link></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="voucher.anotherLedgerHead" default="Another Ledger Head" />:</td>
                                
                                <td valign="top" class="value"><g:link controller="ledgerHead" action="show" id="${voucherInstance?.anotherLedgerHead?.id}">${voucherInstance?.anotherLedgerHead?.encodeAsHTML()}</g:link></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="voucher.instrumentNo" default="Instrument No" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: voucherInstance, field: "instrumentNo")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="voucher.instrumentDate" default="Instrument Date" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${voucherInstance?.instrumentDate}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="voucher.bankName" default="Bank Name" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: voucherInstance, field: "bankName")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="voucher.bankBranch" default="Bank Branch" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: voucherInstance, field: "bankBranch")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="voucher.crossUsing" default="Cross Using" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: voucherInstance, field: "crossUsing")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="voucher.status" default="Status" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: voucherInstance, field: "status")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="voucher.dataCaptured" default="Data Captured" />:</td>
                                
                                <td valign="top" class="value"><g:formatBoolean boolean="${voucherInstance?.dataCaptured}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="voucher.dataCaptureDate" default="Data Capture Date" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${voucherInstance?.dataCaptureDate}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="voucher.dataCapturedBy" default="Data Captured By" />:</td>
                                
                                <td valign="top" class="value"><g:link controller="individual" action="show" id="${voucherInstance?.dataCapturedBy?.id}">${voucherInstance?.dataCapturedBy?.encodeAsHTML()}</g:link></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="voucher.dataCaptureStatus" default="Data Capture Status" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: voucherInstance, field: "dataCaptureStatus")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="voucher.dataCaptureComments" default="Data Capture Comments" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: voucherInstance, field: "dataCaptureComments")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="voucher.instrumentReady" default="Instrument Ready" />:</td>
                                
                                <td valign="top" class="value"><g:formatBoolean boolean="${voucherInstance?.instrumentReady}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="voucher.instrumentReadyDate" default="Instrument Ready Date" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${voucherInstance?.instrumentReadyDate}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="voucher.instrumentReadyBy" default="Instrument Ready By" />:</td>
                                
                                <td valign="top" class="value"><g:link controller="individual" action="show" id="${voucherInstance?.instrumentReadyBy?.id}">${voucherInstance?.instrumentReadyBy?.encodeAsHTML()}</g:link></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="voucher.instrumentReadyStatus" default="Instrument Ready Status" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: voucherInstance, field: "instrumentReadyStatus")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="voucher.instrumentReadyComments" default="Instrument Ready Comments" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: voucherInstance, field: "instrumentReadyComments")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="voucher.instrumentCollected" default="Instrument Collected" />:</td>
                                
                                <td valign="top" class="value"><g:formatBoolean boolean="${voucherInstance?.instrumentCollected}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="voucher.instrumentCollectedDate" default="Instrument Collected Date" />:</td>
                                
                                <td valign="top" class="value"><g:formatDate date="${voucherInstance?.instrumentCollectedDate}" /></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="voucher.instrumentCollectedBy" default="Instrument Collected By" />:</td>
                                
                                <td valign="top" class="value"><g:link controller="individual" action="show" id="${voucherInstance?.instrumentCollectedBy?.id}">${voucherInstance?.instrumentCollectedBy?.encodeAsHTML()}</g:link></td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="voucher.instrumentCollectedStatus" default="Instrument Collected Status" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: voucherInstance, field: "instrumentCollectedStatus")}</td>
                                
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name"><g:message code="voucher.instrumentCollectedComments" default="Instrument Collected Comments" />:</td>
                                
                                <td valign="top" class="value">${fieldValue(bean: voucherInstance, field: "instrumentCollectedComments")}</td>
                                
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
                <!--<div class="buttons">
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'edit', 'default': 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'delete', 'default': 'Delete')}" onclick="return confirm('${message(code: 'delete.confirm', 'default': 'Are you sure?')}');" /></span>
                </div>-->
            </g:form>
        </div>
    </body>
</html>
