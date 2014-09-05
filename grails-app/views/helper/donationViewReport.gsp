<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Donation Report</title>
   </head>
    <body>
        <div class="body">
            <div class="nav">
			    <g:link controller="helper" action="commitmentReport">Commitment Report (last 12 months)</g:link>
        	</div><br>
           <g:each in="${clorSummaryList}" status="csCounter" var="clorSummary">
            <div>
            	<h1>Summary for Counsellor : ${clorSummary.clor}</h1>            	
            	<g:each in="${clorSummary.cleeSummaryList}" status="cleeSummaryCounter" var="cleeSummary">
			<g:link controller="individual" action="show" id="${cleeSummary.cleeid}"><h2>Summary for Counsellee : ${cleeSummary.clee}</h2></g:link>
			<table>
			    <thead>
				<tr>
					<th>Scheme</th>
					<th>Commitment</th>
					<g:set var="numPeriods" value="${ics.Period.count()}" />
					<g:each in="${ics.Period.list([sort:'id'])}" status="j" var="period">
						<th>${period.name}</th>
					</g:each>
					<th>Total</th>
				</tr>
			    </thead>
			    <tbody>
			    <g:each in="${cleeSummary.summaryRows}" status="i" var="it">
				<tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
				    <td>${it.scheme}</td>
				    <td>${it.commitment}</td>
				    <g:set var="indDonationTotal" value="${0}" />
				    <g:set var="indDonationRecTotal" value="${0}" />
				    <g:set var="indCollectionTotal" value="${0}" />
					<g:each in="${0..(numPeriods-1)}" status="j" var="mon">
						<td>${"D:"+(it.indDonation[j]?:'')+" DR:"+(it.indDonationRec[j]?:'')+" C:"+(it.indCollection[j]?:'')}</td>
						<g:set var="indDonationTotal" value="${indDonationTotal+(it.indDonation[j]?:0)}" />
						<g:set var="indDonationRecTotal" value="${indDonationRecTotal+(it.indDonationRec[j]?:0)}" />
						<g:set var="indCollectionTotal" value="${indCollectionTotal+(it.indCollection[j]?:0)}" />
					</g:each>
				    <td>${"DT:"+indDonationTotal+" DRT:"+ indDonationRecTotal+" CT:"+ indCollectionTotal+" Overall: "+(indDonationTotal+indDonationRecTotal+indCollectionTotal)}</td>
				</tr>
			    </g:each>
			    </tbody>
			</table>
               </g:each>
            </div>
           </g:each>
        </div>
    </body>
</html>