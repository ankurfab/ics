
<%@ page import="ics.DonationRecord" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="donationRecord.create" default="Create DonationRecord" /></title>
    </head>
    <body>
        <r:require module="jqui" />
    <script type="text/javascript">
         $(document).ready(function()
            {
                $("#donationDate").datepicker({yearRange: "-100:+0",changeMonth: true,
                changeYear: true,
                dateFormat: 'dd-mm-yy'});
               
            })
        </script>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="donationRecord.list" default="DonationRecord List" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="donationRecord.create" default="Create DonationRecord" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:hasErrors bean="${donationRecordInstance}">
            <div class="errors">
                <g:renderErrors bean="${donationRecordInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="donatedBy"><g:message code="donationRecord.donatedBy" default="Donated By" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationRecordInstance, field: 'donatedBy', 'errors')}">
                                    <g:link controller="individual" action="show" params="['id':donationRecordInstance?.donatedBy?.id,'profile':'true']">${donationRecordInstance?.donatedBy?.encodeAsHTML()}</g:link>
                                    <g:hiddenField name="donatedBy.id" value="${donationRecordInstance?.donatedBy?.id}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="donationDate"><g:message code="donationRecord.donationDate" default="Donation Date" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationRecordInstance, field: 'donationDate', 'errors')}">
                                     <g:textField name="donationDate" value="${donationRecordInstance?.donationDate?.format('dd-MM-yyyy')}"/>                                      

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="amount"><g:message code="donationRecord.amount" default="Amount" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationRecordInstance, field: 'amount', 'errors')}">
                                    <g:textField name="amount" value="${fieldValue(bean: donationRecordInstance, field: 'amount')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="scheme"><g:message code="donationRecord.scheme" default="Scheme" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationRecordInstance, field: 'scheme', 'errors')}">
                                    <g:select name="scheme.id" from="${schemes}" optionKey="id" value="${donationRecordInstance?.scheme?.id}" noSelection="['null': '']" />

                                </td>
                            </tr>
                              <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="center"><g:message code="donationRecord.center" default="Center" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationRecordInstance, field: 'centre', 'errors')}">
                                    <g:select name="centre.id" from="${ics.Centre.list()}" optionKey="id" value="${donationRecordInstance?.centre?.id}" noSelection="['null': '']" />

                                </td>
                            </tr>

                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="reference"><g:message code="donationRecord.reference" default="Reference" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationRecordInstance, field: 'reference', 'errors')}">
                                    <g:textField name="reference" value="${fieldValue(bean: donationRecordInstance, field: 'reference')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="comments"><g:message code="donationRecord.comments" default="Comments" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationRecordInstance, field: 'comments', 'errors')}">
                                    <g:textField name="comments" value="${fieldValue(bean: donationRecordInstance, field: 'comments')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="mode"><g:message code="donationRecord.mode" default="Mode" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationRecordInstance, field: 'mode', 'errors')}">
                                    <g:select name="mode.id" from="${ics.PaymentMode.list(sort: 'name')}" optionKey="id" value="${donationRecordInstance?.mode?.id}" noSelection="['null': '']" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="paymentDetails"><g:message code="donationRecord.paymentDetails" default="Payment Details" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationRecordInstance, field: 'paymentDetails', 'errors')}">
                                    <g:textField name="paymentDetails" value="${fieldValue(bean: donationRecordInstance, field: 'paymentDetails')}" />

                                </td>
                            </tr>
                             <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="transactionId"><g:message code="donationRecord.transactionId" default="Transaction Id" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationRecordInstance, field: 'transactionId', 'errors')}">
                                    <g:textField name="transactionId" value="${fieldValue(bean: donationRecordInstance, field: 'transactionId')}" />

                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="mode"><g:message code="donationRecord.receiptReceivedStatus" default="Receipt Received Status" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationRecordInstance, field: 'receiptReceivedStatus', 'errors')}">
                                    <g:select name="receiptReceivedStatus" from="${['','NOTGENERATED','GENERATED','SENT','RECEIVED']}" value="${donationRecordInstance?.receiptReceivedStatus}" noSelection="['null': '']" />

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
