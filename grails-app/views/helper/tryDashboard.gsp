<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <g:set var="entityName" value="Dashboard" />
        <title>Dashboard</title>
<link rel="stylesheet" type="text/css" href="/ics/css/jquery.jqplot.css" />
<link rel="stylesheet" type="text/css" href="/ics/css/examples.css" />
<!--<script language="javascript" type="text/javascript" src="/ics/js/jquery-1.4.2.min.js"></script>
<script language="javascript" type="text/javascript" src="/ics/js/jquery.jqplot.js"></script>
<script language="javascript" type="text/javascript" src="/ics/js/plugins/jqplot.pieRenderer.js"></script>
<script language="javascript" type="text/javascript" src="/ics/js/plugins/jqplot.barRenderer.js"></script>
<script language="javascript" type="text/javascript" src="/ics/js/plugins/jqplot.categoryAxisRenderer.js"></script>
<script language="javascript" src="/ics/js/plugins/jqplot.cursor.min.js"></script>-->

<g:javascript src="jquery-1.4.2.min.js"/>
<g:javascript src="jquery.jqplot.min.js"/>
<g:javascript src="jqplot.pieRenderer.js"/>
<g:javascript src="jqplot.barRenderer.js"/>
<g:javascript src="jqplot.categoryAxisRenderer.js"/>
<g:javascript src="jqplot.cursor.min.js"/>

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
	//$.jqplot('chartdiv',  [[[1, 2],[3,5.12],[5,13.1],[7,33.6],[9,85.9],[11,219.9]]]);
	
        s1 = [['Sony',7], ['Samsumg',13.3], ['LG',14.7], ['Vizio',5.2], ['Insignia', 1.2]];
	    //s1 = ${eventStats?.eventsummary};
	        
	plot5=   $.jqplot('chart5', [s1], {
	        grid: {
	            drawBorder: false, 
	            drawGridlines: false,
	            background: '#ffffff',
	            shadow:false
	        },
	        axesDefaults: {
	            
	        },
	        seriesDefaults:{
	            renderer:$.jqplot.PieRenderer,
	            rendererOptions: {
	                showDataLabels: true
	            }
	        },
	    title: 'Overall Summary',
	        legend: {
	            show: true,
	            rendererOptions: {
	                numberRows: 1
	            },
	            location: 's'
	        }
	    }); 
	    list300 = [1, 4, 9, 16];
	    list500 = [25, 12.5, 6.25, 3.125];
	    list1000 = [2, 7, 15, 30]; 
	    /*list5000 = 
	    list4999 =*/
plot = $.jqplot('chart1', [list300, list500, list1000], {
    title: 'Booking trend',
    seriesDefaults:{},
    legend: {show:true, location: 'se'},
    series: [{
        label: '300'
    },
    {
        label: '500'
    },
    {
        label: '1000'
    },
    {
        label: '5000'
    },
    {
        label: '4999'
    }],
	axes: {
	    xaxis: {
		renderer: $.jqplot.CategoryAxisRenderer,
		ticks: ['12','13','14','15','16','17','18','19','20','21']
	    },
	    yaxis: {min:0}
	}

});	    
line1 = [1, 4, 9, 16];
line2 = [25, 12.5, 6.25, 3.125];
line3 = [2, 7, 15, 30];        
	    
/*var line1 = [1, 4, 9, 16];
var line2 = [25, 12.5, 6.25, 3.125];
var line3 = [2, 7, 15, 30];*/
/*line1 = ${eventStats?.sold};
line2 = ${eventStats?.resv};
line3 = ${eventStats?.avail};*/
plot2 = $.jqplot('chart2', [line1, line2, line3], {
    stackSeries: false,
    legend: {
        show: true,
        location: 'nw',
        xoffset: 55
    },
    title: 'Daywise summary',
    seriesDefaults: {
        renderer: $.jqplot.BarRenderer,
        rendererOptions: {
            barPadding: 2,
            barMargin: 40
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
        label: 'Sold'
    },
    {
        label: 'Reserved'
    },
    {
        label: 'Available'
    }],
    axes: {
        xaxis: {
            renderer: $.jqplot.CategoryAxisRenderer,
            
            ticks: ['12','13','14','15','16','17','18','19','20','21']
        },
        yaxis: {min:0}
    }
});
plot3 = $.jqplot('chart3', [line1, line2, line3], {
    legend: {
        show: true,
        location: 'nw',
        xoffset: 55
    },
    title: 'Daywise Summary 2',
    seriesDefaults: {
        renderer: $.jqplot.BarRenderer,
        rendererOptions: {
            barPadding: 10,
            barMargin: 10
        }
    },
    series: [{
        label: 'Sold'
    },
    {
        label: 'Reserved'
    },
    {
        label: 'Available'
    }],
    axes: {
        xaxis: {
            renderer: $.jqplot.CategoryAxisRenderer,
            ticks: ['12','13','14','15','16','17','18','19','20','21']
        },
        yaxis: {min:0}
    }
});
	
});
</script>
    </head>
    <body>
    
    <!--<div id="chartdiv" style="height:400px;width:300px; "></div>-->
    <div id="chart5" style="margin-top:20px; width:40%; height:300px;float:left;"></div>
    <div id="chart2" style="margin-top:20px; width:40%; height:300px;float:left;"></div>
    <div id="chart1" style="margin-top:20px; width:400px; height:300px;float:left;"></div>
    <div id="chart3" style="margin-top:20px; width:400px; height:300px;float:left;"></div>
    <script type="text/javascript">
    
    
        

    </script>
    
    
    </body>
</html>
