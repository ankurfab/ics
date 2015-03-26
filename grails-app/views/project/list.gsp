<%@ page import="ics.Project" %>
<!doctype html>
<html>
    <head>
        <meta name="layout" content="main-jqm-landing">
        <title>ICS: Expense Management Module</title>        
    </head>
    
  
<body>
	 <style>
	   #month-a{
	       width:auto;
	   }
	   #month-b{
	       width:auto;
	   }

	   #custom-slider .ui-rangeslider-sliders {
	       margin: 0.5em 100px !important;
	   }

	   #custom-slider input.ui-input-text.ui-slider-input {
	       width: 70px !important;

	}
	   </style> 

    <div role="main" class="ui-content">

                <g:if test="${projectInstanceList.size()>0}">
                       <h4> ${projectInstanceList.status.head().value.toString()}'S</h4></g:if>
                       
                <g:if test="${projectInstanceList.size()==0}">  
                       <h1> No Record found under this Category!!!</h1> </g:if>
	        <g:each in="${projectInstanceList}" status="i" var="projectInstance">
	        
	        <fieldset data-role="collapsible" data-theme="a" data-content-theme="d"  class="collaps">
	                    <legend>${projectInstance.amount+" by "+projectInstance.costCenter?.name+"/"+projectInstance.submitDate?.format('dd-MM-yyyy')+"/"+projectInstance.priority}</legend>
	                    <table>
	                    	<tr>
	                    		<td>Reference</td>
	                    		<td>${fieldValue(bean: projectInstance, field: "ref")}</td>
	                    		<td>Name</td>
	                    		<td>${fieldValue(bean: projectInstance, field: "name")}</td>
	                    	</tr>
	                    	<tr>
	                    		<td>Description</td>
	                    		<td colspan="3">${fieldValue(bean: projectInstance, field: "description")}</td>
	                    		<!--<td></td>
	                    		<td></td>-->
	                    	</tr>
	                    	<tr>
	                    		<td>Amount</td>
	                    		<td>${fieldValue(bean: projectInstance, field: "amount")}</td>
	                    		<td>AdvanceAmount</td>
	                    		<td>${fieldValue(bean: projectInstance, field: "advanceAmount")}</td>
	                    	</tr>
	                    	<tr>
	                    		<td>Priority</td>
	                    		<td>${fieldValue(bean: projectInstance, field: "priority")}</td>
	                    		<td>Category</td>
	                    		<td>${fieldValue(bean: projectInstance, field: "category")}</td>
	                    	</tr>
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
	                    </table>
	                <g:set var="expenses" value="${ics.Expense.findAllByProjectAndStatus(projectInstance,'SUBMITTED')}" />
	                <g:if test="${expenses.size()>0}">
	                	<g:render template="expenseItems" model="['projectInstance':projectInstance,'expenses':expenses]" />
			</g:if>

		        <sec:ifAnyGranted roles="ROLE_CC_OWNER">
				<g:if test="${projectInstance.status=='DRAFT_REQUEST'}">
					<g:link action="create" id="${projectInstance.id}" data-ajax="false">EDIT</g:link>
                                        <g:link action="deleteRequest" id="${projectInstance.id}" data-ajax="false">DELETE</g:link>				
                                        </g:if>
                                        
				<g:if test="${projectInstance.status=='DRAFT_REPORT'}">
					<g:link action="createReport" params="['projectid':projectInstance?.id]" data-ajax="false">EDIT</g:link>
					<g:link action="deleteReport" params="['projectid':projectInstance?.id]" data-ajax="false">DELETE</g:link>
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
					
			    <div data-role="rangeslider">
						<label for="month-a">Budget Consumption for Current Month::</label>
						<input name="month-a" id="month-a" disabled="disabled" min="0" max="${projectInstance.costCenter.budget?:0}" value="${projectInstance.costCenter.balance?:0}" type="range">
						<label for="month-b">Total Budget:</label>
						<input name="month-b" id="month-b" disabled="disabled" min="0" max="${projectInstance.costCenter.budget?:0}" value="${projectInstance.costCenter.budget?:0}" type="range">
					    </div>
				
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
					    <div data-role="rangeslider">
						<label for="month-a">Budget Consumption for Current Month:</label>
						<input name="month-a" id="month-a" disabled="disabled" min="0" max="${projectInstance.costCenter.capitalBudget?:0}" value="${projectInstance.costCenter.capitalBalance?:0}" type="range">
						<label for="month-b">Rangeslider:</label>
						<input name="month-b" id="month-b" disabled="disabled" min="0" max="${projectInstance.costCenter.capitalBudget?:0}" value="${projectInstance.costCenter.capitalBudget?:0}" type="range">
					    </div>
					
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
					    <div data-role="rangeslider">
						<label for="month-a">Budget Consumption for Current Month:</label>
						<input name="month-a" id="month-a" disabled="disabled" min="0" max="${projectInstance.costCenter.budget?:0}" value="${projectInstance.costCenter.balance?:0}" type="range">
						<label for="month-b">Rangeslider:</label>
						<input name="month-b" id="month-b" disabled="disabled" min="0" max="${projectInstance.costCenter.budget?:0}" value="${projectInstance.costCenter.budget?:0}" type="range">
					    </div>
					   
					  </g:if>
					<g:if test="${projectInstance.category=='CAPITAL'}">
					    <div data-role="rangeslider">
					    <label for="month-a">Budget Consumption for Current Month:</label>
						
						
						<input name="month-a" id="month-a" disabled="disabled" min="0" max="${projectInstance.costCenter.capitalBudget?:0}" value="${projectInstance.costCenter.capitalBalance?:0}" type="range">
						<label for="month-b">Rangeslider:</label>
						<input name="month-b" id="month-b" disabled="disabled" min="0" max="${projectInstance.costCenter.capitalBudget?:0}" value="${projectInstance.costCenter.capitalBudget?:0}" type="range">
					    </div>
					   
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