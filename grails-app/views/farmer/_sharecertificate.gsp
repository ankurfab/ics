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
        padding: 1cm;
        #margin: 1cm;
        #border: 1px #D3D3D3 solid;
        #border-radius: 5px;
        background: white;
        #box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
    }
    .subpage {
        padding: 1cm;
        border: 5px red solid;
        height: 27.7cm;
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

<g:set var="nominalValue" value="${ics.Share.get(1).shareAmount}" />
<g:set var="today" value="${new Date()}" />


<div class="book">
<g:each var="farmer" in="${farmerList}">
<g:set var="shareCertificate" value="${ics.ShareCertificate.findByCertificateNo(farmer.shareCertificateNo)}" />
<g:set var="shares" value="${shareCertificate.shares.sort{it.id}}" />

<div class="page">
  <div class="subpage">
	<div>
		<p align="center">
		    Share Certificate
		</p>
		<p align="center">
		    <strong>[Pursuant to sub-section(3)of section 46 of the Companies Act, 2013 and rule 5(2)of the Companies (Share Capital and Debentures)Rule 2014]</strong>
		</p>
		<p>
		    RADHANATH SWAMI FARMERS PRODUCER COMPANY LIMITED.
		</p>
		<p>
		    <strong>Corporate Identification Number : U01403PN2014PTC15992</strong>
		</p>
		<p>
		    Registered Office: Radhanath Swami Farmers Producer Company Limited,
		</p>
		<p>
		    Water pump,Taradatta Park, Tal: Purandhar Dist: Pune412301,
		</p>
		<p>
		    Maharashtra, INDIA.
		</p>
		<p>
		    This is certify thst the person(s) named in this Certificate is /are the Registered Holder(s) of the within mentioned share(s) bearing the distinctive
		    numbers herein specified in the above named Company and the amount endorsed herein has been paid up on each such share.
		</p>
		<p>
		    EQUITY SHARES EACH OF RUPEES ${nominalValue}/- (NOMINAL VALUE)
		</p>
		<p>
		    AMOUNT PAID-UP PER SHARE RUPEES ${nominalValue}/-
		</p>
		<p>
		    Register Foilio No: ${farmer.folioNo} Certificate No: ${farmer.shareCertificateNo}
		</p>
		<p>
		    Name(s) of the Holder(s): ${farmer.firstName} ${farmer.middleName} ${farmer.lastName}
		</p>
		<p>
		    No. of Share held: ${shareCertificate.numShares.intValue()} (${org.apache.commons.lang.WordUtils.capitalize(EnglishNumberToWords.convert(shareCertificate.numShares?.toString()).replaceAll('Rs.','').replaceAll('Paise','').replaceAll('and zero',''))})
		</p>
		<p>
		    Distinctive No.(s): From ${shares.first().shareSerialNo} to ${shares.last().shareSerialNo}(Both inclusive)
		</p>
		<p>
		    Given under the common seal of the Company this ${today.format('dd')} day of ${today.format('MMMM')} ${today.format('yyyy')}
		</p>
		<p>
		    (1)Managing Director:
		    
		    
		</p>
		<p>
		    (2) Director:
		    
		    
		</p>
		<p>
		    (3)Secretary/ any other Authorized person:
		    
		    
		</p>
		<p>
		    Note: No transfer of the Share(s) comprised in the Certificate can be registered unless accompanied by this Certificate.
		</p>
	</div>
  </div><!-- subpage -->

 </div><!-- page -->

</g:each>
</div>

