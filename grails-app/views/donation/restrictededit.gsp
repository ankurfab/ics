
<%@ page import="ics.Donation" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'donation.label', default: 'Donation')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${donationInstance}">
            <div class="errors">
                <g:renderErrors bean="${donationInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${donationInstance?.id}" />
                <g:hiddenField name="version" value="${donationInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="donatedBy"><g:message code="donation.donatedBy.label" default="Donated By" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'donatedBy', 'errors')}">
                                    <g:hiddenField name="donatedBy.id" value="${donationInstance?.donatedBy?.id}" />
                                    ${donationInstance?.donatedBy?.toString()}
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="giftIssued"><g:message code="donation.giftIssued.label" default="Gift Issued" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'giftIssued', 'errors')}">
                                    
<ul>
<g:each in="${donationInstance?.giftIssued?}" var="g">
    <li><g:link controller="giftIssued" action="show" id="${g.id}">${g?.encodeAsHTML()}</g:link></li>
</g:each>
</ul>
<g:link controller="giftIssued" action="createfordonation" params="['donation.id': donationInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'giftIssued.label', default: 'GiftIssued')])}</g:link>

                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="comments"><g:message code="donation.comments.label" default="Comments" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'comments', 'errors')}">
                                    <g:textField name="comments" value="${donationInstance?.comments}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="nameInPadaSevaBook"><g:message code="donation.nameInPadaSevaBook.label" default="Name In Pada Seva Book" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'nameInPadaSevaBook', 'errors')}">
                                    <g:hiddenField name="nameInPadaSevaBook" value="${donationInstance?.nameInPadaSevaBook}" />
                                    ${donationInstance?.nameInPadaSevaBook}
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="scheme"><g:message code="donation.scheme.label" default="Scheme" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'scheme', 'errors')}">
                                    <g:hiddenField name="scheme.id" value="${donationInstance?.scheme?.id}" />
                                    ${donationInstance?.scheme?.toString()}
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="donationDate">Receipt Date</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'donationDate', 'errors')}">
                                    <g:hiddenField name="donationDate" value="${donationInstance?.donationDate}" />
                                    <g:formatDate format="dd-MM-yyyy" date="${donationInstance?.donationDate}"/>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="donationReceipt"><g:message code="donation.donationReceipt.label" default="Donation Receipt" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'donationReceipt', 'errors')}">
                                    <g:hiddenField name="donationReceipt.id" value="${donationInstance?.donationReceipt?.id}" />
                                    ${donationInstance?.donationReceipt?.toString()}
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="amount"><g:message code="donation.amount.label" default="Amount" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'amount', 'errors')}">
                                    <g:hiddenField name="amount" value="${fieldValue(bean: donationInstance, field: 'amount')}" />
                                    ${fieldValue(bean: donationInstance, field: 'amount')}
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="currency"><g:message code="donation.currency.label" default="Currency" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'currency', 'errors')}">
                                    <g:hiddenField name="currency" value="${donationInstance?.currency}" />
                                    ${donationInstance?.currency}
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="mode"><g:message code="donation.mode.label" default="Mode" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'mode', 'errors')}">
                                    <g:hiddenField name="mode.id" value="${donationInstance?.mode?.id}" />
                                    ${donationInstance?.mode?.toString()}
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="chequeNo"><g:message code="donation.chequeNo.label" default="Cheque No" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'chequeNo', 'errors')}">
                                    <g:hiddenField name="chequeNo" value="${donationInstance?.chequeNo}" />
                                    ${donationInstance?.chequeNo}
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="chequeDate"><g:message code="donation.chequeDate.label" default="Cheque Date" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'chequeDate', 'errors')}">
                                    <g:hiddenField name="chequeDate" value="${donationInstance?.chequeDate}" />
                                    <g:formatDate format="dd-MM-yyyy" date="${donationInstance?.chequeDate}"/>
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="bank"><g:message code="donation.bank.label" default="Bank" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'bank', 'errors')}">
                                    <g:hiddenField name="bank.id" value="${donationInstance?.bank?.id}" />
                                    ${donationInstance?.bank?.toString()}
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="bankBranch"><g:message code="donation.bankBranch.label" default="Bank Branch" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'bankBranch', 'errors')}">
                                    <g:hiddenField name="bankBranch" value="${donationInstance?.bankBranch}" />
                                    ${donationInstance?.bankBranch}
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="paymentComments"><g:message code="donation.paymentComments.label" default="Payment Comments" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'paymentComments', 'errors')}">
                                    <g:hiddenField name="paymentComments" value="${donationInstance?.paymentComments}" />
                                    ${donationInstance?.paymentComments}
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="collectedBy"><g:message code="donation.collectedBy.label" default="Collected By" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'collectedBy', 'errors')}">
                                    <g:hiddenField name="collectedBy.id" value="${donationInstance?.collectedBy?.id}" />
                                    ${donationInstance?.collectedBy?.toString()}
                                </td>
                            </tr>
                        

                       
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="receivedBy"><g:message code="donation.receivedBy.label" default="Received By" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'receivedBy', 'errors')}">
                                    <g:hiddenField name="receivedBy.id" value="${donationInstance?.receivedBy?.id}" />
                                    ${donationInstance?.receivedBy?.toString()}
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="fundReceiptDate">Submission Date</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'fundReceiptDate', 'errors')}">
                                    <g:hiddenField name="fundReceiptDate" value="${donationInstance?.fundReceiptDate}" />
                                    <g:formatDate format="dd-MM-yyyy" date="${donationInstance?.fundReceiptDate}"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="fundReceivedAck"><g:message code="donation.fundReceivedAck.label" default="Fund Received Ack" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'fundReceivedAck', 'errors')}">
                                    <g:hiddenField name="fundReceivedAck" value="${donationInstance?.fundReceivedAck}" />
                                    ${donationInstance?.fundReceivedAck}
                                </td>
                            </tr>
                        
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="category"><g:message code="donation.category.label" default="Category" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'category', 'errors')}">
                                    <g:hiddenField name="category" value="${donationInstance?.category}" />
                                    ${donationInstance?.category}
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="nvccDonarName"><g:message code="donation.nvccDonarName.label" default="Nvcc Donar Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'nvccDonarName', 'errors')}">
                                    <g:hiddenField name="nvccDonarName" value="${donationInstance?.nvccDonarName}" />
                                    ${donationInstance?.nvccDonarName}
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="nvccDonationType"><g:message code="donation.nvccDonationType.label" default="Nvcc Donation Type" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'nvccDonationType', 'errors')}">
                                    <g:hiddenField name="nvccBank" value="${donationInstance?.nvccBank}" />
                                    ${donationInstance?.nvccBank}
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="nvccReceiptBookNo"><g:message code="donation.nvccReceiptBookNo.label" default="Nvcc Receipt Book No" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'nvccReceiptBookNo', 'errors')}">
                                    <g:hiddenField name="nvccReceiptBookNo" value="${donationInstance?.nvccReceiptBookNo}" />
                                    ${donationInstance?.nvccReceiptBookNo}
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="nvccReceiptNo"><g:message code="donation.nvccReceiptNo.label" default="Nvcc Receipt No" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'nvccReceiptNo', 'errors')}">
                                    <g:hiddenField name="nvccReceiptNo" value="${donationInstance?.nvccReceiptNo}" />
                                    ${donationInstance?.nvccReceiptNo}
                                </td>
                            </tr>
                        
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="nvccDonarCode"><g:message code="donation.nvccDonarCode.label" default="Nvcc Donar Code" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'nvccDonarCode', 'errors')}">
                                    <g:hiddenField name="nvccDonarCode" value="${donationInstance?.nvccDonarCode}" />
                                    ${donationInstance?.nvccDonarCode}
                                </td>
                            </tr>
                        
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="nvccCollectorName"><g:message code="donation.nvccCollectorName.label" default="Nvcc Collector Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'nvccCollectorName', 'errors')}">
                                    <g:hiddenField name="nvccCollectorName" value="${donationInstance?.nvccCollectorName}" />
                                    ${donationInstance?.nvccCollectorName}
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="nvccReceiverName"><g:message code="donation.nvccReceiverName.label" default="Nvcc Receiver Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'nvccReceiverName', 'errors')}">
                                    <g:hiddenField name="nvccReceiverName" value="${donationInstance?.nvccReceiverName}" />
                                    ${donationInstance?.nvccReceiverName}
                                </td>
                            </tr>
                        
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="nvccDonationMode"><g:message code="donation.nvccDonationMode.label" default="Nvcc Donation Mode" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'nvccDonationMode', 'errors')}">
                                    <g:hiddenField name="nvccDonationMode" value="${donationInstance?.nvccDonationMode}" />
                                    ${donationInstance?.nvccDonationMode}
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="nvccBank"><g:message code="donation.nvccBank.label" default="Nvcc Bank" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationInstance, field: 'nvccBank', 'errors')}">
                                    <g:hiddenField name="nvccBank" value="${donationInstance?.nvccBank}" />
                                    ${donationInstance?.nvccBank}
                                </td>
                            </tr>
                        
                        
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
