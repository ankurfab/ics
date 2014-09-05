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
	      <tr>
	      <td>
	      <b>General Reports</b>
	      </td>
	      </tr>
		<sec:ifAnyGranted roles="ROLE_ADMIN,ROLE_NVCC_ADMIN,ROLE_USER,ROLE_DUMMY,ROLE_BACKOFFICE">
		  <tr>
		    <td>
          		
          		<g:link controller="helper" action="dailyTransactionOnlineReport">Daily Transaction Report </g:link>
                    </td>
                  </tr>
	        
	      </sec:ifAnyGranted>
	      <sec:ifAnyGranted roles="ROLE_NVCC_ADMIN,ROLE_PATRONCARE,ROLE_PATRONCARE_USER">
		  <tr>
		    <td>
			<g:link controller="helper" action="patronCareSchemeReport">Report for Schemewise Donations </g:link>
		    </td>
                  </tr>
	      </sec:ifAnyGranted>
	      <sec:ifAnyGranted roles="ROLE_NVCC_ADMIN,ROLE_PATRONCARE,ROLE_PATRONCARE_USER">
		  <tr>
		    <td>
          		<g:link controller="helper" action="patronCareCollectionReport">Report for Collector (Patron)</g:link>
                    </td>
                  </tr>                   
	      </sec:ifAnyGranted>
	      <sec:ifAnyGranted roles="ROLE_NVCC_ADMIN,ROLE_PATRONCARE_HEAD">
		  <tr>
		    <td>
          		<g:link controller="helper" action="patronCareDonorReport">Master Report for All Donors</g:link>
                    </td>
                  </tr>                   
	      </sec:ifAnyGranted>
	      <sec:ifAnyGranted roles="ROLE_ADMIN,ROLE_NVCC_ADMIN">
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
          		<g:link controller="helper" action="familyDonationsViewReport">Family Donations Report</g:link>
                    </td>
                  </tr> 
		  <tr>
		    <td>
          		<g:link controller="helper" action="rolewiseAddressesReport">Rolewise Addresses Report </g:link>
                    </td>
                  </tr>
		  <tr>
		    <td>
          		<g:link controller="helper" action="amountReport">Search By Amount Report</g:link>
                    </td>
                  </tr>                  
	      </sec:ifAnyGranted>
	      
	      <sec:ifAnyGranted roles="ROLE_ADMIN,ROLE_NVCC_ADMIN">
	      <tr>
	      <td>
	      &nbsp;
	      </td>
	      </tr>
	      <tr>
	      <td>
	      <b>Counselor Counselee Reports</b>
	      </td>
	      </tr>
		  <tr>
		    <td>
          		<g:link controller="helper" action="datewiseCouncellorReport">Datewise Individual Counselor Counselee Report</g:link>
                    </td>
                  </tr>
		  <tr>
		    <td>
          		<g:link controller="helper" action="allCouncellorsCouncelleesSummaryReport">Datewise Counselor Counselee Report</g:link>
                    </td>
                  </tr>    
              </sec:ifAnyGranted>
              <sec:ifAnyGranted roles="ROLE_LOAN_USER">
	      <tr>
	      <td>
	      &nbsp;
	      </td>
	      </tr>
	      <tr>
	      <td>
	      <b>Advanced Donations Reports</b>
	      </td>
	      </tr>
		  <tr>
		    <td>
          		<g:link controller="helper" action="datewiseLoanReport">Datewise Advance Donation Report</g:link>
                    </td>
                  </tr>
		  <tr>
		    <td>
          		<g:link controller="helper" action="councellorLoanDetailedReport">Counselor-Wise Advance Donation Report</g:link>
                    </td>
                  </tr>    
              </sec:ifAnyGranted>
	      <sec:ifAnyGranted roles="ROLE_ADMIN,ROLE_NVCC_ADMIN">
	      <tr>
	      <td>
	      &nbsp;
	      </td>
	      </tr>
	      <tr>
	      <td>
	      <b>NVCC Sevak Reports</b>
	      </td>
	      </tr>
		  <tr>
		    <td>
          		<g:link controller="helper" action="nvccSevakReport">NVCC Sevak Report</g:link>                    </td>
                  </tr>
	      <tr>
	      <td>
	      &nbsp;
	      </td>
	      </tr>
	      <tr>
		      <td>
		      <b>Commitment Reports</b>
		      </td>
	      </tr>
		  <tr>
		    <td>
          		<g:link controller="helper" action="commitmentReport">Commitment Report</g:link>                    </td>
                  </tr>
	      <tr>
		      <td>
		      <b>Scheme Donor Reports</b>
		      </td>
	      </tr>
		  <tr>
		    <td>
          		<g:link controller="individual" action="schemeDonorList">Donor Report</g:link>                    </td>
                  </tr>

	      <tr>
		      <td>
		      <b>Donation Reports</b>
		      </td>
	      </tr>
		  <tr>
		    <td>
          		<g:link controller="helper" action="periodReport">Period Report</g:link>                    </td>
                  </tr>
		  <tr>
		    <td>
          		<g:link controller="helper" action="ocReport">Overall Collection Report</g:link>                    </td>
                  </tr>
		  <tr>
		    <td>
          		<g:link controller="helper" action="ccViewReport">Counsellor-Counsellee Report</g:link>                    </td>
                  </tr>
		  <!--<tr>
		    <td>
          		<g:link controller="helper" action="pcReport" params="['from':'2014-05-01 00:00:00','to':new Date().format('yyyy-MM-dd HH:mm:ss')]">PatronCare Collection Report</g:link>                    </td>
                  </tr>
		  <tr>
		    <td>
          		<g:link controller="helper" action="donationPeriodReport" params="['from':'2014-05-01 00:00:00','to':new Date().format('yyyy-MM-dd HH:mm:ss')]">Donation Report</g:link>                    </td>
                  </tr>
		  <tr>
		    <td>
          		<g:link controller="helper" action="donationRecordPeriodReport" params="['from':'2014-05-01 00:00:00','to':new Date().format('yyyy-MM-dd HH:mm:ss')]">Donation Report (for ECS/NEFT/Other online donations) </g:link>                    </td>
                  </tr>-->
		  <tr>
		    <td>
          		<g:link controller="helper" action="donationSummaryReport" params="['from':new Date().format('dd-MM-yyyy'),'till':new Date().format('dd-MM-yyyy')]">Today's Donation Summary Report</g:link>                    </td>
                  </tr>


              </sec:ifAnyGranted>
              
	      <!--<sec:ifAnyGranted roles="ROLE_NVCC_ADMIN,ROLE_PATRONCARE,ROLE_PATRONCARE_USER">

	        
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
	       -->     
	      
	       <!--<sec:ifAnyGranted roles="ROLE_ADMIN,ROLE_NVCC_ADMIN,ROLE_USER,ROLE_DUMMY,ROLE_BACKOFFICE">
		  <tr>
		    <td>
          		
          		<g:link controller="helper" action="dailyTransactionOnlineReport">Daily Transaction Report </g:link>
                    </td>
                  </tr>
	        
	      </sec:ifAnyGranted>
	       -->
	       <!--
	      <sec:ifAnyGranted roles="ROLE_ADMIN,ROLE_NVCC_ADMIN">
	            
	            
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
	           
		  <tr>
		    <td>
          		<g:link controller="helper" action="councellorReport">Overall Councellor Councellee Report</g:link>
                    </td>
                  </tr>
		  <tr>
		    <td>
          		<g:link controller="helper" action="datewiseCouncellorReport">Datewise Individual Counselor Counselee Report</g:link>
                    </td>
                  </tr>
		  <tr>
		    <td>
          		<g:link controller="helper" action="allCouncellorReport">All Councellors Report</g:link>
                    </td>
                  </tr>      
		  <tr>
		    <td>
          		<g:link controller="helper" action="allCouncellorsCouncelleesSummaryReport">Datewise Counselor Counselee Report</g:link>
                    </td>
                  </tr>                  
                  
		  <tr>
		    <td>
          		<g:link controller="helper" action="nvccSevakReport">NVCC Sevak Report</g:link>
                    </td>
                  </tr>                  
		
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
          		<g:link controller="helper" action="councellorLoanDetailedReport">Counselor-Wise Advance Donation Report</g:link>
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
	       -->
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
          		<g:link controller="helper" action="councellorLoanDetailedReport">Counselor-Wise Advance Donation Report</g:link>
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
	       <sec:ifAnyGranted roles="ROLE_DONATION_EXECUTIVE,ROLE_DONATION_HOD">
		  <tr>
		    <td>
          		&nbsp;
                    </td>
                  </tr>
		  <tr>
		    <td>
          		Scheme Reports
                    </td>
                  </tr>
		  <tr>
		    <td>
          		<g:link controller="helper" action="schemeSummaryReport">Summary Report</g:link>
                    </td>
                  </tr>
		  <tr>
	  
		    <td>
          		<g:link controller="helper" action="schemeIssueReport">Issue Report</g:link>
                    </td>
                  </tr>	       
		  <tr>
	  
		    <td>
          		<g:link controller="helper" action="schemeDonationRecordReport">Scheme Donation Record Report</g:link>
                    </td>
                  </tr>	   

            <tr>
	  
		    <td>
          		<g:link controller="helper" action="schemeMemberDonationReport">Scheme Member-Donation Report</g:link>
                    </td>
                  </tr>	  

              <tr>
	  
		    <td>
          		<g:link controller="helper" action="schemeMemberGiftReport">Scheme Member Gift Report</g:link>
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