<%@ page import="ics.EnglishNumberToWords" %>

	<style type='text/css' media='print'>
    body {
        margin: 0;
        padding: 0;
        background-color: #FAFAFA;
        font: 12pt "Tahoma";
    }
    * {
        box-sizing: border-box;
        -moz-box-sizing: border-box;
    }
    .page {
        width: 21cm;
        height: 29.7cm;
        padding-left: 1.6cm;
        #margin: 1cm;
        #border: 1px #D3D3D3 solid;
        #border-radius: 5px;
        background: white;
        #box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
    }
    .subpageDonor {
        padding-top: 4.6cm;
        #border: 5px red solid;
        height: 148mm;
        #outline: 2cm #FFEAEA solid;
    }
    .subpageOffice {
        padding-top: 2cm;
        #border: 5px red solid;
        #height: 130mm;
        #outline: 2cm #FFEAEA solid;
    }

    @page {
        size: A4;
        margin: 0;
    }
    @media print {
	  html, body {
		width: 210mm;
		height: 297mm;
	  }
  		.page {
            margin: 0;
            border: initial;
            border-radius: initial;
            width: initial;
            min-height: initial;
            box-shadow: initial;
            background: initial;
            page-break-after: always;
        }
    }
	</style>

<div class="book">
<g:each var="dr" in="${drList}">

<g:set var="addr" value="${ics.Address.findWhere(category:'Correspondence',individual:dr.donatedBy)}" />
<g:set var="collType" value="DONATION" />
<g:set var="flgOtherCollType" value="" />
<div class="page">
  <div class="subpageDonor"> <!-- Donor Copy -->
	<div>
	<g:img dir="images" file="80gCropped.jpg"/><br>
	Receipt No: <b>${dr.rbno}-${dr.rno}</b>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	Receipt Date: <b>${dr.donationDate?.format("dd-MM-yyyy")}</b><br>
	Received with thanks a sum of &#8377;<b>${dr.amount}/-</b><br>
	<b>${org.apache.commons.lang.WordUtils.capitalize(EnglishNumberToWords.convert(dr.amount?.toString()))} Only</b><br>
	From <b>${dr.donatedBy.legalName}</b>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	Ics Donor Id: <b>${dr.donatedBy.icsid}</b><br>
	PAN No: <b>${dr.donatedBy.panNo}</b><br>
	Address: <b>${(addr?.addressLine1?:"") + " " + (addr?.pincode?:"")}</b><br>
	<br>
	On Account Of: <b>${collType}</b> By: <b>ECS ${dr.transactionId}</b><br>
	<br>
		<table>
			<tr><td>Yours in the service of Lord Shri Krishna</td></tr>
			<tr><td>For ISKCON Pune</td></tr>
			<tr><td></td></tr>
			<tr><td></td></tr>
			<tr><td></td></tr>
			<tr><td></td></tr>
			<tr><td></td></tr>
			<tr><td><b>${printedBy}</b></td></tr>
		</table>
	</div>
</div>  <!-- Donor Copy -->

<div class="subpageOffice">  <!-- Office Copy -->
	<div>
	<g:img dir="images" file="80gCropped.jpg"/><br>
	Receipt No: <b>${dr.rbno}-${dr.rno}</b>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	Receipt Date: <b>${dr.donationDate?.format("dd-MM-yyyy")}</b><br>
	Received with thanks a sum of &#8377;<b>${dr.amount}/-</b><br>
	<b>${org.apache.commons.lang.WordUtils.capitalize(EnglishNumberToWords.convert(dr.amount?.toString()))} Only</b><br>
	From <b>${dr.donatedBy.legalName}</b>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	Ics Donor Id: <b>${dr.donatedBy.icsid}</b><br>
	PAN No: <b>${dr.donatedBy.panNo}</b><br>
	Address: <b>${(addr?.addressLine1?:"") + " " + (addr?.pincode?:"")}</b><br>
	<br>
	On Account Of: <b>${collType}</b> By: <b>ECS ${dr.transactionId}</b><br>
	<br>
		<table>
			<tr><td>Yours in the service of Lord Shri Krishna</td></tr>
			<tr><td>For ISKCON Pune</td></tr>
			<tr><td></td></tr>
			<tr><td></td></tr>
			<tr><td></td></tr>
			<tr><td></td></tr>
			<tr><td><b>${printedBy}</b></td></tr>
		</table>
	</div>
</div> <!-- Office Copy -->

</div>

</g:each>
</div>

