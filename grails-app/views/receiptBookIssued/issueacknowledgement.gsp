
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
            <g:link class="list" action="list"><h1>Acknowledgement of Receipt Book(s) Issued</h1></g:link>
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
                    
                        
                        <!--<tr class="prop">
                        	<g:if test="${councellorInstance != '' && councellorInstance != null}">
                        	    <td valign="top" class="name"><g:message code="receiptBookIssued.issuedTo.label" default="Councellor" /></td>
                            	<td valign="top" class="value"><g:link controller="individual" action="show" id="${councellorInstance?.id}">${councellorInstance.encodeAsHTML()}</g:link> (${ ics.VoiceContact.findByIndividualAndCategory(councellorInstance,"CellPhone")})</td>
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
                        -->

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="receiptBookIssued.updator.label" default="Issuer" /></td>
                            
                            <td valign="top" class="value">${issuer}</td>
                            
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
					<td valign="top" class="name"><b><g:message code="receiptBookIssued.id.issuedTo" default="Issued To" /></b></td>
					<td valign="top" class="name"><b>Councellor</b></td>
					<td valign="top" class="name"><b><g:message code="receiptBookIssued.id.issueDate" default="Issue Date" /></b></td>
				</tr>
				<g:each in="${ids}" status="i" var="receiptBookIssuedInstance">
				 <tr>
					<td valign="top" class="value">${receiptBookIssuedInstance?.id}</td>
					<td valign="top" class="value">${receiptBookIssuedInstance?.receiptBook}</td>
					<td valign="top" class="value">${receiptBookIssuedInstance?.receiptBook?.numPages}</td>
					<td valign="top" class="value">${receiptBookIssuedInstance?.receiptBook?.startingReceiptNumber}</td>
					<td valign="top" class="value">${receiptBookIssuedInstance?.issuedTo} <g:if test="${ ics.VoiceContact.findByIndividualAndCategory(receiptBookIssuedInstance?.issuedTo,"CellPhone")}">(${ ics.VoiceContact.findByIndividualAndCategory(receiptBookIssuedInstance?.issuedTo,"CellPhone")})</g:if></td>
					<g:set var="crel" value="${ics.Relation.findByName('Councellee of')}" />
					<g:set var="counsellor" value="${ics.Relationship.findByIndividual1AndRelation(receiptBookIssuedInstance.issuedTo,crel)?.individual2}" />
					<td valign="top" class="value">${counsellor} <g:if test="${ ics.VoiceContact.findByIndividualAndCategory(counsellor,"CellPhone")}">(${ ics.VoiceContact.findByIndividualAndCategory(counsellor,"CellPhone")})</g:if></td>
					<td valign="top" class="value">${receiptBookIssuedInstance?.issueDate?.format("dd-MM-yyyy")}</td>
				</tr>
				</g:each>
				<tr>
				<td colspan="7">
				<b>Total ${ids.size()} Receipt Book(s) Issued.<b>
				</td>
				</tr>
				</tbody> 							
				</table>
				</td>
                        </tr>
                       <tr rowspan="2">
                       <td colspan="4"><br>
                       Signature (Issuer):......................................
						<br><br><br>                      
                       Signature (Collector):......................................
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
