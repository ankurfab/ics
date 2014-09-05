<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <g:set var="entityName" value="Dashboard" />
        <title>Dashboard</title>
<link rel="stylesheet" type="text/css" href="/ics/css/jquery.jqplot.css" />
<link rel="stylesheet" type="text/css" href="/ics/css/examples.css" />


<g:javascript src="jquery-1.4.2.min.js"/>
<g:javascript src="jquery.jqplot.js"/>
<g:javascript src="plugins/jqplot.barRenderer.js"/>
<g:javascript src="jqplot.categoryAxisRenderer.min.js"/>
<g:javascript src="jqplot.pointLabels.js"/>
<g:javascript src="jqplot.canvasTextRenderer.min.js"/>
<g:javascript src="jqplot.canvasAxisTickRenderer.min.js"/>
<g:javascript src="jqplot.cursor.js"/>
<g:javascript src="plugins/jqplot.meterGaugeRenderer.js" />

  <style type="text/css" media="screen">
    .jqplot-axis {
      font-size: 0.85em;
    }
    .jqplot-legend {
      font-size: 0.75em;
    }
  </style>

<script type="text/javascript" language="javascript">
/*$(document).ready(function(){
    var s1 = [200, 600, 700, 1000];
    var s2 = [460, -210, 690, 820];
    var s3 = [-260, -440, 320, 200];
    // Can specify a custom tick Array.
    // Ticks should match up one for each y value (category) in the series.
    var ticks = ['May', 'June', 'July', 'August'];
     
    var plot1 = $.jqplot('chart1', [s1, s2, s3], {
        // The "seriesDefaults" option is an options object that will
        // be applied to all series in the chart.
        seriesDefaults:{
            renderer:$.jqplot.BarRenderer,
            rendererOptions: {fillToZero: true}
        },
        // Custom labels for the series are specified with the "label"
        // option on the series option.  Here a series option object
        // is specified for each series.
        series:[
            {label:'Hotel'},
            {label:'Event Regristration'},
            {label:'Airfare'}
        ],
        // Show the legend and put it outside the grid, but inside the
        // plot container, shrinking the grid to accomodate the legend.
        // A value of "outside" would not shrink the grid and allow
        // the legend to overflow the container.
        legend: {
            show: true,
            placement: 'outsideGrid'
        },
        axes: {
            // Use a category axis on the x axis and use our custom ticks.
            xaxis: {
                renderer: $.jqplot.CategoryAxisRenderer,
                ticks: ticks
            },
            // Pad the y axis just a little so bars can get close to, but
            // not touch, the grid boundaries.  1.2 is the default padding.
            yaxis: {
                pad: 1.05,
                tickOptions: {formatString: '$%d'}
            }
        }
    });
});*/

$(document).ready(function(){

	 $.jqplot.config.enablePlugins = true;

	plot2 = $.jqplot('chart2', [${yearwiseCollectionAmount}], {
	    stackSeries: false,
	    highlightMouseOver:true,

	    legend: {
		show: true,
		location: 'nw',
		xoffset: 55
	    },
	    title: 'Yearwise Collection',
	    color: '#DC143C',
	    seriesDefaults: {
		renderer: $.jqplot.BarRenderer,
		pointLabels: { show: true, location: 'n',labels:${yearwiseCollectionAmount}},
		rendererOptions: {
		    barPadding: 10,
		    barMargin: 20,
		    fillToZero: true
		}
	    },
		cursor:{
		  showVerticalLine:true,
		  showTooltip: true,
		  followMouse: true,
		  showTooltipDataPosition:true,
		  zoom:true,
		  intersectionThreshold:6,
		  tooltipFormatString: '%s x:%s, y:%s'
		},
	    series: [{
		label: 'Collection'
	    },],
	    axes: {
		xaxis: {
		    renderer: $.jqplot.CategoryAxisRenderer,
		    label: 'Year',
		    ticks: ${yearTicks},
		    showMinorTicks:true

		},
		yaxis: {min:0, label: 'Collection Amount', tickInterval:2000000, showMinorTicks:true}
	    }
	});

	//bar TotalsByScheme    
	plot5 = $.jqplot('chart5', [${amtByScheme}], {
	    stackSeries: false,
	    highlightMouseOver:true,
	    
	    legend: {
	        show: true,
	        location: 'nw',
	        xoffset: 55
	    },
	    title: 'Schemewise Collection',
	    seriesDefaults: {
	        renderer: $.jqplot.BarRenderer,
	        pointLabels: { show: true, location: 'n',labels:${amtByScheme}},
	        rendererOptions: {
	            barPadding: 10,
	            barMargin: 10,
	            color: '#CC6600',
	            fillToZero: true
	        }
	    },
	        cursor:{
	          showVerticalLine:true,
	          showTooltip: true,
	          followMouse: true,
	          showTooltipDataPosition:true,
	          zoom:true,
	          intersectionThreshold:6,
	          tooltipFormatString: '%s x:%s, y:%s'
	        },
	    series: [{
	        label: 'Collection'
	    },],
	    axes: {
	        xaxis: {
	            renderer: $.jqplot.CategoryAxisRenderer,
        		tickRenderer: $.jqplot.CanvasAxisTickRenderer ,
	            
	            label: 'Scheme',
	            ticks: ${schm},
	            showMinorTicks:true,
				tickOptions:{
					angle: -45,
				}
	        },
	        yaxis: {min:0, label: 'Collection Amount', tickInterval:2000000, showMinorTicks:true}
	    }
	});


	plot3 = $.jqplot('chart3', [${monthWiseCollection}], {
	    stackSeries: false,
	    highlightMouseOver:true,

	    legend: {
		show: true,
		location: 'nw',
		xoffset: 55
	    },
	    title: 'Monthwise Collection for Year '+${yearsMonthwise},
	    seriesDefaults: {
		renderer: $.jqplot.BarRenderer,
		pointLabels: { show: true, location: 'n',labels:${monthWiseCollection}},
		rendererOptions: {
		    barPadding: 10,
		    barMargin: 10,
		    color: '#000080',
		    fillToZero: true
		}
	    },
		cursor:{
		  showVerticalLine:true,
		  showTooltip: true,
		  followMouse: true,
		  showTooltipDataPosition:true,
		  zoom:true,
		  intersectionThreshold:6,
		  tooltipFormatString: '%s x:%s, y:%s'
		},
	    series: [{
		label: 'Collection'
	    },],
	    axes: {
		xaxis: {
		    renderer: $.jqplot.CategoryAxisRenderer,
		    label: 'Month',
		    ticks: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sept', 'Oct', 'Nov', 'Dec'],
		    showMinorTicks:true

		},
		yaxis: {min:0, label: 'Collection Amount',tickInterval:500000, showMinorTicks:true}
	    }
	});

});

</script>

    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            
		</div>
	<div>
    	<br><b>Dashboard for ${ics.Individual.get(patronCareSevaks?.id)}</b>
    	</div>
	<g:if test="${individualInstanceList?.size() > 0}">
	    <g:if test="${monthWiseCollection?.size() > 0}">	    
	    	<div id="chart3" style="margin-top:20px; width:600px; height:500px;float:left;"></div>
	    </g:if>
	    <div id="chart2" style="margin-top:20px; width:600px; height:500px;float:left;"></div>
	    <div id="chart5" style="margin-top:20px; width:800px; height:600px;float:left;"></div>

    	</g:if>
    	<g:else>
		<div>
		<br><b>No devotees cultivated yet.</b>
		</div>
    	</g:else>



    </body>
</html>
