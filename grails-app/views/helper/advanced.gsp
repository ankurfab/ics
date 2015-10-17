<html>
    <head>
        <title></title>
		<meta name="layout" content="main" />
		
	
    </head>
    <body>
    
    <sec:ifNotLoggedIn>
    				<div class="panelBody">
    				<img src="${resource(dir:'images',file:'iskcon-logo.png')}" "/>
    				</div>
	</sec:ifNotLoggedIn>

    <sec:ifAnyGranted roles="ROLE_ADMIN">
    <div id="nav">
    <img src="${resource(dir:'images',file:'iskcon-logo.png')}" "/>
    			<div class="homePagePanel">
    				<div class="panelTop">
        				
    				</div>
    				<div class="panelBody">
    					<div id="controllerList" class="dialog">
									<h2>Master features:</h2>
						            <ul>
						              <g:each var="c" in="${grailsApplication.controllerClasses}">
						                    <li class="controller"><g:link controller="${c.logicalPropertyName}">${c.name}</g:link></li>
						              </g:each>
						            </ul>
	            </div>
    				</div>
    				<div class="panelBtm">
    				</div>
    			</div>
    
    
		</div>
		</sec:ifAnyGranted>


    <sec:ifAnyGranted roles="ROLE_NVCC_ADMIN">
    <div id="nav">
    <img src="${resource(dir:'images',file:'iskcon-logo.png')}" "/>
    			<div class="homePagePanel">
    				<div class="panelTop">
        				
    				</div>
    				<div class="panelBody">
    					<div id="controllerList" class="dialog">
									<h2>Master features:</h2>
						            <ul>
          <li><g:link controller="icsUser" action="list">User Management</g:link></li>
          <li><g:link controller="bouncedCheque" action="list">Dishonoured Cheque Management</g:link></li>
          <li><g:link controller="followup" action="list">Followup Management</g:link></li>
          <li><g:link controller="receiptBookIssued" action="list">Receipt Book Management</g:link></li>
          <li><g:link controller="individualRole" action="list">Role Management</g:link></li>
          <li><g:link controller="motd" action="index">Message of the Day</g:link></li>
          <li><g:link controller="event" action="gridlist">Event Management</g:link></li>
          <li><g:link controller="helper" action="verificationStats">Data Management</g:link></li>
	  <li><g:link controller="helper" action="assignCultivator">Assign Cultivator</g:link></li>
	  <li><g:link controller="helper" action="individualBackup">Backup Individual</g:link></li>
	  <li><g:link controller="helper" action="ccBackup">Backup Councellor Councellee</g:link></li>
	  <li><g:link controller="helper" action="donationBackup">Backup Donation</g:link></li>
	  <li><g:link controller="individual" action="donorList">Donor List</g:link></li>
	  <li><g:link controller="donationRecord" action="list">Donation Record List</g:link></li>
	  <!--<li><g:link controller="donationRecord" action="bulkPrint">ECS Receipts</g:link></li>-->
			              
          <br>
          Master Data Management
          <li><g:link controller="bank" action="list">Bank Master</g:link></li>
          <li><g:link controller="city" action="list">City Master</g:link></li>
          <li><g:link controller="state" action="list">State Master</g:link></li>
          <li><g:link controller="country" action="list">Country Master</g:link></li>
          <li><g:link controller="title" action="list">Title Master</g:link></li>
          <li><g:link controller="relation" action="list">Relation Master</g:link></li>
          <li><g:link controller="role" action="list">Role Master</g:link></li>
          <li><g:link controller="scheme" action="list">Scheme Master</g:link></li>
          <li><g:link controller="gift" action="list">Gift Master</g:link></li>
          <li><g:link controller="devoteeCategory" action="list">Devotee Category Master</g:link></li>
          <li><g:link controller="donationCategory" action="list">Donation Category Master</g:link></li>
          <li><g:link controller="language" action="list">Language Master</g:link></li>
          <li><g:link controller="profession" action="list">Profession Master</g:link></li>
          <!--<li><a class="list" href="${createLink(uri: '/bulkcreate.gsp')}">ReceiptBookMaster</a></li>-->
          <li><g:link controller="receiptBook" action="list">ReceiptBookMaster</g:link></li>
          <li><g:link controller="event" action="list">EventMaster</g:link></li>
          
						            </ul>
	            </div>
    				</div>
    				<div class="panelBtm">
    				</div>
    			</div>
    
    
		</div>
		</sec:ifAnyGranted>

    <sec:ifAnyGranted roles="ROLE_VOICE_ADMIN">
    <div id="nav">
    <img src="${resource(dir:'images',file:'iskcon-logo.png')}" "/>
    			<div class="homePagePanel">
    				<div class="panelTop">
        				
    				</div>
    				<div class="panelBody">
    					<div id="controllerList" class="dialog">
									<h2>Master features:</h2>
						            <ul>
          <li><g:link controller="icsUser" action="list">User Management</g:link></li>
          <li><g:link controller="course" action="list">Course Management</g:link></li>
          <li><g:link controller="event" action="list">Event Management</g:link></li>
          </ul>
          <br><br>
          <h2>Master Data Management</h2>
          <ul>
          <li><g:link controller="skill" action="list">Skill Master</g:link></li>
          <li><g:link controller="seva" action="list">Services Master</g:link></li>
          <li><g:link controller="book" action="list">Book Master</g:link></li>
          <li><g:link controller="centre" action="list">Centre Master</g:link></li>        
          </ul>
	            </div>
    				</div>
    				<div class="panelBtm">
    				</div>
    			</div>
    
    
		</div>
		</sec:ifAnyGranted>

			<div id="pageBody">
	        <h1>Welcome to ICS - ISKCON Communities System</h1>
	        <p>Hare Krishna! All Glories to Srila Prabhupada! All Glories to Shri Guru and Shri Gauranga!!</p>
	        
		    <sec:ifAnyGranted roles="ROLE_ADMIN">
	        		<div>
				Upload ids for bulk login creation: <br />
				    <g:uploadForm action="uploadForLogin">
					<input type="file" name="myFile" />
					<input type="submit" value="Upload"/>
				    </g:uploadForm>
				</div>
	        		<div>
				Bulk login change: <br />
				    <g:uploadForm action="uploadForLoginChange">
					<input type="file" name="myFile" />
					<input type="submit" value="Upload"/>
				    </g:uploadForm>
				</div>
	        		<div>
				Upload Custom Form Template: <br />
				    <g:uploadForm action="uploadCustomForm">
					<input type="file" name="myFile" />
					<input type="submit" value="Upload"/>
				    </g:uploadForm>
				</div>
			</sec:ifAnyGranted>

		</div>
	
    </body>
</html>