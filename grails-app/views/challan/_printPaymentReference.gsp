<%@ page import="ics.EnglishNumberToWords" %>
<div>
	<table border="1">
		<tr>
			<td>
				Challan Number
			</td>
			<td>
				${challan.refNo}
			</td>
			<td>
				Challan Date
			</td>
			<td>
				${challan.issueDate?.format('dd-MM-yyyy HH:mm')}
			</td>
		</tr>
		<tr>
			<td>
				Issued To
			</td>
			<td>
				${challan.issuedTo}
			</td>
			<td>
				Issued To ICS Id
			</td>
			<td>
				${(challan.issuedTo?.icsid)}
			</td>
		</tr>
		<tr>
			<td>
				Payment Date
			</td>
			<td>
				<b>${paymentReference?.paymentDate?.format('dd-MM-yyyy')+" "+paymentReference?.dateCreated?.format('HH:mm')}</b>
			</td>
			<td>
				Payment Amount
			</td>
			<td>
				<g:set var="amountInWords" value="${''+EnglishNumberToWords.convert(paymentReference.amount?.toString())}"/>
				<b>Rs. ${paymentReference?.amount+"/- ("+org.apache.commons.lang.WordUtils.capitalize(amountInWords)	+" Only)"}</b>
			</td>
		</tr>
		<tr>
			<td>
				Payment Mode
			</td>
			<td>
				${paymentReference?.mode}
			</td>
			<td>
				Payment Details
			</td>
			<td>
				${paymentReference.details}
			</td>
		</tr>
		<tr>
			<td>
				Payment Received By
			</td>
			<td>
				${paymentReference?.paymentTo}
			</td>
			<td>
				Payment Receipt No
			</td>
			<td>
				<b>${paymentReference?.ref}</b>
			</td>
		</tr>
	</table>
</div>

