<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <g:set var="entityName" value="Dashboard" />
        <title>Dashboard</title>
<link rel="stylesheet" type="text/css" href="${resource(dir: 'css', file: 'jquery.jqplot.css')}" />
<link rel="stylesheet" type="text/css" href="${resource(dir: 'css', file: 'examples.css')}" />

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
	    color: '#ffffff',
	    seriesDefaults: {
		renderer: $.jqplot.BarRenderer,
		pointLabels: { show: true, location: 'n',labels:${yearwiseCollectionAmount}},
		rendererOptions: {
		    barPadding: 10,
		    barMargin: 10,
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
	    }],
	    axes: {
		xaxis: {
		    renderer: $.jqplot.CategoryAxisRenderer,
		    label: 'Year',
		    ticks: ${yearTicks},
		    showMinorTicks:true

		},
		yaxis: {min:0, label: 'Collection Amount', tickInterval:5000000, showMinorTicks:true}
	    }
	});

	//bar Yearwise Collection of PatronCare Devotees
	plot6 = $.jqplot('chart6', [${pc_yearwiseCollectionAmount}], {
		stackSeries: false,
		highlightMouseOver:true,

		legend: {
			show: true,
			location: 'nw',
			xoffset: 55
		},
		title: 'Yearwise Collection of Patroncare Devotees',
		
		seriesDefaults: {
			renderer: $.jqplot.BarRenderer,
			pointLabels: { show: true, location: 'n',labels:${pc_yearwiseCollectionAmount}},
			rendererOptions: {
				barPadding: 20,
				barMargin: 25,
				color: '#F08080',
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
		}],
		axes: {
			xaxis: {
				renderer: $.jqplot.CategoryAxisRenderer,
				label: 'Year',
				ticks: ${pc_yearTicks},
				showMinorTicks:true

			},
			yaxis: {min:0, label: 'Collection Amount', tickInterval:5000000, showMinorTicks:true}
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
	    }],
	    axes: {
		xaxis: {
		    renderer: $.jqplot.CategoryAxisRenderer,
		    label: 'Month',
		    ticks: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sept', 'Oct', 'Nov', 'Dec'],
		    showMinorTicks:true

		},
		yaxis: {min:0, label: 'Collection Amount',tickInterval:5000000, showMinorTicks:true}
	    }
	});

	//bar Monthwise Collection of PatronCare Devotees
	plot7 = $.jqplot('chart7', [${pc_monthWiseCollection}], {
		stackSeries: false,
		highlightMouseOver:true,

		legend: {
			show: true,
			location: 'nw',
			xoffset: 55
		},
		title: 'Monthwise Collection for Year '+${yearsMonthwise}+ ' of Patroncare Devotees',
		seriesDefaults: {
			renderer: $.jqplot.BarRenderer,
			pointLabels: { show: true, location: 'n',labels:${pc_monthWiseCollection}},
			rendererOptions: {
				barPadding: 10,
				barMargin: 10,
				color: '#DC143C',
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
		}],
		axes: {
			xaxis: {
				renderer: $.jqplot.CategoryAxisRenderer,
				label: 'Month',
				ticks: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sept', 'Oct', 'Nov', 'Dec'],
				showMinorTicks:true

			},
			yaxis: {min:0, label: 'Collection Amount',tickInterval:1000000, showMinorTicks:true}
		}
	});
	
	//meterguage
	   s1 = [${amt}];

	   plot4 = $.jqplot('chart4',[s1],{
			title: 'Total Collection: '+${amt},
	       seriesDefaults: {
		   renderer: $.jqplot.MeterGaugeRenderer,
		   rendererOptions: {
		       //label: 'Total Collections',
		       //labelPosition: 'top',
		       //labelHeightAdjust: -5,
		       intervalOuterRadius: 85,
		       ticks: [200000000, 400000000, 600000000, 800000000],
		       intervals:[400000000, 600000000, 800000000],
		       intervalColors:['#66cc66', '#E7E658', '#cc6666']
		   }
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
	            barPadding: 4,
	            barMargin: 4,
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
	    }],
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
	        yaxis: {min:0, label: 'Collection Amount', tickInterval:500000, showMinorTicks:true}
	    }
	});
	
});
</script>
    </head>
    <body>


	<div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
	</div>
     
    <div id="chart2" style="margin-top:20px; width:600px; height:500px;float:left;"></div>
    <div id="chart6" style="margin-top:20px; width:600px; height:500px;float:left;"></div>
    <div id="chart3" style="margin-top:20px; width:600px; height:500px;float:left;"></div>
    <div id="chart7" style="margin-top:20px; width:600px; height:500px;float:left;"></div>
    <div id="chart4" style="margin-top:20px; width:400px; height:300px;float:left;"></div>
    <div id="chart5" style="margin-top:20px; width:800px; height:600px;float:left;"></div>
    
    </body>
</html>
