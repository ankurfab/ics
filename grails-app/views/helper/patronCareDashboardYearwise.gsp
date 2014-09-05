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
		    barPadding: 5,
		    barMargin: 25,
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
	<div>
    	<br><b>Dashboard for ${ics.Individual.get(patronCareSevaksIds)}</b>
    	</div>
	<g:if test="${individualInstanceList?.size() > 0}">
	    <div id="chart2" style="margin-top:20px; width:600px; height:500px;float:left;"></div>

    	</g:if>
    	<g:else>
		<div>
		<br><b>No devotees cultivated yet.</b>
		</div>
    	</g:else>



    </body>
</html>
