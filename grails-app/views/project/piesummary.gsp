


<%@ page import="ics.CostCenter" %>
<!doctype html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main-jqm-landing" />
        <title>Pie Chart</title>
   </head>
   <style>
      #chart2
           {
            width:100%;
            height:100%;
           }
          table.jqplot-table-legend {
  width: auto !important;
} 
           
</style>
    <body>
     
	 <div role="main" class="ui-content">

	  <fieldset>   
	          <legand>Monthly Summary of the Expenses</legand>
	          <br>
	          <div id="monthchart"></div>
	          <br>
	 </fieldset> 
	  
	  
	  <fieldset>   
	  	  <legand>Quartly Summary of the Expenses</legand>
	  	  <br>
	  	  <div id="quarterchart"></div>
	  	  <br>
	 </fieldset> 
	  
	  
	  <fieldset>   
	  	  <legand>Yearly Summary of the Expenses</legand>
	  	  <br>
	  	  <div id="yearchart">
	  	 
	  	  </div>
	  </fieldset> 
	  

	</div>
	
	
	        <script>
		$(document).on('pageshow',function(){
		  var data = [
		     ['Draft Requests', 16],['Submitted Requests', 12],['Approved Requests', 9], ['Rejected Requests', 14], 
		     ['Escalated Requests', 7]
		   ];
		   var monthplot = jQuery.jqplot ('monthchart', [data], 
		     { 
		       seriesDefaults: {
			 // Make this a pie chart.
			 renderer: jQuery.jqplot.PieRenderer, 
			 rendererOptions: {
			   // Put data labels on the pie slices.
			   // By default, labels show the percentage of the slice.
			   showDataLabels: true,
			   dataLabelFormatString: "%d %d%%"
			 }
		       }, 
                   legend:{
			 show:true, 
			 placement: 'outside', 
			 rendererOptions: {
			 numberRows: 1
			  }, 
			 location:'s',
			 marginTop: '15px'
                         }	
		       		   
		     }
		  );
		  });
	
	         
          </script> 
		<script>
		$(document).on('pageshow',function(){
		var quarterdata = [
		       ['Heavy Industry', 13],['Retail', 10], ['Light Industry', 17], 
		       ['Out of home', 8],['Commuting', 16], ['Orientation', 9]
		     ];
	       var quarterplot = jQuery.jqplot ('quarterchart', [quarterdata], 
		       { 
			 seriesDefaults: {
			   // Make this a pie chart.
			   renderer: jQuery.jqplot.PieRenderer, 
			   rendererOptions: {
			     // Put data labels on the pie slices.
			     // By default, labels show the percentage of the slice.
			     showDataLabels: true
			   }
			 }, 
	       legend:{
			 show:true, 
			 placement: 'outside', 
			 rendererOptions: {
			 numberRows: 1
			  }, 
			 location:'s',
			 marginTop: '15px'
                         }	
		       }
		    );

		});

		</script>
	
		 <script>
		$(document).on('pageshow',function(){
		var yeardata = [
		       ['Heavy Industry', 25],['Retail', 10], ['Light Industry', 13], 
		       ['Out of home', 11],['Commuting',25], ['Orientation', 96]
		     ];
		     var yearplot = jQuery.jqplot ('yearchart', [yeardata], 
		       { 
			 seriesDefaults: {
			   // Make this a pie chart.
			   renderer: jQuery.jqplot.PieRenderer, 
			   rendererOptions: {
			     // Put data labels on the pie slices.
			     // By default, labels show the percentage of the slice.
			     showDataLabels: true
			   }
			 }, 
		   legend:{
			 show:true, 
			 placement: 'outside', 
			 rendererOptions: {
			 numberRows: 1
			  }, 
			 location:'s',
			 marginTop: '15px'
                         } 
		       }
		    );

		   });

		</script>


</body>
</html>
