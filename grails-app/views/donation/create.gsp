
<%@ page import="ics.Donation" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'donation.label', default: 'Donation')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${donationInstance}">
            <div class="errors">
                <g:renderErrors bean="${donationInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="donatedBy"><g:message code="donation.donatedBy.label" default="Donated By" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'donatedBy', 'errors')}">
                                    <g:select name="donatedBy.id" from="${ics.Individual.list()}" optionKey="id" value="${donationInstance?.donatedBy?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="collectedBy"><g:message code="donation.collectedBy.label" default="Collected By" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'collectedBy', 'errors')}">
                                    <g:select name="collectedBy.id" from="${ics.Individual.list()}" optionKey="id" value="${donationInstance?.collectedBy?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="scheme"><g:message code="donation.scheme.label" default="Scheme" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'scheme', 'errors')}">
                                    <g:select name="scheme.id" from="${ics.Scheme.list()}" optionKey="id" value="${donationInstance?.scheme?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="amount"><g:message code="donation.amount.label" default="Amount" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'amount', 'errors')}">
                                    <g:textField name="amount" value="${fieldValue(bean: donationInstance, field: 'amount')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="currency"><g:message code="donation.currency.label" default="Currency" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'currency', 'errors')}">
                                    <g:textField name="currency" value="${donationInstance?.currency}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="donationDate">Receipt Date</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'donationDate', 'errors')}">
                                    <g:datePicker name="donationDate" precision="day" value="${donationInstance?.donationDate}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="donationReceipt"><g:message code="donation.donationReceipt.label" default="Donation Receipt" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'donationReceipt', 'errors')}">
                                    <g:select name="donationReceipt.id" from="${ics.Receipt.list()}" optionKey="id" value="${donationInstance?.donationReceipt?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="receivedBy"><g:message code="donation.receivedBy.label" default="Received By" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'receivedBy', 'errors')}">
                                    <g:select name="receivedBy.id" from="${ics.Individual.list()}" optionKey="id" value="${donationInstance?.receivedBy?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="fundReceiptDate">Submission Date</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'fundReceiptDate', 'errors')}">
                                    <g:datePicker name="fundReceiptDate" precision="day" value="${donationInstance?.fundReceiptDate}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="fundReceivedAck"><g:message code="donation.fundReceivedAck.label" default="Fund Received Ack" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'fundReceivedAck', 'errors')}">
                                    <g:textField name="fundReceivedAck" value="${donationInstance?.fundReceivedAck}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="comments"><g:message code="donation.comments.label" default="Comments" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'comments', 'errors')}">
                                    <g:textArea name="comments" value="${donationInstance?.comments}" rows="5" cols="40"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="nvccBank"><g:message code="donation.nvccBank.label" default="Nvcc Bank" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'nvccBank', 'errors')}">
                                    <g:textField name="nvccBank" value="${donationInstance?.nvccBank}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="nvccDonationType"><g:message code="donation.nvccDonationType.label" default="Nvcc Donation Type" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'nvccDonationType', 'errors')}">
                                    <g:textField name="nvccDonationType" value="${donationInstance?.nvccDonationType}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="nvccReceiptNo"><g:message code="donation.nvccReceiptNo.label" default="Nvcc Receipt No" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'nvccReceiptNo', 'errors')}">
                                    <g:textField name="nvccReceiptNo" value="${donationInstance?.nvccReceiptNo}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="nameInPadaSevaBook"><g:message code="donation.nameInPadaSevaBook.label" default="Name In Pada Seva Book" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'nameInPadaSevaBook', 'errors')}">
                                    <g:textField name="nameInPadaSevaBook" value="${donationInstance?.nameInPadaSevaBook}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="chequeDate"><g:message code="donation.chequeDate.label" default="Cheque Date" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'chequeDate', 'errors')}">
                                    <g:datePicker name="chequeDate" precision="day" value="${donationInstance?.chequeDate}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="nvccDonarCode"><g:message code="donation.nvccDonarCode.label" default="Nvcc Donar Code" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'nvccDonarCode', 'errors')}">
                                    <g:textField name="nvccDonarCode" value="${donationInstance?.nvccDonarCode}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="mode"><g:message code="donation.mode.label" default="Mode" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'mode', 'errors')}">
                                    <g:select name="mode.id" from="${ics.PaymentMode.list()}" optionKey="id" value="${donationInstance?.mode?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="nvccCollectorName"><g:message code="donation.nvccCollectorName.label" default="Nvcc Collector Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'nvccCollectorName', 'errors')}">
                                    <g:textField name="nvccCollectorName" value="${donationInstance?.nvccCollectorName}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="nvccReceiverName"><g:message code="donation.nvccReceiverName.label" default="Nvcc Receiver Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'nvccReceiverName', 'errors')}">
                                    <g:textField name="nvccReceiverName" value="${donationInstance?.nvccReceiverName}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="bank"><g:message code="donation.bank.label" default="Bank" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'bank', 'errors')}">
                                    <g:select name="bank.id" from="${ics.Bank.list()}" optionKey="id" value="${donationInstance?.bank?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="nvccDonationMode"><g:message code="donation.nvccDonationMode.label" default="Nvcc Donation Mode" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'nvccDonationMode', 'errors')}">
                                    <g:textField name="nvccDonationMode" value="${donationInstance?.nvccDonationMode}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="chequeNo"><g:message code="donation.chequeNo.label" default="Cheque No" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'chequeNo', 'errors')}">
                                    <g:textField name="chequeNo" value="${donationInstance?.chequeNo}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="paymentComments"><g:message code="donation.paymentComments.label" default="Payment Comments" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'paymentComments', 'errors')}">
                                    <g:textField name="paymentComments" value="${donationInstance?.paymentComments}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="nvccDonarName"><g:message code="donation.nvccDonarName.label" default="Nvcc Donar Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'nvccDonarName', 'errors')}">
                                    <g:textField name="nvccDonarName" value="${donationInstance?.nvccDonarName}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="nvccReceiptBookNo"><g:message code="donation.nvccReceiptBookNo.label" default="Nvcc Receipt Book No" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'nvccReceiptBookNo', 'errors')}">
                                    <g:textField name="nvccReceiptBookNo" value="${donationInstance?.nvccReceiptBookNo}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="bankBranch"><g:message code="donation.bankBranch.label" default="Bank Branch" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'bankBranch', 'errors')}">
                                    <g:textField name="bankBranch" value="${donationInstance?.bankBranch}" />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
