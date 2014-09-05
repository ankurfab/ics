
<%@ page import="ics.GiftRecord" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title><g:message code="giftRecord.create" default="Create GiftRecord" /></title>
    </head>
    <body>
     <r:require module="jqui" />
    <script type="text/javascript">
         $(document).ready(function()
            {
                $("#giftDate").datepicker({yearRange: "-100:+0",changeMonth: true,
                changeYear: true,
                dateFormat: 'dd-mm-yy'});
               
            })
        </script>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="giftRecord.list" default="GiftRecord List" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="giftRecord.create" default="Create GiftRecord" /></h1>
            <g:if test="${flash.message}">
            <div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
            <g:hasErrors bean="${giftRecordInstance}">
            <div class="errors">
                <g:renderErrors bean="${giftRecordInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="giftedTo"><g:message code="giftRecord.giftedTo" default="Gifted To" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: giftRecordInstance, field: 'giftedTo', 'errors')}">
                                    <g:link controller="individual" action="show" params="['id':giftRecordInstance?.giftedTo?.id,'profile':'true']">${giftRecordInstance?.giftedTo?.encodeAsHTML()}</g:link>
                                    <g:hiddenField name="giftedTo.id" value="${giftRecordInstance?.giftedTo?.id}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="gift"><g:message code="giftRecord.gift" default="Gift" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: giftRecordInstance, field: 'gift', 'errors')}">
                                    <g:select name="gift.id" from="${gifts}" optionKey="id" value="${giftRecordInstance?.gift?.id}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="giftDate"><g:message code="giftRecord.giftDate" default="Gift Date" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: giftRecordInstance, field: 'giftDate', 'errors')}">
                                    
                                    <g:textField name="giftDate" value="${giftRecordInstance?.giftDate?.format('dd-MM-yyyy')}"/>  
                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="scheme"><g:message code="giftRecordInstance.scheme" default="Scheme" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: giftRecordInstance, field: 'scheme', 'errors')}">
                                    <g:select name="scheme.id" from="${schemes}" optionKey="id" value="${giftRecordInstance?.scheme?.id}"  />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="quantity"><g:message code="giftRecord.quantity" default="Quantity" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: giftRecordInstance, field: 'quantity', 'errors')}">
                                    <g:textField name="quantity" value="${fieldValue(bean: giftRecordInstance, field: 'quantity')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="reference"><g:message code="giftRecord.reference" default="Reference" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: giftRecordInstance, field: 'reference', 'errors')}">
                                    <g:textField name="reference" value="${fieldValue(bean: giftRecordInstance, field: 'reference')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="comments"><g:message code="giftRecord.comments" default="Comments" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: giftRecordInstance, field: 'comments', 'errors')}">
                                    <g:textField name="comments" value="${fieldValue(bean: giftRecordInstance, field: 'comments')}" />

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="giftReceivedStatus"><g:message code="giftRecord.giftReceivedStatus" default="Gift Received Status" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: giftRecordInstance, field: 'giftReceivedStatus', 'errors')}">
                                    

                                     <g:select name="giftReceivedStatus" from="${['','Received','Sent','In Process']}" keys="${['','Received','Sent','In Process']}" value="${fieldValue(bean: giftRecordInstance, field: 'giftReceivedStatus')}"  />

                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="giftChannel"><g:message code="giftRecord.giftChannel" default="Way Gift Collected" />:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: giftRecordInstance, field: 'giftChannel', 'errors')}">
                                    
                                     <g:select name="giftChannel" from="${['','In Person','By Counsellor','By Another Devotee','By Courier','Any Other']}" keys="${['','In Person','By Counsellor','By Another Devotee','By Courier','Any Other']}" value="${fieldValue(bean: giftRecordInstance, field: 'giftChannel')}"  />


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
