
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
            <h1>Acknowledgement of Receipt Book(s) Returned</h1>
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

                        <tr class="prop">
                        	<g:if test="${councellorInstance != '' && councellorInstance != null}">
                        	    <td valign="top" class="name"><g:message code="receiptBookIssued.issuedTo.label" default="Councellee Of" /></td>
                            	<td valign="top" class="value"><g:link controller="individual" action="show" id="${councellorInstance?.id}">${councellorInstance.encodeAsHTML()}</g:link></td>
                            </g:if>
                            <g:if test="${IssuerRole1=='Guru'}">
                        	    <td valign="top" class="name"><g:message code="receiptBookIssued.issuedTo.label" default="Role" /></td>
                            	<td valign="top" class="value">Guru</td>
                            </g:if>
                            <g:if test="${IssuerRole2=='Councellor'}">
                        	    <td valign="top" class="name"><g:message code="receiptBookIssued.issuedTo.label" default="Role" /></td>
                            	<td valign="top" class="value">Councellor</td>
                            </g:if>
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
								<td valign="top" class="name"><b><g:message code="receiptBookIssued.id.label" default="Amount Collected" /></b></td>
							</tr>
							<g:each in="${ReceiptBooksReturned}" status="i" var="receiptBookIssuedInstance">
							 <tr>
								<td valign="top" class="value">${receiptBookIssuedInstance?.id}</td>
								<td valign="top" class="value">${receiptBookIssuedInstance?.receiptBook}</td>
								<td valign="top" class="value">${receiptBookIssuedInstance?.receiptBook?.numPages}</td>
								<td valign="top" class="value">${receiptBookIssuedInstance?.receiptBook?.startingReceiptNumber}</td>
								<td valign="top" class="value"><g:formatDate format="dd-MM-yyyy" date="${receiptBookIssuedInstance?.issueDate}" /></td>
								<td valign="top" class="value"><g:formatDate format="dd-MM-yyyy" date="${receiptBookIssuedInstance?.returnDate}" /></td>
								<td valign="top" class="value">${receiptBookIssuedInstance?.status}</td>
								<td valign="top" class="value">${SumAmountCollected[i]}</td>
							</tr>
							</g:each>
							<tr>
							<td colspan="6">
							<b>Total ${ReceiptBooksReturned.size()} Receipt Book(s) Returned.<b>
							</td>
							<td align="right">
							<b>Total
							</td>
							<td>
							${totalCollection}<b>
							</td>
							</tr>
							</tbody> 							
							</table>
							</td>
                        </tr>
                    
                        <!--<tr class="prop">
                            <td valign="top" class="name"><g:message code="receiptBookIssued.id.label" default="Id" /></td>
                            
                            <td valign="top" class="value"><g:formatNumber number="${receiptBookIssuedInstance?.id}" format="#" /></td>
                            
                        </tr>
                        
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="receiptBookIssued.id.receiptBook" default="Receipt Book" /></td>
                            
                            <td valign="top" class="value">${receiptBookIssuedInstance?.receiptBook}</td>
                            
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="receiptBookIssued.id.numPages" default="Number Of Pages" /></td>
                            
                            <td valign="top" class="value">${receiptBookIssuedInstance?.receiptBook?.numPages}</td>
                            
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="receiptBookIssued.id.startingReceiptNumber" default="Starting Receipt Number" /></td>
                            
                            <td valign="top" class="value">${receiptBookIssuedInstance?.receiptBook?.startingReceiptNumber}</td>
                            
                        </tr>
                        
                        
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="receiptBookIssued.issueDate.label" default="Issue Date" /></td>
                            
                            <td valign="top" class="value"><g:formatDate format="dd-MM-yyyy" date="${receiptBookIssuedInstance?.issueDate}" /></td>
                            
                        </tr>
                        
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="receiptBookIssued.updator.label" default="Returned To" /></td>
                            
                            <td valign="top" class="value">${updator}</td>
                            
                        </tr>                        
                        
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="receiptBookIssued.issueDate.label" default="Return Date" /></td>
                            
                            <td valign="top" class="value"><g:formatDate format="dd-MM-yyyy" date="${receiptBookIssuedInstance?.returnDate}" /></td>
                            
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="receiptBookIssued.status.receiptBook" default="Status" /></td>
                            
                            <td valign="top" class="value">${receiptBookIssuedInstance?.status}</td>
                            
                        </tr>                        
                         
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="receiptBookIssued.status.receiptBook" default="Amount Collected (Including Own)" /></td>
                            
                            <td valign="top" class="value">${amtCol}</td>
                            
                        </tr>
                       
                        
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="receiptBookIssued.status.receiptBook" default="Amount Collected (Excluding Own)" /></td>
                            
                            <td valign="top" class="value">${amtColExclOwn}</td>
                            
                        </tr>                        

                        -->
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
