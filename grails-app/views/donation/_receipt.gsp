<%@ page import="ics.EnglishNumberToWords" %>
<g:set var="addr" value="${ics.Address.findWhere(category:'Correspondence',individual:donationInstance.donatedBy)}" />
<g:set var="collType" value="DONATION" />
<g:set var="flgOtherCollType" value="" />
<g:if test="${donationInstance?.collectionType && donationInstance?.collectionType!="Donation"}">
	<g:set var="collType" value="${donationInstance?.collectionType}" />
	<g:set var="flgOtherCollType" value="set" />
</g:if>
<div>
<g:if test="${!firstTime}">
	<h1>Receipt already printed by ${donationInstance?.receiptPrintedBy} on ${donationInstance?.receiptPrintedOn}</h1>
</g:if>
</div>
<div style="padding-left:5em;">
<br>
<br>
<g:if test="${donationInstance?.taxBenefit}">
<br>
<br>
<g:img dir="images" file="80g.jpg"/>
</g:if>
<g:else>
<br>
<br>
</g:else>
<div style="text-align:left"><g:link controller="donation" action="entry" >ISKCON Pune <g:if test="${donationInstance?.taxBenefit}"><b>80G </b></g:if>Donation Receipt</g:link></div><br>
Receipt No: <b>${donationInstance.nvccReceiptBookNo}-${donationInstance.nvccReceiptNo}</b>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Receipt Date: <b>${donationInstance.fundReceiptDate?.format("dd-MM-yyyy")}</b><br>
Received with thanks a sum of &#8377;<b>${donationInstance.amount}/-</b><br>
<b>${org.apache.commons.lang.WordUtils.capitalize(EnglishNumberToWords.convert(donationInstance.amount?.toString()))} Only</b><br>
From <b>${donationInstance.donatedBy.legalName}</b>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Ics Donor Id: <b>${donationInstance.donatedBy.icsid}</b><br>
PAN No: <b>${donationInstance.donatedBy.panNo}</b><br>
Address: <b>${(addr?.addressLine1?:"") + " " + (addr?.pincode?:"")}</b><br>
<br>
On Account Of: <b>${collType}</b><br>
<br>
By: <b>${donationInstance.mode} ${donationInstance.mode?.name!="Cash"?(" No:"+donationInstance?.chequeNo+" Date: "+donationInstance?.chequeDate?.format("dd-MM-yyyy")+" Bank: "+donationInstance?.bankName+" Branch: "+donationInstance?.bankBranch):""}</b><br>
<g:if test="${flgOtherCollType=="set"}">
	Remarks: ${donationInstance?.comments}
</g:if><br>
<b>Note:</b>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Yours in the service of Lord Shri Krishna<br>
1. Cheque/Draft subject to realisation.
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
For ISKCON Pune
<g:if test="${donationInstance?.taxBenefit}"><br>2. For donation above Rs 10,000/- deduction u/s 80G<br>
is available only if the contribution is paid by <br>
crossed cheque/D.D./Credit/Debit card.
</g:if>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<b>${donationInstance.receivedBy?.toString()}</b><br>
</div>
<br>
<br>
<br>
<br><div style="padding-left:5em;">
<br>
<br>
<g:if test="${donationInstance?.taxBenefit}">
<g:img dir="images" file="80g.jpg"/>
</g:if>
<g:else>
<br>
<br>
</g:else>
<div style="text-align:left"><g:link controller="donation" action="entry" >ISKCON Pune <g:if test="${donationInstance?.taxBenefit}"><b>80G </b></g:if>Donation Receipt</g:link></div><br>
Receipt No: <b>${donationInstance.nvccReceiptBookNo}-${donationInstance.nvccReceiptNo}</b>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Receipt Date: <b>${donationInstance.fundReceiptDate?.format("dd-MM-yyyy")}</b><br>
Received with thanks a sum of &#8377;<b>${donationInstance.amount}/-</b><br>
<b>${org.apache.commons.lang.WordUtils.capitalize(EnglishNumberToWords.convert(donationInstance.amount?.toString()))} Only</b><br>
From <b>${donationInstance.donatedBy.legalName}</b>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Ics Donor Id: <b>${donationInstance.donatedBy.icsid}</b><br>
PAN No: <b>${donationInstance.donatedBy.panNo}</b><br>
Address: <b>${(addr?.addressLine1?:"") + " " + (addr?.pincode?:"")}</b><br>
<br>
On Account Of: <b>${collType}</b><br>
<br>
By: <b>${donationInstance.mode} ${donationInstance.mode?.name!="Cash"?(" No:"+donationInstance?.chequeNo+" Date: "+donationInstance?.chequeDate?.format("dd-MM-yyyy")+" Bank: "+donationInstance?.bankName+" Branch: "+donationInstance?.bankBranch):""}</b><br>
<g:if test="${flgOtherCollType=="set"}">
	Remarks: ${donationInstance?.comments}
</g:if><br>
<b>Note:</b>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Yours in the service of Lord Shri Krishna<br>
1. Cheque/Draft subject to realisation.
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
For ISKCON Pune
<g:if test="${donationInstance?.taxBenefit}"><br>2. For donation above Rs 10,000/- deduction u/s 80G<br>
is available only if the contribution is paid by <br>
crossed cheque/D.D./Credit/Debit card.
</g:if>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<b>${donationInstance.receivedBy?.toString()}</b><br>
</div>
