
<%@ page import="ics.DonationRecord" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="donationRecord.edit" default="Edit DonationRecord" /></title>
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
            <h1><g:message code="donationRecord.edit" default="Edit DonationRecord" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:hasErrors bean="${donationRecordInstance}">
            <div class="errors">
                <g:renderErrors bean="${donationRecordInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${donationRecordInstance?.id}" />
                <g:hiddenField name="version" value="${donationRecordInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                        <sec:ifAnyGranted roles="ROLE_DONATION_EXECUTIVE">

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="donatedBy"><g:message code="donationRecord.donatedBy" default="Donated By" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationRecordInstance, field: 'donatedBy', 'errors')}">
                                    ${donationRecordInstance?.donatedBy?.encodeAsHTML()}
                                     <g:hiddenField name="donatedBy.id" value="${donationRecordInstance?.donatedBy?.id}"  />
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
                                    <g:select name="scheme.id" from="${schemes}" optionKey="id" value="${donationRecordInstance?.scheme?.id}" />

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
                                    <g:select name="mode.id" from="${ics.PaymentMode.list()}" optionKey="id" value="${donationRecordInstance?.mode?.id}" noSelection="['null': '']" />

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
                                    <g:select name="receiptReceivedStatus" from="${['ACKONLY','NOTGENERATED']}" value="${donationRecordInstance?.receiptReceivedStatus}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="dateCreated"><g:message code="donationRecord.dateCreated" default="Date Created" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationRecordInstance, field: 'dateCreated', 'errors')}">
                                    ${donationRecordInstance?.dateCreated}
                                    <g:hiddenField name="dateCreated" value="${donationRecordInstance?.dateCreated}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="creator"><g:message code="donationRecord.creator" default="Creator" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationRecordInstance, field: 'creator', 'errors')}">
                                    ${fieldValue(bean: donationRecordInstance, field: 'creator')}
                                    <g:hiddenField name="creator" value="${donationRecordInstance?.creator}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="lastUpdated"><g:message code="donationRecord.lastUpdated" default="Last Updated" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationRecordInstance, field: 'lastUpdated', 'errors')}">
                                    ${donationRecordInstance?.lastUpdated}
                                    <g:hiddenField name="lastUpdated" value="${donationRecordInstance?.lastUpdated}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="updator"><g:message code="donationRecord.updator" default="Updator" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationRecordInstance, field: 'updator', 'errors')}">
                                    ${fieldValue(bean: donationRecordInstance, field: 'updator')}
                                    <g:hiddenField name="updator" value="${donationRecordInstance?.updator}"  />
                                </td>
                            </tr>
                            </sec:ifAnyGranted>

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="rbno">Receipt Book No</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationRecordInstance, field: 'rbno', 'errors')}">
                                    <g:textField name="rbno" value="${donationRecordInstance?.rbno}"/>
                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="rno">Receipt No</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: donationRecordInstance, field: 'rno', 'errors')}">
                                    <g:textField name="rno" value="${donationRecordInstance?.rno}"/>
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
