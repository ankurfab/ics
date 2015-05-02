
<%@ page import="ics.Individual" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Counselor Board Dashboard</title>
	<r:require module="jqui" />
	<r:require module="newjqplot" />
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
        </div>
        <div class="body">
            <h1>More Devotees! Happy Devotees!!</h1>

	    <div id="divEvents">
	    	<g:render template="eventSummary"/>
	    </div>

		<div id="accordian">
		    <div id="summ">
				<div id="chartSumm" style="height:2000px; width:1200px;float:left;"></div>
		    </div>
		</div>

		
        </div>
	
	<script>

		$(document).ready(function(){

		  $( "#accordion" ).accordion();
		  
		  var ajaxDataRenderer = function(url, plot, options) {
		    var ret = null;
		    $.ajax({
		      // have to use synchronous here, else the function
		      // will return before the data is fetched
		      async: false,
		      url: url,
		      dataType:"json",
		      success: function(data) {
			ret = data;
		      }
		    });
		    return ret;
		  };

		var jsonurl_chartSumm = "${createLink(controller:'Helper',action:'clorBoardSummaryData')}";
		var plot_chartSumm = $.jqplot('chartSumm',jsonurl_chartSumm , {
		    title: "Overall Counselor Board Summary",
		    stackSeries: false,
		    dataRenderer: ajaxDataRenderer,
		    dataRendererOptions: {
		      unusedOptionalUrl: jsonurl_chartSumm
		    },
			// Custom labels for the series are specified with the "label"
			// option on the series option.  Here a series option object
			// is specified for each series.
			series:[
			    {label:'Counsellees (including family members and well wishers)'},
			    {label:'Funds (in Rs Lakhs, including donation and collection)'},
			    {label:'Books (in Rs Thousands)'}
			],
			// Show the legend and put it outside the grid, but inside the
			// plot container, shrinking the grid to accomodate the legend.
			// A value of "outside" would not shrink the grid and allow
			// the legend to overflow the container.
			legend: {
			    show: true,
			    location: 's',
			    placement: 'outside'
			},		    
		    seriesDefaults: {
			renderer:$.jqplot.BarRenderer,
			pointLabels: { show: true, location: 'e', edgeTolerance: -15, stackedValue: false },
			shadowAngle: 0,
			rendererOptions: {
			    barDirection: 'horizontal'
			}
		    },
		    axes: {
			yaxis: {
			    renderer: $.jqplot.CategoryAxisRenderer,
			    ticks: ${clorNameList}
			}
		    }
		});

		});

	</script>



    </body>
</html>
