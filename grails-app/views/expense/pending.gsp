

<%@ page import="ics.Individual" %>
<!doctype html>
<html>
    <head>
     <title>Pending Expenses Page</title>
        <meta name="layout" content="main-jqm-landing">
      
        
        
         
        <div id="container">
	                    
	        <div id="currentdiv"> 
	        <g:each in="${ExpenseInstanceList}" status="i" var="expenseInstance">
	        
	        <fieldset data-role="collapsible" data-theme="a" data-content-theme="d"  style="margin-right: 10%;margin-left: 10%;" class="collaps">
	                    <legend>${fieldValue(bean: expenseInstance, field: "raisedBy")}</legend>
	                    <p> RaisedBy:${fieldValue(bean: expenseInstance, field: "raisedBy")}</p>
	                    <p> Type:${fieldValue(bean: expenseInstance, field: "type")}</p>
	                    <p>Category:${fieldValue(bean: expenseInstance, field: "category")}</p>
	                    <p>Description:${fieldValue (bean: expenseInstance, field: "description")}</p>
	                    <p>Amount:${fieldValue(bean: expenseInstance, field: "amount")}</p>
	                    <p>Status:${fieldValue (bean: expenseInstance, field: "status")}</p>
	                    <p> <g:link action="show" id="${expenseInstance.id}">${fieldValue(bean: expenseInstance, field: "department")}</g:link></p>
	                    
	                    <div id="chart2"  data-role="none"  class="expenseplot" style="height:250px; width:250px;"></div>
			    	<div class="code prettyprint">
			    	<pre class="code prettyprint brush: js"></pre>
	                     </div>
	                     
	                                  
			    <div data-role="controlgroup"  data-type="horizontal" data-theme="b"> 	    
			    <a href=""   id=""   data-role="button" data-icon="check"  title="Approve" >Approve</a>
			    <a href=""   id=""   data-role="button" data-icon="delete"   data-history="false" title="Reject">Reject</a>
			    <a href=""   id=""   data-role="button" data-icon="gear"  title="OnHold">OnHold</a>
			    <a href="${createLink(uri: '/')}"   id=""   data-role="button" data-icon="alert"  title="Cancel">Cancel</a>
                          
                           </div>
	     </fieldset>
	                            
	       </g:each>                
	       </div>
           </div>                      
	                            
	  <script>
	  
	 
	 	 $(document).on('pagebeforeshow', '#landingpage', function() {
		
	 			     var ajaxDataRenderer = function(url, plot, options) {
	 			       var ret = null;
	 			       $.ajax({
	 			        
	 			         async: false,
	 			         url: url,
	 			         dataType:"json",
	 			           success: function(data) {
	 			            ret = data;
	 			            console.log(ret);
	 			            }
	 			       });
	 			       return ret;
	 			     };
	 			    
	 			   var jsonurl= "${createLink(controller:'Expense',action:'summaryData')}";
	                                 
	                                 var plot2 = $.jqplot('chart2', jsonurl,{
					 	     title: "AJAX JSON Data Renderer",
					 	     dataRenderer: ajaxDataRenderer,
					 	     dataRendererOptions: {
					 	       unusedOptionalUrl: jsonurl
					 	     }
	  				 });
	 	                   
	 	             
	 	                   
	 	                   
	 	                   $('#chart2').each(function(){
                                     $(this).on("click", function(event, ui) {
	 	                      plot2.replot();
		   		      });
		   
	 	   
	 	               });
	 	   
	 	   });
      
      

      
      
	  </script>
                   
                     
                   

    
 

</body>
</html>