<%@ page import="ics.EnglishNumberToWords" %>
<g:set var="addr" value="${ics.Address.findWhere(category:'Correspondence',individual:donationRecordInstance.donatedBy)}" />
<div style="padding-left:5em;">
<br>
<br>
<br>
<br>
<div style="text-align:left"><g:link controller="donationRecord" action="quickCreate" >ISKCON Pune Donation Receipt</g:link></div><br>
Receipt No: <b>${donationRecordInstance.id}</b>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Receipt Date: <b>${donationRecordInstance.donationDate?.format("dd-MM-yyyy")}</b><br>
Received with thanks a sum of Rs: <b>${donationRecordInstance.amount}/-</b><br>
<b>${EnglishNumberToWords.convert(donationRecordInstance.amount?.toString())} Only</b><br>
From <b>${donationRecordInstance.donatedBy.legalName}</b>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Ics Donor Id: <b>${donationRecordInstance.donatedBy.icsid}</b><br>
PAN No: <b>${donationRecordInstance.donatedBy.panNo}</b><br>
Address: <b>${(addr?.addressLine1?:"") + " " + (addr?.pincode?:"")}</b><br>
<br>
On Account Of: <b>${donationRecordInstance?.scheme}</b><br>
<br>
By: <b>${donationRecordInstance.mode} ${donationRecordInstance.mode?.name!="Cash"?(" No:"+donationRecordInstance?.transactionId+" Bank: "+donationRecordInstance?.paymentDetails):""}</b><br>
<br>
<b>Note:</b>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Yours in the service of Lord Shri Krishna<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<b>${donationRecordInstance?.creator}</b><br>
1. Cheque/Draft subject to realisation.
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
For ISKCON Pune
</div>
