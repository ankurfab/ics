		      <div id="menu">
		      <sec:ifLoggedIn>
			<ul>
			      <sec:ifAnyGranted roles="ROLE_ASMT_ADMIN">
			      	<li><g:link controller="assessment" action="index">Assessment</g:link></li>
			      </sec:ifAnyGranted>      
			      <sec:ifAnyGranted roles="ROLE_ASMT_ADMIN,ROLE_ASMT_MGR">
			      	<li><g:link controller="assessment" action="registrations">Registrations</g:link></li>
			      	<li><g:link controller="assessment" action="dashboard">Dashboard</g:link></li>
			      	<li><g:link controller="assessment" action="feedbacks">Feedbacks</g:link></li>
			      </sec:ifAnyGranted>      
			      <sec:ifAnyGranted roles="ROLE_VOICE_SEC">
			      	<li><g:link controller="individual" action="createprofile">Profile Management</g:link></li>
			      </sec:ifAnyGranted>      
			      <sec:ifAnyGranted roles="ROLE_VOICE_ADMIN">
				  <li><g:link controller="individual" action="ccList">Counsellor-Counsellee Management</g:link></li>
				  <li><g:link controller="role" action="gridList">Group</g:link></li>
				  <li><g:link controller="book" action="gridList">Books</g:link></li>
				  <li><g:link controller="course" action="gridList">Courses</g:link></li>
				  <li><g:link controller="event" action="gridList">Events</g:link></li>
				  <li><g:link controller="seva" action="gridList">Seva</g:link></li>
				  <li><g:link controller="skill" action="gridList">Skills</g:link></li>
			      </sec:ifAnyGranted>      

			      <sec:ifAnyGranted roles="ROLE_PATRONCARE,ROLE_PATRONCARE_USER">
			          <li ><g:link id="pendingItemsMenu" controller="helper" action="pendingItems">Pending Items</g:link></li>
			      </sec:ifAnyGranted> 
		      	      <sec:ifAnyGranted roles="ROLE_PATRONCARE,ROLE_PATRONCARE_USER">
		      	      	  <li><g:link controller="person" action="list">Local Contacts</g:link></li>
		      	      	  <li><g:link controller="individual" action="index">Central Contacts</g:link></li>
		      	      	  <li><g:link controller="donationRecord" action="quickCreate">Donation Record</g:link></li>
				  <!--<li><g:link controller="followup" action="listforindividual" params="['indid':session.individualid]">Followup</g:link></li>-->
				  <li><g:link controller="followup" action="list1" >Followup</g:link></li>
		      	      </sec:ifAnyGranted>
			      <sec:ifAnyGranted roles="ROLE_NVCC_ADMIN,ROLE_BACKOFFICE,ROLE_PATRONCARE_HEAD">
				  <li><g:link controller="individual" action="list">Individual</g:link></li>
			      </sec:ifAnyGranted>
			      <sec:ifAnyGranted roles="ROLE_NVCC_ADMIN,ROLE_DUMMY,ROLE_BACKOFFICE">
				  <li><g:link controller="donation" action="entry">Donation</g:link></li>
 				  <li><g:link controller="donationRecord" action="list">Donation Record</g:link></li>
			      </sec:ifAnyGranted>
			      <sec:ifAnyGranted roles="ROLE_NVCC_ADMIN,ROLE_LOAN_USER">
				  <li><g:link controller="loan" action="list">Advance Donation</g:link></li>
		              </sec:ifAnyGranted>
		              <sec:ifAnyGranted roles="ROLE_NVCC_ADMIN,ROLE_DUMMY,ROLE_BACKOFFICE">
				  <li><g:link controller="individual" action="list">Search</g:link></li>
			      </sec:ifAnyGranted>
			      <sec:ifAnyGranted roles="ROLE_NVCC_ADMIN,ROLE_DUMMY,ROLE_BACKOFFICE">
				  <li><g:link controller="denomination" action="create">Denomination</g:link></li>
			      </sec:ifAnyGranted>
			      <sec:ifAnyGranted roles="ROLE_NVCC_ADMIN,ROLE_PATRONCARE,ROLE_PATRONCARE_USER,ROLE_DUMMY">
				  <li><g:link controller="lifeMembershipCard" action="list">Life Patron Card</g:link></li>
			      </sec:ifAnyGranted>
			      <sec:ifAnyGranted roles="ROLE_PATRONCARE">
				  <li><g:link controller="helper" action="patronCareDashboardInput">Dashboard</g:link></li>
			      </sec:ifAnyGranted>
			      <sec:ifAnyGranted roles="ROLE_NVCC_ADMIN,ROLE_DUMMY,ROLE_BACKOFFICE,ROLE_LOAN_USER,ROLE_PATRONCARE,ROLE_PATRONCARE_USER">
				  <li><g:link controller="helper" action="reports">Reports</g:link></li>
			      </sec:ifAnyGranted>
			      <sec:ifAnyGranted roles="ROLE_NVCC_ADMIN">
				  <li><g:link controller="helper" action="dashboardInput">Dashboard</g:link></li>
			      </sec:ifAnyGranted>
			      <sec:ifAnyGranted roles="ROLE_ADMIN,ROLE_NVCC_ADMIN">
				  <li><g:link controller="helper" action="advanced">Advanced</g:link></li>
			      </sec:ifAnyGranted>
			      <sec:ifAnyGranted roles="ROLE_DUMMY,ROLE_BACKOFFICE">
				  <!--<li><g:link controller="donation" action="bulkdonation0">Donation</g:link></li>-->
				  <li><g:link controller="receiptBookIssued" action="list">Receipt Book</g:link></li>
			      </sec:ifAnyGranted>

			      <sec:ifAnyGranted roles="ROLE_USER">
				  <li><g:link controller="individual" action="list">Search</g:link></li>
			      </sec:ifAnyGranted>
			      
			      <sec:ifAnyGranted roles="ROLE_COUNSELLOR">
				  <li><g:link controller="individual" action="cleelist">Individual Management</g:link></li>
				  <!--<li><g:link controller="helper" action="commitmentReport">Commitment Report (last 12 months)</g:link></li>
				  <li><g:link controller="helper" action="donationReport">Donation Report (till date)</g:link></li>
				  <li><g:link controller="mb" action="list">Marriage Board</g:link></li>-->
			      </sec:ifAnyGranted>      
			      <sec:ifAnyGranted roles="ROLE_COUNSELLOR_GROUP">
				  <li><g:link controller="relationshipGroup" action="show">Group</g:link></li>
			      </sec:ifAnyGranted>      

			<!-- Counsellee Based Roles Start-->
		      	      <sec:ifAnyGranted roles="ROLE_COUNSELLEE">
		      	      	  <li><g:link controller="sadhana" action="index">Sadahna</g:link></li>
		      	      </sec:ifAnyGranted>
			<!-- Counsellee Based Roles End-->

			<!-- Counsellor/Counsellee Based Common Roles Start-->
		      	      <sec:ifAnyGranted roles="ROLE_COUNSELLOR,ROLE_COUNSELLEE">
				  <!--<li><g:link controller="helper" action="clorDashboard">Dashboard</g:link></li>
		      	      	  <li><g:link controller="individual" action="cleelist">Individuals</g:link></li>
		      	      	  <li><g:link controller="event" action="list">Programs</g:link></li>
		      	      	  <li><g:link controller="EventSeva" action="list">Services</g:link></li>
		      	      	  <li><g:link controller="role" action="gridlist">Directory</g:link></li>
		      	      	  <li><g:link controller="helper" action="clorResources">Resources</g:link></li>
		      	      	  <li><g:link controller="book" action="order">JivaDaya</g:link></li>
		      	      	  <li><g:link controller="menuOrder" action="list">Prasad</g:link></li>-->
		      	      </sec:ifAnyGranted>
			<!-- Counsellor/Counsellee Based Common Roles End-->

			      <sec:ifAnyGranted roles="ROLE_COUNSELLOR_ADMIN">
				  <li><g:link controller="helper" action="clorDashboard">Dashboard</g:link></li>
		      	      	  <li><g:link controller="individual" action="cleelist">Individuals</g:link></li>
		      	      	  <li><g:link controller="event" action="list">Programs</g:link></li>
		      	      	  <li><g:link controller="EventSeva" action="list">Services</g:link></li>
		      	      	  <li><g:link controller="role" action="gridlist">Directory</g:link></li>
		      	      	  <li><g:link controller="helper" action="clorResources">Resources</g:link></li>
				  <li><g:link controller="helper" action="clorBoardDashboard">CounselorBoard</g:link></li>
			      </sec:ifAnyGranted>      

			      <sec:ifAnyGranted roles="ROLE_ASMT_USER">
				  <li><g:link controller="assessment" action="userDashboard">AssessmentApp</g:link></li>
			      </sec:ifAnyGranted>      


			      <sec:ifAnyGranted roles="ROLE_TMC">
				  <li><g:link controller="individual" action="devoteelist">Devotees</g:link></li>
				  <li><g:link controller="helper" action="tmcDashboard">Dashboard</g:link></li>
			      </sec:ifAnyGranted>      
			      <sec:ifAnyGranted roles="ROLE_DATA_CLEAN">
				  <!--<li><g:link controller="helper" action="donorInRange" params="['minAmt':'500000','maxAmt':'100000000']">5Lakh And Above</g:link></li>
				  <li><g:link controller="helper" action="donorInRange" params="['minAmt':'100000','maxAmt':'500000']">1L-5L</g:link></li>
				  <li><g:link controller="helper" action="donorInRange" params="['minAmt':'50000','maxAmt':'100000']">50K-1L</g:link></li>
				  <li><g:link controller="helper" action="donorInRange" params="['minAmt':'25000','maxAmt':'50000']">25K-50K</g:link></li>
				  <li><g:link controller="helper" action="donorInRange" params="['minAmt':'10000','maxAmt':'25000']">10K-25K</g:link></li>
				  <li><g:link controller="helper" action="donorInRange" params="['minAmt':'5000','maxAmt':'10000']">5K-10K</g:link></li>
				  <li><g:link controller="helper" action="donorInRange" params="['minAmt':'2000','maxAmt':'5000']">2K-5K</g:link></li>
				  <li><g:link controller="helper" action="donorInRange" params="['minAmt':'1000','maxAmt':'2000']">1K-2K</g:link></li>
				  <li><g:link controller="helper" action="donorInRange" params="['minAmt':'0','maxAmt':'1000']">Below 1K</g:link></li>
				  <li><g:link controller="helper" action="verifyDonor" >Verify</g:link></li>
				  <li><g:link controller="flags" action="list" >Under Verification</g:link></li>
				  <li><g:link controller="individual" action="list">Individual Master List</g:link></li>
				  <li><g:link controller="individual" action="ccList">Counsellor-Counsellee Management</g:link></li>-->				  
			      </sec:ifAnyGranted>     
			      <sec:ifAnyGranted roles="ROLE_REGISTRATION_COORDINATOR">
				  <li><g:link controller="EventRegistration" action="list">Registration</g:link></li>
			      </sec:ifAnyGranted> 
			      <sec:ifAnyGranted roles="ROLE_EVENTPARTICIPANT">
				  <li><g:link controller="EventRegistration" action="show">Registration</g:link></li>
			      </sec:ifAnyGranted>  
			      <sec:ifAnyGranted roles="ROLE_ACCOMMODATION_COORDINATOR">
				  <li><g:link controller="EventAccommodation" action="list">Accommodation</g:link></li>
			      </sec:ifAnyGranted>      
			      <sec:ifAnyGranted roles="ROLE_TRANSPORTATION_COORDINATOR">
				  <li><g:link controller="Trip" action="list">Transportation</g:link></li>
			      </sec:ifAnyGranted>      
			      <sec:ifAnyGranted roles="ROLE_PRASADAM_COORDINATOR">
				  <li><g:link controller="eventPrasadam" action="list">Prasadam</g:link></li>
			      </sec:ifAnyGranted>      

			      <sec:ifAnyGranted roles="ROLE_VIP_COORDINATOR,ROLE_VIP_REGISTRATION">
				  <li><g:link controller="EventRegistration" action="list">VIP-Registration</g:link></li>
			      </sec:ifAnyGranted> 
			      <sec:ifAnyGranted roles="ROLE_VIP_COORDINATOR,ROLE_VIP_ACCOMMODATION">
				  <li><g:link controller="EventAccommodation" action="list">VIP-Accommodation</g:link></li>
			      </sec:ifAnyGranted>      
			      <sec:ifAnyGranted roles="ROLE_VIP_COORDINATOR,ROLE_VIP_TRANSPORTATION">
				  <li><g:link controller="Trip" action="list">VIP-Transportation</g:link></li>
			      </sec:ifAnyGranted>      
			      <sec:ifAnyGranted roles="ROLE_VIP_COORDINATOR,ROLE_VIP_PRASADAM">
				  <li><g:link controller="EventPrasadam" action="list">VIP-Prasadam</g:link></li>
			      </sec:ifAnyGranted>      

			      <sec:ifAnyGranted roles="ROLE_VOLUNTEER_COORDINATOR">
				  <li><g:link controller="eventSeva" action="list">Service</g:link></li>
			      </sec:ifAnyGranted>      

			      <sec:ifAnyGranted roles="ROLE_REGISTRATION_COORDINATOR,ROLE_ACCOMMODATION_COORDINATOR,ROLE_TRANSPORTATION_COORDINATOR,ROLE_PRASADAM_COORDINATOR,ROLE_VOLUNTEER_COORDINATOR,ROLE_VIP_COORDINATOR,ROLE_VIP_REGISTRATION,ROLE_VIP_ACCOMMODATION,ROLE_VIP_TRANSPORTATION,ROLE_VIP_PRASADAM">
				  <li><g:link controller="helper" action="eventDashboard">EventDashboard</g:link></li>
			      </sec:ifAnyGranted>      

			      <sec:ifAnyGranted roles="ROLE_RVTO_COUNSELOR">
				  <li><g:link controller="EventRegistration" action="listlocal">NVCC Registration</g:link></li>
			      </sec:ifAnyGranted>      

			      <sec:ifAnyGranted roles="ROLE_SERVICE_INCHARGE">
				  <li><g:link controller="eventSeva" action="listvolunteer">Volunteer</g:link></li>
			      </sec:ifAnyGranted>      

			      <sec:ifAnyGranted roles="ROLE_KITCHEN_ADMIN">
					<!--<li><g:link class="list" action="index" controller="Recipe">Recipe Management</g:link></li>
					<li><g:link class="list" action="index" controller="MenuChart">Menu Management</g:link></li>-->
					<li><g:link class="list" action="index" controller="Item">Item Management</g:link></li>
					<li><g:link class="list" action="purchaseList" controller="Invoice">Purchase Management</g:link></li>
					<li><g:link class="list" action="salesList" controller="Invoice">Sales Management</g:link></li>
					<!--<li><g:link class="list" action="gridlist" controller="IndividualDepartment" params="[depName='Kitchen']">Staff Management</g:link></li>-->
					<li><g:link class="list" action="report" controller="Invoice">Report</g:link></li>
			      </sec:ifAnyGranted> 

			<!-- Donation Based Roles Start-->
			      <sec:ifAnyGranted roles="ROLE_DONATION_EXECUTIVE">
					<li><g:link controller="donationRecord" action="quickCreate">Donation Record</g:link></li>
					<li><g:link controller="individual" action="list">Individual Master List</g:link></li>
			      </sec:ifAnyGranted> 
			      <sec:ifAnyGranted roles="ROLE_DONATION_EXECUTIVE,ROLE_DONATION_COORDINATOR">
					<li><g:link class="list" action="list" controller="SchemeMember">Scheme Members</g:link></li>
			      </sec:ifAnyGranted> 
			      <sec:ifAnyGranted roles="ROLE_DONATION_EXECUTIVE,ROLE_DONATION_GIFT_INCHARGE">
					<li><g:link class="list" action="list" controller="Gift">Gifts</g:link></li>
			      </sec:ifAnyGranted> 
			      <sec:ifAnyGranted roles="ROLE_DONATION_EXECUTIVE,ROLE_DONATION_HOD">
					<li><g:link class="list" action="reports" controller="Helper">Reports</g:link></li>
			      </sec:ifAnyGranted> 
			      <sec:ifAnyGranted roles="ROLE_DONATION_ECS">
					<li><g:link class="list" action="report" controller="commitment">ECS Donors</g:link></li>
					<li><g:link class="list" action="uploadpaymentdata" controller="donationRecord">Upload ECS Donations</g:link></li>
			      </sec:ifAnyGranted> 
			<!-- Donation Roles End-->
			
			<!-- Account Office/Finance Roles Start-->
			      <sec:ifAnyGranted roles="ROLE_ACC_ADMIN">
				  <li><g:link controller="costCenter" action="list">CostCenter</g:link></li>
				  <li><g:link controller="voucher" action="list">Voucher</g:link></li>
			      </sec:ifAnyGranted>      

			      <sec:ifAnyGranted roles="ROLE_ACC_VE">
				  <li><g:link controller="voucher" action="list">Voucher</g:link></li>
			      </sec:ifAnyGranted>      

			      <sec:ifAnyGranted roles="ROLE_ACC_ADMIN,ROLE_ACC_USER">
				  <li><g:link controller="helper" action="costcenterReport">Transactions</g:link></li>
			      </sec:ifAnyGranted>      

			      <sec:ifAnyGranted roles="ROLE_ACC_ADMIN,ROLE_FINANCE">
				  <li><g:link controller="costCenter" action="statement">Statement</g:link></li>
			      </sec:ifAnyGranted>      

			      <sec:ifAnyGranted roles="ROLE_CG_OWNER,ROLE_CC_OWNER,ROLE_FINANCE,ROLE_ACC_USER">
				  <li><g:link controller="project" action="index">Expense Management</g:link></li>
			      </sec:ifAnyGranted>      
				  
				  <sec:ifAnyGranted roles="ROLE_CG_OWNER,ROLE_CC_OWNER,ROLE_ACC_USER">
				  <li><g:link controller="costCenter" action="statement">Statement</g:link></li>
			      </sec:ifAnyGranted>

			<!-- Account Office/Finance Roles End-->

			<!-- HR Based Roles Start-->
			      <sec:ifAnyGranted roles="ROLE_FINANCE">
            			  <li><g:link controller="Centre" action="list">Department Management</g:link></li>
				  <li><g:link controller="IndividualDepartment" action="gridlist">HR Management</g:link></li>
            			  <li><g:link controller="Project" action="report">Report</g:link></li>
			      </sec:ifAnyGranted>      
			      <sec:ifAnyGranted roles="ROLE_CC_OWNER">
				  <li><g:link controller="IndividualDepartment" action="gridlist">HR Management</g:link></li>
			      </sec:ifAnyGranted>      
			<!-- HR Roles End-->

			<!-- Marriage Board Based Roles Start-->
			      <sec:ifAnyGranted roles="ROLE_MB_ADMIN,ROLE_MB_SEC,ROLE_MB_MEMBER">
					<li><g:link controller="mb" action="dashboard">Mb Dashboard</g:link></li>
					<li><g:link class="list" action="manage" controller="mb">Mb Profile Management</g:link></li>
			      </sec:ifAnyGranted> 
			      <sec:ifAnyGranted roles="ROLE_MB_ADMIN,ROLE_MB_SEC">
					<li><g:link controller="mb" action="pendingApprovals">PendingApprovals</g:link></li>
					<li><g:link controller="mb" action="report">Mb Report</g:link></li>
			      </sec:ifAnyGranted> 
			      <sec:ifAnyGranted roles="ROLE_MB_ADMIN">
					<li><g:link class="list" action="manageBoard" controller="mb">Mb Management</g:link></li>
			      </sec:ifAnyGranted> 
			      <sec:ifAnyGranted roles="ROLE_MB_CANDIDATE">
					<li><g:link controller="mb" action="editProfile">Profile</g:link></li>
					<li><g:link controller="mb" action="prospects">Prospects</g:link></li>
			      </sec:ifAnyGranted> 
			      <sec:ifAnyGranted roles="ROLE_MB_ADMIN,ROLE_MB_SEC,ROLE_MB_MEMBER,ROLE_MB_CANDIDATE">
					<li><g:link controller="mb" action="activityStream">Activity Stream</g:link></li>
			      </sec:ifAnyGranted> 
			<!-- Marriage Board Roles End-->

			<!-- VaishnavSamvardhan Based Roles Start-->
		      	      <sec:ifAnyGranted roles="ROLE_VS_USER,ROLE_VS_ADMIN">
		      	      	  <li><g:link controller="item" action="vsUserItems">Items</g:link></li>
		      	      	  <li><g:link controller="PurchaseList" action="index">Requests</g:link></li>
		      	      	  <li><g:link controller="item" action="vsReports">Reports</g:link></li>
		      	      </sec:ifAnyGranted>
			<!-- VaishnavSamvardhan Based Roles End-->

			<!-- AgroManagementSystem Based Roles Start-->
		      	      <sec:ifAnyGranted roles="ROLE_AMS_ADMIN">
		      	      	  <li><g:link controller="farmer" action="list">Profiles</g:link></li>
		      	      	  <li><g:link controller="farmer" action="reports">Reports</g:link></li>
		      	      	  <li><g:link controller="farmer" action="masterData">Master Data</g:link></li>
		      	      </sec:ifAnyGranted>
			<!-- AgroManagementSystem Based Roles End-->

			<!-- Jivadaya Based Roles Start-->
		      	      <sec:ifAnyGranted roles="ROLE_JIVADAYA_ADMIN">
				  <li><g:link controller="individual" action="list">Individual Master</g:link></li>		      	      	  
		      	      	  <li><g:link controller="book" action="gridlist">Book Master</g:link></li>
		      	      	  <li><g:link controller="book" action="order">Order Management</g:link></li>
		      	      	  <li><g:link controller="challan" action="inward">Inward Entry</g:link></li>
		      	      	  <li><g:link controller="challan" action="outward">Challan Management</g:link></li>
		      	      	  <li><g:link controller="book" action="campaign">Campaign Management</g:link></li>
		      	      	  <li><g:link controller="book" action="scores">Scores</g:link></li>
		      	      	  <li><g:link controller="book" action="reports">Reports</g:link></li>
		      	      	  <li><g:link controller="book" action="dashboard">Dashboard</g:link></li>
		      	      	  <li><g:link controller="challan" action="search">Search</g:link></li>
		      	      </sec:ifAnyGranted>
		      	      <sec:ifAnyGranted roles="ROLE_JIVADAYA_CLERK">
				  <li><g:link controller="individual" action="list">Individual Master</g:link></li>		      	      	  
		      	      	  <li><g:link controller="book" action="gridlist">Book Master</g:link></li>
		      	      	  <li><g:link controller="book" action="order">Order Management</g:link></li>
		      	      	  <li><g:link controller="challan" action="outward">Challan Management</g:link></li>
		      	      	  <li><g:link controller="book" action="scores">Scores</g:link></li>
		      	      	  <li><g:link controller="challan" action="search">Search</g:link></li>
		      	      </sec:ifAnyGranted>
		      	      <sec:ifAnyGranted roles="ROLE_JIVADAYA_USER">
		      	      	  <li><g:link controller="book" action="team">Team</g:link></li>
		      	      	  <li><g:link controller="book" action="order">Order</g:link></li>
		      	      	  <li><g:link controller="book" action="settle">Settle</g:link></li>
		      	      	  <li><g:link controller="book" action="scores">Scores</g:link></li>
		      	      </sec:ifAnyGranted>
			<!-- Jivadaya Based Roles End-->

			<!-- EventManager Based Roles Start-->
		      	      <sec:ifAnyGranted roles="ROLE_EVENTADMIN">
		      	      	  <li><g:link controller="event" action="list">Events</g:link></li>
		      	      </sec:ifAnyGranted>
			<!-- EventManager Based Roles End-->

			<!-- ContactManagement Based Roles Start-->
		      	      <sec:ifAnyGranted roles="ROLE_CONTACT_MGR">
		      	      	  <li><g:link controller="person" action="list">Contacts</g:link></li>
		      	      </sec:ifAnyGranted>
			<!-- ContactManagement Based Roles End-->

			</ul>
		      </sec:ifLoggedIn>


		    <span id='loginLink' style='position: relative; margin-right: 20px; float: right'>
			    <sec:ifLoggedIn>
				    <g:set var="loguser" value="${new Date() + 1}" />
				    Hare Krishna -  ${ics.Individual.findByLoginid(sec.loggedInUserInfo(field:"username"))} (<sec:username/>) ( 
				    <sec:ifAnyGranted roles="ROLE_MB_ADMIN,ROLE_MB_SEC,ROLE_MB_MEMBER,ROLE_MB_CANDIDATE">
				    	<g:link controller='logout' params="['logoutUri': '/mb']"><img src="${resource(dir:'images',file:'lock.png')}" alt="Logout" title="Logout"/></g:link>
				    </sec:ifAnyGranted>
				    <sec:ifNotGranted roles="ROLE_MB_ADMIN,ROLE_MB_SEC,ROLE_MB_MEMBER,ROLE_MB_CANDIDATE">
				    	<g:link controller='logout'><img src="${resource(dir:'images',file:'lock.png')}" alt="Logout" title="Logout"/></g:link>
				    </sec:ifNotGranted>
				    <a href='#' onclick='showChangePassword(); return false;'><img src="${resource(dir:'images',file:'lock_edit.png')}"
				    alt="Change Password" title="Change Password" /></a> 

				    <sec:ifAnyGranted roles="ROLE_ADMIN">
				    <a href='#' onclick='showResetPassword(); return false;'>
				    <img src="${resource(dir:'images',file:'lock_break.png')}" alt="Reset Password" title="Reset Password" /></a>
				    </sec:ifAnyGranted>

				    <a href='<g:createLink controller="individual" action="selfContact" />'><img src="${resource(dir:'images',file:'profile.png')}"
				    alt="Profile" title="Profile" /></a> 

				    )
			    </sec:ifLoggedIn>
			    <sec:ifNotLoggedIn>
				    <!--<a href='#' onclick='showLogin(); return false;'>Login</a>-->
				    <g:link controller="login"></g:link>
			    </sec:ifNotLoggedIn>
			</span>

		      </div>

		      <sec:ifLoggedIn>
			<!-- Atithi Based Roles Start-->
			<nav>
				<ul>
		      	      <sec:ifAnyGranted roles="ROLE_ATITHI_ADMIN,ROLE_ATITHI_USER">
		      	      	  <li><g:link controller="person" action="list">Visitors</g:link></li>
		      	      </sec:ifAnyGranted>
		      	      <sec:ifAnyGranted roles="ROLE_ATITHI_ADMIN">
		      	      	  <li><g:link controller="topic" action="list">Subscription Management</g:link></li>
		      	      	  <li><g:link controller="person" action="dashboard">Dashboard</g:link></li>
		      	      </sec:ifAnyGranted>
				</ul>
			</nav>
			<!-- Atithi Based Roles End-->
		      </sec:ifLoggedIn>
