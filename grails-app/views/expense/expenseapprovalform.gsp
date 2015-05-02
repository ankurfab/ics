<%@ page import="ics.Expense" %>
<!doctype html>
<html>
    <head>
     <title>Expense Approval Form</title>
        <meta name="layout" content="main-jqm-landing">
        </head>
       
<g:form name="expenseApprovalForm" controller="Expense" action="expenseapprovalform" method="POST"> 
<legend>Expense Approval Form</legend>
     <table> 
                    <tr>  
                    <td><label>Category:</label></td>          
                    <td> <input id="category" name="category" value="" type="text" placeholder="category" required></td>
                    </tr>
                    
                    <tr>
                    <td><label>Type:</label></td>          
                    <td><input id="type" name="type" value="" type="text" placeholder="type" required></td>
                    </tr>
                    
                    <tr>
                    <td> <label>Name:</label> </td>         
                    <td> <input id="name" name="name" value="" type="text" placeholder="name" required></td>
                    </tr>
                    
                    <tr>
                    <td><label>Amount:</label></td>          
                    <td><input id="amount" name="amount" value="" type="text" placeholder="amount" required></td>
                    </tr>
                    
                    <tr>
                    <td><label>Description:</label></td>          
                    <td><textarea cols="40" rows="8" name="description" id="description"  placeholder="description"></textarea></td>
                    </tr>
                    
                    <tr>
                    <td><label>submitComments:</label></td>          
                    <td><textarea cols="40" rows="8" name="submitComments" id="submitComments" placeholder="comments"></textarea></td>
                    </tr>
                    
                   <tr>
		   <div data-role="controlgroup"  data-type="horizontal" data-theme="b"> 
		    <td></td>
		    <td> <button class="ui-btn ui-corner-all ui-shadow ui-btn-a ui-btn-icon-left ui-icon-check" id="registerubmitbutton" type="submit" />Submit</button> 
		    <button  id="cancel" class="ui-btn ui-corner-all ui-shadow ui-btn-a ui-btn-icon-left ui-icon-delete" data-rel="back" type="reset" />Cancel</button> </td>
		   </div>
		   </tr>
                   
     </table>        
       
        </fieldset>            
      </g:form>       
     </body>
  </html>
                
                
                
               
