
<%@ page import="ics.ReceiptBookIssued" %>
<html>
    <head>
        <!--<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />-->
        <meta name="layout" content="print" />
        <g:set var="entityName" value="${message(code: 'receiptBookIssued.label', default: 'ReceiptBookIssued')}" />
        <!--<title><g:message code="default.show.label" args="[entityName]" /></title>
        <title>Acknowledgement</title>
    </head>
    <body>
        <!--<div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}">Home</a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="Issue ReceiptBook" /></g:link></span>
        </div>-->
        <div class="body">
            <g:link class="list" action="list"><h1>Acknowledgement of Receipt Book Returned</h1></g:link>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
                <table border="0">
                    <tbody>
                  
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="receiptBookIssued.issuedTo.label" default="Issued To" /></td>
                            
                            <td valign="top" class="value"><g:link controller="individual" action="show" id="${receiptBookIssuedInstance?.issuedTo?.id}">${receiptBookIssuedInstance?.issuedTo?.encodeAsHTML()}</g:link></td>
                        </tr>
                        
                         <tr >
                         	<td colspan="2" width="60%">
                         	<table width="40%">
                         	<tbody>
                         	<tr>
								<td valign="top" class="name"><b><g:message code="receiptBookIssued.id.label" default="Id" /></b></td>
								<td valign="top" class="name"><b><g:message code="receiptBookIssued.id.receiptBook" default="Receipt Book" /></b></td>
								<td valign="top" class="name"><b><g:message code="receiptBookIssued.id.numPages" default="Number Of Pages" /></b></td>
								<td valign="top" class="name"><b><g:message code="receiptBookIssued.id.startingReceiptNumber" default="Starting Receipt Number" /></b></td>
								<td valign="top" class="name"><b><g:message code="receiptBookIssued.id.issueDate" default="Issue Date" /></b></td>
								<td valign="top" class="name"><b><g:message code="receiptBookIssued.id.returnDate" default="Return Date" /></b></td>
								<td valign="top" class="name"><b><g:message code="receiptBookIssued.status.label" default="Status" /></b></td>
								<td valign="top" class="name"><b><g:message code="receiptBookIssued.id.label" default="Cash Amount Collected" /></b></td>
								<td valign="top" class="name"><b><g:message code="receiptBookIssued.id.label" default="Cheque Amount Collected" /></b></td>
								<td valign="top" class="name"><b><g:message code="receiptBookIssued.id.label" default="Total Amount Collected" /></b></td>
							</tr>
							 <tr>
								<td valign="top" class="value">${receiptBookIssuedInstance?.id}</td>
								<td valign="top" class="value">${receiptBookIssuedInstance?.receiptBook}</td>
								<td valign="top" class="value">${receiptBookIssuedInstance?.receiptBook?.numPages}</td>
								<td valign="top" class="value">${receiptBookIssuedInstance?.receiptBook?.startingReceiptNumber}</td>
								<td valign="top" class="value"><g:formatDate format="dd-MM-yyyy" date="${receiptBookIssuedInstance?.issueDate}" /></td>
								<td valign="top" class="value"><g:formatDate format="dd-MM-yyyy" date="${receiptBookIssuedInstance?.returnDate}" /></td>
								<td valign="top" class="value">${receiptBookIssuedInstance?.status}</td>
								<td valign="top" class="value">${receiptBookIssuedInstance?.tempCash}</td>
								<td valign="top" class="value">${receiptBookIssuedInstance?.tempCheque}</td>
								<td valign="top" class="value">${(receiptBookIssuedInstance?.tempCash?:0)+(receiptBookIssuedInstance?.tempCheque?:0)}</td>
							</tr>
							</tbody> 							
							</table>
							</td>
                        </tr>

                       <tr rowspan="2">
                       <td colspan="4"><br>
                       Signature (Collector):......................................
                       <br>
                       ${updator}
						<br><br><br>                       
                       Signature (Receiver):...................................... Date: ${new Date().format('dd-MM-yyyy')}
                       </td>
                       </tr>
                    
                    </tbody>
                </table>
            </div>
            
			<g:form>
				<g:hiddenField name="id" value="${receiptBookIssuedInstance?.id}" />


			   <!-- <span class="button" id="printBtn"><g:actionSubmit class="edit" action="list" value="Print" onclick="hidePrintButton()"/></span>-->


			</g:form>
            
        </div>
        
    </body>
</html>
