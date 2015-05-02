<g:if test="${amtBCInd > 0}">
<div style="background-color:#FF0000">
	<h2>Dishonoured Cheques</h2>
	<table >
	    <tbody>

		<tr>
		    <td valign="top" class="name">Individual:</td>

		    <td valign="top" class="value">${amtBCInd}</td>

			</tr>
		<tr>
		    <td valign="top" class="name">Family+Own:</td>

		    <td valign="top" class="value">${amtBCFam}</td>

			</tr>

	    </tbody>
</table>
</div>
</g:if>

<h2>Scheme Wise Donation Summary</h2>
<table cellspacing="0" cellpadding="0" align="left" border="0">
    <tbody>

<g:each in="${sList}" status="i" var="sInstance">

<tr>
    <td style="word-wrap: break-word" valign="top" class="name" width="50%" align="left" >${sInstance?.scheme}:</td>

    <td style="word-wrap: break-word" valign="middle" class="value" align="left" >${sInstance?.amt}</td>

	</tr>
    </g:each>
<g:each in="${sListDR}" status="i" var="sInstance">

<tr>
    <td style="word-wrap: break-word" valign="top" class="name" width="50%" align="left" >${sInstance?.scheme}*:</td>

    <td style="word-wrap: break-word" valign="middle" class="value" align="left" >${sInstance?.amt}</td>

	</tr>
    </g:each>
    </tbody>
</table>

<br><br><br>
<h2>Donation Summary</h2>
<table>
<tbody>

<tr>
    <td valign="top" class="name">Individual Donation:</td>

    <td style="word-wrap: break-word" valign="top" class="value">${((amtInd?:0)+(amtIndDR?:0))+" ("+(amtInd?:0)+" + "+(amtIndDR?:0)+"*)"}</td>

</tr>

<tr>
    <td valign="top" class="name">Family Donation:</td>

    <g:set var="fam" value="${(amtFam?:0) - (amtInd?:0)}" />

    <td style="word-wrap: break-word" valign="top" class="value">${fam?:''}</td>

</tr>
<g:if test="${isCollector == 'true'}">
	<tr>
	    <td valign="top" class="name" width="45%">Collection:</td>

	    <td style="word-wrap: break-word" valign="middle" class="value" align="left">${amtColExclOwn}</td>

	</tr>

</g:if>
</tbody>
</table>


<h2>Gifts Received Summary</h2>
<table>
    <tbody>

<tr>
    <td valign="top" class="name">Individual:</td>

    <td style="word-wrap: break-word" valign="top" class="value">${amtGiftInd}</td>

	</tr>

<tr>
    <td valign="top" class="name">Family+Own:</td>

    <td style="word-wrap: break-word" valign="top" class="value">${amtGiftFam}</td>

	</tr>
    </tbody>
</table>




<!--<g:if test="${isCollector == 'true'}">
	<h2>Collections Summary</h2>
	<table cellspacing="0" cellpadding="0" align="left" border="0">
	    <tbody>

		<tr>
		    <td valign="top" class="name" width="45%">Collection (incl own):</td>

		    <td style="white-space: -moz-pre-wrap" valign="middle" class="value" align="left" >${amtCol}</td>

		</tr>
		<tr>
		    <td valign="top" class="name" width="45%">Collection (excl own):</td>

		    <td style="word-wrap: break-word" valign="middle" class="value" align="left">${amtColExclOwn}</td>

		</tr>

	    </tbody>
</table>
</g:if>-->

<h2>Datewise Donations Summary</h2>
<table>
    <tbody>
		<thead>
			<th>Donation Date</th>
			<th>Donation Amount</th>
		</thead>
	<g:each in="${individualInstance.donations}" var="d">
		<tr>
			<td><g:formatDate format="dd-MM-yyyy" date="${d.donationDate}"/></td>
			<td>${d.amount}</td>
		</tr>
		<!--<li><g:link controller="donation" action="show" id="${d.id}">${d?.encodeAsHTML()}</g:link></li>-->
	</g:each>

    </tbody>
</table>