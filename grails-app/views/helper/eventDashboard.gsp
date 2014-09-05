<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>RVTO Dashboard</title>
	<r:require module="jqui" />
	<r:require module="newjqplot" />
    </head>
    <body>


        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLinkTo(dir: '')}"><g:message code="home" default="Home" /></a></span>
        </div>
        <div class="body">

		<div id="accordian">
		    <!--<h3>Summary</h3>-->
		    <div id="summ">
				<div id="chartSumm" style="height:300px; width:1200px;float:left;"></div>
		    </div>
		    <!--<h3>Registration</h3>-->
		    <div id="reg">
				<div id="chartRegDet" style="height:300px; width:400px;float:left;"></div>
				<div id="chartRegFill" style="height:300px; width:400px;float:left;"></div>
				<div id="chartRegSumm" style="height:300px; width:400px;float:left;"></div>
		    </div>
		    <!--<h3>Accommodation</h3>
		    <div id="acco">
				<div id="chartAccoDet" style="height:300px; width:400px;float:left;"></div>
				<div id="chartAccoFill" style="height:300px; width:400px;float:left;"></div>
				<div id="chartAccoSumm" style="height:300px; width:400px;float:left;"></div>
		    </div>-->
		</div>


        </div>

	<script class="code" type="text/javascript">
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

	var jsonurl_chartRegDet = "${createLink(controller:'Helper',action:'eventRegistrationDetailData')}";
	  var plot_chartRegDet = $.jqplot('chartRegDet', jsonurl_chartRegDet, {
	    dataRenderer: ajaxDataRenderer,
	    dataRendererOptions: {
	      unusedOptionalUrl: jsonurl_chartRegDet
	    },
	    title:'Registrations by Date',
	      axes:{
		xaxis:{
		  renderer:$.jqplot.DateAxisRenderer,
		 tickOptions:{formatString:'%d-%b'}
		}
	      }
	  });

	var jsonurl_chartRegSumm = "${createLink(controller:'Helper',action:'eventRegistrationSummaryData')}";
    var plot_chartRegSumm = $.jqplot('chartRegSumm', jsonurl_chartRegSumm, {
	title: "Registration Breakdown (excluding rejects)",
	    dataRenderer: ajaxDataRenderer,
	    dataRendererOptions: {
	      unusedOptionalUrl: jsonurl_chartRegSumm
	    },
        seriesDefaults:{
            renderer:$.jqplot.PieRenderer, 
            rendererOptions: { padding: 8, showDataLabels: true, sliceMargin: 4, dataLabels: 'value' }
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
        });      

	  var jsonurl_chartRegFill = "${createLink(controller:'Helper',action:'eventRegistrationSummaryByStatusData')}";
	  var plot2 = $.jqplot('chartRegFill', jsonurl_chartRegFill,{
		    title: "Registration Summary by Status",
		    dataRenderer: ajaxDataRenderer,
		    dataRendererOptions: {
		      unusedOptionalUrl: jsonurl_chartRegFill
		    },
		seriesDefaults:{
		    renderer:$.jqplot.PieRenderer, 
		    trendline:{ show:false }, 
		    rendererOptions: { padding: 8, showDataLabels: true, dataLabels: 'value' }
		},
		legend:{
		    show:true, 
		    location:'s',
		    placement: 'outside', 
		    rendererOptions: {
			numberRows: 1
		    }, 
		    location:'s',
		    marginTop: '15px'
		} 
	  });

	var jsonurl_chartSumm = "${createLink(controller:'Helper',action:'eventSummaryData')}";
        var plot_chartSumm = $.jqplot('chartSumm',jsonurl_chartSumm , {
	    title: "RVTO Summary (1->#VerifiedGuests,2->#AccoAllotments,3->#Volunteers)",
	    stackSeries: true,
	    dataRenderer: ajaxDataRenderer,
	    dataRendererOptions: {
	      unusedOptionalUrl: jsonurl_chartSumm
	    },
            seriesDefaults: {
                renderer:$.jqplot.BarRenderer,
                pointLabels: { show: true, location: 'e', edgeTolerance: -15, stackedValue: true },
                shadowAngle: 135,
                rendererOptions: {
                    barDirection: 'horizontal'
                }
            },
            axes: {
                yaxis: {
                    renderer: $.jqplot.CategoryAxisRenderer
                }
            }
        });


	});
	</script>

    </body>
</html>
