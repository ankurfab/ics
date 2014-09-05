
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
            <h1>Acknowledgement of Receipt Book(s) Issued</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
                <table border="0">
                    <tbody>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="receiptBookIssued.batchId.label" default="Batch Id" /></td>
                            
                            <td valign="top" class="value"><g:formatNumber number="${receiptBookIssuedInstance?.batchId}" format="#" /></td>
                            
                        </tr>
                    
                        <!--<tr class="prop">
                            <td valign="top" class="name"><g:message code="receiptBookIssued.id.label" default="Id" /></td>
                            
                            <td valign="top" class="value"><g:formatNumber number="${receiptBookIssuedInstance?.id}" format="#" /></td>
                            
                        </tr>-->
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="receiptBookIssued.issuedTo.label" default="Issued To" /></td>
                            
                            <td valign="top" class="value"><g:link controller="individual" action="show" id="${receiptBookIssuedInstance?.issuedTo}">${receiptBookIssuedInstance?.issuedTo?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                        
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="receiptBookIssued.issueDate.label" default="Issue Date" /></td>
                            
                            <td valign="top" class="value"><g:formatDate format="dd-MM-yyyy" date="${receiptBookIssuedInstance?.issueDate}" /></td>
                            
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="receiptBookIssued.updator.label" default="Issued By" /></td>
                            
                            <td valign="top" class="value">${issuer}</td>
                            
                        </tr>
                        
                        
                         <tr >
                         	<td colspan="2" width="60%">
                         	<table width="40%">
                         	<tbody>
                         	<tr>
								<td valign="top" class="name"><b><g:message code="receiptBookIssued.id.label" default="Id" /></b></td>
								<td valign="top" class="name"><b><g:message code="receiptBookIssued.id.receiptBook" default="ReceiptBook" /></b></td>
								<td valign="top" class="name"><b><g:message code="receiptBookIssued.id.numPages" default="Number Of Pages" /></b></td>
								<td valign="top" class="name"><b><g:message code="receiptBookIssued.id.startingReceiptNumber" default="Starting Receipt Number" /></b></td>
							</tr>
							<g:each in="${ids}" status="i" var="receiptBookIssuedInstance">
							 <tr>
								<td valign="top" class="value">${receiptBookIssuedInstance?.id}</td>
								<td valign="top" class="value">${receiptBookIssuedInstance?.receiptBook}</td>
								<td valign="top" class="value">${receiptBookIssuedInstance?.receiptBook?.numPages}</td>
								<td valign="top" class="value">${receiptBookIssuedInstance?.receiptBook?.startingReceiptNumber}</td>
							</tr>
							</g:each>
							<tr>
							<td colspan="4">
							<b>Total ${ids.size()} Receipt Book(s) Issued.<b>
							</td>
							</tr>
							</tbody> 							
							</table>
							</td>
                        </tr>
                       <tr rowspan="2">
                       <td colspan="4"><br>
                       Signature (Issuer):..................
						<br><br>                       
                       Signature (Collector):..................
                       </td>
                       </tr>
                    
                    </tbody>
                </table>
            </div>
            
			<g:form>
				<g:hiddenField name="id" value="${receiptBookIssuedInstance?.id}" />
				<g:hiddenField name="batchId" value="${receiptBookIssuedInstance?.batchId}" />


			   <!-- <span class="button" id="printBtn"><g:actionSubmit class="edit" action="list" value="Print" onclick="hidePrintButton()"/></span>-->


			</g:form>
            
        </div>
        
    </body>
</html>
