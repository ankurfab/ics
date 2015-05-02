<%@ page import="ics.Project" %>
<!doctype html>
<html>
    <head>
        <meta name="layout" content="main-jqm-landing">
        <title>ICS: Expense Management Module</title>        
    </head>
    
  
<body>

    <div role="main" class="ui-content">

                <g:if test="${projectInstanceList.size()>0}">
                       <h4> ${projectInstanceList.status.head().value.toString()}'S</h4></g:if>
                       
                <g:if test="${projectInstanceList.size()==0}">  
                       <h1> No Record found under this Category!!!</h1> </g:if>
	        <g:each in="${projectInstanceList}" status="i" var="projectInstance">
	        
	        <fieldset data-role="collapsible" data-theme="a" data-content-theme="d"  class="collaps">
	                    <legend>${projectInstance.amount+" by "+projectInstance.costCenter?.name+"/"+projectInstance.submitDate?.format('dd-MM-yyyy')+"/"+projectInstance.priority+"/"+projectInstance.category}</legend>
	                    <table>
	                    	<tr>
	                    		<td>Reference</td>
	                    		<td>${fieldValue(bean: projectInstance, field: "ref")}</td>
	                    		<td>Name</td>
	                    		<td>${fieldValue(bean: projectInstance, field: "name")}</td>
	                    	</tr>
	                    	<tr>
	                    		<td>Description</td>
	                    		<td >${fieldValue(bean: projectInstance, field: "description")}</td>
	                    		<td>Total Approval Amount</td>
	                    		<td>${fieldValue(bean: projectInstance, field: "amount")}</td>
	                    	</tr>
	                    	<tr>
	                    		<td>Advance Amount Requested</td>
	                    		<td>${projectInstance?.advanceAmount}</td>
	                    		<td>Advance Amount Issued</td>
	                    		<td>${projectInstance?.advanceAmountIssued}</td>
	                    	</tr>
	                    	<tr>
	                    		<td>Settle Date</td>
	                    		<td>${projectInstance?.settleDate?.format('dd-MM-yyyy HH:mm:ss')}</td>
	                    		<td>Settle Amount</td>
	                    		<td>${projectInstance?.settleAmount}</td>
	                    	</tr>
	                    	<!--<tr>
	                    		<td>Priority</td>
	                    		<td>${fieldValue(bean: projectInstance, field: "priority")}</td>
	                    		<td>Category</td>
	                    		<td>${fieldValue(bean: projectInstance, field: "category")}</td>
	                    	</tr>-->
	                    	<sec:ifNotGranted roles="ROLE_CG_OWNER"><!--hide for compact mobile i/f -->
	                    	<tr>
	                    		<td>Type</td>
	                    		<td>${projectInstance.type}</td>
	                    		<td>Issue To</td>
	                    		<td>${projectInstance.advanceIssuedTo}</td>
	                    	</tr>
	                    	<tr>
	                    		<td>Issue Mode</td>
	                    		<td>${projectInstance.advancePaymentMode?.name}</td>
	                    		<td>Issue Comments</td>
	                    		<td>${projectInstance.advancePaymentComments}</td>
	                    	</tr>
	                    	<tr>
	                    		<td>Bill No</td>
	                    		<td>${projectInstance.billNo}</td>
	                    		<td>Bill Date</td>
	                    		<td>${(projectInstance.billDate?.format('dd-MM-yyyy')?:'')}</td>
	                    	</tr>
	                    	</sec:ifNotGranted>
	                    	<tr>
	                    		<td>Submitter</td>
	                    		<td>${projectInstance.submitter}</td>
	                    		<td>Submit Date</td>
	                    		<td>${projectInstance.submitDate?.format('dd-MM-yyyy')}</td>
	                    	</tr>
	                    	<tr>
	                    		<td>Vertical Head</td>
	                    		<td>${projectInstance.reviewer1}(${projectInstance.review1Date?.format('dd-MM-yyyy')})</td>
	                    		<td>Vertical Head Comments</td>
	                    		<td>${projectInstance.review1Comments?:''}</td>
	                    	</tr>
	                    	<sec:ifNotGranted roles="ROLE_CG_OWNER"><!--hide for compact mobile i/f -->
	                    	<tr>
	                    		<td>Finance Head</td>
	                    		<td>${projectInstance.reviewer2}(${projectInstance.review2Date?.format('dd-MM-yyyy')})</td>
	                    		<td>Finance Head Comments</td>
	                    		<td>${projectInstance.review2Comments?:''}</td>
	                    	</tr>
	                    	<tr>
	                    		<td>Accountant</td>
	                    		<td>${projectInstance.reviewer3}(${projectInstance.review3Date?.format('dd-MM-yyyy')})</td>
	                    		<td>Accountant Comments</td>
	                    		<td>${projectInstance.review3Comments?:''}</td>
	                    	</tr>
	                    	</sec:ifNotGranted>
	                    </table>
	                <g:set var="childProjects" value="${ics.Project.findAllByMainProject(projectInstance)}" />
	                <g:set var="expenses" value="${ics.Expense.findAllByProject(projectInstance)}" />
	                <g:if test="${childProjects.size()>0||expenses.size()>0}">
	                	<g:render template="expenseItems" model="['projectInstance':projectInstance,'expenses':expenses,'mainProject':projectInstance,'childProjects':childProjects]" />
			</g:if>

		        <sec:ifAnyGranted roles="ROLE_CC_OWNER">
				<g:if test="${projectInstance.status=='DRAFT_REQUEST'}">
					<g:link action="create" id="${projectInstance.id}" class="ui-btn" data-ajax="false">EDIT</g:link>
                                        <g:link action="deleteRequest" id="${projectInstance.id}" class="ui-btn" data-ajax="false">DELETE</g:link>				
                                        </g:if>
                                        
				<g:if test="${projectInstance.status=='DRAFT_REPORT' || projectInstance.status=='REJECTED_REPORT'}">
					<g:link action="createReport" params="['projectid':projectInstance?.id]" data-ajax="false">EDIT</g:link>
					<g:link action="deleteReport" params="['projectid':projectInstance?.id]" data-ajax="false">CLEAR</g:link>
				</g:if>
				
				</sec:ifAnyGranted>
	                
		        <sec:ifAnyGranted roles="ROLE_CG_OWNER">
				<g:if test="${projectInstance.status=='SUBMITTED_REQUEST' || projectInstance.status=='SUBMITTED_REPORT'}">
					<g:if test="${projectInstance.category=='REVENUE'}">
					
				  <table>
				    <thead>
					 <th>Consumed Budget</th>
					 <th>Available Budget</th>
					 <th>Total Budget</th>
				    </thead>  
				    
				    <tr><td>${projectInstance.costCenter.balance?:0}</td>  <td>${(projectInstance.costCenter.budget?:0)- (projectInstance.costCenter.balance?:0)}</td> <td>${projectInstance.costCenter.budget?:0}</td></tr>
			
				  </table>    					
				
				    	</g:if>
					<g:if test="${projectInstance.category=='CAPITAL'}">
				 <table>
					<thead>
						<th>Consumed Budget</th>
						<th>Available Budget</th>
						<th>Total Budget</th>
					</thead>                                                      
					<tr><td>${projectInstance.costCenter.capitalBudget?:0}</td>  <td>${(projectInstance.costCenter.capitalBudget?:0)- (projectInstance.costCenter.capitalBalance?:0)}</td> <td>${projectInstance.costCenter.capitalBalance?:0}</td></tr>
				  </table> 
					
				    	</g:if>
				<form name=${'formCCAT_'+projectInstance.id} id="${'formCCAT_'+projectInstance.id}" method="post" action="${createLink(controller:'Project',action:'changeState')}">
				  <g:hiddenField name="projectid" value="${projectInstance?.id}" />
				  <g:hiddenField name="approver" value="ROLE_CG_OWNER" />
				    <div>
					<div>
						<label for="comments">Review Comments:</label>
						<g:textArea name="review1Comments" cols="40" rows="5" maxlength="500" value="${projectInstance?.review1Comments}" placeholder="Review Comments"/>
					</div>
					    <fieldset data-role="controlgroup" data-type="horizontal">
						<legend>Status:</legend>
						<input name="approvestatus" id="approvestatus-1" value="APPROVE" checked="checked" type="radio">
						<label for="approvestatus-1">APPROVE</label>
						<input name="approvestatus" id="approvestatus-2" value="REJECT" type="radio">
						<label for="approvestatus-2">REJECT</label>
						<input name="approvestatus" id="approvestatus-3" value="ESCALATE" type="radio">
						<label for="approvestatus-3">ESCALATE</label>
					    </fieldset>

				    </div>
				    <input type="submit" value="Submit">
				</form>
				</g:if>
			</sec:ifAnyGranted>         
		        <sec:ifAnyGranted roles="ROLE_FINANCE">
				<g:if test="${projectInstance.status=='ESCALATED_REQUEST' || projectInstance.status=='ESCALATED_REPORT'}">
					<g:if test="${projectInstance.category=='REVENUE'}">
				<table>
					<thead>
						<th>Consumed Budget</th>
						<th>Available Budget</th>
						<th>Total Budget</th>
					</thead>  
						<tr><td>${projectInstance.costCenter.balance?:0}</td> <td>${(projectInstance.costCenter.budget?:0)- (projectInstance.costCenter.balance?:0)}</td>  <td>${projectInstance.costCenter.budget?:0}</td></tr>
				</table>
					   
					  </g:if>
					<g:if test="${projectInstance.category=='CAPITAL'}">
					  </g:if>
				<form name=${'formCCAT_'+projectInstance.id} id="${'formCCAT_'+projectInstance.id}" method="post" action="${createLink(controller:'Project',action:'changeState')}">
				  <g:hiddenField name="projectid" value="${projectInstance?.id}" />
				  <g:hiddenField name="approver" value="ROLE_FINANCE" />
				    <div>
					<div>
						<label for="comments">Review Comments:</label>
						<g:textArea name="review2Comments" cols="40" rows="5" maxlength="500" value="${projectInstance?.review2Comments}" placeholder="Review comments"/>
					</div>
					    <fieldset data-role="controlgroup" data-type="horizontal">
						<legend>Status:</legend>
						<input name="approvestatus" id="approvestatus-1" value="APPROVE" checked="checked" type="radio">
						<label for="approvestatus-1">APPROVE</label>
						<input name="approvestatus" id="approvestatus-2" value="REJECT" type="radio">
						<label for="approvestatus-2">REJECT</label>
					    </fieldset>

				    </div>
				    <input type="submit" value="Submit">
				</form>
				</g:if>
			</sec:ifAnyGranted>         
			
	     </fieldset>
	                            
	       </g:each>                
	
    </div><!-- /content -->
           
</body>
</html>