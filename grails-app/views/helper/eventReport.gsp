<html>
    <head>
        <title></title>
		<meta name="layout" content="main" />
		
	
    </head>
    <body>
    

			<div id="body">
	        <h1>Reports</h1>
	           <!--<br> -->
	           <div id="controllerList" class="dialog">
		    				<!--<h2>Available Reports:</h2>-->

	            <!--<ul>-->
	      <table>
	      <!--<thead>
	      <tr>
		      <th>
		      		<b>Report</b>
		      </th>
	      </tr>
	      </thead>-->
		<tbody bgcolor="lavender">
	      <sec:ifAnyGranted roles="ROLE_VOICE_ADMIN">
		  <tr>
		    <td>
          		<g:link controller="helper" action="bookReport">Books Read Report</g:link>
                    </td>
                  </tr>
		  <tr>
		    <td>
          		<g:link controller="helper" action="courseReport">Course Report</g:link>
                    </td>
                  </tr>
		  <tr>
		    <td>
          		<g:link controller="helper" action="sevaReport">Service Report</g:link>
                    </td>
                  </tr>
	      		
	      </sec:ifAnyGranted>
	      <sec:ifAnyGranted roles="ROLE_NVCC_ADMIN,ROLE_PATRONCARE,ROLE_PATRONCARE_USER">

	        
		  <tr>
		    <td>

          		<g:link controller="helper" action="birthdayReport">Birthday Report of Donors </g:link>
                    </td>
                  </tr>
		  <tr>
		    <td>

          		<g:link controller="helper" action="marriageAnniversaryReport">Marriage Anniversary Report of Donors </g:link>
                    </td>
                  </tr>                  
		  <tr>
		    <td>
          		<g:link controller="helper" action="patronCareSchemeReport">Report for Schemewise Donations </g:link>
                    </td>
                  </tr>
		  <tr>
		    <td>
          		<g:link controller="helper" action="patronCareCollectionReport">Report for Collector </g:link>
                    </td>
                  </tr>                  
		  <tr>
		    <td>
          		<g:link controller="helper" action="patronCareAmountReport">Search By Amount Report</g:link>
                    </td>
                  </tr>

		  <tr>
		    <td>
          		<g:link controller="helper" action="receiptBookIssuedViewReport">Receipt Books Issued Report</g:link>
                    </td>
                  </tr>	      		
	      </sec:ifAnyGranted>
	            
	      
	       <sec:ifAnyGranted roles="ROLE_ADMIN,ROLE_NVCC_ADMIN,ROLE_USER,ROLE_DUMMY,ROLE_BACKOFFICE">
		  <tr>
		    <td>
          		<!--<g:link controller="helper" action="dailyTransactionOnlineReport" params="[first:true]">Daily Transaction Report (OnLine)</g:link>-->
          		<g:link controller="helper" action="dailyTransactionOnlineReport">Daily Transaction Report </g:link>
                    </td>
                  </tr>
	            <!--<li class="controller">
          		<g:link controller="helper" action="dailyTransactionReport">Daily Transaction Report </g:link>
	            </li>-->
	      </sec:ifAnyGranted>
	      <sec:ifAnyGranted roles="ROLE_ADMIN,ROLE_NVCC_ADMIN">
	            
	            <!--<li class="controller">
          		<g:link controller="helper" action="dailyTransactionReport">Daily Transaction Report </g:link>
	            </li>-->	            
		  <tr>
		    <td>
          		<g:link controller="helper" action="areawiseCollectionReport">Areawise Collections Report</g:link>
                    </td>
                  </tr>
		  <tr>
		    <td>
          		<g:link controller="helper" action="citywiseCollectionReport">Citywise Collections Report</g:link>
                    </td>
                  </tr>                  
		  <tr>
	  
		    <td>
          		<g:link controller="helper" action="schemeReport">Report for Schemewise Donations </g:link>
                    </td>
                  </tr>
		  <!--<tr>
		    <td>
          		<g:link controller="helper" action="schemewiseIndividualsReport">Report for Schemewise Individuals </g:link>
                    </td>
                  </tr>
		  <tr>
		    <td>
          		<g:link controller="helper" action="individualwiseSchemesReport">Report for Individualwise Schemes </g:link>
	            </td>
	          </tr>-->
	            <!--<li class="controller">
          		<g:link controller="helper" action="cultivatorReport">Report for ISKCON representative</g:link>
	            </li>-->
		  <tr>
		    <td>
          		<g:link controller="helper" action="collectorReport">Report for Collector </g:link>
                    </td>
                  </tr>
		  <tr>
		    <td>
          		<g:link controller="helper" action="collectorwiseDonorsReport">Report for Collectorwise Donors</g:link>
                    </td>
                  </tr>
		  <tr>
		    <td>
          		<g:link controller="helper" action="allCollectionsReport">All Collections Report</g:link>
                    </td>
                  </tr>                  
	            <!--<li class="controller">
          		<g:link controller="helper" action="collectorAmountSchemeReport">Report for Collector_Amount_Scheme</g:link>
	            </li>-->
		  <tr>
		    <td>
          		<g:link controller="helper" action="councellorReport">Overall Councellor Councellee Report</g:link>
                    </td>
                  </tr>
		  <tr>
		    <td>
          		<g:link controller="helper" action="datewiseCouncellorReport">Datewise Councellor Councellee Report</g:link>
                    </td>
                  </tr>
		  <tr>
		    <td>
          		<g:link controller="helper" action="allCouncellorReport">All Councellors Report</g:link>
                    </td>
                  </tr>      
		  <tr>
		    <td>
          		<g:link controller="helper" action="allCouncellorsCouncelleesSummaryReport">All Councellors Councellees Summary Report</g:link>
                    </td>
                  </tr>                  
                  
		  <tr>
		    <td>
          		<g:link controller="helper" action="nvccSevakReport">NVCC Sevak Report</g:link>
                    </td>
                  </tr>                  
		  <!--<tr>
		    <td>
          		<g:link controller="helper" action="allCouncellorsViewReport">All Councellors Report</g:link>
                    </td>
                  </tr>-->
		  <tr>
		    <td>
          		<g:link controller="helper" action="amountReport">Search By Amount Report</g:link>
                    </td>
                  </tr>
		  <tr>
		    <td>
          		<g:link controller="helper" action="rolewiseAddressesReport">Rolewise Addresses Report </g:link>
                    </td>
                  </tr>
		  <!--<tr>
		    <td>
          		<g:link controller="helper" action="addressBySchemeReport">Address By Scheme Report </g:link>
                    </td>
                  </tr>-->
	            <!--<li class="controller">
          		<g:link controller="helper" action="addressByDonationReport">Address By Donation Report </g:link>
	            </li>-->	
		  <tr>
		    <td>
          		<g:link controller="helper" action="nameInPadaSevaBookReport">Name In Pada Seva Book Report</g:link>
                    </td>
                  </tr>
		  <tr>
		    <td>
          		<g:link controller="helper" action="familyDonationsViewReport">Family Donations Report</g:link>
                    </td>
                  </tr>
		  <tr>
		    <td>
          		<g:link controller="helper" action="loanSummaryReport">Advance Donation Report (Summary)</g:link>
                    </td>
                  </tr>
		  <tr>
		    <td>
          		<g:link controller="helper" action="loanDetailedReport">Advance Donation Report (Detailed)</g:link>
                    </td>
                  </tr>
		  <tr>
		    <td>
          		<g:link controller="helper" action="councellorLoanSummaryReport">Councellorwise Advance Donation Report (Summary)</g:link>
                    </td>
                  </tr>
		  <tr>
		    <td>
          		<g:link controller="helper" action="councellorLoanDetailedReport">Councellorwise Advance Donation Report (Detailed)</g:link>
                    </td>
                  </tr>
		  <tr>
		    <td>
          		<g:link controller="helper" action="individualLoanDetailedReport">Individualwise Advance Donation Report (Detailed)</g:link>
                    </td>
                  </tr>
		  <tr>
		    <td>
          		<g:link controller="helper" action="datewiseLoanReport">Datewise Advance Donation Report</g:link>
                    </td>
                  </tr>
	            
	            
	       </sec:ifAnyGranted>
	       <sec:ifAnyGranted roles="ROLE_LOAN_USER">
		  <tr>
		    <td>
          		<g:link controller="helper" action="loanSummaryReport">Advance Donation Report (Summary)</g:link>
                    </td>
                  </tr>
		  <tr>
		    <td>
          		<g:link controller="helper" action="loanDetailedReport">Advance Donation Report (Detailed)</g:link>
                    </td>
                  </tr>
		  <tr>
		    <td>
          		<g:link controller="helper" action="councellorLoanSummaryReport">Councellorwise Advance Donation Report (Summary)</g:link>
                    </td>
                  </tr>
		  <tr>
		    <td>
          		<g:link controller="helper" action="councellorLoanDetailedReport">Councellorwise Advance Donation Report (Detailed)</g:link>
                    </td>
                  </tr>
		  <tr>
		    <td>
          		<g:link controller="helper" action="individualLoanDetailedReport">Individualwise Advance Donation Report (Detailed)</g:link>
                    </td>
                  </tr>
		  <tr>
		    <td>
          		<g:link controller="helper" action="datewiseLoanReport">Datewise Advance Donation Report</g:link>
                    </td>
                  </tr>
	            
	       
	       </sec:ifAnyGranted>
	       <sec:ifAnyGranted roles="ROLE_PATRONCARE_USER">
		  <tr>
		    <td>
          		&nbsp;
                    </td>
                  </tr>
		  <tr>
		    <td>
          		Generic Reports
                    </td>
                  </tr>
		  <tr>
		    <td>
          		<g:link controller="helper" action="amountReport">Search By Amount Report</g:link>
                    </td>
                  </tr>
		  <tr>
	  
		    <td>
          		<g:link controller="helper" action="schemeReport">Report for Schemewise Donations </g:link>
                    </td>
                  </tr>
		  <tr>
		    <td>
          		<g:link controller="helper" action="areawiseCollectionReport">Areawise Collections Report</g:link>
                    </td>
                  </tr>
		  <tr>
		    <td>
          		<g:link controller="helper" action="citywiseCollectionReport">Citywise Collections Report</g:link>
                    </td>
                  </tr>                  
		  <tr>
		    <td>
          		<g:link controller="helper" action="familyDonationsViewReport">Family Donations Report</g:link>
                    </td>
                  </tr>
		  <tr>
		    <td>
          		<g:link controller="helper" action="nvccSevakReport">NVCC Sevak Report</g:link>
                    </td>
                  </tr>                  
	       
	       </sec:ifAnyGranted>
	       </tbody>
	   </table>
	            <!--</ul>-->
	</div>
	</div>
	
    </body>
</html>